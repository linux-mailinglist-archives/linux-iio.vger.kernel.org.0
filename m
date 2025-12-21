Return-Path: <linux-iio+bounces-27297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4218ACD44C3
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B731630155CB
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED98303C93;
	Sun, 21 Dec 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLQ+C7GP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE9238166;
	Sun, 21 Dec 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766345151; cv=none; b=gWmK1wAUfnSmAoIZlLzR07hyn8PQLMXc3ynSnUaD7nLnZLKACB/Wm0VU0gqdkcTZUy7YC6WJrB8BH7ZjrQ3ofbsUN4PS87g7XuZgvKeNkZ+ZBloJo4B+UHO8L6aYuIqMfIWV/Rg0Iu1iCFY0T7f1MWzHdzBcb/JZc055Iewj3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766345151; c=relaxed/simple;
	bh=VImLMaojmFtc7C3+oWhMzXS6oNhig3wZr/+l1S8Z9FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFPzTvAlJaRvg+FBPX/JayRm5oPFCRtxs3613FYbrgEVEnVwaqRuRmrkhB6FyVyTuUUrPDRyOa8Lw4X6guo7jP5rGhAG3L8L8wurHuKomBevRJaFqHhIZKg+5CufepxsI11kqN7Z0rMAsAYPcRaX61QL6e0CVEwvEU9pa+mqc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLQ+C7GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C233C4CEFB;
	Sun, 21 Dec 2025 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766345151;
	bh=VImLMaojmFtc7C3+oWhMzXS6oNhig3wZr/+l1S8Z9FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HLQ+C7GPvIDwX1q8u1JrMSkJij7MrPZSGdTJAJM/N7vkhyCcjI+uRXzx9hK2AVqnB
	 da5C5WUnfG1BU7eJ/lftxFg+hjyghBI6+3vCJowcJaIh0o7gsKabV9BaPMGta4XyK4
	 MYvJ2Cg6CC327RKluPY6IS8kENzkl6d3XBjI92T0J0JEjNy/JKuZf1mqSqAZ/mT4MG
	 p/7uJAIsZrW5TXxRyyry+Gq3sb1HwcSrqAfn04FVt6ssA7zsaBTCcV+j2+UIZO3N9u
	 NcU6aSDbtm232/ZV1Ns1XDncUF42PF7uoG4JqaOkInNZ1X0aQRDSg4/IYfEj8D/fDN
	 JCLM/fLdNncyg==
Date: Sun, 21 Dec 2025 19:25:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Tomas Borquez <tomasborquez13@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 3/5] staging: iio: ad9832: cleanup dev_err_probe()
Message-ID: <20251221192541.15018b46@jic23-huawei>
In-Reply-To: <aUQR_vBHQwg9CWFn@debian-BULLSEYE-live-builder-AMD64>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
	<20251215190806.11003-4-tomasborquez13@gmail.com>
	<aUQR_vBHQwg9CWFn@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 11:38:54 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/15, Tomas Borquez wrote:
> > Cleanup dev_err_probe() by keeping messages consistent and adding
> > error message for clock acquisition failure.  
> 
> This is also a clean-up patch while patch 2 is a driver update so I would
> provide this patch (currently patch 3) before the patch updating to use guard().
> 
There are a lot of &spi->dev in the probe function.  BEeore doing any of this
I'd suggest introducing a
struct device *dev = &spi->dev;
and replacing them all with dev.

That also shortens all the lines so maybe some return dev_err_probe()
end up below 80 chars and make the suggestion below irrelvant?
(I haven't checked!)

Jonathan

> > 
> > Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index f9ef3aede4..8d04f1b44f 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -302,15 +302,15 @@ static int ad9832_probe(struct spi_device *spi)
> >  
> >  	ret = devm_regulator_get_enable(&spi->dev, "avdd");
> >  	if (ret)
> > -		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
> > +		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD supply\n");  
> I'd break the lines and write the message in the line below for this and other
> dev_err_probe() that exceed 80 columns. E.g.
> 
> 		return dev_err_probe(&spi->dev, ret,
> 				     "failed to enable AVDD supply\n");
> 
> Note this is just a personal preference of mine, not enforced code style, so
> fine if you prefer keep it as it is.
> 
> >  
> >  	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
> >  	if (ret)
> > -		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
> > +		return dev_err_probe(&spi->dev, ret, "failed to enable DVDD supply\n");
> >  
> >  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
> >  	if (IS_ERR(st->mclk))
> > -		return PTR_ERR(st->mclk);
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
> >  
> >  	st->spi = spi;
> >  	mutex_init(&st->lock);
> > -- 
> > 2.43.0
> > 
> >   


