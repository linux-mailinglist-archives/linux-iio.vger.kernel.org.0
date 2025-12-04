Return-Path: <linux-iio+bounces-26751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B57CA4AC4
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1FBC300B164
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215642D8387;
	Thu,  4 Dec 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fao3rDKO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73F285050
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868069; cv=none; b=S7LN9/LAYlomi+z9/lhuQ/pxCu7aSlVcLNTgOPxQQuCAreI1b3n9AYhHBDljZHaPtu05LkZILncDXBZZ5+PuS4TzTaKyD1JBfw6ep6B6/Wgb5JVaERTfxTmGe0O0+1vEdTsTzDuyPyUx3nKl3wViKDST+V7KNgD13zXzzfY0BWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868069; c=relaxed/simple;
	bh=3ngML/Jq7dnnl6CYo/sspTAs/M19EnvjGfsPsQ9/WIY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MMdu5XhV9d8L7lr+SzObreFeJofWhderp09Rb9BacCABjZOATvWmuYvYa9e6gLRPZrwSetb2Fpkt6LJYtp4zbmzOb4RNBFK7i+XOx45htE5IXosjXuKZsseT+wY0hDDcuKi661UCja1RX2LXYj0HsmIRQWPY0EljDSryV9OOCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fao3rDKO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78ac9f30833so10348117b3.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868066; x=1765472866; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dodiYRijYOTY+6wzJ7p3kpwOxeuNqeJeiUwFQNKlPr0=;
        b=fao3rDKO4dlwqD2ZC7sxk1iBH9Ub7EPNfIj0lG634drib5fugIxrmLjxE296FTJzaF
         m0h6P4SFNpRBmFMS7H6/PNPSpx5Wn9R+toIdZFisBWUTh869UduJfxaLFVaVLvKjETfz
         8xBSZpXRAm1Jpl9HVdrjhaTYPsGvize08PK7767aUdxzntNrzlwv06N3kV96ZmCTr2kk
         5rY0/A9io1RGfUhxyilNkoljfxU5t0t/2p13mbtT2adRfpCf+CAQjIroXbLg8I6kjbac
         GZIFYDtQ/BQPRLzvDxNkI2gZYdgOXo6jRWnsOcTLorp0l6sU7IFbJHyUa34uuT3cEoI3
         QX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868066; x=1765472866;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dodiYRijYOTY+6wzJ7p3kpwOxeuNqeJeiUwFQNKlPr0=;
        b=tha7+Lf2xGSKFTDWC+EA0EaK54uo/J3uEW1fKz0F6y/34Eb3AmoEcMKm8wT/FAKh2P
         BDJqHkEDKHzR/anzza6tP1r2/rcQoKS6eEXG38ab+uhYsEcYB4S5uveOsibCsN+3a5PV
         yE8mZX1fhpem2GuI6PlYsxDNb/r1dCmctJWg7BSGjDJtMWeJ4uqwTN5YJQtX3RDXZdYF
         a5+VBmFcSdCcJw6TufNtyk/B6BIQMzS947PFcNrUGutBtSGAHrgZmZ2xmMcT7MTL7njn
         VwNRmI+lnd+35n5GikypuHETS+7zEBrh47CICswpWbz3tWCLWcoF/2rjrJPhEZBR8WsL
         aeHg==
X-Forwarded-Encrypted: i=1; AJvYcCVx+VP+UqreRZLmdMsQmc6eSw4/3TYx3clFLZZLA1IAzki2szSl6Bf9+6QZiRErVFcynD1JL8mzGF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8DnsK9vigCs8TLmmnrBiUwKt45ZwhxW8t4X+M4zlyH0uukV1
	Zau9Bv1vDh9jMTf2l5hoYssWc4b0OWhHubhfoLNsfmL9phHOsrV5NV5A
X-Gm-Gg: ASbGncvX5LCMHTbTAdLV67sc3cvb4L0VPvYK6hOMoz1eJY54uouLqF9XNF6n0BslXxN
	66ukWShZi7iPe/+5+p920Jn0pJd4+CvEEq5RSZ7vPo/XJ9JRr4MNwAeEka6t6KQQEDW0VGD7A6Z
	4Ko/vqNEn+n1POb3w+sM2zIro1s9vB90FXawjI4oZVV0pY5I8gUe5wQIVzbuelrAHo7mfYY4cNk
	VNGEmzGND16Y0SEcBzaTEwstwbKMOC85YTRiY7ZCmESQHqaWHfVrLkT/CcFuIqiHMH0VZRN+CSA
	knXyc8UWWIBsTwHegimzQKATByTDnXmIoaTkjkWCOJlInIMK/DIgDZ1qURoaH9B0dglCXp5Ords
	1xKNYnDW7ipkPlc1F7eD64ga2GrlWUG/GX8ZH3MQp2l5usbzn2V21E0weZvYUHGA00w7Ph30U36
	rRLv6tJA==
X-Google-Smtp-Source: AGHT+IEex4E/v8syAVkEMByk59a7h0uIcRlr5mbQVnRjs06eIXWWVY8PiZvvFzioBr5dCBQlvKANaw==
X-Received: by 2002:a05:690e:250f:20b0:644:444f:3bb7 with SMTP id 956f58d0204a3-644444f40ccmr429565d50.5.1764868066048;
        Thu, 04 Dec 2025 09:07:46 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2abfd4sm840396d50.5.2025.12.04.09.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:07:43 -0500
Message-Id: <DEPLIJFBZQ36.20XX5DCMCJVB3@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 5/6] iio: health: max30102: Use cleanup.h for IIO
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
 <f96694db-2ad5-46d3-a380-cba3eaa2de2f@baylibre.com>
In-Reply-To: <f96694db-2ad5-46d3-a380-cba3eaa2de2f@baylibre.com>

On Wed Dec 3, 2025 at 4:52 PM -05, David Lechner wrote:
> On 12/3/25 1:18 PM, Kurt Borja wrote:
>> Simplify and drop "hacky" busy-waiting code in max30102_read_raw() by
>> using scoped_guard().
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/iio/health/max30102.c | 24 +++++++-----------------
>>  1 file changed, 7 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102=
.c
>> index 678720102f2b..c642842cb5fb 100644
>> --- a/drivers/iio/health/max30102.c
>> +++ b/drivers/iio/health/max30102.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/buffer.h>
>>  #include <linux/iio/kfifo_buf.h>
>> +#include <linux/cleanup.h>
>> =20
>>  #define MAX30102_DRV_NAME	"max30102"
>>  #define MAX30102_PART_NUMBER	0x15
>> @@ -468,6 +469,7 @@ static int max30102_read_raw(struct iio_dev *indio_d=
ev,
>>  {
>>  	struct max30102_data *data =3D iio_priv(indio_dev);
>>  	int ret =3D -EINVAL;
>> +	bool direct_en;
>> =20
>>  	switch (mask) {
>>  	case IIO_CHAN_INFO_RAW:
>> @@ -475,25 +477,13 @@ static int max30102_read_raw(struct iio_dev *indio=
_dev,
>>  		 * Temperature reading can only be acquired when not in
>>  		 * shutdown; leave shutdown briefly when buffer not running
>>  		 */
>> -any_mode_retry:
>> -		if (!iio_device_claim_buffer(indio_dev)) {
>> -			/*
>> -			 * This one is a *bit* hacky. If we cannot claim buffer
>> -			 * mode, then try direct mode so that we make sure
>> -			 * things cannot concurrently change. And we just keep
>> -			 * trying until we get one of the modes...
>> -			 */
>> -			if (!iio_device_claim_direct(indio_dev))
>> -				goto any_mode_retry;
>> +		scoped_guard(iio_device_claim, indio_dev) {
>
> scoped_guard() is sketchy in switch statements because there is
> a hidden for loop. If someone came along later and put a break;
> inside of the scope, it would break out of the hidden for loop
> rather than the apparent switch case!
>
> Besides that, it adds extra indent that we could avoid.
>
>> +			direct_en =3D !iio_buffer_enabled(indio_dev);
>> =20
>> -			ret =3D max30102_get_temp(data, val, true);
>> -			iio_device_release_direct(indio_dev);
>> -		} else {
>> -			ret =3D max30102_get_temp(data, val, false);
>> -			iio_device_release_buffer(indio_dev);
>> +			ret =3D max30102_get_temp(data, val, direct_en);
>> +			if (ret)
>> +				return ret;
>>  		}
>> -		if (ret)
>> -			return ret;
>> =20
>>  		ret =3D IIO_VAL_INT;
>>  		break;
>>=20
>
> I would write the whole function like this:
>
> static int max30102_read_raw(struct iio_dev *indio_dev,
> 			     struct iio_chan_spec const *chan,
> 			     int *val, int *val2, long mask)
> {
> 	struct max30102_data *data =3D iio_priv(indio_dev);
> 	int ret;
>
> 	switch (mask) {
> 	case IIO_CHAN_INFO_RAW: {
> 		/*
> 		 * Temperature reading can only be acquired when not in
> 		 * shutdown; leave shutdown briefly when buffer not running
> 		 */
> 		guard(iio_device_claim)(indio_dev);

AFAIK you can't guard() inside switch-case blocks. I don't know the
exact reason, but it has to be scoped_guard().

> 		ret =3D max30102_get_temp(data, val, !iio_buffer_enabled(indio_dev));
> 		if (ret)
> 			return ret;
>
> 		return IIO_VAL_INT;
> 	}
> 	case IIO_CHAN_INFO_SCALE:
> 		*val =3D 1000;  /* 62.5 */
> 		*val2 =3D 16;
> 		return IIO_VAL_FRACTIONAL;
> 	default:
> 		return -EINVAL;
> 	}
> }
>
> Could also simplify things further by moving the call to iio_buffer_enabl=
ed()
> into max30102_get_temp().

I'll do it like this if this survives v2.


--=20
 ~ Kurt


