Return-Path: <linux-iio+bounces-6167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E03F90257E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A7C1C2126E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269613F437;
	Mon, 10 Jun 2024 15:19:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312213FD83
	for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032753; cv=none; b=YkbR7hg/Sj0qgLk0vQ8rNGLOtuogpixR2cffvGs1Q7QKwGlfYIelXuUEN+8gcSrk0j6AyzxXWkX/ZoqCo+bynJKKZYIFZH1V0COPc75wEzrryeDV/J+83IevBmpJY4RipSgQqzvTlpsMbuuMqBdAoMUAFTtUDe7/AT3X6Ea3+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032753; c=relaxed/simple;
	bh=GQzGqpHj51TEdtzcEm0mcy1hLjQR9VsZIzfaY6JOkvY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDM/u8Oh1kXBzjTVMKcRaO1lKa3/tNs7Ow84XZFCLzz7OjwHh2M19r2Mw5YKd9IHq8rWEvgyTIrTKkMdh2UHrgYiK0iPu9x5VNS19ap5T5OvIzaiuQ7ZGnhAW2Gy4M5aL5M0NEcbeAWgYd0BNts+IR7K5Jkcjk55zdUXoT+pDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vyb5j3Yn6z6K8pH;
	Mon, 10 Jun 2024 23:17:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1502114038F;
	Mon, 10 Jun 2024 23:19:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 16:19:03 +0100
Date: Mon, 10 Jun 2024 16:19:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Ke Sun <sunke@kylinos.cn>, Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa
	<nuno.sa@analog.com>, Anshul Dalal <anshulusr@gmail.com>, Dragos Bogdan
	<dragos.bogdan@analog.com>, Andrea Collamati <andrea.collamati@gmail.com>,
	<linux-iio@vger.kernel.org>, k2ci <kernel-bot@kylinos.cn>, kernel test robot
	<lkp@intel.com>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] iio: dac: fix ad9739a random config compile error
Message-ID: <20240610161902.000013aa@Huawei.com>
In-Reply-To: <20240609113751.70517cfc@jic23-huawei>
References: <20240609030847.2869455-1-sunke@kylinos.cn>
	<20240609113751.70517cfc@jic23-huawei>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 9 Jun 2024 11:37:51 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  9 Jun 2024 11:08:47 +0800
> Ke Sun <sunke@kylinos.cn> wrote:
> 
> > WARNING: unmet direct dependencies detected for REGMAP_SPI
> >   Depends on [n]: SPI [=n]
> >   Selected by [m]:
> >   - AD9739A [=m] && IIO [=m] && (SPI [=n] || COMPILE_TEST [=y])
> > ...
> > ERROR: modpost: "spi_write_then_read" [drivers/base/regmap/regmap-spi.ko] undefined!
> > ERROR: modpost: "spi_async" [drivers/base/regmap/regmap-spi.ko] undefined!
> > ERROR: modpost: "spi_sync" [drivers/base/regmap/regmap-spi.ko] undefined!
> > ERROR: modpost: "__spi_register_driver" [drivers/iio/dac/ad9739a.ko] undefined!
> > 
> > Fixes: e77603d5468b ("iio: dac: support the ad9739a RF DAC")
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404250156.2PQRWmex-lkp@intel.com/
> >   
> No blank line in tag blocks they are used by various scripts and also checked
> by various patch correctness scripts so this will just get me moaned at
> by bots.  I'll fix that.
> 
> > Signed-off-by: Ke Sun <sunke@kylinos.cn>  
> SPI is built in most rand configs anyway so this seems like it won't
> reduce our testing scope significantly.
> 
> Applied.

Ah. I'm an idiot and had queued Arnd's earlier fix for this
on the wrong tree hence it missed my last fixes pull request.

I'll do another one later this week with a version of this patch on it.

Thanks,

Jonathan



> 
> > ---
> >  drivers/iio/dac/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index 3c2bf620f00f..ee0d9798d8b4 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -133,7 +133,7 @@ config AD5624R_SPI
> >  
> >  config AD9739A
> >  	tristate "Analog Devices AD9739A RF DAC spi driver"
> > -	depends on SPI || COMPILE_TEST
> > +	depends on SPI
> >  	select REGMAP_SPI
> >  	select IIO_BACKEND
> >  	help  
> 
> 


