Return-Path: <linux-iio+bounces-11639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168B9B697F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B5C1C20B1B
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BA2144B5;
	Wed, 30 Oct 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpnFElbe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA6768FC;
	Wed, 30 Oct 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306878; cv=none; b=l2MMgW2mJyfUWWa3yLeKclSa2t/uSL8xmwAjAUYL6bI8ULzFSpP6GxwnDfW5BQCLOB53ZMdIf4oxmqMGEOGXfcNtPHTBjhrzlXHe/j4+4EGyHZLa9hoVk0ky8WcnnlZ9OAT7uR20JU3pjr3kn98PJ2/sxq0RJ6gyaTy5o6njAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306878; c=relaxed/simple;
	bh=D2oJYtwG9EKSoZ7I5siUsipoREy99xEvaxJ67nyWbRU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=H6A6BzVEkhwBvFrF5EUWqx4dAFVR8B0PX5RYNMiYOfxRy+xyNSiDwcoLi8cO7grqZFuYOkZju2A/BNJHjXH0rn8+OU0Fei1Q4wErjy9LDxInPe4+nHPUYWIHNmsBY8xUGbdlo6LHW4TwwuDPwCunF+VppsMyGpk/KVVM4XNbK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpnFElbe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so67046f8f.2;
        Wed, 30 Oct 2024 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730306875; x=1730911675; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyAZDfpaHEPPobXVP0C8mBTxkDr4yKYduYhVIQw6zIQ=;
        b=YpnFElbexnAoI4p3nm+oEnOGznhVnG70iHajdfyBa0oxavF4ooeYk8qU4A9ryLUESL
         tbso8zUvEnmgAoFa801y+1QUzgYXkA3kpn+wEoTQU70hPD+/3VjXnXogTS/+YdExqr8m
         fOgbnyDtY27NvD4A6wkJBOqK85lSMb6du9GLchaufOp0es7oCnkpUlL12pdUfCez4DMC
         pzm976YB9X2/Yo5MTWEQ57odkaUCONykKLZzP7t4UyKhdLNbQl0SJ4eLmXfu1MhKRMXp
         XL1DNjoZXXsxBYTdkgxbSDwtX3tGAEAlpmYRo70XoeVQPYzAfiKfVyZ0ZhcUjjgLIvGG
         T3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306875; x=1730911675;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyAZDfpaHEPPobXVP0C8mBTxkDr4yKYduYhVIQw6zIQ=;
        b=MG18yXkc9mz6O9rCyNpquT9Ikp3EsBR9YTzEnyk5rq/3/nXiZmMjkyBJTYaikmRA38
         y0HNZ3tB2Fp1j7ILFRiwgJDCBxnfVDOVWl4f8138r16HIQTIhuVTq8SaoZBNKcCJzXMp
         lSYeicM2XGzWmhLm5G8BEtAHMwBNcv9bNbSU6ARsMgHakxLG+hkWkB8gHRccTbZgAqFk
         YbS93heRuQLMSbqWjfuPbNJFRAa7b+YRZGaotz2fhTCw3+RtUvZxmVuYezI1uj275xzd
         c/Or2ftArpmx1nxRccLnwF2oAzZmaSORr4IrRLZb7t2NMK+Xo0bqJ4WMQum4a73JtrO9
         pHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR+4yob1g5g09XHn4NCGU56dJhYUprdklsjjWA8v6apMSIcW1WFFG/aEETOUFlYlHt1uuBhEm4gPQOkQkO@vger.kernel.org, AJvYcCXHQq52B3FL0UwOWMWSci5cc+kSo9DvQJz0GxRDPvl9bBCeNvAeC4k8PJZhpD3YhKRXOPAycT4OyR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBWL4YoLtwODHSOaebereRuis2JQybvA+u7XLgyjVnO4llran
	htFfEmgaiIv+I2MMeKc2zt/MER4x07iqEgVoRrRdNVcuSlwxzkLx
X-Google-Smtp-Source: AGHT+IG57LVIgndXcx5SWpD+2PATOaWbuFrMV4s6ZZHtymFNkj3j2HhNOX8+RKbSuV0gHdI/styCyg==
X-Received: by 2002:adf:edd1:0:b0:37d:332e:d6ab with SMTP id ffacd0b85a97d-38061228332mr15422792f8f.43.1730306874368;
        Wed, 30 Oct 2024 09:47:54 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3b57bsm15915247f8f.26.2024.10.30.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:47:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241030162013.2100253-3-andriy.shevchenko@linux.intel.com>
References: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com> <20241030162013.2100253-3-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] iio: adc: pac1921: Check for error code from devm_mutex_init() call
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Oct 2024 17:47:52 +0100
Message-ID: <173030687241.39393.12307342500543400932@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Andy Shevchenko (2024-10-30 17:19:19)
> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something. Add the missed
> check.
>=20
> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/pac1921.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index f6f8f9122a78..385e86ecc441 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1132,7 +1132,9 @@ static int pac1921_probe(struct i2c_client *client)
>                 return dev_err_probe(dev, PTR_ERR(priv->regmap),
>                                      "Cannot initialize register map\n");
> =20
> -       devm_mutex_init(dev, &priv->lock);
> +       ret =3D devm_mutex_init(dev, &priv->lock);
> +       if (ret)
> +               return ret;
> =20
>         priv->dv_gain =3D PAC1921_DEFAULT_DV_GAIN;
>         priv->di_gain =3D PAC1921_DEFAULT_DI_GAIN;
> --=20
> 2.43.0.rc1.1336.g36b5255a03ac
>=20

Totally agree, thanks!

Acked-by: Matteo Martelli <matteomartelli3@gmail.com>

Best regards,
Matteo Martelli

