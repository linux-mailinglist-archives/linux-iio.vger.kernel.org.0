Return-Path: <linux-iio+bounces-15768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4832AA3BC4D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3A18849CB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FC01DE8A8;
	Wed, 19 Feb 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db6EyNxG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63C1DE891
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962802; cv=none; b=b6GpSjtAJk2lD0akO0SSNgRYiEJoTbJulHWhuZXPrCodHKswapOyBb46bQGkvYGTPdpdqceCpVP1BoTSld+gS6A7WP6hyTzOqSUXV+aCSXcF62b2+2U1mqSaXSLEQhgGM4IzDJ4UvtXafdbDUrhyO2jXoD8PaSRFRWs+o24yaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962802; c=relaxed/simple;
	bh=nEa1Tizcptdi/4YhCSIDwkL+bIYVV3FFNTwRaWmWLkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BvCjrLRurI2hnPNLdd0Qhnh9Hz5B7SY/Hsj5HgvoDro+lu9aUStiHCaI5Z6TbF3a9RneT80Z89T4x7EfUqU5CtpF059IDNQNq2D9ir6323Q9nDseFfaV9B+qX59qfnQWHUS54RIVQf2plnf4+D9+CMjTTkQ+1bJAd+rmvhCmCXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db6EyNxG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso29586805e9.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962799; x=1740567599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MpeRd05UZfsnILpt3yPKL88eGYYZDa/SBvuYHSUVFOI=;
        b=Db6EyNxG8xhIkZ6F9J6gCR4+j3fBMFhJjGooE2s4qqPxpx1+AkDUxqVGOSFeliQ4ko
         EBR2OH3cbAnwdMqUFDjrpx7acq7TYIIN2RpGJbdIKqcrfgc6FksUK8zRJARv5qIHVZ7j
         gGLWdmKpMIXsWYsCVfM9aK4CuXZNyhmuZieM/zqq0FddIhlFZH892hTPPdCYIiL4uOv1
         UQ2M/Ap3QNXlzEauBzzrtdNqR99HcKOVIzIW3kRMDTPPlVZpOGQ7egLMh0JbjcEeCo04
         nFg1GW6vl/T5wIyh7vBBrj6ISWd3yYjkm7Kc7W2Kt/MgWnSeqdX+/HE+MyR+1jqfJfYp
         Ag/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962799; x=1740567599;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpeRd05UZfsnILpt3yPKL88eGYYZDa/SBvuYHSUVFOI=;
        b=cRpdud+5snmKJKkliYPpnqBeaywgngD7tG07EgadPPFuTvJQ7qqeI0D92l/1OJbunq
         /w30mAL0mXijQJOxD64kYcEp/6o7KJgqKOqu1QrM4HLsdc1hdUtVU5m0D7wznHIsZG6j
         XSycIrdX2NDYaRsOXE1NdDKdq1lqBThahsS1wdVrMS+VZXZfMn98ilUBrDH+rrs/Lh/m
         NRUjPrz8NskCSKK79Z+ZIEullNC+T538tyVDJJBy2Yc/tFuYzcixtt+SqnSVuuzhVg7n
         MJnAv7dBlTFrBJHpGSpbzK+rGpSA5kdcwuJwxY7hczb48uzMeYIjUWSE9x/6gueKzu0B
         j98w==
X-Forwarded-Encrypted: i=1; AJvYcCXRTD090sTMUdFoH80YKEjecaZfToBhs7Sne/3XlEbGT2DtlniGhTKH5vIODmxeBXUB7MiiagQXuRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PnP4nuQCFwGcve8lBWB9pKtKxqqNB625or1ns7F2GqlrtZa+
	keH2UIBMpOzsIoyqaoCuD6dN9iQLLdL1Rr9AZ9Z8VJNe0JNHlqv4
X-Gm-Gg: ASbGncvdb93g8VymvqlPv76r++lbmO6g/A4vQV6JcUmTAiysvc8rC/Jw0AymNMfxpZD
	ZlqP2QgfPWYZkOrHYYQzDMYVvUOaWMDgxPNVHRzwSgNWNT5nXbKZQRQlg+6063J+L7mz4I4jGGY
	tUwCXFfdTfrsJ69ERJZXKoGqE3KUuHJMq8VoVdMW3kmYv9hg900fkTlloye8VdCQvmxe69WH3Rk
	UXnPGX0dsiQcdzDdvfAgsU6ajspml0q8zzWPkQ28+wP7MlZ/QFpaDkEC9EujarLmAGJ9o0gOAJ7
	eXi7Q5ASbJm/72JjAsg6RwVEcrGty0Ks2JO86Qrp6yK591n0/RwDdb8susvyno4=
X-Google-Smtp-Source: AGHT+IE9214jU/6JQfaegzlZMi+h3Gw6uvHQWHWjbIn0+oWWrF6gAjT+mXHlD4wuk2PNk9J0tMxAeQ==
X-Received: by 2002:a05:600c:548a:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-439a0a30b55mr503325e9.14.1739962798956;
        Wed, 19 Feb 2025 02:59:58 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm17276555f8f.82.2025.02.19.02.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:59:58 -0800 (PST)
Message-ID: <59817352ee84ba254399c97f1bfde1b3925c0dee.camel@gmail.com>
Subject: Re: [PATCH 16/29] iio: adc: ad7791: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 11:00:02 +0000
In-Reply-To: <20250217141630.897334-17-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-17-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7791.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index e49d4843f304..597c2686ffa4 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -343,13 +343,12 @@ static int ad7791_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ret =3D __ad7791_write_raw(indio_dev, chan, val, val2, mask);
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0


