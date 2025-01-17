Return-Path: <linux-iio+bounces-14435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01383A1554E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 18:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40133A3689
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1119F461;
	Fri, 17 Jan 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OjjnFUHT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2219EEBD
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133750; cv=none; b=b38H7Cx/r3JmHcNL7tsEZuKW+INMO9BhjFlaJSm9DOUVifODqkkBVIjRYSGOWMwl31scT85poeafgAtUNsaT2VMEmm/0lXFzd5UInEnD7AWBxikkEFCSjEpwhxV2jQdZucw9FxwEplJP1RbjAKvQURb0zUN0vFYhETCwampcHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133750; c=relaxed/simple;
	bh=GQsq+F7zA1DuWpXElMWopd8uifYdKlm8EaeJLolsG1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5sZWkwjX5h343Wj+/XYN+nPNpval1DdlFHtYPmgiheDENXHCRmP980Y+Bad4TlPFVkBtVYhkNAcr6iY2xM2H5mh2BGdsXg4TqcR3nOacrs0S089uF4asNaZFwnZnpZ6ONrYs+MSrSlvtrut4TlKgSRURFFiX6pv7K1b2d+GTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OjjnFUHT; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb9a0a2089so1239071b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 09:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737133747; x=1737738547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pd2mM284nu/1WMfOl9weOh16uftldviBpS/+L7i4W1U=;
        b=OjjnFUHTAg3o1YXzsp0NiYAPdtB9XWXMz0CJThgoeo3hFF8B8Z4V6b4Sposq2O2ety
         vjU2GRxWBYC0wPD4hNHUTv3LZuKBzEVD/HCQgzM/NU4w4an+fcQr3Ftut62sf3WCMstz
         TsGYWjQSmozrjnoUyEbor67GPpp8EneONu/v+KVL9botX0Q7EbfSJIU2N/uL2+XOSONw
         VWgliiWsK5qWi9JSlhNCbbsvgVCN5eBewoObvxnMbiouC+EXh3hLCC/eOHuX4qYXc848
         h7xaNqKw053clg6xvsSr8RNkK/XixmoDNpvVOYeRP4H1rHG8NeSIyfQVJpN2fsejA9P2
         f7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133747; x=1737738547;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd2mM284nu/1WMfOl9weOh16uftldviBpS/+L7i4W1U=;
        b=d2/Y2JdVeuibmNMeLgSZQG1NZUTyGug/MGImq3c+Q98h8upHLqYputIQLSW518hcPK
         wLO2rqqnEDbmrMRW8FTibh4qUl4fU98CLRWtkEzjVfCvOOeD5N3T92NnlifNgud7Zy3g
         1Tk/4aBsIEh36f7zD999vgc9EHL7VBFA7nD+dh3cJ5PocW1fdKsa16Rcfij7uWCPr2AL
         LDlJQot5IwiZ2wyeQwrQTpYgWFXbgZm0fUF4AE7697PZFwLAQs66KEY+635gdYbB8fOW
         ZGvdYaKL23JEcKJ67WyYNN5+ZzyFORqw5hirBpSOHBMrQWDbWLkghDL6luQbnfwqxii8
         e2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIaGDu8/qjEIfBnuQiwTY9XJR7q+LZC6eccb5KrhzbSmjmhypeRCTYfgqajyot3vso37Ni/mK2bAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRMBBIEHB75gRNk5zHoBmbmm0HzV1+sPFE3TzchhDCSIMCsUR
	zexep8AB1jbFAf6+3XDOwNGY+vfJxxXGHMMiTpKzTXTTOD1PRVI+2wXVLDkedNE=
X-Gm-Gg: ASbGncuV1iq+ZmRM0J0oC84Zk1oSyXKGrLenO0PuKjF48LaWcZqE/Ia8c3vaxohmgLH
	Yw+VvTpvCmEMVTBGXedOSyVPMToN+JDKk9T401eAhV3ZiEYMcgecSvxUG1mYSVD9EUJYOS0iybd
	lT1D4EY3dqSw9sJX8G8+wjGY0zvy058ejCY8nNijAng2QxEV/OoBEnWiYUTH7NbKaKk3/GusK5X
	o9y4/H+ShVcWNF64winn9moJEOoJz3KXVt9AZ0asCRLaufgB0mKVl8226LCFtLKCFecYLCFmI5f
	C9RFRq+g3uW10Fph2w==
X-Google-Smtp-Source: AGHT+IEPSz+mgL97otCibvYhbniO7AQ7rHqR/4jbswbIP8oUN5lgewAOdrBOIyHlAR7qfcfaHwbvmw==
X-Received: by 2002:a05:6808:2199:b0:3eb:5c3d:35a7 with SMTP id 5614622812f47-3f19fd7b5d6mr2093866b6e.34.1737133746931;
        Fri, 17 Jan 2025 09:09:06 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19da6f3casm866483b6e.19.2025.01.17.09.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 09:09:05 -0800 (PST)
Message-ID: <67dc52c4-5252-40c3-b89e-8e46e3c2df27@baylibre.com>
Date: Fri, 17 Jan 2025 11:09:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/17] iio: adc: ad4695: Add support for SPI offload
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
 <20250113-dlech-mainline-spi-engine-offload-2-v7-14-e0860c81caae@baylibre.com>
 <ls32gl5a7nsihmmpfabxhm6ilg7idyxdhyrhbkay6e2fiokoah@o5ujfxlsq3s3>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <ls32gl5a7nsihmmpfabxhm6ilg7idyxdhyrhbkay6e2fiokoah@o5ujfxlsq3s3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 9:47 AM, Angelo Dureghello wrote:
> Hi,
> 
> noticed just one possible issue here, see below.
> 
> On 13.01.2025 15:00, David Lechner wrote:
>> Add support for SPI offload to the ad4695 driver. SPI offload allows
>> sampling data at the max sample rate (500kSPS or 1MSPS).
>>
>> This is developed and tested against the ADI example FPGA design for
>> this family of ADCs [1].
>>
>> [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v7 changes: none
>>
>> v6 changes:
>> * Fixed use of c++ style comments
>> * Moved static const struct definition out of probe function
>> * Changes bits_per_word to always be 19 for future oversampling
>>   compatibility (Trevor is working on implementing oversampling support
>>   on top of this patch, so we have high confidence this is the correct
>>   thing to do)
>> * Fixed wrong xfer->len
>>
>> v5 changes:
>> * Register SCLK speed handling has been split out into a separate series.
>> * Add sampling_frequency_available attribute.
>> * Limit max allowed sampling frequency based on chip info.
>> * Expand explanations of offload enable/disable ordering requirements.
>> * Finish TODO to use macros for phandle arg values.
>> * Don't use dev_info() when falling back to non-offload operation.
>> * Update to accommodate changes in other patches in this series.
>>
>> v4 changes: new patch in v4
>> ---
>>  drivers/iio/adc/Kconfig  |   1 +
>>  drivers/iio/adc/ad4695.c | 445 +++++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 429 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 995b9cacbaa964d26424346120c139858f93cdcd..ec60b64c46e187e2be18ab1f8ca9e6f4f03299f9 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -52,6 +52,7 @@ config AD4695
>>  	tristate "Analog Device AD4695 ADC Driver"
>>  	depends on SPI
>>  	select IIO_BUFFER
>> +	select IIO_BUFFER_DMAENGINE
>>  	select IIO_TRIGGERED_BUFFER
>>  	select REGMAP
>>  	help
>> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
>> index 13cf01d35301be40369571e7dd2aeac1a8148d15..c8cd73d19e869f11999608f61df5724d329b4427 100644
>> --- a/drivers/iio/adc/ad4695.c
>> +++ b/drivers/iio/adc/ad4695.c
>> @@ -19,14 +19,19 @@
>>  #include <linux/device.h>
>>  #include <linux/err.h>
>>  #include <linux/gpio/consumer.h>
>> +#include <linux/iio/buffer-dmaengine.h>
>>  #include <linux/iio/buffer.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/triggered_buffer.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  #include <linux/minmax.h>
>> +#include <linux/mutex.h>
>>  #include <linux/property.h>
>> +#include <linux/pwm.h>
>>  #include <linux/regmap.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/spi/offload/consumer.h>
>> +#include <linux/spi/offload/provider.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/units.h>
> 
> ...
> 
>> +static int ad4695_offload_trigger_request(struct spi_offload_trigger *trigger,
>> +					  enum spi_offload_trigger_type type,
>> +					  u64 *args, u32 nargs)
>> +{
>> +	struct ad4695_state *st = spi_offload_trigger_get_priv(trigger);
>> +
>> +	/* Should already be validated by match, but just in case. */
>> +	if (nargs != 2)
>> +		return -EINVAL;
>> +
>> +	/* DT tells us if BUSY event uses GP0 or GP3. */
>> +	if (args[1] == AD4695_TRIGGER_PIN_GP3)
>> +		return regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
>> +				       AD4695_REG_GP_MODE_BUSY_GP_SEL);
>> +
>> +	return regmap_clear_bits(st->regmap, AD4695_REG_GPIO_CTRL,
>> +				 AD4695_REG_GP_MODE_BUSY_GP_SEL);
> 
> This should probably be:
>          
>         return regmap_clear_bits(st->regmap, AD4695_REG_GPIO_MODE,
>                                  AD4695_REG_GP_MODE_BUSY_GP_SEL);
> 

Indeed, thanks! Hopefully we won't need a v8 and Jonathan can fix while
applying. :-)

>> +}
>> +
> 
> Regards,
> angelo
> 


