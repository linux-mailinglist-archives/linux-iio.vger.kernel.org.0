Return-Path: <linux-iio+bounces-16546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDEFA57A77
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5641893290
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA711C5F19;
	Sat,  8 Mar 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfScBwHl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8214A24;
	Sat,  8 Mar 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741440484; cv=none; b=N3UMFEY7Ui8IQBZRT4mDAYlG5GQ1B7ZSwOuheurEE1KGAynYlllV0avMvBHzWIwNiitKDuCjigLpth7Dl+Fqwr7L4GPTWlT2K4mZdV8hGTFwpwl3GyJdD+bCSjvMIQoeRNos290yi29x32LFOH3X9hX9t584KWzQz2ZYEyfr1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741440484; c=relaxed/simple;
	bh=vqy/RHjRO1A0fppQXF2DH0HTJMaKnPAnjPqZVNW9VkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqadjtuVV+w4A7W2ePJhf1ZcjGs5BdMaHPNwcG+epfC/rs9z+ba4ezad+BTf6F67s5VZFQn47EtNaNgjerxngR5s8IJY6NfIZZFCCt6bFHBF8Ij3RwD8wXTRHEzFoAP+o2jitiz4WzIzjjTqEh2sVtMwGeY7iZFye+37e9YdGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfScBwHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3898C4CEE0;
	Sat,  8 Mar 2025 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741440483;
	bh=vqy/RHjRO1A0fppQXF2DH0HTJMaKnPAnjPqZVNW9VkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tfScBwHl8+Qkt7Kh1//ncgfvr/fhfIxgstarEyOo02wNl2U1yU6ZJ1WWmNSyHfvvb
	 rXBBd4Ymn7OfCL3TIxqtHX6mNS8NT8vO4l7Hm5atp2AzzSZYrOD53nwV6CKEqdP8Gj
	 luNY7D7aMfZIaRaGY8s92E3OEpHYFMDKuElrH05u9ys8M6M84MOtQXCovsHNkiaLR9
	 45jmqrzpltWPuVxIzwDjQBwpKY1tpH/u9in1DW9dJeVFUkIqz3DHiwrh9mN9KdtS0W
	 yVIXCX62cUfjtzBebFkIHnu9nae8aMLjsde4pR0TnWZqjOtGmfOLG8UIkL5bo7hIIi
	 WvRKI4IzT6qXg==
Date: Sat, 8 Mar 2025 13:27:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
 jonath4nns@gmail.com
Subject: Re: [PATCH v4 08/17] iio: adc: ad7768-1: convert driver to use
 regmap
Message-ID: <20250308132754.7f91c7d2@jic23-huawei>
In-Reply-To: <Z8ryhMV1lYZeZVCB@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<b0c7976d4bc817b7056ef40e3ce870b42e8a2d80.1741268122.git.Jonathan.Santos@analog.com>
	<Z8ryhMV1lYZeZVCB@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 10:20:04 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/06, Jonathan Santos wrote:
> > Convert the AD7768-1 driver to use the regmap API for register
> > access. This change simplifies and standardizes register interactions,
> > reducing code duplication and improving maintainability.
> > 
> > Create two regmap configurations, one for 8-bit register values and
> > other for 24-bit register values.
> > 
> > Since we are using regmap now, define the remaining registers from 0x32
> > to 0x34.
> > 

Marcelo, crop to just the bit you reply to.  Reduces chance that
key part is missed when someone is scrolling through.

> > -static int ad7768_spi_reg_write(struct ad7768_state *st,
> > -				unsigned int addr,
> > -				unsigned int val)
> > -{
> > -	st->data.d8[0] = AD7768_WR_FLAG_MSK(addr);
> > -	st->data.d8[1] = val & 0xFF;
> > +static const struct regmap_config ad7768_regmap_config = {
> > +	.name = "ad7768-1-8",
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.read_flag_mask = BIT(6),
> > +	.rd_table = &ad7768_regmap_rd_table,
> > +	.wr_table = &ad7768_regmap_wr_table,
> > +	.max_register = AD7768_REG_ACCESS_KEY,
> > +	.use_single_write = true,
> > +	.use_single_read = true,
> > +};
> >  
> > -	return spi_write(st->spi, st->data.d8, 2);
> > -}
> > +static const struct regmap_range ad7768_regmap24_rd_ranges[] = {
> > +	regmap_reg_range(AD7768_REG24_ADC_DATA, AD7768_REG24_ADC_DATA),
> > +	regmap_reg_range(AD7768_REG24_COEFF_DATA, AD7768_REG24_COEFF_DATA),  
> 
> So, this device has only two registers that are 24-bit size?
> Also, one of those is the ADC_DATA register which you will probably want
> to read with optimized SPI messages in the future (devm_spi_optimize_message()).
> That makes me wonder if the 24-bit regmap worth's the boiler plate to have it.
> Does the driver access AD7768_REG24_COEFF_DATA after the patches from this
> series is applied? If not, maybe drop the 24-bit regmap and implement ADC_DATA
> with usual spi_message/spi_transfer interfaces?

Given it's used today and is better than a mix of regmap and non-regmap
(as no need to go SPI specific yet) I'd keep it for now.  If it ends up
completely unused, then fair enough to rip it out again.  It's not
a lot of code.

Jonathan


