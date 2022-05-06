function PrimeGen 
{
    param(
        [int] [parameter(mandatory=$true, Valuefrompipeline = $true)] $MaximumP
    )
    $rList = @()
    for ($ii = 2; $ii -le $MaximumP; $ii++) {
        $divCounter = 0 #The number of primes which divided the number evenly (should be at most '1' (count and literal))
        for ($pp = 0; ($pp -le $rList.Length) -and ($rList[$pp] -le [Math]::Sqrt($ii)); $pp++) {
            $tPrime = [int]($rList[$pp])#Prime to be tested
            if (($tPrime -gt 1) -and (($ii % $tPrime) -eq 0))
            {   $divCounter += 1   }
        }
        if ($divCounter -eq 0)
        {   $rList += $ii    }
    }
    $rList
}

PrimeGen 200000