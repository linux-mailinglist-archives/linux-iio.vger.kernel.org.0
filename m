Return-Path: <linux-iio+bounces-19315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9822AB008D
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C356189EC05
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5A27D784;
	Thu,  8 May 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/z9hWXI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E231F462F
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722227; cv=none; b=RYd7LyNraQeC0EuoKgVWxLDNN0d9Re1a21xUUn8tW/BG8z1gf2/WvIaiBK4qExbAyokcA0cPGhdJ/TFaSlT6mFYqWnal7xMDQ/eGswyuCgFPhc5gy4U+nSXv+jYKBpkOgx4Zh/3jiloB0lnw6G56+F/sHcOLW14KmupH7YgvGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722227; c=relaxed/simple;
	bh=Jh19Urx49SN1eBkNLxQSIgzaQGEu7st4LVSyuPgV6/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6XsllkwbGxW8ORDPQg9rvymr4mfO4EcruweyJRgQLcijqs6xqgosooxqkN8oQK+Ss2qn/35tO3gKd/GfKVXIEhsdzp65nHvJRLEruMe01q4j6GizHHlzoE8kSrDaFYbMKnM8dfV9SIS8Xx2GVqKgUJqT6M0US3PPE1Go2CX+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/z9hWXI; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fa6c54cc1aso747840b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746722225; x=1747327025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ud3f+6cWmU2LT/ykE3+yDGGOzWMAhXBY4OtcE04qM8A=;
        b=j/z9hWXIj4bUA2RMIuQoOyZ1ZS3RXQ0hHQh6f8AxCrxdOzxZuQGbqLC86g5bsrJtrM
         tQX8tRbI000Y7c3x8eUBn+6c4BPcQfpMD6AEkLMrklmOBk8K3MtitGGjrHsaOkH6/enF
         zdofgEpUdeU7Y43m2RM7P4ILIMQv8VbcdMBHroEfvYDcj37FhGS6HJ4H27xR22R5keht
         NLePVumPIk3VFy7wpeEQHU6rxTdgNKYc6gyQFFh7J8q1ADTlyaPqiFjR1xrnbFNkzbnT
         G66qZ0G2eCZqENG9VYLiQBcC1BMaNTf6DuwgP06hwG2tI2uW8YpPom7SS+2ZqtKD+bVF
         P06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746722225; x=1747327025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud3f+6cWmU2LT/ykE3+yDGGOzWMAhXBY4OtcE04qM8A=;
        b=HTqhDrXZjCAb3gMlI5asnc/wXNaLQbIZEwUEsVafzdHLWopsK25Zw65eNLRvOYnVYm
         sFD4HDR5K2PrAq4ncBm8ckWqLVtaNQTpzCUX3eq5DMOUzqFN+0a3JQ1VixQ82KVaai27
         6lDexmINpzRhGBeblf6gsaSAg5IeEqdiLvtxFA7he2GPHrq7x0Aih7IyIwRFq4Q+fCIw
         EkXpSYRPhWQ9FCX0hcWU7aNuv/tJJJ8Og7ScHprfHnbuMb45hU7ebcmhwsrMIWNzpgdR
         6uYGGqHAWiLwzlex5/Hy1Yqi6+WSvEigUX+MBHJBudx8PXdrcLAjaBcPjF2eWA55LJ3V
         UjSg==
X-Forwarded-Encrypted: i=1; AJvYcCUsu7JdiAxHkLkBrhIjSinjzgcwET7QYi/e8GyXAnVpgJRnp/wT1rGIEFFKupJRPx31hmr0NoFBs7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbri+/fC4LEQfI5qMzss98v35u+KZ9gqs6WWySJx19xN/l3+V
	YxMoPFdjk143SBlTj+FJfJP2InjMW0U7/HnoCs4oIk7qSAG1aJKq
X-Gm-Gg: ASbGncvEgKxRo63z4pTWvx6klTJKZdDafW74JXll20pOmhBb5RRR65VGwjXFc0dJW7L
	NHm6xaN3L7RClxNdxdDzuaG1TUPxKGxcfrIVgyfIMXtxigrO76PPUgfzKBMqxwRZoSb1YHpTmFQ
	GrVYw/sq8g904fr/zE79jxI7ad7IKbijFgdYhHE9pbA/sDd3TAoCdDb99fLe//LInWmEMAVthi4
	qXmKX+BVzZPRYMVQIsr8xDaFMeotXG4lct9SL7/y+wt7yp4JKBBOeVc3llaHqZ1nf2rxe/Gv4g4
	1jXgMLwxFAIKJ1jYz5KIuaiVZXlfOPVqbsApQUq3xhDFlD+QuFv9D4z6WMss
X-Google-Smtp-Source: AGHT+IFgKCdBwL2DjtUQFegQG+tyQtJRE6pJkWx3JhZrhOU8kiqntMc4RbULYuWVMVWMlCZo4XAiBw==
X-Received: by 2002:a05:6808:2017:b0:3fb:a7d0:3b1f with SMTP id 5614622812f47-4037fea3102mr241363b6e.39.1746722224645;
        Thu, 08 May 2025 09:37:04 -0700 (PDT)
Received: from localhost ([2804:30c:404b:a800:55e1:4221:1a82:c6cf])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-403802d1fd1sm16479b6e.12.2025.05.08.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:37:02 -0700 (PDT)
Date: Thu, 8 May 2025 13:38:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Bianca Costa =?iso-8859-1?Q?Galv=E3o?= <biancalvao@gmail.com>
Cc: jic23@kernel.org, juliacalixtorosa@usp.br,
	Bianca Costa =?iso-8859-1?Q?Galv=E3o?= <biancagalvao@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: mmc35240: refactor volatile and
 writeable reg functions
Message-ID: <aBzeAMqvfG5rakaR@debian-BULLSEYE-live-builder-AMD64>
References: <20250507182327.49068-1-biancalvao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507182327.49068-1-biancalvao@gmail.com>

Hi Bianca, Júlia,

On 05/07, Bianca Costa Galvão wrote:
> The two functions `mmc35240_is_volatile_reg()` and `mmc35240_is_writeable_reg()` implement exactly complementary logic.
> Refactor by having `mmc35240_is_volatile_reg()` simply return the logical negation of `mmc35240_is_writeable_reg()`.

Wrap commit title and description to 75 columns.

> 
> Signed-off-by: Bianca Costa Galvão <biancagalvao@usp.br>
> Co-developed-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
> Signed-off-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
> ---
What were the changes since v1?
It helps reviewers if a change log is provided in the covers letter and/or after
the `---` of individual patches.

>  drivers/iio/magnetometer/mmc35240.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 07f58567e521..80f023eaba9f 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -418,14 +418,16 @@ static const struct iio_info mmc35240_info = {
>  	.attrs		= &mmc35240_attribute_group,
>  };
>  
> -static bool mmc35240_reg_check(unsigned int reg)
> -{
> -	return reg == MMC35240_REG_CTRL0 || reg == MMC35240_REG_CTRL1;
> -}
Hmm, I can't find mmc35240_reg_check() in drivers/iio/magnetometer/mmc35240.c.
Was that part of an initial patch idea?

>  
>  static bool mmc35240_is_writeable_reg(struct device *dev, unsigned int reg)
>  {
> -	return mmc35240_reg_check(reg);
> +	switch (reg) {
> +		case MMC35240_REG_CTRL0:
> +		case MMC35240_REG_CTRL1:
> +			return true;
> +		default:
> +    		return false;
The line right above has spaces at the beginning. Use only 8 size tabs for
indentation in the above case.
By the way, the current mmc35240_is_writeable_reg() implementation in IIO testing
branch seems to be doing what is proposed above.

> +	}
>  }
>  
>  static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
> @@ -447,7 +449,7 @@ static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
>  
>  static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
>  {
> -	return !mmc35240_reg_check(reg);
> +	return !mmc35240_is_writeable_reg(dev, reg);
I guess what you wanted to do is to just make the volatile function return
writeable_reg negated. Not the most wanted update but, if you do so, add a
comment explaining why the volatile registers are the ones that are not
writeable.

>  }

Regards,
Marcelo

