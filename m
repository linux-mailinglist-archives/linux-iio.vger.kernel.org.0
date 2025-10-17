Return-Path: <linux-iio+bounces-25204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8951BEAD43
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 18:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 996D8587C40
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 16:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4EB2BF3DB;
	Fri, 17 Oct 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBrR57zW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B02BEFEB
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719035; cv=none; b=caqecDaa3Y98jQ5pnA1DBJbOBi1955F2PUaFmsmq7N4dyrKeXloyMYILbspUedn2jLxUgAFBeBDOgy7Dv2U3PiQlKD3I/WV4LLKxaQsbIw2o45Oh+ywKk+kzdhKVUwjN68/MsA5uILKBO1YGEsILT89JExI7ie3uhgje7ZUbgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719035; c=relaxed/simple;
	bh=K5dh/21yz367t5636zz5BS+SRG5wCokC8YohqZIkQhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y53yz5ejN7gPoZ2w0JOCiBLwpJXZwktPj4bG83qDAPpkXCUM6EWrKRru49ZvtMn2IZ0GRcOqyuH+xowLJ7Bwd6ayFTr92JS+MRwdw+mUwDAZ3MrWccpPQOL3cYbYO1Z38gOu3fADkKdB3UxMmpmzoyXFX0BHhLTnF2CuNvt3mQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBrR57zW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78e4056623fso27552536d6.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760719032; x=1761323832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZqTIsgME323ZkO31yyQWUQxJPAMGciP0ot1SYinmXM=;
        b=gBrR57zWpXm2w/7blqiasX6rmV7vMOXlvxZj17ty4WRF2XnRnvCdJtbZv+TCRnKfEx
         dJRlYjhECXVkQ9Q1HIXqpT24ZGQzQyQsiU9ADp3KCRFJ3G7mv1AiaubTgOpTRR3QJiZ3
         nL5TZx6sR9W1Vxti398bZwYcjYqIqFXg7IwscFtEsLL6pqzhaQpJbypNsFnFKem58Lnt
         vDxezsCzssRFdXkEHo2TWlwIp5pluD9Qrl4KdwvuiuR/eE1k/nRL5SkfuLiqgxJrKVTe
         CXGLcSwa1vOVG6qTZzmTOJQt6xSCdBQTV/aXP+AmQChG2FjRoFtd4Y80fXd9rDh0uUM7
         a6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719032; x=1761323832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZqTIsgME323ZkO31yyQWUQxJPAMGciP0ot1SYinmXM=;
        b=C1duqvZMD9MziiRDf/ga2gwvV0g1XZRezBLuc+74DandPtKybHFbhRNAeJrbUwfrgv
         yIzi5l884fxqCws6NirESZkJRn0MjsOb7IuvRedjd+jZ2Vmzg/QZssikMIruY8qQ1PGJ
         d0JtnrpTGQYxKFrczqjL6MhyuZ+O0pmsDxKTu+aROP1+rRhGp+Fc4uKt4Bg87kI64FPf
         GPbBAnR6g4t9TRL8peoUVlvtzOFzGIlVjW8tjztN0UQHcTvN+DJUo7wVKIWoX02m6dMp
         EVmUZ/wd2Mz6I1JgLEWX6AhP7iWHnMg+x6mCgTBLCWUw14k2DMhu6+KrYAsFQ0EvuIwS
         wofA==
X-Forwarded-Encrypted: i=1; AJvYcCVugd4H4KxkOFYtyySgxzvWQibc8SdssGiSIiA0ND7I8kupzqpi8lhnJW6cIci8Ll0LYTiYhkseUQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTOyMpXpSaeBTnUe67HWRNFuxnQZQlJcNSoIvyfg9LWh8uepR
	2NDdSN6SW1DQAk0mGSOwIpTpR0QrLQggjXCWxqSwOPRblxSk9zDcKlKk
X-Gm-Gg: ASbGncva3R9Zqchiz81Lvhv7AAZKvwAG5BvZDXINT2momyBmId4klarxbVb7TEGSvqh
	a1HozbXVzSe0CUhKHb79dMq8hnQjTnq3wDfN1ewn+61F8CZznuj7jp4FyfxtTvYvKhWB5uLs5V8
	o+IMAFFRWgnSd6ZU6YQA2w4fp1gn8ot//fdKc4/CvC+zp8LCK4ypCkpczYS07dNCm0ejJvWMdmS
	a24RzQyrHIEZrhDA+EddEmi2kxlRl3KjUWNaMRXCPgaSbPiXo0QeyzA2zOh1KhlclYJsdjIWx0Q
	gLY6+/7YqDLwkWPF4Qk9vF84JXJMeZHCPQtYDCBeB6yClDAtiXU97QidpHbkGg8bw2lxkhDIsZ6
	MA2e39OR/kdvpBmPveE/XBHoOvPCHDt66YxHWUXZEfuuW3oTzcRhovh9U50MjhMHGIcr2f0/HQ2
	DKijYIy7Q=
X-Google-Smtp-Source: AGHT+IEBLNSjsT2f6SbTw5aTPGakjHLdlQrL5hue+DxfPG8mzc3zrpMssrggDkT+31HrLygOdkrpIg==
X-Received: by 2002:ad4:594b:0:b0:87c:2920:5730 with SMTP id 6a1803df08f44-87c29205b08mr24398926d6.40.1760719031704;
        Fri, 17 Oct 2025 09:37:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d91324sm1575686d6.65.2025.10.17.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:37:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:37:09 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
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
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
Message-ID: <aPJwtZSMgZLDzxH8@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>

On Fri, Oct 17, 2025 at 12:54:09PM +0200, Geert Uytterhoeven wrote:
> There is no need to prefix macro parameters with underscores.
> Remove the underscores.
> 
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - Update recently introduced FIELD_MODIFY() macro,
> 
> v3:
>   - New.
> ---
>  include/linux/bitfield.h | 106 +++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 5355f8f806a97974..7ff817bdae19b468 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -60,68 +60,68 @@
>  
>  #define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
>  
> -#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
> +#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
>  	({								\
> -		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
> -				 _pfx "mask is not constant");		\
> -		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
> -		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> -				 ~((_mask) >> __bf_shf(_mask)) &	\
> -					(0 + (_val)) : 0,		\
> -				 _pfx "value too large for the field"); \
> -		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
> -				 __bf_cast_unsigned(_reg, ~0ull),	\
> -				 _pfx "type of reg too small for mask"); \
> -		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
> -					      (1ULL << __bf_shf(_mask))); \
> +		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
> +				 pfx "mask is not constant");		\
> +		BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");	\
> +		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
> +				 ~((mask) >> __bf_shf(mask)) &	\
> +					(0 + (val)) : 0,		\
> +				 pfx "value too large for the field"); \
> +		BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >	\
> +				 __bf_cast_unsigned(reg, ~0ull),	\
> +				 pfx "type of reg too small for mask"); \
> +		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
> +					      (1ULL << __bf_shf(mask))); \
>  	})

Hi Geert,

Thanks for the series!

I agree that underscored parameters are excessive. But fixing them has
a side effect of wiping the history, which is a bad thing.

I would prefer to save a history over following a rule that seemingly
is not written down. Let's keep this untouched for now, and if there
will be a need to move the code, we can drop underscores as well.

Meanwhile you (and David) can propose a corresponding rule in
coding-style.rst and a checkpatch warning. That way we at least will
stop merging a new code of that style.

Thanks,
Yury

