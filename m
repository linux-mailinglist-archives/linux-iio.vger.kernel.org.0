Return-Path: <linux-iio+bounces-15543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537EA360A5
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537AF169B71
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2326657D;
	Fri, 14 Feb 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1lYWQD1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563FA264A9F;
	Fri, 14 Feb 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543987; cv=none; b=blA6Ba25xb8bm+Yj/Te/R/UzHzHmS0XnSziyzSQreiLCbhttvchStqqb9k3nvXIq4ehjl/UtO4lnE2ByiSjXem/7i4TMZ1xYMpK4mKFwgQx1fcpSkLY5ZzdLYtjDBYo5Vup20W2JfNbFiEttG8LM/+0WiCGwkUk8ht/6noiXiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543987; c=relaxed/simple;
	bh=NX77pwb06Kvs7WxpDXaPVihgFPdSFRjITEXfK2Hopjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfks0SxrCjtVE7TLsl5QcHV5GKivNYfeTFv9X/TpqqK6Ad6+O8rG9JWMFaUl+PcofLIfNnNQl3NrzpO6S6MqJ1Ld9//Cesjk/Zw4P+yqk1WgMwCT69Y/Wwu+ju+JScZ1WZU431J+YkvFDdEa5Gf1JQ5hURRJB2vu/EYas+7YyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1lYWQD1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f9c6d147edso19887417b3.3;
        Fri, 14 Feb 2025 06:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543985; x=1740148785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI8KVq1D2a2mMAsVtcWo7XlUKAeczvE5EfV30VmWJCY=;
        b=L1lYWQD1HeOZuTlLSjNWY981oW2qoKZCC/qOnmyqYQl4K+Pm17y6r12jG7xcaG+1VX
         BbvZ2/rjdlC7W/83sZLAcah/+biNula3fnw1P0aMO2kjOCX03DpgNkW8AR0yPXy1xMYN
         KjEHjRz6dncJ+zDuUFgltJCDd32dZK1qUKYRvmU0b6e0rSGRgvTWnttj8F/k1tJ8aOTI
         P8RrFLxafZesdgaj8ZLSeooQXlxQdpIWXGRahoKmTqNdBSL6mVLiPLzJty0/vNThf/eW
         fKZLL0Xx0JMnhGZ+Rc4lKzvhR0W3XH4x5B+1IrjfULcZLgzG6I9IVrCaVIa2fpwv/2YU
         iCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543985; x=1740148785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI8KVq1D2a2mMAsVtcWo7XlUKAeczvE5EfV30VmWJCY=;
        b=MmDABZ7Olj1WJ+JicG7nJFSEByTcLqV178qsLh9Ttld4XqtMqmP4KSn3PLjvY2Z13I
         0xNYBylTIWdV75549CmuUzSqa+lvGf1B7DPojz8mQBm8Ve//1VAS9FbPS2Yqtc9BoxuN
         yvtBLJUqy4twjToirMZHN8oJbjNxg05e0zWRvFZwj/plu0KLPFWzTvjpdptITAh6JQc1
         Y4fifXB13bGu/u5NHN4pyL27GcTFmb5zTti15lrn9NVc4bN3lQilRxnhHC//thMstr3b
         kRSIsKAbFhaDDX2OAWtFMWXLZo8PufbjUoq+BVUNkeuHqeSLWPRyKqTKuyIDcJgkr9vs
         QGqg==
X-Forwarded-Encrypted: i=1; AJvYcCU9zKa+ZZcNTFTQFhx5u3Jfju+l6atRRqftutvHlB8qAmNYB0JsSipfA4kgv70k8hcLd+lB9F16o+kHQI8q@vger.kernel.org, AJvYcCUyTgyuo9pBFAVqxFu+C/8z0NB64lfjKYlV0pSBkV91I5uHl9JA2mdHU6AdZ2Jrp8ARLzdj3DpzzhOhqoI=@vger.kernel.org, AJvYcCVQ25wsogKO1J9hdg0xlYTR4zgZf2i8XjS+tSG1BuEv+FXL0B/6v8VI0DdSGwVrgmCTfYojiGOc+dgBP82hx8z0mOQ=@vger.kernel.org, AJvYcCWXX19V/6efSVl3+hZ+agotxk81yqPslfj2j1zhnhzrmEozVuD+GOmCz2favD9OFCBcoK5fRjf3R5bw@vger.kernel.org, AJvYcCWu1Pe+Ct1o+OYuX9jx/Uhyn0LUJRbwsiZJmTwdPkW80koDpcNmPpCGajjFViqLQDCDqpKQVmuGceASpQ==@vger.kernel.org, AJvYcCXSa0su7Ym3VesrF+ipApPdz4if0gPGiHJ8VkqrHnh4Nx42YfPhL+6WwBTDotf2eaTnTJsrf/yG7nI=@vger.kernel.org, AJvYcCXUrhuCTJaATfRo6CuuoTcJzfVIRPRM20mF2xlJ3eiFpNmXV1FadFINdjdS1i3KC0eFDybUmeHWJrIzWiGp@vger.kernel.org
X-Gm-Message-State: AOJu0YxtiU5bya+44KiEEY2z+atVGfKOCzl7i+swR4Uw5zs5BAMPzaXt
	Va0MeGD/TjU6LB/3Q/phyP5cngHS9QC23pen1JE71V8UOBejNI9h
X-Gm-Gg: ASbGnctbhFxQniYN7pDyKsH8fU59roj4JE1Y+xDcMXrGZPdYXR+Fj7eADxt7aoyc6O5
	SuWjIcol5Dh59VkApoSu3opVFnO/z2DZYaDYFcixP+DPpMY47cuxL0IpraUirdFUvhtkBc+3VnZ
	/i5qVcCqXeGNGdfMMWgTsN+2z6k+bBuMyeG9Bkq/nzSg7EOsaENNPE3gWc3xlKxMeYlAD0+x7Ne
	Icjs+BCCn1SmxIu3NFio32ZFFHsImUWsLvUifKSlCosUoggp3SxBbcABrFOXMOjc+8vxRLITep3
	sGSAYQEYlFczu/hfz6VRJ21PLBs2oxSz9xuU/mzdMbQ9ADtMaO8=
X-Google-Smtp-Source: AGHT+IFSk6lpEhh1WcbK3saqrHokhIjyrUSazUu/lghjS/PE2nJjXAP82B0Z/67hwQGCLhksXNnAww==
X-Received: by 2002:a05:690c:6206:b0:6ef:6fef:4cb6 with SMTP id 00721157ae682-6fb1edcc561mr119515777b3.0.1739543985181;
        Fri, 14 Feb 2025 06:39:45 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3609589asm7800987b3.56.2025.02.14.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:39:44 -0800 (PST)
Date: Fri, 14 Feb 2025 09:39:43 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <Z69Vr4ZGlrq7HxmT@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
 <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
 <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
 <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr>
 <Z6DzQHebEKBb12Wo@thinkpad>
 <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>

On Fri, Feb 14, 2025 at 12:03:16PM +0100, Geert Uytterhoeven wrote:
> Hu Yury,
> 
> On Mon, 3 Feb 2025 at 17:48, Yury Norov <yury.norov@gmail.com> wrote:
> > On Tue, Feb 04, 2025 at 12:41:55AM +0900, Vincent Mailhol wrote:
> > > On 03/02/2025 at 22:59, Geert Uytterhoeven wrote:
> > > > On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> > > >> On 03/02/2025 at 16:44, Johannes Berg wrote:
> > > >>> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> > > >>>>> Instead of creating another variant for
> > > >>>>> non-constant bitfields, wouldn't it be better to make the existing macro
> > > >>>>> accept both?
> > > >>>>
> > > >>>> Yes, it would definitely be better IMO.
> > > >>>
> > > >>> On the flip side, there have been discussions in the past (though I
> > > >>> think not all, if any, on the list(s)) about the argument order. Since
> > > >>> the value is typically not a constant, requiring the mask to be a
> > > >>> constant has ensured that the argument order isn't as easily mixed up as
> > > >>> otherwise.
> > > >>
> > > >> If this is a concern, then it can be checked with:
> > > >>
> > > >>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
> > > >>                    __builtin_constant_p(_val),
> > > >>                    _pfx "mask is not constant");
> > > >>
> > > >> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> > > >> any other combination.
> > > >
> > > > Even that case looks valid to me. Actually there is already such a user
> > > > in drivers/iio/temperature/mlx90614.c:
> > > >
> > > >     ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> > > >
> > > > So if you want enhanced safety, having both the safer/const upper-case
> > > > variants and the less-safe/non-const lower-case variants makes sense.
> >
> > I agree with that. I just don't want the same shift-and operation to be
> > opencoded again and again.
> >
> > What I actually meant is that I'm OK with whatever number of field_prep()
> > macro flavors, if we make sure that they don't duplicate each other. So
> > for me, something like this would be the best solution:
> >
> >  #define field_prep(mask, val) \
> >        (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))
> >
> >  #define FIELD_PREP(mask, val)                                         \
> >          (                                                             \
> >                  FIELD_PREP_INPUT_CHECK(_mask, _val,);                 \
> >                  field_prep(mask, val);                                \
> >          )
> >
> > #define FIELD_PREP_CONST(_mask, _val)                                  \
> >         (                                                              \
> >                 FIELD_PREP_CONST_INPUT_CHECK(mask, val);
> >                 FIELD_PREP(mask, val); // or field_prep()
> >         )
> >
> > We have a similar macro GENMASK() in linux/bits.h. It is implemented
> > like this:
> >
> >  #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
> >  #define GENMASK(h, l) \
> >          (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >
> > And it works just well. Can we end up with a similar approach here?
> 
> Note that there already exists a FIELD_PREP_CONST() macro, which is
> intended for struct member initialization.

Hi Geert,

That was my suggestion. Now that we're going to have many flavors
of the same macro, can we subordinate them to each other? 

