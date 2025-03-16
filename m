Return-Path: <linux-iio+bounces-16889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F678A63506
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E313A78B0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962C19F11F;
	Sun, 16 Mar 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCkn3x9W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB865189916
	for <linux-iio@vger.kernel.org>; Sun, 16 Mar 2025 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121142; cv=none; b=M6tqknJq+ifYZYq4i86YCj/oEYxy6tZLRSw1b8tby7M+RaO417DeQnHSZp0fWPR1p+mo/JQvvG5WQruuhWz1fw/xVkIs0HVBCprs14Pgfu2+xZ6Jvi2GhfcQEFlxZzXNRHrGZIJ/bz68/I9dBAihLlDN55GwqFVCw5vXZcCpjP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121142; c=relaxed/simple;
	bh=rrZy0viAniqPbhoR+1hQ7ijtZ9CkDKXykVMVhgwnyzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tYlev0vv5GniuKLMdBgYXVWuTqHschpKCw1HKlBxBYrJjy3A4tSucAqbZWsDMAjVlhKN1wabmxHsAHFWJ8kW/LUX/oL0M8QDCfFCKKqJqg/RgiUmYWXsimppgXJKtqrUJ4ORSQ4MkNIB8Eyma1BgZzv6RBMLEv5LjFHAaGyR2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCkn3x9W; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3995ff6b066so168547f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Mar 2025 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742121137; x=1742725937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbB3Zun3gDrzT2BzlBXVO8tDPzz0kaoZWWFSKmDuYmw=;
        b=VCkn3x9WOV9Nld35bfal9VJQgKLUdvQISx+UjrioEuyOkI8V/6V4FR/Ug1wP+6yS8P
         rMfs1uitVSY3WHIJ1hBQXQNtUSYGsupVR++JnDPMT4XyLy6Bajc/u5h6lBHJwFtufqLv
         c6ugKn6yP9SPfOOsZvVCZD5KHV/Oz8MCNAeiGe9icl5U0nX/lgkGPo70amlQLmxH7AZ8
         RQtqGdaJ5THD23ONWnAT7K4AW+YwogVGOPPC70zQLDXOBx+880CmEqSCPYAJDWcKx7Ea
         wQlHSQllWPqkWvV3h2b9e+Luz0L49UkiK1HhUaC0UcrfD5dYVP875J+ZR0yG/lXChgoY
         pCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742121137; x=1742725937;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbB3Zun3gDrzT2BzlBXVO8tDPzz0kaoZWWFSKmDuYmw=;
        b=TaGsftURvHT6aecPtdlVqO4rui9OBasiMF604qIBR08IMhQkPm7UWnEbPb/aUWCXhE
         oueFSILOZ7hHeogw1+OMWVJJhdW+9I4X34I/4t2o90Q5d9/h6GQmFjmMwHjYzhG10pmJ
         YSeh57oN0pKMk5GuaxqSUvnhb0c0iOo9n9XiYR1WTsrEIa+pFj8qC4LZiO4K6kNQ4Z9M
         Dt6U1xZSzlkYUqKdqO1sns7l46JujXiUqxwlEA4EDKD+t2ygYEc9VWpG7Y8dB/YpkxQh
         XxuFwNNvYEyp8uBAnezzb+/sB7FhfBQxXeOYBKiwWY5lN6yH4hCm9mC3CQYLxkwFvz7a
         3XFg==
X-Forwarded-Encrypted: i=1; AJvYcCUtEkjL9PEL8VwpNwAZw+i1Nr2MnwUw17tI+ou34yzK7ZLeCgMyzbwy/1I5EA+a77cdBQ+p6efO1tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDub9+et5wn8hd3eOW78jaaHje1ecTpx0vPNyIduGOnjx1oFC
	yLm8AVvh5s7ZCi6kxx3VM+nIyCIphyXSP9XdE7AhhckP5id5e0V/INgTQZWxKDo=
X-Gm-Gg: ASbGncvKMXMZBZpJ85DSa5/08yCvFClpzmO+8e9Lc8IctrDetpp3A3FzYVDG4C+xMRy
	DntPRgo0VRNFaf7/lO3ZkFvmu6i1hKpYMOPgxdzH68yNxPl7a8MKMj922GEoxmbTfo5Z4OzyEa5
	MnSleXv+FsLp2q2bDy1hC6xjTtRMlmKvRoWeBTBMq7ONSaMQAXzYvHXvIMQcLFvLkFUm0ZFo2LK
	HMSNSF1iPq1Ec/s+FR3I1ewBon/KUjTVgm2ZPX/71nrjaRWEItmOQ2rdE6stgOMkQ3nDXAEgcTS
	oKwP9kgG59uHa57/QACWxuiNVTTrQp6zfgQOeeu55WXiFlI8gA==
X-Google-Smtp-Source: AGHT+IGPUH+kPc//pK+nbCVSTVrqoPbY9VyOj+oM6MVV21R+0n68FEr8K6JofP1y8x4JU00kKq6+Og==
X-Received: by 2002:adf:c790:0:b0:391:41fb:89ff with SMTP id ffacd0b85a97d-3971f60b104mr9360022f8f.27.1742121137018;
        Sun, 16 Mar 2025 03:32:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c888152dsm11459147f8f.48.2025.03.16.03.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 03:32:16 -0700 (PDT)
Date: Sun, 16 Mar 2025 13:32:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, corbet@lwn.net,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <0658073a-059b-417a-aafc-c83651e922cf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/iio-adc-ad4000-Add-support-for-SPI-offload/20250315-012316
base:   af94f401e26f686f7391ce79b38a6129417c22dc
patch link:    https://lore.kernel.org/r/301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
config: parisc-randconfig-r072-20250316 (https://download.01.org/0day-ci/archive/20250316/202503161513.yeRBTxjg-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503161513.yeRBTxjg-lkp@intel.com/

New smatch warnings:
drivers/iio/adc/ad4000.c:862 ad4000_spi_offload_setup() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +862 drivers/iio/adc/ad4000.c

e74205e82803041 Marcelo Schmitt 2025-03-14  846  static int ad4000_spi_offload_setup(struct iio_dev *indio_dev,
e74205e82803041 Marcelo Schmitt 2025-03-14  847  				    struct ad4000_state *st)
e74205e82803041 Marcelo Schmitt 2025-03-14  848  {
e74205e82803041 Marcelo Schmitt 2025-03-14  849  	struct spi_device *spi = st->spi;
e74205e82803041 Marcelo Schmitt 2025-03-14  850  	struct device *dev = &spi->dev;
e74205e82803041 Marcelo Schmitt 2025-03-14  851  	struct dma_chan *rx_dma;
e74205e82803041 Marcelo Schmitt 2025-03-14  852  	int ret;
e74205e82803041 Marcelo Schmitt 2025-03-14  853  
e74205e82803041 Marcelo Schmitt 2025-03-14  854  	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
e74205e82803041 Marcelo Schmitt 2025-03-14  855  							   SPI_OFFLOAD_TRIGGER_PERIODIC);
e74205e82803041 Marcelo Schmitt 2025-03-14  856  	if (IS_ERR(st->offload_trigger))
e74205e82803041 Marcelo Schmitt 2025-03-14  857  		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
e74205e82803041 Marcelo Schmitt 2025-03-14  858  				     "Failed to get offload trigger\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  859  
e74205e82803041 Marcelo Schmitt 2025-03-14  860  	ret = ad4000_set_sampling_freq(st, st->max_rate_hz);
e74205e82803041 Marcelo Schmitt 2025-03-14  861  	if (ret)
e74205e82803041 Marcelo Schmitt 2025-03-14 @862  		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),

s/PTR_ERR(st->offload_trigger)/ret/

e74205e82803041 Marcelo Schmitt 2025-03-14  863  				     "Failed to set sampling frequency\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  864  
e74205e82803041 Marcelo Schmitt 2025-03-14  865  	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
e74205e82803041 Marcelo Schmitt 2025-03-14  866  	if (IS_ERR(rx_dma))
e74205e82803041 Marcelo Schmitt 2025-03-14  867  		return dev_err_probe(dev, PTR_ERR(rx_dma),
e74205e82803041 Marcelo Schmitt 2025-03-14  868  				     "Failed to get offload RX DMA\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  869  
e74205e82803041 Marcelo Schmitt 2025-03-14  870  	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
e74205e82803041 Marcelo Schmitt 2025-03-14  871  							  IIO_BUFFER_DIRECTION_IN);
e74205e82803041 Marcelo Schmitt 2025-03-14  872  	if (ret)
e74205e82803041 Marcelo Schmitt 2025-03-14  873  		return dev_err_probe(dev, ret, "Failed to setup DMA buffer\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  874  
e74205e82803041 Marcelo Schmitt 2025-03-14  875  	return 0;
e74205e82803041 Marcelo Schmitt 2025-03-14  876  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


