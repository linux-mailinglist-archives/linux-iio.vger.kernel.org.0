Return-Path: <linux-iio+bounces-20315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC6AD1309
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A574E7A4AED
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F5152E02;
	Sun,  8 Jun 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJcz/yh9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C433EA;
	Sun,  8 Jun 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397102; cv=none; b=P2WtGVBcGLLk9RPF6KZGI8CnEbR05rdi/rp53aDUMm3nnjw9ZRvv8f1WSBRfO8fWreY3Apdp3oGxDVyhUcPFsjhA50SHDf4rupZ2AiVN4Yo9jxeVbkEeZygsiVxdNuCYJrGh8eaTWQpeiJC26f9KI1/Xw670FyItsa7H/dTkdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397102; c=relaxed/simple;
	bh=44+K9pJQHVmddnoq6jFcbDPxDh9T4ucmfXnzaPivNNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej1k2ELCKuzHvyhdC3RsiT6j5cdCkdU1c+BmEtP0nQwLVNGJ2Ykx5cL3kCntqIWRLLp/7q2d2zwSnrsDLOKq4l/jd8cpTr7OKdukuFoVcjidccYrmCZ6SkMMh3CftDshDLAnTSbxIOSe3Wm1rNuXrxbk7iDfIoBgWP71T2fBUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJcz/yh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2924EC4CEEE;
	Sun,  8 Jun 2025 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749397102;
	bh=44+K9pJQHVmddnoq6jFcbDPxDh9T4ucmfXnzaPivNNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJcz/yh9hq0xmgpaI275pp0Vj65B5Wlig8p3n21YqR4/YV+HlO4u9L5VrRhshqEif
	 +IrBIXJqe7aei1eRUGHD11X3qmGykufsupFMupwgESrHm2rhfinC7crdR6SAL5EBEo
	 tjDukZBb3vOstjuSDMP8GW3BMwg8Tr4owzvfrS/oTIV4x0Q6VdtoioSYisS1JLOAHo
	 ObOZUnQZcx2eoutKJgL25zR2p8ks8UkGFqiNet24OBzAC8AB6iCqlMCrFzVU2SQ5M4
	 jvpsuyFHaVFo/FRZKhIRzn4jhuPpfeW2YNzDL9zCjN5JuyaqIQ9KvBPPeLY8h7osIr
	 5vDMrYOoWgkoQ==
Date: Sun, 8 Jun 2025 16:38:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] iio: accel: adxl313: make use of regmap cache
Message-ID: <20250608163812.4a1a93df@jic23-huawei>
In-Reply-To: <20250608162215.0d1789d0@jic23-huawei>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-4-l.rubusch@gmail.com>
	<20250608162215.0d1789d0@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Jun 2025 16:22:15 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  1 Jun 2025 17:21:31 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
> 
> > Setup regmap cache to cache register configuration. This is a preparatory
> > step for follow up patches. Using cached settings will help at inerrupt
> > handling, to generate activity and inactivity events.  
> 
> The regmap cache will reduce traffic to the device for things like reading
> back sampling frequency, so no need to justify this patch with 'future'
> stuff.  Justify it with current.   I've applied with the description of
> simply
> 
> "Setup regmap cache to cache register configuration, reducing bus traffic
> for repeated accesses to non volatile registers."
> 
Dropped again.  The is_volatile should include all volatile registers
not just ones we happen to be using so far. 

You added debug accesses in previous patch which will not take the volatile
nature into account unless the register is in that switch statement.

Put the all in from the start.

Jonathan

> > 
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl313.h      |  2 ++
> >  drivers/iio/accel/adxl313_core.c | 17 +++++++++++++++++
> >  drivers/iio/accel/adxl313_i2c.c  |  6 ++++++
> >  drivers/iio/accel/adxl313_spi.c  |  6 ++++++
> >  4 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> > index 72f624af4686..fc937bdf83b6 100644
> > --- a/drivers/iio/accel/adxl313.h
> > +++ b/drivers/iio/accel/adxl313.h
> > @@ -54,6 +54,8 @@ extern const struct regmap_access_table adxl312_writable_regs_table;
> >  extern const struct regmap_access_table adxl313_writable_regs_table;
> >  extern const struct regmap_access_table adxl314_writable_regs_table;
> >  
> > +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg);
> > +
> >  enum adxl313_device_type {
> >  	ADXL312,
> >  	ADXL313,
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> > index 06a771bb4726..0c893c286017 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -46,6 +46,23 @@ const struct regmap_access_table adxl314_readable_regs_table = {
> >  };
> >  EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL313);
> >  
> > +bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
> > +{
> > +	switch (reg) {
> > +	case ADXL313_REG_DATA_AXIS(0):
> > +	case ADXL313_REG_DATA_AXIS(1):
> > +	case ADXL313_REG_DATA_AXIS(2):
> > +	case ADXL313_REG_DATA_AXIS(3):
> > +	case ADXL313_REG_DATA_AXIS(4):
> > +	case ADXL313_REG_DATA_AXIS(5):
> > +	case ADXL313_REG_FIFO_STATUS:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
> > +
> >  static int adxl312_check_id(struct device *dev,
> >  			    struct adxl313_data *data)
> >  {
> > diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
> > index a4cf0cf2c5aa..e8636e8ab14f 100644
> > --- a/drivers/iio/accel/adxl313_i2c.c
> > +++ b/drivers/iio/accel/adxl313_i2c.c
> > @@ -21,6 +21,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
> >  		.rd_table	= &adxl312_readable_regs_table,
> >  		.wr_table	= &adxl312_writable_regs_table,
> >  		.max_register	= 0x39,
> > +		.volatile_reg	= adxl313_is_volatile_reg,
> > +		.cache_type	= REGCACHE_MAPLE,
> >  	},
> >  	[ADXL313] = {
> >  		.reg_bits	= 8,
> > @@ -28,6 +30,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
> >  		.rd_table	= &adxl313_readable_regs_table,
> >  		.wr_table	= &adxl313_writable_regs_table,
> >  		.max_register	= 0x39,
> > +		.volatile_reg	= adxl313_is_volatile_reg,
> > +		.cache_type	= REGCACHE_MAPLE,
> >  	},
> >  	[ADXL314] = {
> >  		.reg_bits	= 8,
> > @@ -35,6 +39,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
> >  		.rd_table	= &adxl314_readable_regs_table,
> >  		.wr_table	= &adxl314_writable_regs_table,
> >  		.max_register	= 0x39,
> > +		.volatile_reg	= adxl313_is_volatile_reg,
> > +		.cache_type	= REGCACHE_MAPLE,
> >  	},
> >  };
> >  
> > diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> > index 9a16b40bff34..68e323e81aeb 100644
> > --- a/drivers/iio/accel/adxl313_spi.c
> > +++ b/drivers/iio/accel/adxl313_spi.c
> > @@ -24,6 +24,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
> >  		.max_register	= 0x39,
> >  		/* Setting bits 7 and 6 enables multiple-byte read */
> >  		.read_flag_mask	= BIT(7) | BIT(6),
> > +		.volatile_reg	= adxl313_is_volatile_reg,
> > +		.cache_type	= REGCACHE_MAPLE,
> >  	},
> >  	[ADXL313] = {
> >  		.reg_bits	= 8,
> > @@ -33,6 +35,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
> >  		.max_register	= 0x39,
> >  		/* Setting bits 7 and 6 enables multiple-byte read */
> >  		.read_flag_mask	= BIT(7) | BIT(6),
> > +		.volatile_reg	= adxl313_is_volatile_reg,
> > +		.cache_type	= REGCACHE_MAPLE,
> >  	},
> >  	[ADXL314] = {
> >  		.reg_bits	= 8,
> > @@ -42,6 +46,8 @@ static const struct regmap_config adxl31x_spi_regmap_config[] = {
> >  		.max_register	= 0x39,
> >  		/* Setting bits 7 and 6 enables multiple-byte read */
> >  		.read_flag_mask	= BIT(7) | BIT(6),
> > +		.volatile_reg	= adxl313_is_volatile_reg,
> > +		.cache_type	= REGCACHE_MAPLE,
> >  	},
> >  };
> >    
> 


