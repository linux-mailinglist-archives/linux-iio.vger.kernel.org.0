Return-Path: <linux-iio+bounces-9583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A8979232
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3759DB21ED7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2611D12E4;
	Sat, 14 Sep 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A862qipD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D21D0962;
	Sat, 14 Sep 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726332505; cv=none; b=m32EiKiTehavhZ8ng22vdZe2sKjP+Kk61iz03NGJ36jzwdLKCi64HHdoLVil4MGMbBiMni0S74c/4p1/5ZAc80Owmjwze/VUmGAXULdh9qw/gTCK9/ARtYV66rWNPzcqFwbrJWFLrZW28kucH1VtMz81y9jk0xYLcIIfW2m5cW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726332505; c=relaxed/simple;
	bh=kcqNIGzqlci55KmlGNxY0BZAEpEt4QYRtYJ/vhuZBCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9/PC4naR/WkbcBUoEeNu438t/41UsDwA3/kVUfcd63+8EeQk2Al3GHyZauTq56IbCK7F1BQe2Xye05FIMggD4YiE1ZoKWwq+AB8zTnJJ+upWAG8jBtiXIxMYpJCFaNM8Dc+u5vjFHFdkU/R5l6tEu2MgKWOuJ8IjxHZshwlbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A862qipD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B8BC4CEC0;
	Sat, 14 Sep 2024 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726332505;
	bh=kcqNIGzqlci55KmlGNxY0BZAEpEt4QYRtYJ/vhuZBCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A862qipDEmDvKrWnNl75FwRifZQPV+/vkndi7EPJZjxAoY33HhcSVbqOjfHIzERnQ
	 MtD4G9IzQnZXc6ZVBp1WeufAdBRKTz1GUCaZX3i9ZmeQmFCWa2Op89M76QwmQVJnRl
	 2VcfrBtKe7ZAFPzSP7gshh9NGUeoGHEezOptR4yy+zEeXmAEqoG+dbNTvZ7WLI8SJ5
	 8pZf0/WilObcGI/y81zpfVz6xS9p/akJjv6n1x6w7+CXr8Eer5XIAP29g48thPipsd
	 oGmRve6Z/CINV3ovgb/DICscjZD3hT4eO6PnOOGu8gxWsjvszhDwdPSFruoOkmpuat
	 8cVvl2BppzBsQ==
Date: Sat, 14 Sep 2024 17:48:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, Mike
 Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20240914174815.4084f90f@jic23-huawei>
In-Reply-To: <202409140955.bz1rH7Q6-lkp@intel.com>
References: <20240912121609.13438-4-ramona.nechita@analog.com>
	<202409140955.bz1rH7Q6-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
> >> drivers/iio/adc/ad7779.c:748:35: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]  
>      748 |                 return dev_err_probe(&spi->dev, ret,
>          |                                                 ^~~
>    drivers/iio/adc/ad7779.c:735:9: note: initialize the variable 'ret' to silence this warning
>      735 |         int ret;
>          |                ^
>          |                 = 0
Definitely don't do that!

just replace ret with -EINVAL

Jonathan

>    8 warnings generated.
> 
> 
> vim +/ret +748 drivers/iio/adc/ad7779.c
> 
>    729	
>    730	static int ad7779_probe(struct spi_device *spi)
>    731	{
>    732		struct iio_dev *indio_dev;
>    733		struct ad7779_state *st;
>    734		struct gpio_desc *reset_gpio, *start_gpio;
>    735		int ret;
>    736	
>    737		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>    738		if (!indio_dev)
>    739			return -ENOMEM;
>    740	
>    741		st = iio_priv(indio_dev);
>    742	
>    743		st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
>    744		if (IS_ERR(st->mclk))
>    745			return PTR_ERR(st->mclk);
>    746	
>    747		if (!spi->irq)
>  > 748			return dev_err_probe(&spi->dev, ret,  
>    749					     "DRDY irq not present\n");
>    750	

