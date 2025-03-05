Return-Path: <linux-iio+bounces-16416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE795A4FF36
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4806D3B0406
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A962459C0;
	Wed,  5 Mar 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="ba4QRE8b"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-15.pe-b.jellyfish.systems (out-15.pe-b.jellyfish.systems [198.54.127.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484C242936;
	Wed,  5 Mar 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179524; cv=none; b=gMDNMJV0T7HJ/HzZR0kC4jdLvfAlDN4tCZZ4aslpcgzKZ2pXSGTEp2FdttfeqHZqX8H9RegpZXv4o4r8Nz8/ClH9lvWmO6aHCGPfwOK/KNTep0B/+13wSMPO7zsi87CSf9paQElHOwNwIsuxFJ5kXTIrY5aNpIbHKFB+e/mG9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179524; c=relaxed/simple;
	bh=/K2p0FTR2UIkmGg/Tef6xM/nvbXgWQLerngb4UfBJVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnrC3vt7ZlaFF5KEIeG7y6xLjx3k4fQioBZbVWoXvPyezy5R85aC3PK1J5//wQ7II9bWihJyn0VTPt4CQqScAAVeMdcCd/GE+2wqGW5+kh7DwX8abB0GvxCWQ69en2IFmSTD9Afsfrn4YxfyTm5xVddwuPpGhzE1vNzGWBTp3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=ba4QRE8b; arc=none smtp.client-ip=198.54.127.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z7CKQ4dMfzDqqt;
	Wed, 05 Mar 2025 12:58:34 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z7CKQ3K3Nz3hhVZ;
	Wed,  5 Mar 2025 07:58:34 -0500 (EST)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4Z7CKQ1pBvz3hhTl;
	Wed,  5 Mar 2025 07:58:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741179514;
	bh=/K2p0FTR2UIkmGg/Tef6xM/nvbXgWQLerngb4UfBJVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ba4QRE8btF/gs8bVyVBvn1bNn1F85Dyt6vZKTFcG0WvSigjqtY27rMUPO1s4qLgpW
	 Xb/IAW/IE99UYm7jCG4CJBAB+uUQRXgwHApNVo+hgm/YRJqSFEXsswU2/N/y0o+dx8
	 Cmn+uw+4jCfJYeT5Ikq7puF0XNNC6foFwpDnGlfzIYPoNuVDmb1QVU/uGL3feSM0Bs
	 Wt04gTlB6Kl8DaJFOFdb0IjHPT16hS7ALrxM2meI2XnJe9o4B3z+E/EFZO6ltGH7zA
	 QU0cVBGObamgFeKDkUKW0j+Y1KoFaxUOIjXl2I5J/hflwj9SGS7ZMgsvMzaoOPV46C
	 tpXKOv/C67lLA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Wed,  5 Mar 2025 07:58:22 -0500 (EST)
Date: Wed, 5 Mar 2025 07:58:23 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: filter: admv8818: fix range calculation
Message-ID: <Z8hKbxWT--0lMHao@65YTFL3.secure.tethers.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <20250304235502.4d0342a1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304235502.4d0342a1@jic23-huawei>
X-Virus-Scanned: ClamAV using ClamSMTP

On Tue, Mar 04, 2025 at 11:55:02PM +0000, Jonathan Cameron wrote:
> On Tue, 25 Feb 2025 08:46:11 -0500
> Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> 
> Hi Sam,
> 
> Various comments inline.
> 
> Jonathan
> 
> 
> > Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
> > the ADMV8818 datasheet
> This feels like a first fix...

Agreed. This should be broken out. For discussion let's call this PATCH_1.

> > 
> > Search for the minimum error while ensuring that the LPF corner
> > frequency is greater than the target, and the HPF corner frequency
> > is lower than the target
> > 
> > This fixes issues where the range calculations were suboptimal.
> This feels like a 2nd one.  Maybe two patches appropriate.
>

Agreed. For discussion let's call this PATCH_2.

> > 
> > Add two new DTS properties to set the margin between the input frequency
> > and the calculated corner frequency
> And this feels like a feature.  So 3rd patch that we don't necessarily
> backport.  For earlier stages we just use the default values that
> you have in the binding.
>

Hmm. This is interesting.  I propose that PATCH_1 is a fix, and both PATCH_2 and this DTS change are treated as a feature. The reason I am suggesting this is that PATCH_2 changes the behavior of the corner frequency and if we backport that then some users may find that their devices no longer function as they used to. Another way of saying this is that PATCH_2 really should include the DTS changes for those users that depended on the old corner calculation algorithm. Does this sound reasonable?
 
> > 
> > Below is a generated table of the differences between the old algorithm
> > and the new. This is a sweep from 0 to 20 GHz in 10 MHz steps.
> 
> So, these are just the entries where the 3db point changes?
> All the others are same?
> 

With a 10 MHz resolution, yes. It was an attempt to show that if the user selected a corner frequency that in many cases there was a better option. The code, as it exists, uses the same algortihm for finding the corner frequency when in either manual or auto mode - There are two problems with this approach:
1. If you are using manual mode, you can't select a specific corner frequency without subtracting 1 from your target frequency. This highlights problem number 2.
2. If you are in automatic mode and your fundamental frequency is 1 Hz below a corner - that corner will be selected. This will efectively put the corner frequency/3db point at the fundamental frequency. This will cut your signal power in half.

Perhaps there is a better way to show this? Conveying this without images is challenging.

Here is an example of where both algorithms agree (1 Hz resolution):
freq = 1750000001 Hz, 3db: 1750000000 (old algorithm) => 1750000000 (new algorithm) Hz

Note that if the user is in `auto` mode then the corner frequency will be put almost exactly on their fundamental frequency.
The same will happen with the new algorithm, but the user has the ability to select a minimum margin using DTS.


> > === HPF ===
> > freq = 1750 MHz, 3db: bypass => 1750 MHz
> > freq = 3400 MHz, 3db: 3310 => 3400 MHz
> > freq = 3410 MHz, 3db: 3310 => 3400 MHz
> > freq = 3420 MHz, 3db: 3310 => 3400 MHz
> > freq = 3660 MHz, 3db: 3550 => 3656 MHz
> > freq = 6600 MHz, 3db: 6479 => 6600 MHz
> > freq = 6610 MHz, 3db: 6479 => 6600 MHz
> > freq = 6620 MHz, 3db: 6479 => 6600 MHz
> > freq = 6630 MHz, 3db: 6479 => 6600 MHz
> > freq = 6640 MHz, 3db: 6479 => 6600 MHz
> > freq = 6650 MHz, 3db: 6479 => 6600 MHz
> > freq = 6660 MHz, 3db: 6479 => 6600 MHz
> > freq = 6670 MHz, 3db: 6479 => 6600 MHz
> > freq = 6680 MHz, 3db: 6479 => 6600 MHz
> > freq = 6690 MHz, 3db: 6479 => 6600 MHz
> > freq = 6700 MHz, 3db: 6479 => 6600 MHz
> > freq = 6710 MHz, 3db: 6479 => 6600 MHz
> > freq = 6720 MHz, 3db: 6479 => 6600 MHz
> > freq = 6730 MHz, 3db: 6479 => 6600 MHz
> > freq = 6960 MHz, 3db: 6736 => 6960 MHz
> > freq = 6970 MHz, 3db: 6736 => 6960 MHz
> > freq = 6980 MHz, 3db: 6736 => 6960 MHz
> > freq = 6990 MHz, 3db: 6736 => 6960 MHz
> > freq = 7320 MHz, 3db: 7249 => 7320 MHz
> > freq = 7330 MHz, 3db: 7249 => 7320 MHz
> > freq = 7340 MHz, 3db: 7249 => 7320 MHz
> > freq = 7350 MHz, 3db: 7249 => 7320 MHz
> > freq = 7360 MHz, 3db: 7249 => 7320 MHz
> > freq = 7370 MHz, 3db: 7249 => 7320 MHz
> > freq = 7380 MHz, 3db: 7249 => 7320 MHz
> > freq = 7390 MHz, 3db: 7249 => 7320 MHz
> > freq = 7400 MHz, 3db: 7249 => 7320 MHz
> > freq = 7410 MHz, 3db: 7249 => 7320 MHz
> > freq = 7420 MHz, 3db: 7249 => 7320 MHz
> > freq = 7430 MHz, 3db: 7249 => 7320 MHz
> > freq = 7440 MHz, 3db: 7249 => 7320 MHz
> > freq = 7450 MHz, 3db: 7249 => 7320 MHz
> > freq = 7460 MHz, 3db: 7249 => 7320 MHz
> > freq = 7470 MHz, 3db: 7249 => 7320 MHz
> > freq = 7480 MHz, 3db: 7249 => 7320 MHz
> > freq = 7490 MHz, 3db: 7249 => 7320 MHz
> > freq = 7500 MHz, 3db: 7249 => 7320 MHz
> > freq = 12500 MHz, 3db: 12000 => 12500 MHz
> > 
> > === LPF ===
> > freq = 2050 MHz, 3db: bypass => 2050 MHz
> > freq = 2170 MHz, 3db: 2290 => 2170 MHz
> > freq = 2290 MHz, 3db: 2410 => 2290 MHz
> > freq = 2410 MHz, 3db: 2530 => 2410 MHz
> > freq = 2530 MHz, 3db: 2650 => 2530 MHz
> > freq = 2650 MHz, 3db: 2770 => 2650 MHz
> > freq = 2770 MHz, 3db: 2890 => 2770 MHz
> > freq = 2890 MHz, 3db: 3010 => 2890 MHz
> > freq = 3010 MHz, 3db: 3130 => 3010 MHz
> > freq = 3130 MHz, 3db: 3250 => 3130 MHz
> > freq = 3250 MHz, 3db: 3370 => 3250 MHz
> > freq = 3260 MHz, 3db: 3370 => 3350 MHz
> > freq = 3270 MHz, 3db: 3370 => 3350 MHz
> > freq = 3280 MHz, 3db: 3370 => 3350 MHz
> > freq = 3290 MHz, 3db: 3370 => 3350 MHz
> > freq = 3300 MHz, 3db: 3370 => 3350 MHz
> > freq = 3310 MHz, 3db: 3370 => 3350 MHz
> > freq = 3320 MHz, 3db: 3370 => 3350 MHz
> > freq = 3330 MHz, 3db: 3370 => 3350 MHz
> > freq = 3340 MHz, 3db: 3370 => 3350 MHz
> > freq = 3350 MHz, 3db: 3370 => 3350 MHz
> > freq = 3370 MHz, 3db: 3490 => 3370 MHz
> > freq = 3490 MHz, 3db: 3610 => 3490 MHz
> > freq = 3610 MHz, 3db: 3730 => 3610 MHz
> > freq = 3730 MHz, 3db: 3850 => 3730 MHz
> > freq = 3850 MHz, 3db: 3870 => 3850 MHz
> > freq = 3870 MHz, 3db: 4130 => 3870 MHz
> > freq = 4130 MHz, 3db: 4390 => 4130 MHz
> > freq = 4390 MHz, 3db: 4650 => 4390 MHz
> > freq = 4650 MHz, 3db: 4910 => 4650 MHz
> > freq = 4910 MHz, 3db: 5170 => 4910 MHz
> > freq = 5170 MHz, 3db: 5430 => 5170 MHz
> > freq = 5430 MHz, 3db: 5690 => 5430 MHz
> > freq = 5690 MHz, 3db: 5950 => 5690 MHz
> > freq = 5950 MHz, 3db: 6210 => 5950 MHz
> > freq = 6210 MHz, 3db: 6470 => 6210 MHz
> > freq = 6470 MHz, 3db: 6730 => 6470 MHz
> > freq = 6730 MHz, 3db: 6990 => 6730 MHz
> > freq = 6990 MHz, 3db: 7250 => 6990 MHz
> > freq = 7000 MHz, 3db: 7250 => 7000 MHz
> > freq = 7250 MHz, 3db: 7400 => 7250 MHz
> > freq = 7400 MHz, 3db: 7800 => 7400 MHz
> > freq = 7800 MHz, 3db: 8200 => 7800 MHz
> > freq = 8200 MHz, 3db: 8600 => 8200 MHz
> > freq = 8600 MHz, 3db: 9000 => 8600 MHz
> > freq = 9000 MHz, 3db: 9400 => 9000 MHz
> > freq = 9400 MHz, 3db: 9800 => 9400 MHz
> > freq = 9800 MHz, 3db: 10200 => 9800 MHz
> > freq = 10200 MHz, 3db: 10600 => 10200 MHz
> > freq = 10600 MHz, 3db: 11000 => 10600 MHz
> > freq = 11000 MHz, 3db: 11400 => 11000 MHz
> > freq = 11400 MHz, 3db: 11800 => 11400 MHz
> > freq = 11800 MHz, 3db: 12200 => 11800 MHz
> > freq = 12200 MHz, 3db: 12600 => 12200 MHz
> > freq = 12210 MHz, 3db: 12600 => 12550 MHz
> > freq = 12220 MHz, 3db: 12600 => 12550 MHz
> > freq = 12230 MHz, 3db: 12600 => 12550 MHz
> > freq = 12240 MHz, 3db: 12600 => 12550 MHz
> > freq = 12250 MHz, 3db: 12600 => 12550 MHz
> > freq = 12260 MHz, 3db: 12600 => 12550 MHz
> > freq = 12270 MHz, 3db: 12600 => 12550 MHz
> > freq = 12280 MHz, 3db: 12600 => 12550 MHz
> > freq = 12290 MHz, 3db: 12600 => 12550 MHz
> > freq = 12300 MHz, 3db: 12600 => 12550 MHz
> > freq = 12310 MHz, 3db: 12600 => 12550 MHz
> > freq = 12320 MHz, 3db: 12600 => 12550 MHz
> > freq = 12330 MHz, 3db: 12600 => 12550 MHz
> > freq = 12340 MHz, 3db: 12600 => 12550 MHz
> > freq = 12350 MHz, 3db: 12600 => 12550 MHz
> > freq = 12360 MHz, 3db: 12600 => 12550 MHz
> > freq = 12370 MHz, 3db: 12600 => 12550 MHz
> > freq = 12380 MHz, 3db: 12600 => 12550 MHz
> > freq = 12390 MHz, 3db: 12600 => 12550 MHz
> > freq = 12400 MHz, 3db: 12600 => 12550 MHz
> > freq = 12410 MHz, 3db: 12600 => 12550 MHz
> > freq = 12420 MHz, 3db: 12600 => 12550 MHz
> > freq = 12430 MHz, 3db: 12600 => 12550 MHz
> > freq = 12440 MHz, 3db: 12600 => 12550 MHz
> > freq = 12450 MHz, 3db: 12600 => 12550 MHz
> > freq = 12460 MHz, 3db: 12600 => 12550 MHz
> > freq = 12470 MHz, 3db: 12600 => 12550 MHz
> > freq = 12480 MHz, 3db: 12600 => 12550 MHz
> > freq = 12490 MHz, 3db: 12600 => 12550 MHz
> > freq = 12500 MHz, 3db: 12600 => 12550 MHz
> > freq = 12510 MHz, 3db: 12600 => 12550 MHz
> > freq = 12520 MHz, 3db: 12600 => 12550 MHz
> > freq = 12530 MHz, 3db: 12600 => 12550 MHz
> > freq = 12540 MHz, 3db: 12600 => 12550 MHz
> > freq = 12550 MHz, 3db: 12600 => 12550 MHz
> > freq = 12600 MHz, 3db: 13000 => 12600 MHz
> > freq = 12610 MHz, 3db: 13000 => 12970 MHz
> > freq = 12620 MHz, 3db: 13000 => 12970 MHz
> > freq = 12630 MHz, 3db: 13000 => 12970 MHz
> > freq = 12640 MHz, 3db: 13000 => 12970 MHz
> > freq = 12650 MHz, 3db: 13000 => 12970 MHz
> > freq = 12660 MHz, 3db: 13000 => 12970 MHz
> > freq = 12670 MHz, 3db: 13000 => 12970 MHz
> > freq = 12680 MHz, 3db: 13000 => 12970 MHz
> > freq = 12690 MHz, 3db: 13000 => 12970 MHz
> > freq = 12700 MHz, 3db: 13000 => 12970 MHz
> > freq = 12710 MHz, 3db: 13000 => 12970 MHz
> > freq = 12720 MHz, 3db: 13000 => 12970 MHz
> > freq = 12730 MHz, 3db: 13000 => 12970 MHz
> > freq = 12740 MHz, 3db: 13000 => 12970 MHz
> > freq = 12750 MHz, 3db: 13000 => 12970 MHz
> > freq = 12760 MHz, 3db: 13000 => 12970 MHz
> > freq = 12770 MHz, 3db: 13000 => 12970 MHz
> > freq = 12780 MHz, 3db: 13000 => 12970 MHz
> > freq = 12790 MHz, 3db: 13000 => 12970 MHz
> > freq = 12800 MHz, 3db: 13000 => 12970 MHz
> > freq = 12810 MHz, 3db: 13000 => 12970 MHz
> > freq = 12820 MHz, 3db: 13000 => 12970 MHz
> > freq = 12830 MHz, 3db: 13000 => 12970 MHz
> > freq = 12840 MHz, 3db: 13000 => 12970 MHz
> > freq = 12850 MHz, 3db: 13000 => 12970 MHz
> > freq = 12860 MHz, 3db: 13000 => 12970 MHz
> > freq = 12870 MHz, 3db: 13000 => 12970 MHz
> > freq = 12880 MHz, 3db: 13000 => 12970 MHz
> > freq = 12890 MHz, 3db: 13000 => 12970 MHz
> > freq = 12900 MHz, 3db: 13000 => 12970 MHz
> > freq = 12910 MHz, 3db: 13000 => 12970 MHz
> > freq = 12920 MHz, 3db: 13000 => 12970 MHz
> > freq = 12930 MHz, 3db: 13000 => 12970 MHz
> > freq = 12940 MHz, 3db: 13000 => 12970 MHz
> > freq = 12950 MHz, 3db: 13000 => 12970 MHz
> > freq = 12960 MHz, 3db: 13000 => 12970 MHz
> > freq = 12970 MHz, 3db: 13000 => 12970 MHz
> > freq = 13000 MHz, 3db: 13390 => 13000 MHz
> > freq = 13390 MHz, 3db: 13810 => 13390 MHz
> > freq = 13810 MHz, 3db: 14230 => 13810 MHz
> > freq = 14230 MHz, 3db: 14650 => 14230 MHz
> > freq = 14650 MHz, 3db: 15070 => 14650 MHz
> > freq = 15070 MHz, 3db: 15490 => 15070 MHz
> > freq = 15490 MHz, 3db: 15910 => 15490 MHz
> > freq = 15910 MHz, 3db: 16330 => 15910 MHz
> > freq = 16330 MHz, 3db: 16750 => 16330 MHz
> > freq = 16750 MHz, 3db: 17170 => 16750 MHz
> > freq = 17170 MHz, 3db: 17590 => 17170 MHz
> > freq = 17590 MHz, 3db: 18010 => 17590 MHz
> > freq = 18010 MHz, 3db: 18430 => 18010 MHz
> > freq = 18430 MHz, 3db: 18850 => 18430 MHz
> > freq = 18850 MHz, 3db: bypass => 18850 MHz
> > 
> > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> > Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> > ---
> > V1 -> V2: Cleaned up the wording of the commit message
> > V2 -> V3: Add DTS properties to control corner frequency margins
> > ---
> >  drivers/iio/filter/admv8818.c | 136 ++++++++++++++++++++++++++--------
> >  1 file changed, 105 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> > index 848baa6e3bbf..a446d8d421ae 100644
> > --- a/drivers/iio/filter/admv8818.c
> > +++ b/drivers/iio/filter/admv8818.c
> > @@ -90,6 +90,8 @@ struct admv8818_state {
> >  	struct mutex		lock;
> >  	unsigned int		filter_mode;
> >  	u64			cf_hz;
> > +	u64			lpf_margin_hz;
> > +	u64			hpf_margin_hz;
> >  };
> >  
> >  static const unsigned long long freq_range_hpf[4][2] = {
> > @@ -103,7 +105,7 @@ static const unsigned long long freq_range_lpf[4][2] = {
> >  	{2050000000ULL, 3850000000ULL},
> >  	{3350000000ULL, 7250000000ULL},
> >  	{7000000000, 13000000000},
> > -	{12550000000, 18500000000}
> > +	{12550000000, 18850000000}
> 
> As above. This seems to be the first fix and should stand on it's own.
> 

Good point, I will include this change in v5.

> >  };
> >  
> >  static const struct regmap_config admv8818_regmap_config = {
> > @@ -122,43 +124,59 @@ static const char * const admv8818_modes[] = {
> >  static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
> >  {
> >  	unsigned int hpf_step = 0, hpf_band = 0, i, j;
> > +	u64 freq_error;
> > +	u64 min_freq_error;
> > +	u64 freq_corner;
> >  	u64 freq_step;
> >  	int ret;
> >  
> >  	if (freq < freq_range_hpf[0][0])
> >  		goto hpf_write;
> >  
> > -	if (freq > freq_range_hpf[3][1]) {
> > +	if (freq >= freq_range_hpf[3][1]) {
> >  		hpf_step = 15;
> >  		hpf_band = 4;
> >  
> >  		goto hpf_write;
> >  	}
> >  
> > +	/* Close HPF frequency gap between 12 and 12.5 GHz */
> > +	if (freq >= 12000 * HZ_PER_MHZ && freq < 12500 * HZ_PER_MHZ) {
> > +		hpf_step = 15;
> > +		hpf_band = 3;
> > +
> > +		goto hpf_write;
> > +	}
> > +
> > +	min_freq_error = U64_MAX;
> >  	for (i = 0; i < 4; i++) {
> 
> Can we get that 4 from an array size rather than hard coding here?
>

Sure, noted for v5.

> > +		/* This (and therefore all other ranges) have a corner
> 
> Multiline comment in IIO (and most of kernel for that matter) is
> /*
>  * This...
>

Shoot, I figured check_patch would have caught that. Noted for v5

> > +		 * frequency higher than the target frequency.
> > +		 */
> > +		if (freq_range_hpf[i][0] > freq)
> > +			break;
> > +
> >  		freq_step = div_u64((freq_range_hpf[i][1] -
> >  			freq_range_hpf[i][0]), 15);
> >  
> > -		if (freq > freq_range_hpf[i][0] &&
> > -		    (freq < freq_range_hpf[i][1] + freq_step)) {
> > -			hpf_band = i + 1;
> > +		for (j = 0; j <= 15; j++) {
> 
> Similarly, where does the 15 come from?  It's kind of in the old
> code but given you are changing this good to make that clearer in
> some fashion.

Each filter band has 16 possible corners (0-15). I will add a define in v5.

> 
> > +			freq_corner = freq_range_hpf[i][0] + (freq_step * j);
> No need for brackets around the two multiplied term.
> 
> For all these comments check for other instances. I'm just pointing out one.

Noted.

> > +
> > +			/* This (and therefore all other steps) have a corner
> > +			 * frequency higher than the target frequency.
> > +			 */
> > +			if (freq_corner > freq)
> > +				break;
> >  
> > -			for (j = 1; j <= 16; j++) {
> > -				if (freq < (freq_range_hpf[i][0] + (freq_step * j))) {
> > -					hpf_step = j - 1;
> > -					break;
> > -				}
> > +			freq_error = freq - freq_corner;
> > +			if (freq_error < min_freq_error) {
> > +				min_freq_error = freq_error;
> > +				hpf_step = j;
> > +				hpf_band = i + 1;
> >  			}
> > -			break;
> >  		}
> >  	}
> >  
> > -	/* Close HPF frequency gap between 12 and 12.5 GHz */
> > -	if (freq >= 12000 * HZ_PER_MHZ && freq <= 12500 * HZ_PER_MHZ) {
> > -		hpf_band = 3;
> > -		hpf_step = 15;
> > -	}
> > -
> >  hpf_write:
> >  	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
> >  				 ADMV8818_SW_IN_SET_WR0_MSK |
> > @@ -186,7 +204,11 @@ static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
> >  
> >  static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
> >  {
> > -	unsigned int lpf_step = 0, lpf_band = 0, i, j;
> > +	int i, j;
> 
> Might as well combine with declaration of ret below.
>

Noted.

> > +	unsigned int lpf_step = 0, lpf_band = 0;
> > +	u64 freq_error;
> > +	u64 min_freq_error;
> > +	u64 freq_corner;
> Good to combine a few of these related u64 as single line declaration..
>

Noted.

> >  	u64 freq_step;
> >  	int ret;
> >  
> > @@ -199,18 +221,34 @@ static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
> >  		goto lpf_write;
> >  	}
> >  
> > -	for (i = 0; i < 4; i++) {
> > -		if (freq > freq_range_lpf[i][0] && freq < freq_range_lpf[i][1]) {
> > -			lpf_band = i + 1;
> > -			freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
> > -
> > -			for (j = 0; j <= 15; j++) {
> > -				if (freq < (freq_range_lpf[i][0] + (freq_step * j))) {
> > -					lpf_step = j;
> > -					break;
> > -				}
> > -			}
> > +	min_freq_error = U64_MAX;
> > +	for (i = 3; i >= 0; --i) {
> 
> As above. If that 3 comes from an array size, please make that clear.
>

Noted.

> > +		/* At this point the highest corner frequency of
> > +		 * all remaining ranges is below the target.
> > +		 * LPF corner should be >= the target.
> > +		 */
> > +		if (freq > freq_range_lpf[i][1])
> >  			break;
> > +
> > +		freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
> > +
> > +		for (j = 15; j >= 0; --j) {
> > +
> > +			freq_corner = freq_range_lpf[i][0] + j*freq_step;
> > +
> > +			/* At this point all other steps in range will
> > +			 * place the corner frequency below the target
> > +			 * LPF corner should >= the target.
> > +			 */
> > +			if (freq > freq_corner)
> > +				break;
> > +
> > +			freq_error = freq_corner - freq;
> > +			if (freq_error < min_freq_error) {
> > +				min_freq_error = freq_error;
> > +				lpf_step = j;
> > +				lpf_band = i + 1;
> > +			}
> >  		}
> >  	}
> >  
> > @@ -242,16 +280,28 @@ static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
> >  static int admv8818_rfin_band_select(struct admv8818_state *st)
> >  {
> >  	int ret;
> > +	u64 hpf_corner_target, lpf_corner_target;
> >  
> >  	st->cf_hz = clk_get_rate(st->clkin);
> >  
> > +	// Check for underflow
> 
> No C++ style comments in IIO code.  This is just a consistency thing rather than
> really matter. We have lots of code that predates those being at all acceptable
> in the kernel and a mixture of the two styles is messy!
>

Bugger. check_patch failed me again :)
Noted. I will go through and address all comments to make sure they fit the style.  

> > +	if (st->cf_hz > st->hpf_margin_hz)
> > +		hpf_corner_target = st->cf_hz - st->hpf_margin_hz;
> > +	else
> > +		hpf_corner_target = 0;
> > +
> > +	// Check for overflow
> > +	lpf_corner_target = st->cf_hz + st->lpf_margin_hz;
> > +	if (lpf_corner_target < st->cf_hz)
> > +		lpf_corner_target = U64_MAX;
> > +
> >  	mutex_lock(&st->lock);
> >  
> > -	ret = __admv8818_hpf_select(st, st->cf_hz);
> > +	ret = __admv8818_hpf_select(st, hpf_corner_target);
> >  	if (ret)
> >  		goto exit;
> >  
> > -	ret = __admv8818_lpf_select(st, st->cf_hz);
> > +	ret = __admv8818_lpf_select(st, lfp_corner_target);
> >  exit:
> >  	mutex_unlock(&st->lock);
> >  	return ret;
> > @@ -647,6 +697,26 @@ static int admv8818_clk_setup(struct admv8818_state *st)
> >  	return devm_add_action_or_reset(&spi->dev, admv8818_clk_notifier_unreg, st);
> >  }
> >  
> > +static int admv8818_read_properties(struct admv8818_state *st)
> > +{
> > +	struct spi_device *spi = st->spi;
> > +	int ret;
> > +
> > +	ret = device_property_read_u64(&spi->dev, "adi,lpf-margin-hz", &st->lpf_margin_hz);
> > +	if (ret == -EINVAL)
> > +		st->lpf_margin_hz = 0;
> > +	else if (ret < 0)
> > +		return ret;
> Often for properties with defaults we don't worry too much about checking for errors other
> than 'not there'. So I'd be fine with this being the simpler.
> 
> 	st->lpf_margin_hz = 0;
> 	device_property_read_u64(...)
> 
> and no explicit error checking.
> 
> If you really want to retain the protection against wrong formats etc, then fair enough.

My only concern that the user will have no feedback that his or her filter settings are not being used which could lead to subtle, hard to track down frequency responses. Would it be more appropriate here to print a warning instead of returning an error?

> > +
> > +	ret = device_property_read_u64(&spi->dev, "adi,hpf-margin-hz", &st->hpf_margin_hz);
> > +	if (ret == -EINVAL)
> > +		st->hpf_margin_hz = 0;
> > +	else if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> >  static int admv8818_probe(struct spi_device *spi)
> >  {
> >  	struct iio_dev *indio_dev;
> > @@ -678,6 +748,10 @@ static int admv8818_probe(struct spi_device *spi)
> >  
> >  	mutex_init(&st->lock);
> >  
> > +	ret = admv8818_read_properties(st);
> I haven't checked but if this is first place that you use property.h then
> need that included.
> 
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = admv8818_init(st);
> >  	if (ret)
> >  		return ret;
> 

