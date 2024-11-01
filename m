Return-Path: <linux-iio+bounces-11779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3757F9B939D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF9F28344D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD51AA793;
	Fri,  1 Nov 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDddxVyQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00371A256C;
	Fri,  1 Nov 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472412; cv=none; b=EPtxcyjws9ICf8HAGifdCLXEflzDwEjCfSsX+dICY3VZCoh9whVF0GXI6ZmeEhD0wxkPqyPWBSEIHaSUwb+oVS6tb+9OdSJXhi00z/0QikuF/6KBGrHe9EtKOKa4scr1bZBrOEqkobtc662UYQVV1I7A2I//7xwM1BaVbTvelPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472412; c=relaxed/simple;
	bh=bfFO/ERSw8GFISafMmt/GXTEGunK8+XOPLQBkHfdAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqRODx+vXBkFfNOdosImyMYqHkizrfK7ewcjxiPvMy4Qvs8sNTGvP73Rt4CCI8mdsng/M1s7by3XIYQMXra2PZJqnq2xCo9siduj7QvV3R1LgPblo6dQ+apltGaEhi8SEGIq0gkjTCtrjWG88/ei9N/5RQ+VZkHyZvoOtDF1uBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDddxVyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6A3C4CED7;
	Fri,  1 Nov 2024 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730472412;
	bh=bfFO/ERSw8GFISafMmt/GXTEGunK8+XOPLQBkHfdAmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TDddxVyQR0FUm6pjmmMW2dVPgc04B5swwgREsKOfWb2ZdTfKeigu0o9dcZmQXaz6S
	 /n9TFX15Me3XU/Ow+MeDfREsCSmPQbRk62IC/1OKIZ/rtpb3TPbUVvvo0UKzAzK/dQ
	 UE/KQPhrQbw4/bngN584H2Gmp6tLzZWNHmzscblAtZPur1kzIxnZ0+e9lfJxZTFpGx
	 za714FhhY9vidHfBPnprtYFe82fInGOgd9nsfhJ8jMzQFy+F6whQnQaTT8cdOS4ODv
	 lR6N2qbhThRY5W7R4u2qYqCdVvM95cpH+Ig8MLkpdE266Zi+TAyR97tACwRhJtf7Wr
	 kHLT/DdM89/AA==
Date: Fri, 1 Nov 2024 14:46:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Angelo
 Dureghello <adureghello@baylibre.com>, Conor Dooley
 <conor.dooley@microchip.com>, <lkp@intel.com>
Subject: Re: [PATCH v9 0/8] iio: add support for the ad3552r AXI DAC IP
Message-ID: <20241101144641.512e2ed5@jic23-huawei>
In-Reply-To: <20241031212626.64b30020@jic23-huawei>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
	<139a7fb4-124a-4d0e-b1a1-32f8d2fb65f2@baylibre.com>
	<20241031212626.64b30020@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 21:26:26 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 29 Oct 2024 14:08:15 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 10/28/24 4:45 PM, Angelo Dureghello wrote:  
> > > Purpose is to add ad3552r AXI DAC (fpga-based) support.
> > > 
> > > The "ad3552r" AXI IP, a variant of the generic "DAC" AXI IP,
> > > has been created to reach the maximum speed (33MUPS) supported
> > > from the ad3552r. To obtain the maximum transfer rate, a custom
> > > IP core module has been implemented with a QSPI interface with
> > > DDR (Double Data Rate) mode.
> > > 
> > > The design is actually using the DAC backend since the register
> > > map is the same of the generic DAC IP, except for some customized
> > > bitfields. For this reason, a new "compatible" has been added
> > > in adi-axi-dac.c.
> > > 
> > > Also, backend has been extended with all the needed functions
> > > for this use case, keeping the names gneric.
> > > 
> > > The following patch is actually applying to linux-iio/testing.
> > > 
> > > ---    
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> >   
> 
> Series applied with 2 tweaks as called out in replies to individual
> patches. Pushed out initially as testing for 0-day to see if there
> are any issues my (admittedly now very lazy) build tests didn't find.
 [jic23-iio:testing 104/113]  drivers/iio/dac/ad3552r-hs.c:400:17: warning: variable 'goffs' is  uninitialized when used here

was a report from 0-day. 
I 'think' the fix (based on v6 which is last time anything set this)
is the following and that's what I'll push out for now.

If it should be something else send me a patch on top of my testing branch
so I can quickly apply it.

I've also dropped the explicit select of ADI_AXI_DAC as you can only do that
if you also carry all it's dependencies. (another 0-day report)

Thanks as ever to the lkp team for their incredibly useful service!



diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 97dfc598aec6..7a5b277ee370 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -295,7 +295,6 @@ static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
 
 static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 {
-       s16 goffs;
        u16 id;
        u16 gain = 0, offset = 0;
        u32 ch, val, range;
@@ -397,7 +396,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
                        gain = ad3552r_calc_custom_gain(st->ch_data[ch].p,
                                                st->ch_data[ch].n,
                                                st->ch_data[ch].gain_offset);
-                       offset = abs(goffs);
+                       offset = abs(st->ch_data[ch].gain_offset);
 
                        st->ch_data[ch].range_override = 1;


> 
> Thanks,
> 
> Jonathan
> 


