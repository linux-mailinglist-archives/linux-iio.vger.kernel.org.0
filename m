Return-Path: <linux-iio+bounces-26087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CFC4420C
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2480A4E5BF6
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649C3002DB;
	Sun,  9 Nov 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi2PHE5S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001922F617B;
	Sun,  9 Nov 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704823; cv=none; b=qFixfjhrMEbczLmrnw2ycbNyQg8WSjCJvl0moDOqbp1znGw8UfPcboecPw+RHuHwiuSfWNYWbMf1FVpszQ27jUGmgJYkq1fA20Svxp+jQ0lxHaeKsKqpswy1/Tu6+fBnzNWfIL3+A2oXHWFR1JxcMnK2602rHfW7XMc7ObodUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704823; c=relaxed/simple;
	bh=2F3e8q72q71SxOPIY9BaxEooig/W5GdkP+C+cbkiI9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XP3Y/H4vSJYWbB+s8FTVoyuLQQGt/cpIWU4PowH340CZAtTndSbdz1fyxeouGBBVkDye5gqxaFgFKxJxl3aO4B539er+GRU6TmLFseV+RAu/Jinc2bplpa+y13Vg6Yehtl1Af7H5q6n//7+v7d+x6xYcg21Nu6SBnxAuDM5icH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi2PHE5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F57C19421;
	Sun,  9 Nov 2025 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704822;
	bh=2F3e8q72q71SxOPIY9BaxEooig/W5GdkP+C+cbkiI9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mi2PHE5S6F60p5G0dtgSbCH9iqmgbnBpQNA/Io8+Te7gc1A4D5SQnPhZV6ao8Xjhy
	 8eMpaCf6v3XIZfwe1L7oE0Cfh8i91bomstoz9b+O7CnxeURHoirB6d1K8oXstfar20
	 uYs+l2EzBl9PqVW6p1x+116KcAQ1iZvwCNYn48GJW5ECf5J8vU77wZSByqw2FekMbH
	 Or1fDu86n0CyB5H5HOrNKWrwtdp6E9K3u7bs6GnlCdbeJoX6rw3U5VSyLMbPLE+cVm
	 GXE0upkMwqC13cWNuozcgOYAlOjTErBGbwRqLzaEcfaYqdjkUHrWg2bI8cesIuUNv4
	 0cCFjcyOdLO9w==
Date: Sun, 9 Nov 2025 16:13:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 07/12] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <20251109161335.54c9ffc1@jic23-huawei>
In-Reply-To: <aQpD7zx7D6sQOAdC@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-7-6fe35458bf8c@analog.com>
	<aQpD7zx7D6sQOAdC@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +
> > +#define AD5446_CHANNEL(bits, storage, shift) \
> > +	_AD5446_CHANNEL(bits, storage, shift, NULL)
> > +#define AD5446_CHANNEL_POWERDOWN(bits, storage, shift) \
> > +	_AD5446_CHANNEL(bits, storage, shift, ad5446_ext_info_powerdown)
> > +
> > +/**
> > + * struct ad5446_state - driver instance specific data
> > + * @dev:		this device
> > + * @chip_info:		chip model specific constants, available modes etc
> > + * @vref_mv:		actual reference voltage used
> > + * @cached_val:		store/retrieve values during power down
> > + * @pwr_down_mode:	power down mode (1k, 100k or tristate)
> > + * @pwr_down:		true if the device is in power down
> > + * @lock:		lock to protect the data buffer during write ops
> > + */
> > +struct ad5446_state {
> > +	struct device *dev;
> > +	const struct ad5446_chip_info *chip_info;
> > +	unsigned short vref_mv;  
> 
> _mV?

I'm fine with tidying these up, but not in a code move patch.
Nuno, please considering doing this as a follow up.

> 
> > +	unsigned int cached_val;
> > +	unsigned int pwr_down_mode;
> > +	unsigned int pwr_down;
> > +	/* mutex to protect device shared data */
> > +	struct mutex lock;
> > +	union {
> > +		__be16 d16;
> > +		u8 d24[3];
> > +	} __aligned(IIO_DMA_MINALIGN);
> > +};
> > +
> > +/**
> > + * struct ad5446_chip_info - chip specific information
> > + * @channel:		channel spec for the DAC
> > + * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> > + * @write:		chip specific helper function to write to the register
> > + */
> > +struct ad5446_chip_info {
> > +	struct iio_chan_spec channel;
> > +	u16 int_vref_mv;  
> 
> _mV?
> 
> > +	int (*write)(struct ad5446_state *st, unsigned int val);
> > +};
> > +
> > +int ad5446_probe(struct device *dev, const char *name,
> > +		 const struct ad5446_chip_info *chip_info);
> > +
> > +#endif  
> 


