Return-Path: <linux-iio+bounces-23630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF2B3FF9E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DE57B6EF6
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFE285058;
	Tue,  2 Sep 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPwP2jAc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E521254D;
	Tue,  2 Sep 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814701; cv=none; b=NpGmT5yWEvwCqL3OKJpwrXl4iXBK2Ph4c/qcMB5Lc/7WYeqUYKkj8yjToqA7Xfu57WNRSEndosvM2iAVdYG068ZeQ51skSdUwkCm/OaFE11NJ1jGxbJrE6ECxZ0hPPdm08EjTQ3HAuR0aEhFpjimgSRqmZhL82QrPjp9EU3cdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814701; c=relaxed/simple;
	bh=HadKKoTQkiYRYD+Q9STWCp5j2x3xfiz4EdMvkmL9Ksc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pqSAogTHBqCwWIZS7zqN1LXd3MkaKjl9tJyLsMW9eJDG2BNSz2C7+Kx3V/Y86D4HvZvBALdKDuOynUMQ4VqDPGvdEpsExfU6l5eb4mzDEviSwa6XZIqYqw4ruu1udgUVhm98QeMLrGQtqwykeSM6QU3EMurJ7St4iuHqtXdm/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPwP2jAc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4615185b3a.1;
        Tue, 02 Sep 2025 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814699; x=1757419499; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zyhWquQv7Dc6WCsaXfcsUCBB8ZbCZwXcmEAVK37Drc=;
        b=DPwP2jAcWR6AL5Gj8hldtQyqH3iYZ+EyymvOxiGQ8MPCP3nF696E2h/b4dqefZITEL
         S1ATuYSdShpb2bN+DFOCdcTH0Qh//5djgZJsnBpdHqiNIFKK2FNFiWBKxtKExdpbZhPR
         mqgQp09JWqU7MI9STLog9q7MjSfUO+Ip5t5BpGXj4gdKBEl7x6UB9H9RVEmuxfWyuCeP
         iqNUfVIe3mR9C6ayZgIgDTFMuypp1UtdO6qYRKeJL1ZEWKO04QQUDGw241MuABR1rNK3
         2JUP8OFW7nBiXAhCifyhwzQOYBeQtinliFL+42TQdpugANYU9CS/+44YiyrjlEslmsry
         bODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814699; x=1757419499;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zyhWquQv7Dc6WCsaXfcsUCBB8ZbCZwXcmEAVK37Drc=;
        b=L+HFSGglfG5cPXv210S21lT8BuGHdWPhI92wNuG1Ww9btbctfYrDDimsKb9kBBYArK
         a4R1NC/LYErYSTR95Mcl4ssfEqUS6jcTPOhZw8dHQvLYZMXq+LD79d18m+P7jSMLOjzf
         bgklX54bGPexkaV/3URfshUusDoknxmjwlM3GR+dnLzIhmvjgDzuCoRyQ438U8hv0h+x
         ah6qnFi22Td//kbHQGGFYFYcW3LmR8y8VMpqZ+Xxq5Cpqkcj8Wn6qixZ3y3rmFutivAu
         7j7P6IdikcUWlam1fbbJPKGYsufQxC57YyP3Bq7UAzDn7wd7VnNtB3S+MDH+3xndezL8
         WFKg==
X-Forwarded-Encrypted: i=1; AJvYcCV71606lsNl0Skpynso2rOdH4QA4ufS6WMbgDDHWZn/eW0INuLyZ4UudUg+aw2AeTOJiB/C9kAa2Io=@vger.kernel.org, AJvYcCW3ZbjWrJhn5ZUnlad+oCrvOHsz56g1YpfGkwUCd1SgTXoQzyYs5s/xKMNQeKrL9SzOVomeUaA26zUbaCPV@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQOwHBvQmDfVQsvudvnDNO9UOh1tXueF2aZLD4G0r+e5uYXPx
	cfih7cFcMLdlOnAdhlTSjAQSDzHnov4dPikn+MhG0w3Z94Xzqd669q98
X-Gm-Gg: ASbGncudzdCKwRyoa24RClosDAZYeWBsgzHTp4faw+0JVs5wtqGW8bwf0uTwbbVyLU1
	7h9mqiQkZqH9Znps8GUDBiLTfA3IBTteu3g8KMHRw8UPPrYgDS8+XGzPX90QGa+u/+mRjPAJA6q
	JD0qHjoOLyyUnk3CBPR4MQOSZxKAPzjazBXbGF1fxHt4rKDZ+MWTxKjTHSIjs54JZPigPbhIcBs
	6coMiztV1Ow/S1seFHYVETwOu4wmBXm/fzILrzno+6IFxqZIw7k8s9ZE6LRC0CJb+yiGmhSWNCM
	9iiSBgWFzJSsILgt26lFAk/EHfT2OxIPtyHRQHBXrOU5h1RjPM+oGKhFkBsAXVC11rfCo01Tv66
	LzKTPWdck4dXEhJMUXdBEA0T0gu8++OybNtf3+aPPuW9oBJPPEMixBg==
X-Google-Smtp-Source: AGHT+IHDTJN6/dGfanBLyhoQz/HGvmBLWI9DLEll0zuer2Rccgcv+A9BtDmX0rUhwFaFbkTA+tF8UA==
X-Received: by 2002:a05:6300:218a:b0:243:cb7b:4f5f with SMTP id adf61e73a8af0-243d6e60e70mr16594385637.25.1756814698736;
        Tue, 02 Sep 2025 05:04:58 -0700 (PDT)
Received: from localhost ([123.119.72.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8cc9091csm3736087a12.19.2025.09.02.05.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 20:04:53 +0800
Message-Id: <DCIAU0EO8E0K.3JIXZ2XICP3YC@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Chris Lesiak"
 <chris.lesiak@licorbio.com>
To: <dimitri.fedrau@liebherr.com>, "Li peiyu" <579lpy@gmail.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Dimitri Fedrau" <dima.fedrau@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
 <20250901-hdc3020-units-fix-v2-2-082038a15917@liebherr.com>
In-Reply-To: <20250901-hdc3020-units-fix-v2-2-082038a15917@liebherr.com>

Hi Dimitri, thank you for your patch. A few comments inline.

On Tue Sep 2, 2025 at 1:51 AM CST, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>
> According to the ABI the units after application of scale and offset are
> milli degree celsius for temperature thresholds and milli percent for
> relative humidity thresholds. Currently the resulting units are degree
> celsius for temperature thresholds and hysteresis and percent for relativ=
e
> humidity thresholds and hysteresis. Change scale factor to fix this issue=
.
>
> Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events suppor=
t")
> Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/iio/humidity/hdc3020.c | 69 +++++++++++++++++++++++++-----------=
------
>  1 file changed, 41 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc302=
0.c
> index 8aa567d9aded9cab461f1f905b6b5ada721ba2f0..deb19e0291f7f820c5f8760fb=
f0682379ab5f34b 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -72,6 +72,13 @@
>  #define HDC3020_MAX_TEMP_HYST_MICRO	164748607
>  #define HDC3020_MAX_HUM_MICRO		99220264
> =20
> +/*
> + * In order to avoid overflows when returning thresholds and hysteresis =
values,
> + * the fraction of these is set to 13107, also the datasheet refers to 6=
5535
> + * this is not enough to prevent overflows. Dividing this value by 5 fix=
es this.
> + */
> +#define HDC3020_THRESH_FRACTION		(65535 / 5)
> +

I think the comment is a bit too verbose. If you explain why the value
has to be divided by 5, you probably don't need to tell the result of
the division. Something as simple as "divide 65535 from the datasheet by
5 to avoid overflows" could do.

>  struct hdc3020_data {
>  	struct i2c_client *client;
>  	struct gpio_desc *reset_gpio;
> @@ -376,15 +383,16 @@ static int hdc3020_thresh_get_temp(u16 thresh)
>  	int temp;
> =20
>  	/*
> -	 * Get the temperature threshold from 9 LSBs, shift them to get
> -	 * the truncated temperature threshold representation and
> -	 * calculate the threshold according to the formula in the
> -	 * datasheet. Result is degree celsius scaled by 65535.
> +	 * Get the temperature threshold from 9 LSBs, shift them to get the
> +	 * truncated temperature threshold representation and calculate the
> +	 * threshold according to the formula in the datasheet and additionally
> +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> +	 * calculating threshold and hysteresis values.

If I got it right, you are actually dividing by 5 and not by
HDC3020_THRESH_FRACTION.

>  	 */
>  	temp =3D FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
>  	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> =20
> -	return -2949075 + (175 * temp);
> +	return -589815 + (35 * temp);
>  }
> =20
>  static int hdc3020_thresh_get_hum(u16 thresh)
> @@ -394,13 +402,14 @@ static int hdc3020_thresh_get_hum(u16 thresh)
>  	/*
>  	 * Get the humidity threshold from 7 MSBs, shift them to get the
>  	 * truncated humidity threshold representation and calculate the
> -	 * threshold according to the formula in the datasheet. Result is
> -	 * percent scaled by 65535.
> +	 * threshold according to the formula in the datasheet and additionally
> +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> +	 * calculating threshold and hysteresis values.

Same here?

>  	 */
>  	hum =3D FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
>  	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
> =20
> -	return hum * 100;
> +	return hum * 20;
>  }

Best regards,
Javier Carrasco

