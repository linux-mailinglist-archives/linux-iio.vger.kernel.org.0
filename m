Return-Path: <linux-iio+bounces-5449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AA8D3974
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1266F1C22FA4
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29D8159594;
	Wed, 29 May 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjzd6D8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1915920F
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993387; cv=none; b=XbdXBqVi0t+LiwQhZvSLpiXkjA1/vibmMDxaQoLVJsGDlCDS0awJjLILNHkzYkEbGEhqUzNQ8qd+BhraXaK1F1yMX7WBy/ajJyMkgnZnpuwoMJV+Z7IHioBo1Ui0Eoe1sSI0sJih4lgCn86Jp9XOZFj9iIsRepli0mCwB/9nHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993387; c=relaxed/simple;
	bh=OGbtwjULhl3w+vcGIL81b+obaLwHCiTbz2FtbPMorDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J6bLE4o6B/TIhKK0+uDPE/4+rPH8n7Cl44mRlkdbSj6j4IWBL698/kUG4hvUD/hosxGss6lpNz6DyoXd8htwo1h3yw6zu1LpaD8jz8jS47K2js6WckM0rc4WrnIbIcOXXuOciJjNEU1J3bGzvh0BCsZIJ+E/VRnW/EBflaoHg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjzd6D8J; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ab1d7243fso1362850e87.1
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993384; x=1717598184; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=onLXeJRqtHiywJfTtQupZmxSe9czseg1ydGlgZn2T04=;
        b=cjzd6D8JtWGDjAN+E7b91l2sY8dlCZ6TWvu1q9RAHv8qwfoECiXO9Mjv7jrmwLkm7I
         5q+2uZVeOTXJkazqnptyqCtO9phu32XlKDO9WZ4hV8LlvtJ7Elo1pZfQpij1542axtul
         cOMPqHkQaBjUt3+uoC6q5Cm/2O9B9Ya5Mc9RMIfiWPqBCCT9SlM2t0664jgI2YUONQDu
         88gtShsvH2K0gdDyG19fyp38m6jLBktP7aZI+JwfRExEgFobSJWf8vpmpuSm9OzjBxe7
         08qLqVHugypeqJvLxLZfaGBTAiBPsoph3sulkfVOpJQ4Z8KUx9DvdfiQ/uRgIr6bsfuK
         e20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993384; x=1717598184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onLXeJRqtHiywJfTtQupZmxSe9czseg1ydGlgZn2T04=;
        b=BUSQXUwlnTI6eg9p7iNF7rEWgUxtiFOGBlVVk5qjJWOWiWtb4U3Mjtl4vLYCRN1TxZ
         k3SssPrWWTD1EFHdxkW4sFMCwt0ICxqcx283NRrDf+ElA9ALfYBnRsivhlRCXV7eCV7d
         R/Y4B4GX9KUvOfnvswrcvZts6zPyV4/+NvZNCg0WpsnpGgfjJ3gV/rtzF7SKnPZ2D7tb
         ZQlWQFw1aolk3tH0FlpwTed+DvBUeFJKKTX5x8FmazH5oV9X25IkcYlSquS9DCcKRl4X
         CrbA5/g9qvJiSwjyPfiRpaP/QcwIo8KIbSUWbXjNdOdFgIDS8O2GuEXR9o6YPKnbkCYn
         erAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoRvV/4A4o2c4M9A83HmQBokOf6q64uWncMr2Y+2jQsN3hjTa9OFXfpiTPMD/WKIEVRaIPLLPK4rYaRKgajy85+mQuW77zZxSf
X-Gm-Message-State: AOJu0Yx/jvxdlKYhFxCjfo5fAHra7FtFF/FK9TZR8FrNYdV1xoLbG9ze
	E2tgOL1aHAULYgzYM6SiOwl8qPOL4LX6EKcweDHhcOciPbxW3sxqjtL1xolGX8E=
X-Google-Smtp-Source: AGHT+IGc7EKt54sm1khoej2woFrmOQu3LLvXiuSZdD1P1QxwpCeqzx3WQs7Wuujc3vbdzMFGi4KfwA==
X-Received: by 2002:a05:6512:3a93:b0:529:b3c9:7261 with SMTP id 2adb3069b0e04-529b3c97397mr6223224e87.5.1716993383771;
        Wed, 29 May 2024 07:36:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc51489sm721025766b.128.2024.05.29.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:36:23 -0700 (PDT)
Date: Wed, 29 May 2024 17:36:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Francesco Dolcini <francesco@dolcini.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <a3521734-487b-4c17-b910-2b169b26bc64@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527154050.24975-3-francesco@dolcini.it>

Hi Francesco,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Dolcini/dt-bindings-iio-adc-add-ti-ads1119/20240527-234431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240527154050.24975-3-francesco%40dolcini.it
patch subject: [PATCH v1 2/2] iio: adc: ti-ads1119: Add driver
config: openrisc-randconfig-r071-20240529 (https://download.01.org/0day-ci/archive/20240529/202405291150.r5z8TZYu-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405291150.r5z8TZYu-lkp@intel.com/

New smatch warnings:
drivers/iio/adc/ti-ads1119.c:653 ads1119_get_configs() warn: passing zero to 'PTR_ERR'

vim +629 drivers/iio/adc/ti-ads1119.c

14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  642  static int ads1119_get_configs(struct ads1119_state *st)
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  643  {
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  644  	struct device *dev = &st->client->dev;
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  645  
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  646  	st->vref = devm_regulator_get_optional(dev, "vref");
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  647  	if (IS_ERR(st->vref))
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  648  		return dev_err_probe(dev, PTR_ERR(st->vref),
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  649  				     "Failed to get vref\n");
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  650  
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  651  	st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  652  	if (IS_ERR(st->reset_gpio))
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27 @653  		return dev_err_probe(dev, PTR_ERR(st->vref),
                                                                                                  ^^^^^^^^
st->reset_gpio was intended.

14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  654  				     "Failed to get reset gpio\n");
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  655  
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  656  	return ads1119_alloc_and_config_channels(st);
14caaeae0e22b3 João Paulo Gonçalves 2024-05-27  657  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


