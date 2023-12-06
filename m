Return-Path: <linux-iio+bounces-672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB14807679
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D04281D01
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0705E675B5;
	Wed,  6 Dec 2023 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMMe/r8Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AD60B97;
	Wed,  6 Dec 2023 17:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B587CC433C8;
	Wed,  6 Dec 2023 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701883436;
	bh=yQe1hhlghXHIzeiywFrRp3JcvgCHn8uJPfTmcmii+1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jMMe/r8QHUccNDjXTTOizpkzKyNNGBKGR82CuZoyie63yGMIoebvA3O9f3iCgtmEJ
	 qvA3GEEAVkJgY+8HtSmq1Ppu0xbdUxiWl7fmOXb8mis9E6jZGuFyDk2XfKtrLAeIcH
	 CN8rEwgY2HtYCY+/0HU6+VRhvj7HbulswkkyPenAU4npSoX9auvAxsgLREwPQLwzEJ
	 pw3wcTGFdCQooK0Yo4KQY0aFR2r5jhRMSDWGLBTT/whG1oBNGRAyrC+5wECfec8Ezg
	 kdjY3BQAJafPlXReKBWm0rHey5eBhnptM/sTt9yGUuvL2gVXd2DtDABh5gEPAvdCiK
	 kVGzFYKK/tnuA==
Date: Wed, 6 Dec 2023 17:23:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231206172343.100e8bd7@jic23-huawei>
In-Reply-To: <0ae6466f-479a-476a-adf4-3bd099235eda@denx.de>
References: <20231127212726.77707-1-marex@denx.de>
	<20231127212726.77707-2-marex@denx.de>
	<20231204112941.770e22cb@jic23-huawei>
	<0ae6466f-479a-476a-adf4-3bd099235eda@denx.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 02:43:30 +0100
Marek Vasut <marex@denx.de> wrote:

> On 12/4/23 12:29, Jonathan Cameron wrote:
> > On Mon, 27 Nov 2023 22:26:53 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> The ISL76682 is very basic ALS which only supports ALS or IR mode
> >> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> >> other fancy functionality.
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Signed-off-by: Marek Vasut <marex@denx.de>  
> > 
> > There is a additional question on what scale means for
> > an IR channel.  There aren't any well defined units (as it depends
> > on the sensitivity curve) so in general we avoid providing scale
> > for intensity readings.
> > 
> > The datasheet has a vague go at working around this problem by
> > using counts relative to IR measurement in daylight which would
> > measure 210 LUX.  (via faking that with a 850nm green led??)
> > 
> > That's far from a standard..
> > 
> > We do have precedence of scale applied to intensity channels
> > so I guess the ship has sailed.
> > 
> > Perhaps we should just add an explicit not to the ABI docs
> > to cover that changing the scale in these sensors will result
> > in the counts changing, but multiplying raw by scale isn't going
> > to give any sensible units.
> > 
> > So probably not a thing to fix in this series, but to address
> > separately.  
> 
> Is something like this what you have in mind ?

Yes, something along those lines.  We could add more detail on why
but perhaps that would just confuse things more than just stating
it is the case.

> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
> b/Documentation/ABI/testing/sysfs-bus-iio
> index 0eadc08c3a139..584607f560d02 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -618,7 +618,9 @@ KernelVersion:      2.6.35
>   Contact:       linux-iio@vger.kernel.org
>   Description:
>                  If a discrete set of scale values is available, they
> -               are listed in this attribute.
> +               are listed in this attribute. Unlike illumination,
> +               multiplying intensity by intensity_scale does not
> +               yield value with any standardized unit .
> 
>   What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
>   What:          /sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain
> 


