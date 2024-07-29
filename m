Return-Path: <linux-iio+bounces-8026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12693F97A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF751C221F8
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B49155300;
	Mon, 29 Jul 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODA8ePg3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445E1494DC
	for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267084; cv=none; b=hHYreUUmTFWpdHsAM8nULlSg7lUKFR8LSO7vu/H/vjHuFC3z8NKUj4pFrv47YaChjEXeIT+LLvT30QnJbuZmJSE3nPgavKvSnuNSMCQSYyo8a19EVHH8FD0L3WD3JjFS5zMDVy2a+qJwNlmYLC55+sxhiA/gKQuWvyt2Q0QcY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267084; c=relaxed/simple;
	bh=nMRedrIDpiQfBKEZwZLAtsO2l+vfALPP2GCneA2DJeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b6csauUdzIdU9Ro6MifbVfvIavJfZVHVrqJhSN5mprnqRli/Ab1HGwrlSkAQodV2U50kke5/wxf69/3nKpKbmb4NHx7uvHhaDVI7cKfBeAuQYK0erJXN+3hInj9aWNxPo9CPIBjne/j6opkWfh1SJjdV4Kl1d5ZbnCSVxDV5+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ODA8ePg3; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-261e543ef35so2112003fac.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2024 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722267082; x=1722871882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxgOzZ9wt6xYia5fWSbdpgGngVyCVzmloiaeIDkpJyU=;
        b=ODA8ePg3j9b4y9vPkFGf/q5qRHVKZvNUKs2+mxYIN0437xkOpf6LMp/N/5j9vzc/pX
         hkKDC+94scLtMtm2+XOVSbaW5Foynk64aS/X0qNrXotP//CppgiZUAGy/FQWA13EMwbm
         IDlkR3gUa2dmi1YmpwgPET2cAygzuim2G97fmGYjSMJFa09OOyjNdUfMhgQMApfOtaer
         CALAcbmd6WO05vwuAxgyyLiN6PWX9kpscwZbLt3HcJpASjOHhPxpJ2awReRrG5xSTJiR
         F2IPHmMdypFF2Wcp5GHV9L08DewmatDnOTT5Y7RWPtzhSTuL1s0r4kzJW8LSIVkWo/6s
         WwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722267082; x=1722871882;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxgOzZ9wt6xYia5fWSbdpgGngVyCVzmloiaeIDkpJyU=;
        b=Wa7WvKy4zV8ysHfCaRZfFDzY2ZgHc3ZDbx36s9Ex9/YAk457ng9AbXObRRG2Nyr5m9
         SWusS+LT70gYDnZqY8fN4oSZx3auWB0/cWIzU9S9g44v2g5kmf6l8hQoZPYCPpCzjVbH
         ZoahmEyo2np9d2qs16AK3KeyVBxS+H7DJ6CuhglQmdBystOb8aOJgsisw4/WiAVzvJqq
         Xyn9M9de1fJhyDChtW4cVJ59sSUi/+gDTvMPSSUIDHMmPM7oe0Z6NSdiS5EkUk5HO90G
         tGpPfEZ+vPsgvbxUfXfeyNvcbGxPQ1aQ/vHFkmOkoTVkgAe3I03Ix/HZds6j1/ahM3cn
         ITMw==
X-Forwarded-Encrypted: i=1; AJvYcCUy0A8ztj8YFP62ps7x42TLrsrwOsKFMuFwX6p13ktGFVqNf6g6HM99OIOEKGG8g6vd9arRe0ni6fn+ADQK4f36dAVZj6JxplVx
X-Gm-Message-State: AOJu0Yw3Goa3hfP/96Mr4CInGYd+7QXJ4dlGvg6AUir/JveYGfKEpfgr
	DreKfIKE8TctEs3fuJp0bvr4MPqRjicqhZ+0LbZjXuCkbfN7A1swxkCXvVO/ycg=
X-Google-Smtp-Source: AGHT+IHaNouuhzQ1M1UrMMhpFB2OYkekDxpOwvZS4ZCvpyA/cVxQfuO1chwsPix33xJ5/ckC5Qt+ig==
X-Received: by 2002:a05:6870:b625:b0:260:fb01:5651 with SMTP id 586e51a60fabf-267d4d2dc08mr9917991fac.12.1722267082223;
        Mon, 29 Jul 2024 08:31:22 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2653cfcf7edsm1889857fac.3.2024.07.29.08.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:31:21 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:31:20 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <ee65606b-aef1-48c1-8e61-3f00302416ff@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724155517.12470-5-ramona.nechita@analog.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Alexandra-Nechita/dt-bindings-iio-adc-add-a7779-doc/20240725-000001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240724155517.12470-5-ramona.nechita%40analog.com
patch subject: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
config: hexagon-randconfig-r081-20240728 (https://download.01.org/0day-ci/archive/20240729/202407290151.pCUNfKeG-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202407290151.pCUNfKeG-lkp@intel.com/

smatch warnings:
drivers/iio/adc/ad7779.c:779 ad7779_probe() error: uninitialized symbol 'ret'.

vim +/ret +779 drivers/iio/adc/ad7779.c

ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  761  static int ad7779_probe(struct spi_device *spi)
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  762  {
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  763  	struct iio_dev *indio_dev;
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  764  	struct ad7779_state *st;
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  765  	struct gpio_desc *reset_gpio, *start_gpio;
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  766  	int ret;
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  767  
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  768  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  769  	if (!indio_dev)
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  770  		return -ENOMEM;
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  771  
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  772  	st = iio_priv(indio_dev);
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  773  
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  774  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  775  	if (IS_ERR(st->mclk))
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  776  		return PTR_ERR(st->mclk);
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  777  
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  778  	if (!spi->irq)
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24 @779  		return dev_err_probe(&spi->dev, ret,
                                                                                                        ^^^
s/ret/-EINVAL/

ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  780  				     "DRDY irq not present\n"); 
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  781  
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  782  	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
ed8e3886f0d748 Ramona Alexandra Nechita 2024-07-24  783  	if (IS_ERR(reset_gpio))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


