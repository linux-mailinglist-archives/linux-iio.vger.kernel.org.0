Return-Path: <linux-iio+bounces-22540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C3B1FF88
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7E216D918
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8762D8789;
	Mon, 11 Aug 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2O8Jkqq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEB2D663D
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894802; cv=none; b=NayNiI5teYXyC51Qk7bCbHvNnCeGcgrwjdHfs0CVxmCZW3C31xGPW1QolXzGPJirMUiv49S9zI185IhvZPNiUW+PFIT+sp68/HGGmQACoF5BOymeAYmP97HlqLxL2aMraQgEy8MImtgteFl1dAykTi3u3UlESf/7t/43iqoiR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894802; c=relaxed/simple;
	bh=jBo5UANno+XfA29YPINf2MeDmdVe/2QnIWuOgjuDJGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WTy3VLl/YXEQjjdyb5h9wFCydhJGt6i1sGpmfq0ms0xNFYo2jBL+S1ZmaiWX/k5vp+QJAFbj6TJ8qUULC3fPrsFITNbvo/OSkOSSXaHgI5rDy5zizxVuSbttjjhYI8Pf7zY1frWDmZ04Ct4ukuRwawgYGpYKCzu9hrOWc7RFAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M2O8Jkqq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7892609a5so2196630f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754894798; x=1755499598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZI4IZrSEWJ+0JsUHQ5F8RKmssnmQDDF0w+or3Wom0Y=;
        b=M2O8JkqqDgYT16WrtZ2ZiYx2jJ5dozjhPSTYWSrShlOeWDc9NOEUamv7a+MOCoy4pq
         O1MiiRVMA8P7Xu61xm+4oAHUDyibt4bmMbrYMLzpYsZ4K0599nkfwSy2Hx826fDafgR1
         BVVD9ymsJLso3kCIwzoJlfzsNF0Xf6GuKrvRBmdCz5JMQfweTay6cmflGM0Cq+ccNnjC
         uufNLpbPvUdQwPO69vfN1UrfeZlJ7/OAipI+3AH0sisX8J3KR19lY/E5SdH7W3cG/10B
         bseSFaijZfetA+MB1Ugawq+td5PXYUthppMqlJU7Rjweu9vzGS75cjeF1wGwh1TABZKR
         BSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754894798; x=1755499598;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZI4IZrSEWJ+0JsUHQ5F8RKmssnmQDDF0w+or3Wom0Y=;
        b=irD5eVt0f0L/UK4OvHGG0HLmGipjNJLbMJGB/yIjpcPcUAvjlkJJmeWvpTrsEW4nId
         AH700jbvJWPOlBfOSCpF5VCc5X4ARTF/f4YY2+qQQpSfSKAjCFXKzSaHxpJILaXvtt4d
         t/ixP1wj7hqL3z7bhQ2lBW3T+XB6A0LockpOF2XJEHiITK7IWh85AsKXcP7HRQn0AAjQ
         S8aiGeWfjqQYUcVFMhFoWlJRwyythUzUwe6RsgGEx9yJoWuXokd1jrFZFiVTufEjdrY7
         Gx7O7XaGBFRO4+eDHhRXD6qg84KdcLjM56p3DIyZN8IpNmoenW13gRlXEviLl+lhUvf/
         CfbA==
X-Forwarded-Encrypted: i=1; AJvYcCVi+P/JJsm+44RlcZvHlVt3WJEhkuBXHRW7ruNb528QiexkWoNKrLHTXueFv0xoxrzUVzYMgZk1kWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLiioRi0YQSDpEVXYv1mkaCDVIhOr4ngiB84Xf5EjTkJNWKIm
	Nl5FKSV55B1kpMl2+0m5P7K6Rdtcv8Oau7IQJgTvWTzCeWeh/rDADvc2ubD7dvewE5Y=
X-Gm-Gg: ASbGnctjbzpTGlDkCStLZhkh39NsgDnzECIjXaRG2J3LSfPvaUZQaJkifGihJnfVgLG
	NAyH5YmfHs1wvY3ivLCO1snRO1N7u1Yk8jVRvJ6azv2joZoxNCI5WV8gSBoOu/o1QWPWiVz0TEU
	Ri2G8r0O1NCi6ecGus1MMmQWcBRMmvFL0YblC+9qvBBV8G+5uUOxmSsXeZcgVMXIISq9uwigtDq
	pNlNIqFph5h/PiFVhoaRFlvSiLLGx2yNXxD+6m2d/2Y+MGp5/CZOmXOBgHpGsYJY9GM4hhFiUp6
	UTJ62avOThDMXDaO9ryO/zLLmbQCbueKLrdJMt0oWh0bORyS9aD3dFosz64ToENuHMVqLpEdyuJ
	gJq+sgrlrBhVfSafajktOqFQzitNGJUtziisYyIJK998=
X-Google-Smtp-Source: AGHT+IH+a64xEOPVPhERDfj/+owOAQRBVcZN1KIVGv8qfkFFGNlsOI9q9ejBHs8ooi13JqXBcw4o9g==
X-Received: by 2002:a5d:64c3:0:b0:3b7:8832:fdd5 with SMTP id ffacd0b85a97d-3b900b2c83bmr9256965f8f.16.1754894798292;
        Sun, 10 Aug 2025 23:46:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3c33fesm40026751f8f.29.2025.08.10.23.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:46:37 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:46:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ioana Risteiu <Ioana.Risteiu@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: Re: [PATCH v2 3/3] iio: adc: update ad7779 to use IIO backend
Message-ID: <202508090909.tqDX7ah1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806192502.10120-4-Ioana.Risteiu@analog.com>

Hi Ioana,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ioana-Risteiu/iio-adc-adi-axi-adc-add-axi_adc_num_lanes_set/20250807-032923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250806192502.10120-4-Ioana.Risteiu%40analog.com
patch subject: [PATCH v2 3/3] iio: adc: update ad7779 to use IIO backend
config: x86_64-randconfig-161-20250809 (https://download.01.org/0day-ci/archive/20250809/202508090909.tqDX7ah1-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508090909.tqDX7ah1-lkp@intel.com/

smatch warnings:
drivers/iio/adc/ad7779.c:893 setup_back() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +893 drivers/iio/adc/ad7779.c

1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  879  static int setup_back(struct ad7779_state *st, struct iio_dev *indio_dev)
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  880  {
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  881  	struct device *dev = &st->spi->dev;
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  882  	int ret = -EINVAL;
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  883  	int num_lanes;
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  884  
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  885  	indio_dev->info = &ad7779_info_data;
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  886  
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  887  	ret = ad7779_conf_channels(indio_dev, st);
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  888  	if (ret)
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  889  		return ret;
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  890  
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  891  	st->back = devm_iio_backend_get(dev, NULL);
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  892  	if (IS_ERR(st->back)) {
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06 @893  		dev_err_probe(dev, ret, "failed to get iio backend");

s/ret/PTR_ERR(st->back)/

1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  894  		return PTR_ERR(st->back);

Change this to:

	if (IS_ERR(st->back))
		return dev_err_probe(dev, PTR_ERR(st->back),
				     "failed to get iio backend");

1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  895  	}
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  896  
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  897  	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  898  	if (ret)
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  899  		return ret;
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  900  
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  901  	ret = devm_iio_backend_enable(dev, st->back);
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  902  	if (ret)
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  903  		return ret;
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  904  
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  905  	ret = device_property_read_u32(dev, "adi,num-lanes", &num_lanes);
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  906  	if (ret < 0)
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  907  		return ad7779_set_data_lines(indio_dev, 4);
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  908  
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  909  	return ad7779_set_data_lines(indio_dev, num_lanes);
1d61d2e4f96ac5 Ioana Risteiu 2025-08-06  910  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


