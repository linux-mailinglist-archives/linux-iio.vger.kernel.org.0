Return-Path: <linux-iio+bounces-14774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF11A2431B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E7B188A99F
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676BB1F1902;
	Fri, 31 Jan 2025 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEbWMdyb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BF14AD3F;
	Fri, 31 Jan 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350221; cv=none; b=l6PjQxJrUFpyOzomIfskBDbNLg0VUMOpLCG4iX44LOJpgQhEsdLswm7dPbK9oUifcZL31XwDeWo5SuyjGdFbTi+D3dEeypJOBnWNXc5dRylVxZJDxhzfGUd3BPgU2YaSui4AEDXTagco4UaCC7dE3KLzI9ROwQ6asI/Iqc9wdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350221; c=relaxed/simple;
	bh=uzxZezk1KcRSDBfkDDnaI/05Lxa4t4IjBjpskgW0ogQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFrVh35kF14rcJ9hspgD4X2aaBZvW+tmJ/6T3gbokwcYGvfYN5G//Im0/YCaSnolWUP68cuV90ahlZGCXx2b7AGkNNXFphYmla/wOFkxFoo+rWYPJu1SDjgf42V0sG40VSbl0mnjbq3QRikynpsEglug9RKApbzgLfZJ9UQ5x0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEbWMdyb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38be3bfb045so2387097f8f.0;
        Fri, 31 Jan 2025 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738350217; x=1738955017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pglTObOFT5rBCszltvVnpJmzw8D/oeXug/disPOkEu0=;
        b=FEbWMdybdt3UQYzjd//UkZvWxH3FJ/AEOIInsiVqs3hDhy2UtmLBfsF0at46OrTpAZ
         adGbpzVJ4JjIFTKAuLg6N43lrttuoQi4i43ZTKnwfaMfqOEak+FrbB7yX64xPn8RtQfs
         uBABEquQptUUTT9GEfsdBl6J5g6++VC1PzCO5JLvMOyHu/9SXR+CruJLujv7ubjFImtp
         5jd/IrurwKUMzvg7aJRnziM/6vN98rWM7ST/9if0r5vblw10nJs6Gls5xy139G1Y7b1y
         vlGO5qRLX4D8tGzVCqWbCGW+Z6aRlbbSWYCHK7Aud/LaGGOOTbCN1rpWPl4iALfqa8lF
         CkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738350217; x=1738955017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pglTObOFT5rBCszltvVnpJmzw8D/oeXug/disPOkEu0=;
        b=gNGIK1WqK0S6DXd7MKYJYb0+6bYY3e4ERxfZrEac2PxuAobwEeecowOCTCvOQU0XMG
         EZz7Rfu8swnLUSvb1bk5EonQaNXlJ7pbPnIB8jjNBL0evYlVHVZ9P3GiB3OzpZXdMgLt
         2oeAggXb1pTlb7Avf6sZR5Fdl/I0V9KYa/edxZ7qoNBWwfscH4ly+gHvqmqIo6ZMSzv0
         Z+hwBFAEbc/S2lGRSH3tK4Bls0zFX9C/U41n7eZruv9QxDAlgWtW2OchrbSBSywD1uRJ
         9o0bm3JH4ZyxrXjkEq6ihzGB8vxdlUHOyKYK5IUfWlY6DcCKGbkO6ihQ8HvqkDY6gSm9
         yrGA==
X-Forwarded-Encrypted: i=1; AJvYcCU272tjlm/WTtnn4kL/ZocT8ievOATnWCiu1JmlZLXyu9C9ZKsg62PgvJMxf3T42wNxf303aqPDV4pbwgzX@vger.kernel.org, AJvYcCUcNeZLAGt/uq2/l6gF9qrZEDyOOILQWqtzNY4A4m/KPVpQajCuB6vFdhpp1ko+C0xpbn9JTP26/wQ=@vger.kernel.org, AJvYcCVAq3+kFFMVezT1Vs9wpPng3pjLYNI5vNYcwcvzlFCL4uE//jPLA8GY+H2wWjTI3mUCsoyOrVOUecOsA0cvOFPXVmk=@vger.kernel.org, AJvYcCVc+DrnT1EWf3cOeJBCqpN52uqkXtf60Xv35YGeF934NJTOvD1X8KF7DuKRLNDDulWVU/fxQlnwzHvOhQ==@vger.kernel.org, AJvYcCWCyPa9p7qioCoHwtF0tg3FcxF5semsglRDBMQeHM9JBv67h1bWZ+hHs5Se/VHZSvOHBU9iEDYAlApDYNWB@vger.kernel.org, AJvYcCXET6HV3yHXnpdfnAevKRuTJAbiFemNiGnFXkl4bt5kB/H6nEHJ4SWz2saiuZg3Q0MCJp7NOEC61CQPD4o=@vger.kernel.org, AJvYcCXoDrRBvmQMOtHrBCAmB8CWvdtadB9vwco7oQkK/O0RTrYXqy7910kz6x9q7xObyy2UBM/cZNX+xw6R@vger.kernel.org
X-Gm-Message-State: AOJu0YzX83mbmefnGf/2B/022rRiusROqxAMrZuksYQenKRnSVD9EbZd
	rE0j1BRyrFg2OOy8iF0MlGkxFjfMASGihCzOeMlgONAgAf+PCBp7
X-Gm-Gg: ASbGncv8py/3dJd8r5ME77JpKSl23J2hmNld88EBkt4jYuVXFwgzaZykeIdBmDN2MXl
	qHC6w9Vd6W/2aTbCvT94r7uX5wY1GHsbJDViqr8NdqlCNiovqUHMut0gCAcW84di5N7dpzTBgpI
	QX2mdmrztgxBUmKtgLGm79XCRHyNpZQHXcWWezf7hfFPqcuenpZ48bkxZrkmrDxKj7WjhyiybAE
	W6DUOaTaGrU1pjhRBvGuLcF7y85GJNX2iGEIJUMcD6w9neDNdMFivOoqLSJ4I2QjfbKhrMd3sAj
	HVGgmm1PBEoYSI6TefgpnsHttefKv91o2WGUxABXJ6ADQS8JiudWqQ==
X-Google-Smtp-Source: AGHT+IGOWalHkw0VQDuZrFgGWdO/5t7oYMe9eAr7RV/AmNQsKEb7LjEGNkj8XpJngRC9CG3jrtAtQg==
X-Received: by 2002:a5d:5f56:0:b0:386:3d27:b4f0 with SMTP id ffacd0b85a97d-38c60f26459mr3846706f8f.14.1738350217335;
        Fri, 31 Jan 2025 11:03:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23d444bsm64691365e9.8.2025.01.31.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:03:36 -0800 (PST)
Date: Fri, 31 Jan 2025 19:03:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20250131190335.4c18fb3c@pumpkin>
In-Reply-To: <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
References: <cover.1738329458.git.geert+renesas@glider.be>
	<1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 14:46:51 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures.
...
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f1732230700..c62324a9fcc81241 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -203,4 +203,38 @@ __MAKE_OP(64)
>  #undef __MAKE_OP
>  #undef ____MAKE_OP
>  
> +/**
> + * field_prep() - prepare a bitfield element
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @_mask is not limited to a compile-time constant.
> + */
> +#define field_prep(_mask, _val)						\

You don't need an _ prefix on the 'parameters' - it doesn't gain anything.

> +	({								\
> +		typeof(_mask) __mask = (_mask);				\

Use: __auto_type __mask = (_mask);

> +		unsigned int __shift = sizeof(_mask) <= 4 ?		\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(((typeof(_mask))(_val) << __shift) & (__mask));	\

There are a lot of () in that line, perhaps:

		__auto_type(__mask) = (_mask);
		typeof (__mask) __val = (_val);
		unsigned int __shift = ...;

		(__val << __shift) & __mask;

Note the typeof (__mask) - avoids line-length 'bloat' when the arguments are non-trivial.

	David

