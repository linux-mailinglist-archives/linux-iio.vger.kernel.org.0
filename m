Return-Path: <linux-iio+bounces-4760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6538B9DB1
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906811C21E39
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58A15574D;
	Thu,  2 May 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l115D39k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA315AD93
	for <linux-iio@vger.kernel.org>; Thu,  2 May 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664684; cv=none; b=V+MHce5YS6nn9p+ldcjBvbG2puMR10S0P5fzx+v4P6eEd5es5uggYHGv2cepGJSzXgu4+3wLIwfWjx9nda3+bFjQ8XT2OtBVrgTF61OfdHS3HwaAlYldAp7D4Z8XbD7DyE7qnUk81zur7PpU1LaZ6FLisl9qA56jF5G0CGOHhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664684; c=relaxed/simple;
	bh=Ycut8WBmXd4oz5BvXZ2uaYW7WT/zFd8JciQTWmdtqds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8eofCnMjy0PflpJkQL3eB3ojNq/ZltrKBcnT/UylonKVm0m62KJ6TCWQJ/EWRBG1BrPi+MGRGdwqDVM525HLFOGCafHCS2/jqFi3DiF6mZ00Qo7CCCTJ9D2aGLqWRwumFNzRc9tCTOaKGKHKGOsNNQEwC//ftS17wDgbBGKlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l115D39k; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e10b6e2bacso28187951fa.0
        for <linux-iio@vger.kernel.org>; Thu, 02 May 2024 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714664681; x=1715269481; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p1vhxMTit7g/3LA2MNfmNjcs7bMe6yu1YW7Rm1sk4Hs=;
        b=l115D39kFen+XH/1n1oAF06TNRggn3lrBxBYPO+NY88NHNo2vvRINV6MGX/qfAJloG
         dKtar87y89/SEoPQAyi4Y4V/w50n46MEyisZJvyByNnCFZ7djGlYzyKSyDAkirE6i4yt
         BnUvyjyei2b2ENXAhzOLkTfZ1mt63AgsfnyaW9IEpENl7BmT6nJlXVYWAgV6RWKcqMv6
         /t3ELsGYTd43CQeeohD2zBAo3zNTrbnRaFwVbEtsT7coifcoP3E4GprZukRUcR88kn59
         7fbi2mlpP1dc1gqMZ04jjt5mJZC5K5DqJp3N0RMVXeFuq+f73nbuLcUu9841NuQ/Gklf
         UTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714664681; x=1715269481;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1vhxMTit7g/3LA2MNfmNjcs7bMe6yu1YW7Rm1sk4Hs=;
        b=qTmQzmfWoahktZJrqWOE6RFTvD2ZaObLq75qBNehoJ8GTzJlk7Qb34xMheZT5KJzFN
         zl36kbMHrzN5+9IIx8tI9Ix66+VwC7Gvft3KoV7jYQr6obVSwhLBk2bV7M43QuYT/9en
         U+afTH0gsCYjdoNauNnnamvp7uz1fM0fBqiUVrGxTwKSQUOkp5hKM9VUNBD99lFe2emP
         wSt9ZL2dqBQLCBm6axm1FAyLMQ/6VEMCsXcqkeiUatjo577cZ0hFRokMDb3W9RGppIYP
         uBHDaNo2xSe6vzlmGdPe8ISo4jWmxwmNctJsmB44afg2bYgZnT0DNQgFfbWYLjm4ULqq
         KJFw==
X-Forwarded-Encrypted: i=1; AJvYcCUl+28uWia43ch0YqHJCvi5qqI/eI1wv/Kh7bf+oOcqH0qvQI756xWn2p/xLmeZlXgCcF1ko+6DRmRcgKU/Z+sjcUWsRmnGTyUv
X-Gm-Message-State: AOJu0Yz7k43vO1pOVj41RUI/mg74MSPn3fgqC+QedNA4NMx9ue0jksS5
	n7l15ucV4iupsMhQ9jLF6RJztwuEL7n+jPJF2AgEBO0I0wmU1uJ/
X-Google-Smtp-Source: AGHT+IE7qe3uusOLdeIONKuykdxY1tMd95wbHTqVqP9Rp+M/GZLHXzwULs7fJ+XqyyvN1Qa5gPs2YA==
X-Received: by 2002:a2e:8858:0:b0:2dc:8baa:92b7 with SMTP id z24-20020a2e8858000000b002dc8baa92b7mr79363ljj.9.1714664678728;
        Thu, 02 May 2024 08:44:38 -0700 (PDT)
Received: from thinkpad-work.lan (228.red-83-37-7.dynamicip.rima-tde.net. [83.37.7.228])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b00418948a5eb0sm6116155wmb.32.2024.05.02.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:44:38 -0700 (PDT)
Message-ID: <043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: Fix BMP580 temperature reading
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Adam Rizkalla <ajarizzo@gmail.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 02 May 2024 17:44:37 +0200
In-Reply-To: <Zin2udkXRD0+GrML@adam-asahi.lan>
References: <Zin2udkXRD0+GrML@adam-asahi.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 01:22 -0500, Adam Rizkalla wrote:
> Fix overflow issue when storing BMP580 temperature reading and
> properly preserve sign of 24-bit data.
>=20
> Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>
> ---
> =C2=A0drivers/iio/pressure/bmp280-core.c | 10 +++++-----
> =C2=A01 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-
> core.c
> index fe8734468ed3..e79c9715bb28 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1393,12 +1393,12 @@ static int bmp580_read_temp(struct bmp280_data *d=
ata,
> int *val, int *val2)
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Temperature is returned in Celsius degrees in fractional
> -	 * form down 2^16. We rescale by x1000 to return milli Celsius
> -	 * to respect IIO ABI.
> +	 * form down 2^16. We rescale by x1000 to return millidegrees
> +	 * Celsius to respect IIO ABI.
> =C2=A0	 */
> -	*val =3D raw_temp * 1000;
> -	*val2 =3D 16;
> -	return IIO_VAL_FRACTIONAL_LOG2;
> +	raw_temp =3D sign_extend32(raw_temp, 23);
> +	*val =3D ((s64)raw_temp * 1000) / (1 << 16);
> +	return IIO_VAL_INT;
> =C2=A0}
> =C2=A0
> =C2=A0static int bmp580_read_press(struct bmp280_data *data, int *val, in=
t *val2)

Hi Adam,

Great catch! Reading back the device's datasheet, it also says the raw pres=
sure
value it's a 24 bit signed integer, so we have the same problem on
bmp580_read_press. Could you make a v2 version of this series including the
pressure fix?

Kind regards,
Angel


