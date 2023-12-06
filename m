Return-Path: <linux-iio+bounces-670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEFD80766B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB63282019
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4719C675A1;
	Wed,  6 Dec 2023 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIX1Wpc1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CFD4F1F3;
	Wed,  6 Dec 2023 17:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7059FC433C7;
	Wed,  6 Dec 2023 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701883261;
	bh=iH7nPHv7nxpFTnIIg5qFfUrheqhXwiZvAbuhhnhnD5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qIX1Wpc1Cfak05zq3VEDdoG6lSNrfrxg1aYzsZsFzZe2F46yhsQZKyGF6Q156REbk
	 LSKVZEUDw76FFya1TD/UUG7Sb+lIAhZdIAMF562U+h00IDFbtnGMo4Trca8Ho1YNQ9
	 fR19lCCyY4x6/Mz+Os1qhrGEeQHDZWPZo7RFX7lEoajCwOtYy+bufdZpgB7Z4ncWeF
	 Bf1pZY+rrn+J+vGUVf17jNIaNpJqYcvQ/edmYuWwLR050gD2V7qk50PiJDumhdavg5
	 BEtx6UJUWBwZ6P9bOOoT0de7Q/TOZSLWmuy0PboqvsiCrYFn8kgk84a2zgphLhj5Do
	 SCrZkpwszikgw==
Date: Wed, 6 Dec 2023 17:20:49 +0000
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
Message-ID: <20231206172049.3e0ce859@jic23-huawei>
In-Reply-To: <e3d3cc61-0d31-4d83-92a9-07d74995a66a@denx.de>
References: <20231127212726.77707-1-marex@denx.de>
	<20231127212726.77707-2-marex@denx.de>
	<20231204112001.7dff7066@jic23-huawei>
	<6e4ed42c-21be-469c-a8bb-57779ef24bf9@denx.de>
	<20231204143521.5ca0fc7e@jic23-huawei>
	<e3d3cc61-0d31-4d83-92a9-07d74995a66a@denx.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 02:24:51 +0100
Marek Vasut <marex@denx.de> wrote:

> On 12/4/23 15:35, Jonathan Cameron wrote:
> > On Mon, 4 Dec 2023 12:23:06 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> On 12/4/23 12:20, Jonathan Cameron wrote:  
> >>> On Mon, 27 Nov 2023 22:26:53 +0100
> >>> Marek Vasut <marex@denx.de> wrote:
> >>>      
> >>>> The ISL76682 is very basic ALS which only supports ALS or IR mode
> >>>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> >>>> other fancy functionality.
> >>>>
> >>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>  
> >>> Hi Marek,
> >>>
> >>> Discussion around available on v5 made me look closer at that aspect.
> >>> You are providing all the available entries in the callback but they
> >>> shouldn't be exposed to actually read unless the *_available bitmap
> >>> bits corresponding to them are set.
> >>>
> >>> If you like I can just rip the unused code out whilst applying?
> >>> Or if you'd prefer to send a v7 that's great too.
> >>>
> >>> Otherwise everything looks good to me.  
> >>
> >> Maybe just do that while applying and I'll test it right after to see
> >> whether something broke, that's probably fastest. Just let me know where
> >> this got applied. I have the device on my desk .  
> > 
> > Diff is below.  Applied to the togreg  
> 
> I only found the commit in 'testing' branch , so I used that one .
I messed up it seems and didn't actually push the updated version.
Done so now along with squashing in the bracket tidy up.
> 
> > branch of iio.git and initially pushed out
> > as testing for normal reasons + for you to test.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > 
> > diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> > index 15a68609985b..8605187bfb62 100644
> > --- a/drivers/iio/light/isl76682.c
> > +++ b/drivers/iio/light/isl76682.c
> > @@ -184,8 +184,6 @@ static int intensity_scale_available[] = {
> >          0, 673000,
> >   };
> >   
> > -static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
> > -
> >   static int isl76682_read_avail(struct iio_dev *indio_dev,
> >                                 struct iio_chan_spec const *chan,
> >                                 const int **vals, int *type,
> > @@ -207,11 +205,6 @@ static int isl76682_read_avail(struct iio_dev *indio_dev,
> >                  default:
> >                          return -EINVAL;
> >                  }
> > -       case IIO_CHAN_INFO_INT_TIME:
> > -               *vals = integration_time_available;
> > -               *length = ARRAY_SIZE(integration_time_available);
> > -               *type = IIO_VAL_INT_PLUS_MICRO;
> > -               return IIO_AVAIL_LIST;
> >          default:
> >                  return -EINVAL;
> >          }  
> 
> Ah, looking at the attrs before and after, now I get it:
> 
> $ grep -H . /sys/bus/iio/devices/iio\:device0/*
> /sys/bus/iio/devices/iio:device0/in_illuminance_raw:21
> /sys/bus/iio/devices/iio:device0/in_illuminance_scale:0.015000
> /sys/bus/iio/devices/iio:device0/in_illuminance_scale_available:0.015 
> 0.06 0.24 0.96
> /sys/bus/iio/devices/iio:device0/in_intensity_raw:33
> /sys/bus/iio/devices/iio:device0/in_intensity_scale:0.010500
> /sys/bus/iio/devices/iio:device0/in_intensity_scale_available:0.0105 
> 0.042 0.168 0.673
> /sys/bus/iio/devices/iio:device0/integration_time_available:0.090
> /sys/bus/iio/devices/iio:device0/name:isl76682
> 
> /sys/bus/iio/devices/iio:device0/in_illuminance_raw:22
> /sys/bus/iio/devices/iio:device0/in_illuminance_scale:0.015000
> /sys/bus/iio/devices/iio:device0/in_illuminance_scale_available:0.015000 
> 0.060000 0.240000 0.960000
> /sys/bus/iio/devices/iio:device0/in_intensity_raw:24
> /sys/bus/iio/devices/iio:device0/in_intensity_scale:0.010500
> /sys/bus/iio/devices/iio:device0/in_intensity_scale_available:0.010500 
> 0.042000 0.168000 0.673000
> /sys/bus/iio/devices/iio:device0/integration_time:0.090000
> /sys/bus/iio/devices/iio:device0/name:isl76682
> 
> Thanks !
> 


