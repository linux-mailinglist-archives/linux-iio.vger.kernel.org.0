Return-Path: <linux-iio+bounces-14866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CAFA24F5E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03407A2474
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830131FBEB1;
	Sun,  2 Feb 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL0EzNW3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10E1FBCB6;
	Sun,  2 Feb 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738518839; cv=none; b=ub+LKxdT6Nd/MharsksR5NA1OGvoK75GP6nzkMfqW983mmRZ2L0AewqU6R2H5AAyc1HrDPptuLXxDVsn5N9R9skGp4ykcUs25BXo2IWnOh7ibFC+xZonXxSDqirdj4xL11qldi2HCVlSO+ybIypRv3f3/So90KvAJ2DQ1rvdB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738518839; c=relaxed/simple;
	bh=wJ1UIWu8ialmyd9DgBW/S9FAV5r3Qu1m/hwmDc7n5FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbpdXPcWvjXpg4RCUFAdM6KwJmdJsdIAeOQ5A/ke+kaH5UetinyXcGz9lz2JsxvnYgOtsdxYGrV2bDnDyl1stgs46J2s6sU/LFH646AReX6hx3YlKUmDgyq98VILRSIp1GBjx/n4+dzOx6rSMQla+5Qqxaij+GCYzr3jfL+4V7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL0EzNW3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f6cb364c7fso17285577b3.3;
        Sun, 02 Feb 2025 09:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738518835; x=1739123635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bu/o5ZKE+DmrVvfqpvDfKwO+d8/POCqsIdA64ajmPWE=;
        b=EL0EzNW3p/UPCWPz5ixqlfJGRdBUqpe0WKZhc7nXfdCL8/VqiPW6x9P4SiH1/QOZd0
         FjJUaHs/RXXdgqfUZ2+Dj0MoNBpGRPht3vC6qkq/vDm+m9Rt8joSyh7lbIDn1ri0e6Zy
         SZLnZ7yQIz06zgKYYfIfRSaIF9XeCqUgXal7tdaW9T/iD4UQSKDuBVftGrGToRg5YFwf
         YsXoYFt8d+c6adfG9fmn8Le0OX2t1eiJIDoC8gpMT+6tsiyM0eNoURWxoe2XvN+NH+Yo
         UQKS6W2PAWb2FSjrcWrNkP9wWJmQKLglJMoaIuAFKA+V3pqOIPvTtc25GlrtT4iWlZrr
         W5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738518835; x=1739123635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu/o5ZKE+DmrVvfqpvDfKwO+d8/POCqsIdA64ajmPWE=;
        b=lFX9CW2Ej/CQ4fh6590qXQwVyC/60LbbjqztW2x0M/K1BcfCVcvAHVgp1jl2FMrt/Q
         ogSWmE49G//JHtcblA4JZQVyBBlz/tuZw7Q34ZFwQc52dTTJ+a/8e2/We+NlVg/oatPU
         ewXjt5h+mpme4wRnWSop0viOGmJMvnFugwQzb0HHXchrwJqQ9rqKrTEY3k+i7Oy2qDiU
         4KBhEIQG+xrweB6ySe6c70cwJO/vZVcgHOzvzHFH2ZRLVayQlqZJAvXjmX6uZVDcMcoY
         Tc/0kVohcBY8LjnND1vBoPov3Yl53Nh1jA85mwKXeZ2oSS1UFBQ8xdPLuvLLdmYJl3zO
         kLlg==
X-Forwarded-Encrypted: i=1; AJvYcCUAaajvYpz8GSj4uwIKIZ6e1iQmkQ4DNRARryjdFX2EF3QRBCoafBEi19HLPBsgZcIGWT2fCR/JEAZaNhYZ/SOoUzg=@vger.kernel.org, AJvYcCUyMLvJz0jFM+cf8vwi/Ol41pBzglnBX8qNf47Jxk3lq6xeFZsudL1z0kjiRZXMFEexC94plh4kX8UZtKOd@vger.kernel.org, AJvYcCUzR0qxnDRAKnfWoDtN3pgFAwaU2XDkKtOdkptEfnOK3Zxfjmg7q8Fk1bLDzpYJRBMRVrNM42XFwBtWaOg=@vger.kernel.org, AJvYcCWQA94JmZ+mXRYpsIgQUearpO9l6cc6scycTAVbiEEPTLjHaar4CO/GMPE2c0LDN0ehWF5Mqe5BBxNK@vger.kernel.org, AJvYcCWqO6+XOXU6i8QtuXaDUDaMEV4eG6QWJT5fIo6YnikOQw0l+hKh91OnZh0v9I/PeSk9EOzYYe45kVNepTAB@vger.kernel.org, AJvYcCX5/ErFzWLIR6q1Cab99QaEUsZ1gqJxQTJjIL/IzcgVE4zKIQq0tVyMaCGsZfTcUcFm9zOA4VXu9sTDzQ==@vger.kernel.org, AJvYcCXRJyy4eB36v/hQq2Jtg1D3kKuZ0NApl+flXdz52yJUYx1J12gZo+nmln1luDa4KrgLviVeAlssVy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzslZo50tx0HH7PMmBGlgNIgZUjRYuVbFvxRDcnrM0qDjfoIO9t
	1nPsIS/WBc7/325FpDUdMFw2NqrAhkE6YfOZFPRpnrqUdKJXgEeq
X-Gm-Gg: ASbGncszc/3FFpH4moRgk6T4zetiveR/EFL2cMbbjKDRjQ92BcpFy8KKKSX5BkbStDL
	WCd3dz5r0jT9VIZM9kedqZFLY70sORczXebsKTxs4e+VqTY4B7Xpps+EJChlQg/VogIafUrI5N7
	Fm/jmFsPPXSiuFfQ/UjNvOcNIwYVfWvbQY3J+XBHILjxwC93wIPbCh1YnpJZenG1i9eGlHBAsxF
	sWKzSNKWf/LTQTsHDMWbIH4xR86BE7Swvqwp7hAky8nFk9S5Ypcvm+JkXFLyjy+0swxyFE84aKX
	/3JOczHz7VpQRXZE3mTN8ZaaZFV7sO6QGUuf/cqZEcZeoIqQqVI=
X-Google-Smtp-Source: AGHT+IHHQI3478HvRiKWIVLIdATv32EFyyXdDb7s9xEv/S/0xqBbGzFcSVKK2nIkOtoAuYeOo+6nPg==
X-Received: by 2002:a05:690c:6e09:b0:6f5:4304:fdc with SMTP id 00721157ae682-6f7a832a301mr158970467b3.6.1738518835574;
        Sun, 02 Feb 2025 09:53:55 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c465b884sm17908247b3.59.2025.02.02.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 09:53:55 -0800 (PST)
Date: Sun, 2 Feb 2025 12:53:53 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <Z5-xMUqrDuaE8Eo_@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>

On Sun, Feb 02, 2025 at 05:26:04PM +0900, Vincent Mailhol wrote:
> On 31/01/2025 at 22:46, Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> 
> Why is it that the existing FIELD_{GET,PREP}() macros must be limited to
> compile time constants?

I guess, for historical reasons?

> Instead of creating another variant for
> non-constant bitfields, wouldn't it be better to make the existing macro
> accept both?

Yes, it would definitely be better IMO.

> As far as I can see, only __BUILD_BUG_ON_NOT_POWER_OF_2()  and
> __BF_FIELD_CHECK() need to be adjusted. I am thinking of this:
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..c6bedab862d1 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -8,6 +8,7 @@
>  #define _LINUX_BITFIELD_H
> 
>  #include <linux/build_bug.h>
> +#include <linux/compiler.h>
>  #include <asm/byteorder.h>
> 
>  /*
> @@ -62,15 +63,13 @@
> 
>  #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                      \
>         ({                                                              \
> -               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
> -                                _pfx "mask is not constant");          \
> -               BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
> -               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> -                                ~((_mask) >> __bf_shf(_mask)) &        \
> -                                       (0 + (_val)) : 0,               \
> +               BUILD_BUG_ON_MSG(statically_true((_mask) == 0),         \
> +                                _pfx "mask is zero");                  \
> +               BUILD_BUG_ON_MSG(statically_true(~((_mask) >>

This should be a const_true(), because statically_true() may be OK
with something like:
        ((runtime_var << 1) & 1 == 0)

I think it's your own patch that adds const_true(): 4f3d1be4c2f8a :)

Thanks,
Yury

