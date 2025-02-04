Return-Path: <linux-iio+bounces-14979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D9FA275D9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9427A1A75
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27225214810;
	Tue,  4 Feb 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxFt1+76"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7272147F9;
	Tue,  4 Feb 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683014; cv=none; b=J1uA4ouxV8o92N1UXB9e6Op15WtEDwLZGMMcpUUU0qu+xBiZ+NceFxmSv2IXuNF1hD18NH3mhyZpa+3o30VKc3cKn+BMvpTr2EJsxAaDc4UCweOtq20Kfz7vIbcvvBIMG6aRR1YwzWIFqEp36IXtAz9SsIDdAcvUlRMh4uuCf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683014; c=relaxed/simple;
	bh=w12EPpGUmvzDudWzppT/O+ACvWWy08Cbo3XC+tGv3iY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZvmOOkrKGR2+i9/Hlr9Boq6eMQ41tlm6K3U7jvap+Z/Tz/V4npUmtwKsCAN38aQysqM5/0Ydmb+i62mPzZAbJA5fUs2u2GxjyjPg0JlinCjFIEiohg6eY2qtk3uGllLDq+8SvWz+9QnrAQetsLrYTh2G0omlzR/BZMQMpGFGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxFt1+76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F517C4CEE2;
	Tue,  4 Feb 2025 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683014;
	bh=w12EPpGUmvzDudWzppT/O+ACvWWy08Cbo3XC+tGv3iY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxFt1+76LToM21A8s0ynlnAIwt78hr6Di4Rj31ycjaxNsQldtEz4HGEKhDCpZBIoU
	 Xq7Uyz1X4dOfpnShEge2okV+AlHBJXtcWuP46mvOedK7nxngJBLhC9mfqClLlHO4AK
	 m+iBiNjJZnet6vZuKO6jTDzRyc/CYRlBuu40fbiQTidRQ+FjMq4imH0KziZHiC07Vs
	 yHXFoZLweaKE9xL0bnUKC6Uai0BGtZPAOhRb+gLgYbIyPKjDVAV9MTomKE5Jk+0r3r
	 Z1Ki34lpSJDD3f7NpPDeqiev2aYna2qG+7mqi/vzbvodKXpJ1+Z96jQ2BaoarLuvEX
	 +0olbUxhCUEmw==
Date: Tue, 4 Feb 2025 07:30:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20250204073011.5f6ca125@kernel.org>
In-Reply-To: <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
References: <cover.1738329458.git.geert+renesas@glider.be>
	<1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
	<e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Feb 2025 17:26:04 +0900 Vincent Mailhol wrote:
> On 31/01/2025 at 22:46, Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.  
> 
> Why is it that the existing FIELD_{GET,PREP}() macros must be limited to
> compile time constants?

Hard no, some high performance networking drivers use this on 
the fastpath. We want to make sure that the compiler doesn't
do anything stupid, and decomposes the masks at build time.

The macros work just fine for a *lot* of code:

$ git grep -E 'FIELD_(PREP|GET)\(' | wc -l
22407

BTW aren't u32_get_bits(), u32_replace_bits() etc. not what 
you need in the first place? I think people don't know about
those, with all due respect the way they are coded up looks 
like an IOCCC submission..

