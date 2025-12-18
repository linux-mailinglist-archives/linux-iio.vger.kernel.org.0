Return-Path: <linux-iio+bounces-27180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F717CCC529
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CA83069C8A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103F29ACC6;
	Thu, 18 Dec 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWALlaHo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61256275B15
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068637; cv=none; b=kc3hsbQcnObUNmtprbnpWxTK4wXwH1AOglL0lNmWs6YwNHY+ajTTx2xd7nBXDYu17sjCvUpGH7cVfIKe2dnrKVbqQp9PG0e/fv4gMlreTzMzcOlqfZMxRGdVhcai1DeRGJdVVRI3bmNJ/NUUF8nXoPeNxjNroBuSg6lxWtXbWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068637; c=relaxed/simple;
	bh=DxtyRnzdSJwt8HkqzKj/nu+FArvP4MZdiT5K2ZOumNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLEh3SXkwcnX+DW6+XrCm6LHmpaZX+dUDixvIyrEi/4nb9IH5LuNcZEms07foUA+4Csj7iXWmA1nqmgU2+DRsqbI2jtQw+KVAUsk/sOghGshAcvSg631TkbAeP/6NOkoRkP496saTrxO9hGPzfl4YXnnAHSP2A6bjBifu8zVnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWALlaHo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d52768ccso9383805ad.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766068634; x=1766673434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TR3PplabcnA7UkJBFlt/TnM938reXt23QxQT7MrdzIY=;
        b=AWALlaHodyvxjzvpP8G1eXpNOUswcJZ3CoM7VGuAgd2Jp0MuwtMir24gjUFvCBV2nI
         4ipI/xyGUO+L4J5k8vuWfdgC6m8hbKfHSvJIzDwRWNtwEebOjqGSSLboTWvHDV0p4P/T
         Fxz3Uj9GF+/VvW8A+UUxjNUZ1LphbVabMVGGDx8hlJK46LxYQ7zDbd+lVln92taUyqrL
         +bVi8UrMPY7bAuy39TAtpkv7S1hkZ1WwryYol3a7ZQsrw//K6l9D2yVJZxmw2f477rP2
         WilgzlU1oxijmUAxihS5GxHwgBFUc7COEZsOjb130PJFfJRsVGW1TrFKmjv/0IJt++IO
         d9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766068634; x=1766673434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR3PplabcnA7UkJBFlt/TnM938reXt23QxQT7MrdzIY=;
        b=o5yvLH0AXa59pLg1xCeAPZWDWxNtLRMPSkB3bIjk/5AqmXkrfJwVUCHGy/jUjqpL60
         PQjoz29bVOcG0jpZPdpz4Rqou+t55ZJItfmzR36TCA/DZ8rnpm/LQwJm9baR3M36/DU2
         l0BYRwJtYh6FvsGXDChjuiQhUjVXvslmF9Rdhre2X16CQoJU1PzhRgHGqT/SVnInZAcD
         D4ZXT+wvqrVPW/FKGcOHgYhCdQ1NyL+cOocxbo23KhNGNSLshaFGHED4o3avTQwA0wUu
         Rw9EnU4euTQXwbxiY3x6g+3cxEXcLUJPLa2RtgikXiIbY4tMY3eocu3apeb1BU67cV1L
         bD+g==
X-Forwarded-Encrypted: i=1; AJvYcCXH0UnU/9f19TYPYauB2B7o2g85k5DDvjjl4/0XYPPohPBudZGiY02AK75I/ASnsYOosoxuO/2mQnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqzxteg220VwsslbGs63qltaobbIQqJ8gvZSJSOnlBub5faAkk
	k9Favo7EHjvQsQyd0yZiNXNt0K47Vjso1iVJl0w9cjfO83rmvVtVZya9dzZsdw==
X-Gm-Gg: AY/fxX5gC4w0SsDYDBpZJKH3raAuMsnY2vubdBuSsMU+cCTdLmG3H0qCKQGN7j/59Ac
	vD4hRvpgvWM3y5NTDTspLXrMu0FWtSWwsWNSXtqVOCgLBEZpmPJkVITtvI/lbLHIzTcPJRWayar
	S+gBRG5PMUdSRRYDE27/JaETsgprmAQ42HS1wP8MUvyD2RuqE2AyeYQVe0sWbS4qOwSCbRnwYGV
	TMUiQkuoVote8z5q92Y5fOHfos8zDVPGPZjDYo1UvcxGhyxHXgnKczAhDGsaDGMUg5mFAuTvwK+
	4kKrkX7OCkMBpKYGXlUnGmQZ0C/m7oNfjgQgMSJi4zWdntnWO/kN07tn1oJAcNFgJuwJwBrjeN3
	08CbQ6ichhWaVz1PxTVvnTP2ymUugR7M0svXhkqrH7aAM+/qCTHetpeYg+SnRaWG+rgBH5O4Xlk
	j3tPCTatppwO3kje19Jpc=
X-Google-Smtp-Source: AGHT+IHklmQ9OYtCFpJ6W2rLqAN4zF9YoH2D4KR8JaJzkloRbmKoMsSz7BP5QMv66aUqN8WuYp28+Q==
X-Received: by 2002:a05:701b:2605:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-11f34be9b9cmr18708999c88.11.1766068634462;
        Thu, 18 Dec 2025 06:37:14 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061f58ba0sm7980511c88.8.2025.12.18.06.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:37:13 -0800 (PST)
Date: Thu, 18 Dec 2025 11:38:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/5] staging: iio: ad9832: cleanup dev_err_probe()
Message-ID: <aUQR_vBHQwg9CWFn@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
 <20251215190806.11003-4-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215190806.11003-4-tomasborquez13@gmail.com>

On 12/15, Tomas Borquez wrote:
> Cleanup dev_err_probe() by keeping messages consistent and adding
> error message for clock acquisition failure.

This is also a clean-up patch while patch 2 is a driver update so I would
provide this patch (currently patch 3) before the patch updating to use guard().

> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index f9ef3aede4..8d04f1b44f 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -302,15 +302,15 @@ static int ad9832_probe(struct spi_device *spi)
>  
>  	ret = devm_regulator_get_enable(&spi->dev, "avdd");
>  	if (ret)
> -		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
> +		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD supply\n");
I'd break the lines and write the message in the line below for this and other
dev_err_probe() that exceed 80 columns. E.g.

		return dev_err_probe(&spi->dev, ret,
				     "failed to enable AVDD supply\n");

Note this is just a personal preference of mine, not enforced code style, so
fine if you prefer keep it as it is.

>  
>  	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
>  	if (ret)
> -		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
> +		return dev_err_probe(&spi->dev, ret, "failed to enable DVDD supply\n");
>  
>  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))
> -		return PTR_ERR(st->mclk);
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
>  
>  	st->spi = spi;
>  	mutex_init(&st->lock);
> -- 
> 2.43.0
> 
> 

