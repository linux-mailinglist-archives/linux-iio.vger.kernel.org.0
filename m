Return-Path: <linux-iio+bounces-6082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5F90131F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD392B20DE5
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FB1C6B2;
	Sat,  8 Jun 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al30UE+Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84631210E4;
	Sat,  8 Jun 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717869195; cv=none; b=Q3JPDM1MFSubau9mb5wv2CvUL7LuEgrQbWxGkgW03kYsQWVw/i6l0I+nyeLrhR9jc8rzD/KImmLXUzV37oVb5D4y0yZXvJwQKBHT+SUoYfIEu+1HH6GFwcZoB60yXZPmzw8Wdm+HExFCsM+5OArRrl6v1sDheAs3x7GVuieZoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717869195; c=relaxed/simple;
	bh=YlniDuEi5dt+izfMlbcR3uDQhTYUP24idyKQwxJBTyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7+Ehv8/MlbtugtfwSXMpHwd6Wp3eFirEXabSPbgG6N+KuXEyJKkBKivoq82oqU6HWKzkE000smcmc3/k7rQJ8meTulU9+Pjxbuy7OdcDdKLEGXSJZo97s5lt4kfq5BxBH1XzT/T5SZdiIcKNJkybD/rlnplOZwwrXLTHGBejw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al30UE+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D09C2BD11;
	Sat,  8 Jun 2024 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717869195;
	bh=YlniDuEi5dt+izfMlbcR3uDQhTYUP24idyKQwxJBTyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Al30UE+QNSNBaOKWrFu0D41gkAgQcOEfg1LOE7kNqxY5msVxfqqdCFMkxM/2Yvkpb
	 DyxNQ1xO+m/9eA4BEnd0JtiT0Tu4ivVA70RMm8V2MAb9EowNiw8MJQXbbtrj6zdtlo
	 l7aCRPm0x5nuqzW0DVYDRSOZUOjovI3hNKRZ7rSgVFgcoL6C0wPNromQBkFqzLSphn
	 7iWnGQw6EAZPkrJpDsCV4bhNi/wsDmyTZGTJ3z88e7eOsVAKovxi4pvZd3zAZVfrkB
	 3pd5dm5HxvXaIULKmyns8Elnq4CnxYOem/jAgPePmZV1Pj0v6cI6SrmXeMZX7xSAG0
	 SWoTrB+wRY/FQ==
Date: Sat, 8 Jun 2024 18:53:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: select IIO_BUFFER &
 IIO_KFIFO_BUF
Message-ID: <20240608185308.4743fb2c@jic23-huawei>
In-Reply-To: <sdlebaxls5al3hzbhzeqnt6j3iijgobkxtljzpkn6how6cgywq@ipane3aqqdzv>
References: <20240605203810.2908980-2-alexander.sverdlin@siemens.com>
	<sdlebaxls5al3hzbhzeqnt6j3iijgobkxtljzpkn6how6cgywq@ipane3aqqdzv>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 09:01:10 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On Wed, Jun 05, 2024 at 10:38:06PM UTC, A. Sverdlin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > 
> > Provide missing symbols to the module:
> > ERROR: modpost: iio_push_to_buffers [drivers/iio/accel/fxls8962af-core.ko] undefined!
> > ERROR: modpost: devm_iio_kfifo_buffer_setup_ext [drivers/iio/accel/fxls8962af-core.ko] undefined!
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>  
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> > ---
> >  drivers/iio/accel/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index c2da5066e9a7b..80b57d3ee3a72 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -330,6 +330,8 @@ config DMARD10
> >  config FXLS8962AF
> >  	tristate
> >  	depends on I2C || !I2C # cannot be built-in for modular I2C
> > +	select IIO_BUFFER
> > +	select IIO_KFIFO_BUF
> >  
> >  config FXLS8962AF_I2C
> >  	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer I2C Driver"
> > -- 
> > 2.45.2
> >   
> 


