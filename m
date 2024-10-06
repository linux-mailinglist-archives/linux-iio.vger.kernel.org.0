Return-Path: <linux-iio+bounces-10235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6C991E75
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040611F21B79
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890B176ADA;
	Sun,  6 Oct 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF90Yqpz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30316FF37;
	Sun,  6 Oct 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221019; cv=none; b=U4v+g6LcPgOliVyDmgA76lVOuENcpwfiUAM/SO87iH6Oq48L4fOZxB4TTekWAtyV3Qb/0f7iBzhQE+z7JYFVkeFvy9P2/Hi0A04ScKcB+Wz2Q21ncrpI/Fyu7NJKhL+MSSB+RhI8kZPub/2AZt6QPzDQFHaaxS7/NBEKSjGHOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221019; c=relaxed/simple;
	bh=H/uOEYzjp1vynmDcmBCx1k0MtYqjbMrI8pw5STXOuwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsVf4OzxOz05DcH1+CeUd1R3C/lSircGOeX226YdDPr0m0oAKcvmpEwmcIKytYyb4RFPWFND+ziRfHByn1nfIPq7T/Zh9ZkdoFUW13tquyFLkA0IgXGAtu/XppXIIpZoJ5RbTaLyNUXYDHjG7thFvmEzwV98RTiH6+rjSU2bHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF90Yqpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF334C4CEC5;
	Sun,  6 Oct 2024 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221019;
	bh=H/uOEYzjp1vynmDcmBCx1k0MtYqjbMrI8pw5STXOuwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WF90YqpzL0YqVnLlINsmyu7xRG4HbekSC8O5K86RcbaALYNMGwlf0Nh9joiXmvhdI
	 E9trgB3HW2pIpqG7KVOoRLiXWpwS2NgpXk644BJUTYdtI+yoapOKwkoywe83kOBas8
	 NR0DJmVKy/brjTAcZM/qVgynbXrfupVMCN+oAb5eZ06nnyqIqLnNVzMVOwcovFS9+z
	 pL35mC6ODleAzta3+BBmnkDm84axsjsmWQdeWQkN+F2CXwu/1kol040vUu+EZErv9J
	 v/0QJBIAaitlOS6mlyQsJ/7Bvcm5Ixbn9sO+V3+5XPr3mslNafHJcc/leiaLVfTS2G
	 b/DViqOJEInBw==
Date: Sun, 6 Oct 2024 14:23:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cristian Pop
 <cristian.pop@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] iio: frequency: admv4420: add missing select
 REMAP_SPI in Kconfig
Message-ID: <20241006142319.5506ca68@jic23-huawei>
In-Reply-To: <b54239aa-9573-41e1-86f1-b38611443c46@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
	<20241003-ad2s1210-select-v1-4-4019453f8c33@gmail.com>
	<b54239aa-9573-41e1-86f1-b38611443c46@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 21:30:26 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 03/10/2024 18:49, Javier Carrasco wrote:
> > This driver makes use of regmap_spi, but does not select the required
> > module.
> > Add the missing 'select REGMAP_SPI'.
> > 
> > Fixes: b59c04155901 ("iio: frequency: admv4420.c: Add support for ADMV4420")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/iio/frequency/Kconfig | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> > index 89ae09db5ca5..b90e1ac4b342 100644
> > --- a/drivers/iio/frequency/Kconfig
> > +++ b/drivers/iio/frequency/Kconfig
> > @@ -92,14 +92,15 @@ config ADMV1014
> >  	  module will be called admv1014.
> >  
> >  config ADMV4420
> > -       tristate "Analog Devices ADMV4420 K Band Downconverter"
> > -       depends on SPI
> > -       help
> > -         Say yes here to build support for Analog Devices K Band
> > -         Downconverter with integrated Fractional-N PLL and VCO.
> > -
> > -         To compile this driver as a module, choose M here: the
> > -         module will be called admv4420.
> > +	tristate "Analog Devices ADMV4420 K Band Downconverter"
> > +	depends on SPI
> > +	select REGMAP_SPI
> > +	help
> > +	  Say yes here to build support for Analog Devices K Band
> > +	  Downconverter with integrated Fractional-N PLL and VCO.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called admv4420.
> >  
> >  config ADRF6780
> >          tristate "Analog Devices ADRF6780 Microwave Upconverter"
> >   
> 
> Note that I formatted the entry to use tabs instead of spaces, although
> I forgot to add it to the commit message.
Please split it up.  The fix wants backporting.  Also there are
other white space issues in here that would be good to clean up
(see the entry above).

> 
> Best regards,
> Javier Carrasco
> 


