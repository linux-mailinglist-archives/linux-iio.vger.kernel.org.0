Return-Path: <linux-iio+bounces-5649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9288D778D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA021C215F7
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DDD6D1A1;
	Sun,  2 Jun 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/e6RU5O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0D219E4;
	Sun,  2 Jun 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717355844; cv=none; b=lwzoZoJXoxqKiGRv/Vqse+yjWy8SQwaT9ME51UfVhMgdrrn6IIoFGQU/j74Ef4AiM5LEyW0uBxF5qHJZsO/Cp0uIhyWR+Y5o0jkC9ZQqvsMeypaPTc3SGv+FIscdWTYd2KXaenngzKjWfDCGt+voEEZB9oV4VW5Tc5rs3ima19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717355844; c=relaxed/simple;
	bh=2TBWg/+qwWR97iXfi+OuCUPcDnucc4D2yfjxL8zhdmA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDwcP3tVLyJP5u/yW9b5KUSFFqQJvzc8M1M7ooD4SMQrYW2hoDU4imo0ZoXQOVY7IGfFXPXI6nfnRFR9MZHvDAa/PbQn3n5kanhWXK6NWuIa4Na2NGIPSSxXYqf73rUbIx4/sgBmF0Oxbd/R9r0hT57ozCGDT8uuu6P0hDKTmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/e6RU5O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42121d28664so31901995e9.2;
        Sun, 02 Jun 2024 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717355841; x=1717960641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPpc1cNXUJlKcHgb3iTHYZlBD481psTql015HQxevII=;
        b=l/e6RU5OahozqghSOdTGWJFT9UHjRBt1wvn9GLTipYkzDRcJl9yh1F+V7k9ztDldUf
         6YvL7u8yO8ohRxyv07wabVEYfIy4IGiHQJ8yYcG41jbG4uWOuhbvvaHqgisn9MgJUY43
         rna8usr/+Am/LBxLzjmtUwMAF+f++CjaGLl5DamJtV9At+UgHxW1h+FbJX42QGVmEcYe
         kHf2SQwlqgtFcOMyd7bGxw8vR7f0A6z/9Q7t8bS1mm+v1eRQ1WS+WYx2H5glcwi9XgwL
         6eXNZIm/yJTN82ANvNiwpSJIg3fkpoH+lJoa0tpjPT0BmTA1r9dC233OWlsMoE5G6mLg
         R5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717355841; x=1717960641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPpc1cNXUJlKcHgb3iTHYZlBD481psTql015HQxevII=;
        b=IYlKd+esvAEHlXK5t0TArxoAhN2YTrBObVweH/3ME+aPgvjTnH8SSDgnduxrM2BxhL
         aICCFlEByfNkDXv5rVBz+bDdkScCPFGSL17zv438kXDsofs1YwpmxVAoWooKWgKypWoW
         Me+MJehO8trDp1o6N9eOjb6Kmjvry32n88J7bcQF9JWa4sq1ST0mtTEjfejRQMwJkxbf
         eUv9MeIhBZklLoAfm/UhGob9pHHcodtjAh4CYxLCILNvwjd3U1S7QHZ8jpqqjCtx9ev0
         v9yqMmn9XWgLfYvYWLk5V/cpBALD9YBB3MyVkg7FJUS20DDJgy18Z6WGn4bkGbSV3x8E
         qsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8nK8VWFKGSFG6QTbbjQ99iFMt2jREYcBJN09EDv58B26O+bqHtaxkZ/ngii5ndoyuV8fW+UyyPwYTOB1YTx3o9DntO5FKMg7j020uWuPK6XBN1rQi7wnJco2T97BmqU5RwDPQkzp
X-Gm-Message-State: AOJu0Yyl2L/l/nDoOiD4yKh4kSu8mdxp6o9hrH+AgZ8IV6rP9eV76ujp
	rWQ2296YxST4GZO4hJvLTAlpEcxSy7W0Mw88mnu+cW/ouofjCy7Q
X-Google-Smtp-Source: AGHT+IHc5K5gLCarewdNGOEllukR+wh4z1BnFtsRopiMjOECNHauOfXbiZYAMUHzB12FW2vmEYZLaQ==
X-Received: by 2002:a05:600c:1d82:b0:418:2a57:380c with SMTP id 5b1f17b1804b1-4212e0ae95emr56859425e9.26.1717355840440;
        Sun, 02 Jun 2024 12:17:20 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:add1:b1ad:7182:3e90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42138260c5asm46317845e9.41.2024.06.02.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:17:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 2 Jun 2024 21:17:18 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/17] iio: chemical: bme680: Fix type in define
Message-ID: <20240602191718.GB387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-6-vassilisamir@gmail.com>
 <20240602134150.6cdf01af@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602134150.6cdf01af@jic23-huawei>

On Sun, Jun 02, 2024 at 01:41:50PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 20:37:53 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> Patch title "type" should be "typo". :)
> 

Ah, you are right thanks for pointing this out!

Cheers,
Vasilis

> > Fix a define typo that instead of BME680_... it is
> > saying BM6880_...
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/chemical/bme680.h      | 2 +-
> >  drivers/iio/chemical/bme680_core.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> > index 4edc5d21cb9f..3133d624270a 100644
> > --- a/drivers/iio/chemical/bme680.h
> > +++ b/drivers/iio/chemical/bme680.h
> > @@ -12,7 +12,7 @@
> >  
> >  #define BME680_REG_TEMP_MSB			0x22
> >  #define BME680_REG_PRESS_MSB			0x1F
> > -#define BM6880_REG_HUMIDITY_MSB			0x25
> > +#define BME680_REG_HUMIDITY_MSB			0x25
> >  #define BME680_REG_GAS_MSB			0x2A
> >  #define BME680_REG_GAS_R_LSB			0x2B
> >  #define   BME680_GAS_STAB_BIT			BIT(4)
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index dd2cd11b6dd3..8b42c4716412 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> > @@ -719,7 +719,7 @@ static int bme680_read_humid(struct bme680_data *data,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
> > +	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
> >  			       &tmp, sizeof(tmp));
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read humidity\n");
> 

