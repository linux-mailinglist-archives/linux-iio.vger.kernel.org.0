Return-Path: <linux-iio+bounces-2760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032ED859FC0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FA61C211E7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A422619;
	Mon, 19 Feb 2024 09:33:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFF23750
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335200; cv=none; b=shAez9/mbKte0Di3OCszxW5moS2mWPFhX56EMjgSevZoLvqfMfNRkeMK1EeD+eQJXNrrm2a+hHhS5DLgg/dl/6uVA0J5EfxR88ZFqgPGl9uuaKmIiKVCiH5/DAMHWMFgWsRMhtqZUwRyEQURjz6PhWjZyFsDpxL8zeEhJ6pazT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335200; c=relaxed/simple;
	bh=IRrdTlGU/ZX6THZGzY/QmVIXbFl9/RK7PUhcBJMlrnI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jil4N/pWd/TWIRlyFdmiYWMNx1T3We2z+tOfzFIiIm9Htq0CLESUAsNFEHqkUxyzOBDOvS3fl20mg65wq/2HnGNxWHKbFf7S7Senum2c+ZP8idVN1aB6hCbAWiWK6BIyaL/ba+mvAVu+3DistXv9DmfEYJNxNMLf0QW/J1xdSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdcfv6ddDz6JB4f;
	Mon, 19 Feb 2024 17:28:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DA43141A07;
	Mon, 19 Feb 2024 17:33:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 09:33:09 +0000
Date: Mon, 19 Feb 2024 09:33:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: kernel test robot <lkp@intel.com>
CC: Mike Looijmans <mike.looijmans@topic.nl>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-iio@vger.kernel.org>
Subject: Re: [jic23-iio:testing 107/107]
 drivers/iio/adc/ti-ads1298.c:653:29: warning: variable 'ret' is
 uninitialized when used here
Message-ID: <20240219093310.00005d3e@Huawei.com>
In-Reply-To: <202402171104.pciYOoXE-lkp@intel.com>
References: <202402171104.pciYOoXE-lkp@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> >> drivers/iio/adc/ti-ads1298.c:653:29: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]  
>      653 |                 return dev_err_probe(dev, ret, "Cannot get reset GPIO\n");
>          |                                           ^~~
>    drivers/iio/adc/ti-ads1298.c:642:9: note: initialize the variable 'ret' to silence this warning
>      642 |         int ret;
>          |                ^
>          |                 = 0
>    7 warnings generated.
> 

This is the only one that matters I think,

> 
> vim +/ret +653 drivers/iio/adc/ti-ads1298.c
> 
>    635	
>    636	static int ads1298_probe(struct spi_device *spi)
>    637	{
>    638		struct ads1298_private *priv;
>    639		struct iio_dev *indio_dev;
>    640		struct device *dev = &spi->dev;
>    641		struct gpio_desc *reset_gpio;
>    642		int ret;
>    643	
>    644		indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>    645		if (!indio_dev)
>    646			return -ENOMEM;
>    647	
>    648		priv = iio_priv(indio_dev);
>    649	
>    650		/* Reset to be asserted before enabling clock and power */
>    651		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>    652		if (IS_ERR(reset_gpio))
>  > 653			return dev_err_probe(dev, ret, "Cannot get reset GPIO\n");  
Should be PTR_ERR(reset_gpio)

I'll fix it up when I'm on the right machine.


>    654	
>    655		/* VREF can be supplied externally, otherwise use internal reference */
>    656		priv->reg_vref = devm_regulator_get_optional(dev, "vref");
>    657		if (IS_ERR(priv->reg_vref)) {
>    658			if (PTR_ERR(priv->reg_vref) != -ENODEV)
>    659				return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
>    660						     "Failed to get vref regulator\n");
>    661	
>    662			priv->reg_vref = NULL;
>    663		} else {
>    664			ret = regulator_enable(priv->reg_vref);
>    665			if (ret)
>    666				return ret;
>    667	
>    668			ret = devm_add_action_or_reset(dev, ads1298_reg_disable, priv->reg_vref);
>    669			if (ret)
>    670				return ret;
>    671		}

Thanks as ever is due to the 0-day team! Should have gotten this in my local tests, but
maybe I wasn't paying enough attention to the results :(


Jonathan



