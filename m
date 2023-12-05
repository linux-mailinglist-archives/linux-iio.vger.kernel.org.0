Return-Path: <linux-iio+bounces-618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2B804403
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 02:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F841C20C0E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66841110;
	Tue,  5 Dec 2023 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CkLS8IFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC2119D;
	Mon,  4 Dec 2023 17:24:55 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F147087635;
	Tue,  5 Dec 2023 02:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701739493;
	bh=SMpoj3TwLBc6FRec2SncQ6GPRVXqJWojVtlhmJKNFI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CkLS8IFvjXLtTLlhRF+b4ab+dZ0HOHQ7uUhJBmX2JhW9DVJBB0r2111PhJVEofS1K
	 qi8onZxUvdzP0+rwAftAmGHtNdwYxWiAtbLBcAQApJhaaWDVRjjCMs6fala6soG/vJ
	 hyjQK3X6RnxAghmCAZpakN39GB9BwehA0wmxa811GTAYTQg4ULId9e8IyNSSbLkeyg
	 A6GVq/G67n8ilNxxU6s976cLDzbc8/E3JC2lBijViaw4+RnN0OQFCmeti4YYr/mj19
	 jNLX9j4b3pUrctShB04VxaCj1A7ahlux7yV+f2e+ChD7rK3YaEZRH+5ch8y4/r/O4c
	 fSJFYUHSipY+A==
Message-ID: <e3d3cc61-0d31-4d83-92a9-07d74995a66a@denx.de>
Date: Tue, 5 Dec 2023 02:24:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231127212726.77707-1-marex@denx.de>
 <20231127212726.77707-2-marex@denx.de> <20231204112001.7dff7066@jic23-huawei>
 <6e4ed42c-21be-469c-a8bb-57779ef24bf9@denx.de>
 <20231204143521.5ca0fc7e@jic23-huawei>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231204143521.5ca0fc7e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/4/23 15:35, Jonathan Cameron wrote:
> On Mon, 4 Dec 2023 12:23:06 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 12/4/23 12:20, Jonathan Cameron wrote:
>>> On Mon, 27 Nov 2023 22:26:53 +0100
>>> Marek Vasut <marex@denx.de> wrote:
>>>    
>>>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>>>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>>>> other fancy functionality.
>>>>
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Hi Marek,
>>>
>>> Discussion around available on v5 made me look closer at that aspect.
>>> You are providing all the available entries in the callback but they
>>> shouldn't be exposed to actually read unless the *_available bitmap
>>> bits corresponding to them are set.
>>>
>>> If you like I can just rip the unused code out whilst applying?
>>> Or if you'd prefer to send a v7 that's great too.
>>>
>>> Otherwise everything looks good to me.
>>
>> Maybe just do that while applying and I'll test it right after to see
>> whether something broke, that's probably fastest. Just let me know where
>> this got applied. I have the device on my desk .
> 
> Diff is below.  Applied to the togreg

I only found the commit in 'testing' branch , so I used that one .

> branch of iio.git and initially pushed out
> as testing for normal reasons + for you to test.
> 
> Thanks,
> 
> Jonathan
> 
> 
> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> index 15a68609985b..8605187bfb62 100644
> --- a/drivers/iio/light/isl76682.c
> +++ b/drivers/iio/light/isl76682.c
> @@ -184,8 +184,6 @@ static int intensity_scale_available[] = {
>          0, 673000,
>   };
>   
> -static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
> -
>   static int isl76682_read_avail(struct iio_dev *indio_dev,
>                                 struct iio_chan_spec const *chan,
>                                 const int **vals, int *type,
> @@ -207,11 +205,6 @@ static int isl76682_read_avail(struct iio_dev *indio_dev,
>                  default:
>                          return -EINVAL;
>                  }
> -       case IIO_CHAN_INFO_INT_TIME:
> -               *vals = integration_time_available;
> -               *length = ARRAY_SIZE(integration_time_available);
> -               *type = IIO_VAL_INT_PLUS_MICRO;
> -               return IIO_AVAIL_LIST;
>          default:
>                  return -EINVAL;
>          }

Ah, looking at the attrs before and after, now I get it:

$ grep -H . /sys/bus/iio/devices/iio\:device0/*
/sys/bus/iio/devices/iio:device0/in_illuminance_raw:21
/sys/bus/iio/devices/iio:device0/in_illuminance_scale:0.015000
/sys/bus/iio/devices/iio:device0/in_illuminance_scale_available:0.015 
0.06 0.24 0.96
/sys/bus/iio/devices/iio:device0/in_intensity_raw:33
/sys/bus/iio/devices/iio:device0/in_intensity_scale:0.010500
/sys/bus/iio/devices/iio:device0/in_intensity_scale_available:0.0105 
0.042 0.168 0.673
/sys/bus/iio/devices/iio:device0/integration_time_available:0.090
/sys/bus/iio/devices/iio:device0/name:isl76682

/sys/bus/iio/devices/iio:device0/in_illuminance_raw:22
/sys/bus/iio/devices/iio:device0/in_illuminance_scale:0.015000
/sys/bus/iio/devices/iio:device0/in_illuminance_scale_available:0.015000 
0.060000 0.240000 0.960000
/sys/bus/iio/devices/iio:device0/in_intensity_raw:24
/sys/bus/iio/devices/iio:device0/in_intensity_scale:0.010500
/sys/bus/iio/devices/iio:device0/in_intensity_scale_available:0.010500 
0.042000 0.168000 0.673000
/sys/bus/iio/devices/iio:device0/integration_time:0.090000
/sys/bus/iio/devices/iio:device0/name:isl76682

Thanks !

