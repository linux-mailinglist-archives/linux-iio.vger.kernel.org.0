Return-Path: <linux-iio+bounces-6887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D291634B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 11:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A038D1C20B16
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB411494AF;
	Tue, 25 Jun 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfPSfPyF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061C1465A8;
	Tue, 25 Jun 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308706; cv=none; b=qE26gU+LpB90CNMPAOWs3UNmcwwkK+aq7LdsLEUd08uPeiwqRTNpZ0nbXjqdiVXZrZzgDYLSboyjJQWL1KAbkxPcFLEYFIZaH6x+PllPoU54ib/kjrrLuR7ukgY4rhX6r43+csI9m/Hio88jUrVyCZ5Oh6AERxEEmDc+UIwdS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308706; c=relaxed/simple;
	bh=krS9Mvgfv1r674P7O4ypAF9zYi3Xvttv5EIqPXv17L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNOKB71XS25yK48QPFi8/lcxhbrFSTxUdbptsmuAjKeA3sEfefy5jTzXn5yRa9Hsl7aB7wL8Yu+QJjoB2+C9UEnW53gJ06UdpO5X1rSaK1/UTuSWU9I6AOGohBpDQ1JM5hLDbEE2G6RQ2wzgEPDynw6t3Cww/xnWMD6wWVMtdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfPSfPyF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424a2dabfefso4342625e9.3;
        Tue, 25 Jun 2024 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719308703; x=1719913503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIIIZAn/vUy65QsZqccsqK6cOs9yt5zxfHhX9sIjtcA=;
        b=LfPSfPyFPVTEJsVA5pTdup3x+7wKZMgz323RQvCMJAQRCBQnf8Zb5ijkjuvbO26rjs
         3DgCpEAlcv17r+uYtFQtl18wUsrXL7cMlHUEf9wL+2d+rGmQNd8ZdKho6np6ULE2n73U
         Ob50RUaq8EPTVaUrQRg3z8yf9lqk804XrVHxJ+EbA7247lhFQiaZV7Eo3Y8+rlr1VWYj
         qYJ7IDVyHxqL6rrSPvzYygn697LqgFbcNvCcaNzQY52kPXgFAa0E0Nq97JACTO1hsw59
         XJ4F4v0Uvi5eKYSAKNQCVfAgGcolKJhr9kaP23eSOAbc5+dzCX1OjXfz2kwMbT3o4gIp
         jSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719308703; x=1719913503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIIIZAn/vUy65QsZqccsqK6cOs9yt5zxfHhX9sIjtcA=;
        b=vQ8tVeYsvHeJJLZZuxCkFHZonxxQycJrDbnIJaUT8yUTIlphxmPd7It1ZhDrw+3kB+
         NjlY4F4K5lwDG72KE1hMZcCVZs6rZ7XFzpdLJui4GTH+M8Kcpq+SLca7PmH8HB6JAZW8
         uPuVqJfi9+cnUEXblCAwPsVO1oksnRSU2HBOFFRRGjATwYKiPrbsXnDTBDxDR4mkdvLc
         OsWXhXxbpqYaIRqdZqYho3R4N7A1b5FEHFEkPAtzmjRn4TWrOFuLCsu56gcMvoPAbiXD
         MFpXmNsqX+wT1PieiM+ZBbNI6U6KcpViDHc1GSLgRatoJ1BM1T9qzRXQEZHQHYSTQE4o
         6G4g==
X-Forwarded-Encrypted: i=1; AJvYcCXzQ0CA1L8xk09/1CZgf0+E/BIIASrnQW65XUm8ElZWVq70/g2AOp8Y6Owm8JK1+Pdh6vpk9dBmnHUlT19OplejaTFIl+bQK/IMn+da0PLqzyxuYTgoUnPu0I/Nhmkc/fC5F+L+s0bK
X-Gm-Message-State: AOJu0YzIxI1Y/Bfv3mzHITPvPNnROKaj4pNluM46XLeQ0KWrPw6dGOyu
	J/CM8OGKTSDDlThl7IxN93Fb/JYltUGxRp0IMUEnGsehYyN45Gnj/+1q33MV
X-Google-Smtp-Source: AGHT+IFWAG5qBQA3OWxmqrqWaI6eEMkpPQ3v+3BEEFQ2gyEjqVtk+KtJIpGS1Vw1sbSJK7B2rF/hfA==
X-Received: by 2002:a05:600c:2146:b0:422:7a16:6986 with SMTP id 5b1f17b1804b1-4248cc27178mr51563565e9.9.1719308702436;
        Tue, 25 Jun 2024 02:45:02 -0700 (PDT)
Received: from [10.76.84.176] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c789esm12499351f8f.91.2024.06.25.02.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:45:02 -0700 (PDT)
Message-ID: <7f61333b-1d43-4321-aa51-79273255454c@gmail.com>
Date: Tue, 25 Jun 2024 12:44:48 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix disable_one callback
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, dumitru.ceclan@analog.com0,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dumitru Ceclan <dumitru.ceclan@analog.com>
References: <20240621120539.31351-1-dumitru.ceclan@analog.com>
 <CA+GgBR_7OXJLytDeF-MSJSAAgFRJm39wBbEXxSR6HUV_zcWg_A@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CA+GgBR_7OXJLytDeF-MSJSAAgFRJm39wBbEXxSR6HUV_zcWg_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/06/2024 16:26, Alexandru Ardelean wrote:
> On Fri, Jun 21, 2024 at 3:05 PM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:
>>
>> The ADC ad7192 is a sigma delta ADC with a sequencer that does not
>> require a disable_one callback as all enable channel bits are within
>> the same register.
>>
>> Remove the requirement of the disable_one callback for sigma delta ADCs
>> with a sequencer.
>>
>> This patch could be squashed with the commit that it fixes from patch
>> series: Add support for AD411x
>>
> 
> This fix looks fine.
> But, then this raises a question if this needs be to extended to the
> `disable_all` and maybe `indio_dev->info->update_scan_mode` check.
> And if so, how should this be handled?
> 
> For example:
> drivers/iio/adc/ad7124.c:    .disable_all = ad7124_disable_all,
> drivers/iio/adc/ad7173.c:    .disable_all = ad7173_disable_all,
> drivers/iio/adc/ad7192.c:    .disable_all = ad7192_disable_all,
> drivers/iio/adc/ad7192.c:    .disable_all = ad7192_disable_all,
> 
> And:
> drivers/iio/adc/ad7124.c:    ret = ad_sd_init(&st->sd, indio_dev, spi,
> &ad7124_sigma_delta_info);
> drivers/iio/adc/ad7173.c:    ret = ad_sd_init(&st->sd, indio_dev, spi,
> &ad7173_sigma_delta_info);
> drivers/iio/adc/ad7192.c:    ret = ad_sd_init(&st->sd, indio_dev, spi,
> st->chip_info->sigma_delta_info);
> drivers/iio/adc/ad7780.c:    ad_sd_init(&st->sd, indio_dev, spi,
> &ad7780_sigma_delta_info);
> drivers/iio/adc/ad7791.c:    ad_sd_init(&st->sd, indio_dev, spi,
> &ad7791_sigma_delta_info);
> drivers/iio/adc/ad7793.c:    ad_sd_init(&st->sd, indio_dev, spi,
> &ad7793_sigma_delta_info);
> 
> At least the ad7791.c & ad7793.c drivers support parts with more than
> 1 channel, and there does not seem to be any `disable_all` hook
> defined (at least in iio/testing).
> I have not gone too deep with `indio_dev->info->update_scan_mode`, but
> it would be worth to do a check there as well
> 
> 

disable_all and update_scan_mode callbacks are required only when the ADC
features a sequencer, as in you can enable more than one channel at a time
and the ADC will automatically cycle conversions through all enabled channels.

This feature is signaled by setting the ad_sigma_delta_info.num_slots attribute
to a value >1. The only drivers that set .num_slot from what I see are:
ad7173, ad7192, ad7124. So only these 3 are relevant in this discussion.

For ad7192, disable_all() is useless as both ad7192_set_channel() and
ad7192_update_scan_mode() actually set to 0 other channel enable bits.

I do not see any reason at this moment to extend this to disable_all and
update_scan_mode.

>> Fixes: a25a0aab2187 ("iio: adc: ad_sigma_delta: add disable_one callback")
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  drivers/iio/adc/ad_sigma_delta.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
>> index d6b5fca034a0..8c062b0d26e3 100644
>> --- a/drivers/iio/adc/ad_sigma_delta.c
>> +++ b/drivers/iio/adc/ad_sigma_delta.c
>> @@ -672,11 +672,6 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
>>                         dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_all().\n");
>>                         return -EINVAL;
>>                 }
>> -
>> -               if (!info->disable_one) {
>> -                       dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_one().\n");
>> -                       return -EINVAL;
>> -               }
>>         }
>>
>>         if (info->irq_line)
>> --
>> 2.43.0
>>
>>


