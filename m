Return-Path: <linux-iio+bounces-21384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E1AFA460
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44844189F6B1
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4235A1B043A;
	Sun,  6 Jul 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRA+ujo3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DCC2E36F4;
	Sun,  6 Jul 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796936; cv=none; b=B9KI9pab/5idBMOz1ufWqdkbffx4GsDLKe+QAc9jzQxwj0Zi5LcHnGXQzdr3ynB4jtp7JfNootJ6+6itYocfTYAqXK0xUE3C0vp9QvyT2TUUJJrbq2jwQIGuGpemC9qDsX5JOjCESeSvd7loUUmaljD4IN8tuT0jsSTOSyWFxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796936; c=relaxed/simple;
	bh=oGuBidC0zWuD2QFcUHv7r6XN9hXK/RZ4p8aZ9s8T64I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgUZnbaJwlpFeskixOqyX0IkQK5I30TAWayr1xuqIWvfoVxTOrfSMFD3paU/iTTFaQsmWvf0N3zVzeDs2O3eF8tmX4D7AMOu4ezcvMGNesl2IWB6ZCwOUW4JVAAdsg72DpYmb/2DCBM6YdlDmTcFV0RwJGF1Q+5wiLGSNP0Stpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRA+ujo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34F1C4CEED;
	Sun,  6 Jul 2025 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751796935;
	bh=oGuBidC0zWuD2QFcUHv7r6XN9hXK/RZ4p8aZ9s8T64I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CRA+ujo3RENAtBtPr3ajXVM2GxGzR3G9Y4UKQeYO+/mJS23FpI6FDcNdJ8GCICMnd
	 b1vTq4eLe64QBXMVddQw2LE29i6AG/VVzf2NPZ02SRKoMGjNzoJZFom1VTpWyg2PKK
	 cL74hjDe4hTJXUdjJ92+d+uSiai8QrhT5boc6nlSBE7BHeyUZeiJhl01Ms/06zRS2z
	 RKIrMzZ45dsXX/y1XtQuTH/wqpzhN/Vr5M6A/2Nlb/h6dm5e0D3Sh9j+OisWis0fyU
	 PRxGCiHZ4OTDXZSRMlsJjMTJbRKmH//jnC35N0gaqvZxtne6g3jKKHyM04M9DpuCLa
	 Ig3j/KNU4syTQ==
Date: Sun, 6 Jul 2025 11:15:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7173: fix num_slots
Message-ID: <20250706111529.360a3095@jic23-huawei>
In-Reply-To: <f023c92b-183c-4157-a6eb-ff722dfd716a@baylibre.com>
References: <20250704-iio-adc-ad7173-fix-num_slots-on-most-chips-v2-1-a74941609143@baylibre.com>
	<f023c92b-183c-4157-a6eb-ff722dfd716a@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 12:04:04 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/4/25 11:21 AM, David Lechner wrote:
> > Fix the num_slots value for most chips in the ad7173 driver. The correct
> > value is the number of CHANNELx registers on the chip.
> > 
> > In commit 4310e15b3140 ("iio: adc: ad7173: don't make copy of
> > ad_sigma_delta_info struct"), we refactored struct ad_sigma_delta_info
> > to be static const data instead of being dynamically populated during
> > driver probe. However, there was an existing bug in commit 76a1e6a42802
> > ("iio: adc: ad7173: add AD7173 driver") where num_slots was incorrectly
> > set to the number of CONFIGx registers instead of the number of
> > CHANNELx registers. This bug was partially propagated to the refactored
> > code in that the 16-channel chips were only given 8 slots instead of
> > 16 although we did managed to fix the 8-channel chips and one of the
> > 4-channel chips in that commit. However, we botched two of the 4-channel
> > chips and ended up incorrectly giving them 8 slots during the
> > refactoring.
> > 
> > This patch fixes that mistake on the 4-channel chips and also
> > corrects the 16-channel chips to have 16 slots.
> > 
> > Fixes: 4310e15b3140 ("iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > Changes in v2:
> > - Improve commit message.
> > - Link to v1: https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com
> > ---
> >  drivers/iio/adc/ad7173.c | 37 +++++++++++++++++++++++++++----------
> >  1 file changed, 27 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..9c197cea11eb955becf4b9b97246379fa9c5da13 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -771,10 +771,27 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
> >  	.num_slots = 8,
> >  };
> >  
> > +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
> > +	.set_channel = ad7173_set_channel,
> > +	.append_status = ad7173_append_status,
> > +	.disable_all = ad7173_disable_all,
> > +	.disable_one = ad7173_disable_one,
> > +	.set_mode = ad7173_set_mode,
> > +	.has_registers = true,
> > +	.has_named_irqs = true,  
> 
> > +	.supports_spi_offload = true,  
> 
> Well drat, I was too quick with the update and the bots [1] noticed that
> this conflicts with the in-flight patch that added this field [2].
> 
> I guess we can drop this one line, but then the other patch will wait
> until this fix makes its way back into the togreg/testing branches.

I'm lost - what would you prefer we do here?  For now I have [2] on my
tree but can drop just that one patch if it unwinds this complexity.
> 
> [1]: https://lore.kernel.org/linux-iio/202507050018.iWEJiG04-lkp@intel.com/
> [2]: https://lore.kernel.org/linux-iio/20250701-iio-adc-ad7173-add-spi-offload-support-v3-12-42abb83e3dac@baylibre.com/
> 
> > +	.addr_shift = 0,
> > +	.read_mask = BIT(6),
> > +	.status_ch_mask = GENMASK(3, 0),
> > +	.data_reg = AD7173_REG_DATA,
> > +	.num_resetclks = 64,
> > +	.num_slots = 16,
> > +};
> > +  
> 


