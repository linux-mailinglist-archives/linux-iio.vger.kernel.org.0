Return-Path: <linux-iio+bounces-5020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAE8C4806
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 22:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04651F21A16
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66D7F7DB;
	Mon, 13 May 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="RfVuyz35"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A278C9B
	for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630586; cv=none; b=dXRKUCNZqpeRSzAUnnQxkIQyj+DUCmuE4Kkf+7udT6tlSSxXlpsxxoBY7tSYxLcZK5f3Jq+kZgi0RZHlH7bQ0UY17zz6qwqmrg2b15+5CtTgQJEEA3Mrg/whuBcLJJmoJzFiE/XBwn8OJZ2Cn3kB4bdhoBYzN5qHc33lfq6ATcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630586; c=relaxed/simple;
	bh=s1hXVf6tyL8uq55NXv8OQrk/qgk5wctwVrIENTgbzus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI7zeppDT7c8UnvR8dWsDhPGS3d0ok148bkm5txZUUaB8+wQgeF9WFX/EhNMul0t6tMdV3p5XCuvbXEGY7yYYEPYBy4HdZpLmkQjbbGe30aQ5tJKxhZhzqDbxxQr0htobK9jL/kxhyEQ1N5AYrAaxyOwcezYFkd8IIHQ4a/h7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=RfVuyz35; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23d38cd0df6so2830193fac.2
        for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1715630583; x=1716235383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/mC8iHyEmlHpwqktNUilmvaxLB5nXIdCTUQODGPwBk=;
        b=RfVuyz35LfglAVOIwUtsA9iQZYEWDGQTmQEh6h2L4OPk2VqLbrWnDWFrE5heLsGTaJ
         8mKkQnBoY5rttBzbfPUqmmggKu4gO4QbEcBKcu8zGWtTSuX9Qvj0K9j8rteqlkR1PB6o
         y9FLJIpN4sBLLxUsMUn6Pcxq3h8CMmyTXRHTlM5uztiYsJSyXfo1O85tmdECBqdVmR+G
         PtQG4Rkv/jLeVVcZfVfiONnYBlK4Tpjc8GGzK2pnGyUT1DOHDghAGYWJV2PxhiaaK61f
         24GnvLpCXClUCfAC60XEQ/8JLYLrM9X/uD0FBZ+Py90j+WF73hoXPl5Cc1cAVRYSywaZ
         9p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630583; x=1716235383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/mC8iHyEmlHpwqktNUilmvaxLB5nXIdCTUQODGPwBk=;
        b=cCfy2xy1LfJTBBO+5nXCRx8xqC1uqDeRCtMs0Q4anS1Ken2gbrimG5TOXuBM86CuRw
         RGrUazeTn2valBoGPzmCdH4mBu4ET2V/aB1Xzv5mZjerDNrNXmimniEbfIFm1Tfaop/u
         5/CVlBTxtC1orj2g3rqoQ23nnwMrY7PR3VrasLr/j262KzngA1gufFxql0nPfkh4R/8M
         g7bGvd4EyZLLu7meUDXyPiccUFvn8vDmM3ukofZUiN9gzfGXtTx3vLhDaIIBAeuk8zcB
         kSIjWjSpbAxv/J/ZGHV/5I/+6KLlIcPgJepFbH7wgOZnBXMDIJg49daYFDTyB5Z4dKDZ
         cuuA==
X-Forwarded-Encrypted: i=1; AJvYcCVMCd+iXo0wyyfI5YoRKCvI3V1n28UcLgmhgZkta0oo74ut8e6KSrwp2YMjd4souYIbFUuEJQW79vvbP0ATfzNMpEuCtXVIkwRf
X-Gm-Message-State: AOJu0Yx0n3kixBHcJY+IYngmVtokkq/yLDL3TVTbMQLpnz4wqBgEOp0Q
	E0APtMtOs1E+YoIOYg9pGZ4AyHYsZCFNSWJ6/2hH6KtiaBZG9j9WwbvIm8yrHykltsjaYMe/N+Z
	o2SNe5kHS0GeTXc4DH6+vKKo7kJpYXCesdvUS
X-Google-Smtp-Source: AGHT+IHMvY4NwUqw059de60Gzl/JLpgWiP6Cdv3/1rHDK4v1S2yPxePJas+PW6SFNOzXbZEEw2kevniOpnmdQuaVQcA=
X-Received: by 2002:a05:6871:b27:b0:244:bb9e:bdbc with SMTP id
 586e51a60fabf-244bb9ed677mr6392251fac.10.1715630582870; Mon, 13 May 2024
 13:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513184514.3200222-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240513184514.3200222-1-harshit.m.mogalapalli@oracle.com>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 13 May 2024 22:02:26 +0200
Message-ID: <CAKv63uvAe=RkZ6ytWfNkM5exy5ys5n2NwcJER=VMVAP+61-+rw@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, 
	kernel-janitors@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,
I agree it is is copy-paste error. Minor remark below and a few typo
fixes in commit message. Thanks for your contribution.

Reviewed-by: Crt Mori<cmo@melexis.com>

On Mon, 13 May 2024 at 20:47, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> When devm_regmap_init_i2c() fails, ragmap_ee could be error pointer,
When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,

> instead of checking for IS_ERR(ragmap_ee), regmap is checked which looks
instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
> like a copy paste error.
>
> Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is found using smatch, only compile tested.
> ---
>  drivers/iio/temperature/mlx90635.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index 1f5c962c1818..2b61489d5ee0 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -947,8 +947,8 @@ static int mlx90635_probe(struct i2c_client *client)
>                                      "failed to allocate regmap\n");
>
>         regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
> -       if (IS_ERR(regmap))
> -               return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +       if (IS_ERR(regmap_ee))
> +               return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
>                                      "failed to allocate regmap\n");

Maybe fix her would also be to this regmap error message to include
regmap EEPROM?

>
>         mlx90635 = iio_priv(indio_dev);
> --
> 2.39.3
>

