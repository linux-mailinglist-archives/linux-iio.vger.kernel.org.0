Return-Path: <linux-iio+bounces-26714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF65FCA1BA3
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 22:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5B7B3004D26
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF5B308F28;
	Wed,  3 Dec 2025 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MqytHjm3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29A2E6CB2
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798767; cv=none; b=OWAYTlT6TuonmZx9jRr3S+AA46J+8LK1kafdEFqUWjgifWPLCRCW7bK1MFlRnfZ6nu42IuVu/hb1OsbR6EHduZkA9ZBvx6aF3Uvkrmj2KTUF62FgLE/JdPZU95KWbBRbXJvOLkWgbq3FA63LJLeJU3g5OB+adQ+zhIbuG/0r3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798767; c=relaxed/simple;
	bh=tPRF1CoqHq1bSZSieR8xUCGzT7F+QflgTBv5IcMCgnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwpMc0KQHlMElSK4KYgRJvvixTJsNI0psYyaWKYcMU8gMkyOfzzSEbe1edPlV4eDF7g6VTyogF8Yo/Bcj5E7kvtcK6TW1ZrYz7RCrq4Lj7CTiHyNhOoOEzMLudkcOaGAxMZmWuwCaOCsGOr4Sx1FMriZ4qFnMNAWRjW2OSTtAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MqytHjm3; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3f50614f4ccso95950fac.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 13:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764798765; x=1765403565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RX9QHP9FjIBUfnr75g5SgMGg3GzUgvduhpBKi7K+O98=;
        b=MqytHjm3LE7rlQBAFopFlyzLXoeb3/bgF98nWol8Y+XYvmSPObDK6P/618dINIVYw/
         CZRip9fW2saYCkeAqbIcQlFHMdiGKpEUSnq2S4H/vZAxV3h931YP3yBrHUPcg0a+l+N4
         yZnWewymTwSE4Rf4Jm8ClFJ6Wr/UxVRtv6RUNDcgFrRE9X6jFQm6tSEfkay0pb1HXbS1
         TYh/0OjKDTnjcfHEdOOSJmVVHWfKlSnNt56ARCtLcdxbGbJjIXJ+8nRwougV5n8QkzuI
         5THdEoRDrFCUkrNj4bvI1diamMb+OdrhtCbo+lO5AgeGpoUkllzs1QGrApea7/2QFWVx
         Qy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798765; x=1765403565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RX9QHP9FjIBUfnr75g5SgMGg3GzUgvduhpBKi7K+O98=;
        b=AzEEx4hJ5s/GS/x44bIe8+UoA9ny4w3YhjT8vTRfk+DZS+pgCw63vDaCPyKpeorb6A
         cqTpCj7Ygi32Jco9LV+tU9Db5nfupfCp8jEHMaiw3gnhaBJ+v3xkiEKRitNiRbTBJpFW
         iW14KFcP/jWmC9+AUhmjuqiSMwEf8pcMgeMTZdTPBTha2uF4BwI0sEjm5AADRLXSSTUs
         CPnRK0VvkVkA9WgDxt/yiFcVyvC8ks1c29+Hld17zQUb5201lVnzg0MY74i1KbMpv5mf
         o8sSMKBqbGjOb1sI/rRDjATbMz8M67DUUlOAzL/5ag8MVhPdIuudAG+TP1r9f71N7RBh
         0tOg==
X-Forwarded-Encrypted: i=1; AJvYcCWHTxcP+BRg888fUshzfpSWp7ExTJ/8M8stYtA/3q9M41rTj3VKAFUsKOhOAde3TGsFPwk/Fl+xQLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4RMHDB3Ym3ufhss8bMdueuTlo8SueE2t1xvZEzt8d5PZGXNr
	Eaj7fqKA6N+w5yiTkBT8MsXcN6OEoGNGlny4zx8Stpb3tB3jTqQcoLaQ4QE2LoSS6pc=
X-Gm-Gg: ASbGncspuwiRuWX8hrHKIjIQVy1lV1OgEwV9X5V8bCpB7RzxhewfDedIDjaWGI0PQQL
	Ul7EGscvs0CB3IHmgHCkFNKLtlUc8bMTRpjQ0sXQJv3j7QRAtx9yeQ0dJilDmAQAaGyyao78Stn
	wuPJBugjb3LQQ9CIrLMimX9/2X/A0q7lIYj+/NfyS/MOc/airU3uUcvoUmQ9uuzhcQy7+BAMUzr
	eTkXup0H7XfMoWaZM+PiYagY6G8bnur4YP1ml+fYaYZyFEE34D6jN8d8ZCPm4FDDKLYtrFuRgXV
	5/92ty5WGypzoQ/+DVKM1L/QKoiVtky8ic3fFQvV8zL7TtC2iLRn5y26UUnT5JP4GsVv1vOpX3y
	sFKUI0qtBHklEMoguknC+y6eJF1+ihFsqLSp41PVKn0YrHRKX0Wp3Ge23jHqrVb/I+eGhbDhIne
	lSU0N5vpIRqYGj3h8=
X-Google-Smtp-Source: AGHT+IG4z+B6Xde3wmACpPEWATygFNAXQbVq9XSR6nn1XUJX6+en3XojkjV+aNxgDC8XciITQs627Q==
X-Received: by 2002:a05:6870:9e97:b0:36d:31f3:9f1c with SMTP id 586e51a60fabf-3f169257c8fmr2306690fac.14.1764798764709;
        Wed, 03 Dec 2025 13:52:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b05:aad2:5053:6d1? ([2600:8803:e7e4:500:6b05:aad2:5053:6d1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca3ad8asm11031494fac.6.2025.12.03.13.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:52:44 -0800 (PST)
Message-ID: <f96694db-2ad5-46d3-a380-cba3eaa2de2f@baylibre.com>
Date: Wed, 3 Dec 2025 15:52:43 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] iio: health: max30102: Use cleanup.h for IIO
 locks
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
 <20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 1:18 PM, Kurt Borja wrote:
> Simplify and drop "hacky" busy-waiting code in max30102_read_raw() by
> using scoped_guard().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/health/max30102.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 678720102f2b..c642842cb5fb 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -24,6 +24,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/cleanup.h>
>  
>  #define MAX30102_DRV_NAME	"max30102"
>  #define MAX30102_PART_NUMBER	0x15
> @@ -468,6 +469,7 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct max30102_data *data = iio_priv(indio_dev);
>  	int ret = -EINVAL;
> +	bool direct_en;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -475,25 +477,13 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
>  		 * Temperature reading can only be acquired when not in
>  		 * shutdown; leave shutdown briefly when buffer not running
>  		 */
> -any_mode_retry:
> -		if (!iio_device_claim_buffer(indio_dev)) {
> -			/*
> -			 * This one is a *bit* hacky. If we cannot claim buffer
> -			 * mode, then try direct mode so that we make sure
> -			 * things cannot concurrently change. And we just keep
> -			 * trying until we get one of the modes...
> -			 */
> -			if (!iio_device_claim_direct(indio_dev))
> -				goto any_mode_retry;
> +		scoped_guard(iio_device_claim, indio_dev) {

scoped_guard() is sketchy in switch statements because there is
a hidden for loop. If someone came along later and put a break;
inside of the scope, it would break out of the hidden for loop
rather than the apparent switch case!

Besides that, it adds extra indent that we could avoid.

> +			direct_en = !iio_buffer_enabled(indio_dev);
>  
> -			ret = max30102_get_temp(data, val, true);
> -			iio_device_release_direct(indio_dev);
> -		} else {
> -			ret = max30102_get_temp(data, val, false);
> -			iio_device_release_buffer(indio_dev);
> +			ret = max30102_get_temp(data, val, direct_en);
> +			if (ret)
> +				return ret;
>  		}
> -		if (ret)
> -			return ret;
>  
>  		ret = IIO_VAL_INT;
>  		break;
> 

I would write the whole function like this:

static int max30102_read_raw(struct iio_dev *indio_dev,
			     struct iio_chan_spec const *chan,
			     int *val, int *val2, long mask)
{
	struct max30102_data *data = iio_priv(indio_dev);
	int ret;

	switch (mask) {
	case IIO_CHAN_INFO_RAW: {
		/*
		 * Temperature reading can only be acquired when not in
		 * shutdown; leave shutdown briefly when buffer not running
		 */
		guard(iio_device_claim)(indio_dev);
		ret = max30102_get_temp(data, val, !iio_buffer_enabled(indio_dev));
		if (ret)
			return ret;

		return IIO_VAL_INT;
	}
	case IIO_CHAN_INFO_SCALE:
		*val = 1000;  /* 62.5 */
		*val2 = 16;
		return IIO_VAL_FRACTIONAL;
	default:
		return -EINVAL;
	}
}

Could also simplify things further by moving the call to iio_buffer_enabled()
into max30102_get_temp().



