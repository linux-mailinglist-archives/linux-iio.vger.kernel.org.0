Return-Path: <linux-iio+bounces-9417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF297279C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B0B1F249E3
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B381531E1;
	Tue, 10 Sep 2024 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKtP3pIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9A13634A;
	Tue, 10 Sep 2024 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938527; cv=none; b=td8oXwxOAZRlSxpreRuP/5IJD5CHFdFd5DLjUKWnvXk7kMlH6WKMa8qSh97IbDy24ZjYBVilavim/wb4RbxBvGdxyD8YsfiboRwTF7LsykLdAbBaOtj5vOS8836dkWU48VYp08EyAhnV9621pMq5QQUjw8yZcdMXoqV7owEXPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938527; c=relaxed/simple;
	bh=8cxRyHSeBpjU1pXWRi18M5b41/aLzXrHgO1SZO7hLwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXqAqV3iTZQh5F0cvf+r+Qz2aj2vlmjGDYwfh+aHGwmzX8vsJkv5Bmjm1yvWpe/NfkfiJgOCQojXiCuE4yaXgj1+D4Ticjg46txLQ/bVbkqo9zWsEgjIISZFzbzt/mkaUvMMLDLYihb21dSypViY7pKOn2lNksPdk4eC162qI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKtP3pIq; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99fd0535bso235664385a.3;
        Mon, 09 Sep 2024 20:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725938525; x=1726543325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8bdJGOdx2d1IizNCB9ViMz9g0V5IvdFfVu8Im0IDPA=;
        b=YKtP3pIq3kgUmLHPsql9IWW1iFX+uDczJthccz7dZHTLhKYfJqUnNAOiRno4UUC1lV
         eOqCTnurmHC5CccwCMROI8AgsBhw6bReqYM4aIKsk7eH4VRTubPRs7oO6G4NsrAyaU2y
         F0aZdBe2cKiMYuxZi4FVXx6dEsT9zzdyNdbNUL3orbQT1e41FAEv1J2SD1GP2js+q71Z
         Po1FyUPRQh1BAtVRR1nMjDSfvyWpX2zW1Ekfpkem/m3sLLQFQxTPRwdx13O2jhMgRvHH
         uWgwARclQHD99Rb3XkBcWRv+VWwV1yxfKWyWs7UNHW+qWACe0YFTP2TC2xvChd8C7qJg
         ly7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725938525; x=1726543325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8bdJGOdx2d1IizNCB9ViMz9g0V5IvdFfVu8Im0IDPA=;
        b=WrmEv98Px7DJY8q7J8RebEJQMoHZy6Hw4lrEZMWc5S/iU92RbQG8bRFTpZSasECuOh
         mEWNB7KFGBTqmQflbrj/8jyMh3p5o2EBSylHNqNMrJr2K9AmBzQIB3j3Vern44lQKjgD
         mrOmXngIuTijyuTkqDLXQJgEUIvCXC2gTWogYbr80YD7aK2uqpwBdPgAZ5MVP3D3XQEk
         ZpL4S2zD7Q+VTMcCXyDzbtn3w07/hamv+6RiByymv5iTgv9q77UNWYyJo/Srmjs3Ng4F
         o3iY9nPgjaEfE6L0j8C6r2xDtgroPrUuxp57hbVwGr/bOb+qlPZxq5+ueZdIGngjrlrc
         1WMg==
X-Forwarded-Encrypted: i=1; AJvYcCVh9cAZhzkaONbfV3EHC3xRY2/lWnduhkgBvVby8qx5DtbCCnVt0Js5Yayfpp1qWHzNNpzCZG76wsUc@vger.kernel.org, AJvYcCW6ohAKeKlGYboyrbekPjAWsAWmv0sdJg5P2G5Ct+7J/9F5PE9WHPXQwO+mPFHGXy0OILS/N9FUvfm6apNS@vger.kernel.org, AJvYcCWHiT7JZvSPE76dEmgER+vlBzfAXTc22BZ37WHCQ5S0MdpXYXMNQtIVoljqj+w7dyjQfzgiiM2658gB@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmHnV6YDBdGEKyfE4X97TOWqAf8fbAODVcpER2LpsoRxsLLcQ
	wW51OWmDWWp4y1aj1rE6dIeeNGQ1HX4wfm7IVrAzvzn9vFnT94FW
X-Google-Smtp-Source: AGHT+IGoym0OdCqi+QXcbZia8VxoxQUUvP6XMZdznCQMrLzyxpiZjWOxh5VQEvZ/SkJ3Lz/m2dUQfQ==
X-Received: by 2002:a05:620a:430c:b0:7a2:32e:3c47 with SMTP id af79cd13be357-7a997340133mr1697968185a.34.1725938524890;
        Mon, 09 Sep 2024 20:22:04 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1e3a8sm272236385a.117.2024.09.09.20.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 20:21:55 -0700 (PDT)
Date: Mon, 9 Sep 2024 23:21:52 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>, oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <f5zruqfmohoaohr2qwqug33dsar5q3fubhspbwuisxxblni6h4@paioiqyjzeg5>
References: <20240909043254.611589-3-lanzano.alex@gmail.com>
 <202409100026.17N3K11W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409100026.17N3K11W-lkp@intel.com>

On Tue, Sep 10, 2024 at 01:03:04AM GMT, kernel test robot wrote:
> Hi Alex,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on robh/for-next linus/master v6.11-rc7 next-20240909]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Lanzano/dt-bindings-iio-imu-add-bmi270-bindings/20240909-123509
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20240909043254.611589-3-lanzano.alex%40gmail.com
> patch subject: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240910/202409100026.17N3K11W-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100026.17N3K11W-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409100026.17N3K11W-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/iio/imu/bmi270/bmi270_core.c: In function 'bmi270_configure_imu':
> >> drivers/iio/imu/bmi270/bmi270_core.c:180:31: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
>      180 |                               FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
>          |                               ^~~~~~~~~~
> 
> 
> vim +/FIELD_PREP +180 drivers/iio/imu/bmi270/bmi270_core.c
> 
>    165	
>    166	static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
>    167	{
>    168		int ret;
>    169		struct device *dev = bmi270_device->dev;
>    170		struct regmap *regmap = bmi270_device->regmap;
>    171	
>    172		ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
>    173				      BMI270_PWR_CTRL_AUX_EN_MSK |
>    174				      BMI270_PWR_CTRL_GYR_EN_MSK |
>    175				      BMI270_PWR_CTRL_ACCEL_EN_MSK);
>    176		if (ret)
>    177			return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
>    178	
>    179		ret = regmap_set_bits(regmap, BMI270_ACC_CONF_REG,
>  > 180				      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
>    181						 BMI270_ACC_CONF_ODR_100HZ) |
>    182				      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
>    183						 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
>    184				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
>    185		if (ret)
>    186			return dev_err_probe(dev, ret, "Failed to configure accelerometer");
>    187	
>    188		ret = regmap_set_bits(regmap, BMI270_GYR_CONF_REG,
>    189				      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
>    190						 BMI270_GYR_CONF_ODR_200HZ) |
>    191				      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
>    192						 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
>    193				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
>    194		if (ret)
>    195			return dev_err_probe(dev, ret, "Failed to configure gyroscope");
>    196	
>    197		/* Enable FIFO_WKUP, Disable ADV_PWR_SAVE and FUP_EN */
>    198		ret = regmap_write(regmap, BMI270_PWR_CONF_REG,
>    199				   BMI270_PWR_CONF_FIFO_WKUP_MSK);
>    200		if (ret)
>    201			return dev_err_probe(dev, ret, "Failed to set power configuration");
>    202	
>    203		return 0;
>    204	}
>    205	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I am having trouble reproducing this build error on both jic23-iio/togreg and
linus/master v6.11.rc7 on an aarch64 box with the same compiler version.
Maybe a config option is causing this?

However, I will add #include <linux/bitfield.h> to remedy this issue if
some edge case is being hit.

Best regards,
Alex

