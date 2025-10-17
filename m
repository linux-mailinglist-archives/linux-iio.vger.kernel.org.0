Return-Path: <linux-iio+bounces-25212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD653BEB190
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAB25E6717
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AE3081D5;
	Fri, 17 Oct 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT0kk5AT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134F221726;
	Fri, 17 Oct 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722779; cv=none; b=PQGu7n8ZdD4ihx0s5glaaCJFel3VMqjLGzW53ri17yteryRvIFu95dNnO0ieQEkXlaDjMGY5tkGsRJ+g5gDaZNksy+YZLuwAXD4nGRjMs+07UlFzLneaIrrFWxNfWSxUX/4SZEBkduM3nvylKIbD+RAgydXTjJ4lpKjRh6CjKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722779; c=relaxed/simple;
	bh=RLpFlKj0oX6F2FHmvB6odL7qjqFC0HmExWxoVhIdU1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvyS4bxtzcEfUO//Ezexi0Lj5QwG1MlYxsOIhUXmMBcMTbUGQMRLLucauGlguhJmARoqgaaw9cvBQuaGzY6+1CJ7LGjpuSGtvzaKhpsDJxtbctyDTNik1DvncTA4wlJzPPMQ55YholeG9ClBGfmsU5+bk4hjvR8zmgtANWNmdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT0kk5AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD47C4CEE7;
	Fri, 17 Oct 2025 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722779;
	bh=RLpFlKj0oX6F2FHmvB6odL7qjqFC0HmExWxoVhIdU1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NT0kk5AT8tFG1ex9SS8EUtqaH3MN+k/hRFCGSaqU55hscTm9YrecMaHll0u79zNw6
	 sIBNy7OA9YnQH8zcWJvaMly7J6UxVErlApIMtWqqtxuCay5hHv3uxPVR74IQZH7Eo7
	 POgxmUZCozpR5oUMwioI8150ALcQrPO9kadHLQDIRlSHNVEt+zPMCklNd1E0+Dvk0M
	 FLUc8epgBZ5fXzgVrxCcc2oNTqFhlAuQ56P5auW6pS+BXbjn0jHuPDkH8FdSsJSL4W
	 uFicrrFA5Ph3zrKxR/crhBXdSf97NMqd7lwWACFyVrsYLycFeAVJesTkco7Sb8QbzJ
	 h9rvU97EVVwQg==
Date: Fri, 17 Oct 2025 10:39:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, David Laight
 <david.laight.linux@gmail.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20251017103936.49fbafdd@kernel.org>
In-Reply-To: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
References: <cover.1739540679.git.geert+renesas@glider.be>
	<2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
	<20251017081912.2ad26705@kernel.org>
	<CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 18:00:41 +0200 Geert Uytterhoeven wrote:
> > +/**
> > + * u32_encode_bits() - prepare a u32 bitfield element (non-const)
> > + * @v: value to put in the field
> > + * @field: shifted mask defining the field's length and position
> > + *
> > + * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
> > + *
> > + * Note that the helper is available for other field widths (generated below).
> > + */
> > +static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
> > +{
> > +       if (__builtin_constant_p(v) && (v & ~field_mask(field)))
> > +               __field_overflow();
> > +       return ((v & field_mask(field)) * field_multiplier(field));  
> 
> Unfortunately gcc emits actual divisions or __*div*() calls, and
> multiplications in the non-constant case.
> 
> So I don't think this is suitable as-is.

Sorry I missed or forgot that you replied :(

The inline helpers exist already have have a lot of uses. If __ffs is
more optimal then why not make existing helpers use it as well? 
It'd be far more beneficial:

$ git grep u32_encode_bits | wc -l
391

Sorry if I'm being slow..

