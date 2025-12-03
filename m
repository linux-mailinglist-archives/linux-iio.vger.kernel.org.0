Return-Path: <linux-iio+bounces-26717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C3FCA1D96
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E7F300B295
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216F2E2DF2;
	Wed,  3 Dec 2025 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Drttv1iu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCA2D8774
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801664; cv=none; b=adQ090Iz+NJGPyoE4/MyGrYRfdwOWyVxojlJFmQjlYksuQfr9EbeB14Sl5TxqoVLCUfpnR5PlMub9+D8jCAx7x5HZKhS1mRW3xarOWYp/wJyKtv0KvGifYnc8nvTizu5FarrDkWv2k+Wd+iRqgPL3HcPtkn5IlrzweRbE2OxTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801664; c=relaxed/simple;
	bh=SUQIyZJZp+O7Vp//jfjuuVMp8y8KVbrJbuI0BpFAPZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+1ATidpk0uPludDTKOBzZwhYH99YHkyBSKrEMgagjiQVPL5L9OgA1yhFjO4zI+bsyfGhDzsePYbfa11mHExUyLr9CMGNG/+W15X2Whpq8Bjk32l5ZxhwizgvXmr2lDc9KWpmLk3xVQz7r4LWs7QVuy46grY2REDcJyzWwA+OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Drttv1iu; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c71cca8fc2so228120a34.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 14:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764801661; x=1765406461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fae2T8A00LxuEcnVsoAj9zMjZYXT6dEfKw1jD+A44wY=;
        b=Drttv1iuhKnZu/tN9TQgwTuAdcfBuye8YxZ1AZqAUUvUg8fFYnXL3QNHnHPoD9Oqks
         +F8RSNP83iSxP41JCH5g3nlLp0KOSfLxl+7LG4bvRxc9Zy6+jOvouIDHVmGyxYAwEbbD
         Hu+JjRFPqS4/YgtPZ3mzps5+5xAN4W9dyqkeMoPcVCWqGzQX/W9+N/G+DBAkwrIg8bxY
         kLTPo9u7MJUPd+QKZt2rFv5YGDxs+e3Ssw5N1+CmN4Tof1SDYUPuP/hO/liWE1iivHKd
         e4zJWkPbGwj57fOLlCrV7NW+GQItOKD+4JnDYF6G9GRu6LVc6FsQxyIKRgHbphWa97Sh
         NfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764801661; x=1765406461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fae2T8A00LxuEcnVsoAj9zMjZYXT6dEfKw1jD+A44wY=;
        b=Q1K1eOkkhcLIEUlnUMYj+0Tvc2UROZTEQk2j5PPC/K1v7+qmrgpefGGOHoA+XYlVtA
         ljQcpD5SqIlGBa5CybTsAhruirCcseuMtOCmfvOKe5UaLnj3uLjnR+zDqy1aqfLfGQ6S
         y2W4Dw9En+30c1rWxiuQNdy/0q2fJ5QMxCa1ZMaocnKIPODQdziAiP/RXCb1YV2Esm4i
         9uqlJWwEDxY+jYJDi4pR55iE4smsiEYLeltIf+DPWQQz+OzxJNFlWVWJI+QLQBTTBc+J
         xUCGi7uvuiqaY5Ruvtgg8uYOD7qGKL/M+F/oKaNY69FYXpv7jQD9j28Hb+ZLVvJYyrtm
         DxRw==
X-Forwarded-Encrypted: i=1; AJvYcCUUyISkUFV2j2bMmlG96ws13T2Jiy1OIWeTIlQZWbtQadV9y8Oko2kiKbpnfRKqff18FMAyyDqReRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6i2ujzdQglWrVAQhvaJ/GP5ZqcDH7iCszCi1hlABeY3H7qM1m
	BeKiseyKtyYf9oHi7zK10nC0BNfSRKVVfBCx3IvLtRekuucSTHLRO0UhrPhPEBsfzxs=
X-Gm-Gg: ASbGnctK5OvFXDm5/OyfTB746m2eCByLJor5KHqTDsbgDA1kXaecEj+YfFRcxfZn1Oe
	p/K4Ug/+8vwqqaDqjfnmBQ3ELyjeyzukGZ62cfCNF3qH4bs7C4TKHhto31k8nf+jbvE97ElMNyB
	pk2c6CR6lUCYqEfcmWzeYTxxzP912KAVvN3rw7dLwaqzDbcvsmGZyMFqWI/uMltzOyp82RroK4x
	6isXA1VrMC7GBoV3T9m7AuS3RxYdEQkYHmDIXAJNJQVCH0kzWAgob0QBhV+EPLaMv85VGUi8uA+
	vWEvEqJYwDAutpTHrBoCfsMH4ulcuILbnzTDx566anXlbS4UGuNwJ8ZL6tOiaR3LyZvbi1jNlXq
	1YJ26oSvrxhRRqxO/ZEyiupgCPqXIcHK+/QoYBbAjIU4d8dUQyGhtjFATV6M2CYpsNx34SBIlZR
	lgsT3IVPLcqaPCU7lBXw==
X-Google-Smtp-Source: AGHT+IE8ahaPipDh8W8AoMJnvq7L+yJGEo+dv7+OKVdTyAgpgP0LgOtF5++RGJ1xwcQ5dHaHz4vquw==
X-Received: by 2002:a05:6830:410e:b0:7c7:568d:cba with SMTP id 46e09a7af769-7c94d8c65cfmr2925018a34.0.1764801660974;
        Wed, 03 Dec 2025 14:41:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:25f4:78dc:7b9e:e7a4? ([2600:8803:e7e4:500:25f4:78dc:7b9e:e7a4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acdb599sm1821a34.28.2025.12.03.14.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 14:41:00 -0800 (PST)
Message-ID: <e1048329-83d7-4947-a57f-afdf75fb1e1f@baylibre.com>
Date: Wed, 3 Dec 2025 16:40:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/6] iio: light: opt4060: Use cleanup.h for IIO locks
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-6-b4a1fd639423@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-lock-impr-v1-6-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 1:18 PM, Kurt Borja wrote:
> Simplify and drop "hacky" busy-waiting code in
> opt4060_set_driver_state() by using guard().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/light/opt4060.c | 52 +++++++++++++++------------------------------
>  1 file changed, 17 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> index 500899d7bd62..903963606143 100644
> --- a/drivers/iio/light/opt4060.c
> +++ b/drivers/iio/light/opt4060.c
> @@ -22,6 +22,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/cleanup.h>
>  
>  /* OPT4060 register set */
>  #define OPT4060_RED_MSB				0x00
> @@ -302,41 +303,22 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
>  				    bool continuous_irq)
>  {
>  	struct opt4060_chip *chip = iio_priv(indio_dev);
> -	int ret = 0;
> -any_mode_retry:
> -	if (!iio_device_claim_buffer(indio_dev)) {
> -		/*
> -		 * This one is a *bit* hacky. If we cannot claim buffer mode,
> -		 * then try direct mode so that we make sure things cannot
> -		 * concurrently change. And we just keep trying until we get one
> -		 * of the modes...
> -		 */
> -		if (!iio_device_claim_direct(indio_dev))
> -			goto any_mode_retry;
> -		/*
> -		 * This path means that we managed to claim direct mode. In
> -		 * this case the buffer isn't enabled and it's okay to leave
> -		 * continuous mode for sampling and/or irq.
> -		 */
> -		ret = opt4060_set_state_common(chip, continuous_sampling,
> -					       continuous_irq);
> -		iio_device_release_direct(indio_dev);
> -		return ret;
> -	} else {
> -		/*
> -		 * This path means that we managed to claim buffer mode. In
> -		 * this case the buffer is enabled and irq and sampling must go
> -		 * to or remain continuous, but only if the trigger is from this
> -		 * device.
> -		 */
> -		if (!iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> -			ret = opt4060_set_state_common(chip, true, true);
> -		else
> -			ret = opt4060_set_state_common(chip, continuous_sampling,
> -						       continuous_irq);
> -		iio_device_release_buffer(indio_dev);
> -	}
> -	return ret;
> +
> +	guard(iio_device_claim)(indio_dev);
> +
> +	/*
> +	 * If we manage to claim buffer mode and we are using our own trigger,
> +	 * IRQ and sampling must go to or remain continuous.
> +	 */
> +	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))

The commit message does not explain why this was changed from
iio_trigger_validate_own_device() to iio_trigger_using_own(). I'm guessing
that is why we also dropped the `!`?

> +		return opt4060_set_state_common(chip, true, true);
> +
> +	/*
> +	 * This path means that we managed to claim direct mode. In this case
> +	 * the buffer isn't enabled and it's okay to leave continuous mode for
> +	 * sampling and/or irq.
> +	 */
> +	return opt4060_set_state_common(chip, continuous_sampling, continuous_irq);
>  }
>  
>  /*
> 


