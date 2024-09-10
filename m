Return-Path: <linux-iio+bounces-9418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7999727A1
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914C41F24A94
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 03:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71791552FD;
	Tue, 10 Sep 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUhzEJFX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9622638;
	Tue, 10 Sep 2024 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938660; cv=none; b=g+9a8jzoc0CUmD8iFEsZfQejuhyytbk9L8o7qU8U3Hi+DFpiFLMyxkuQKW8OECgWSL/+o5yZEDU/uuyAZS3jQTl2cgNGOUeNP7JO8n/3x14oixySEUGLD3a5Ks8p+ph3vxte7JcsxeWIVcJseLYFvLYqryf7ANskUpX7/eTiSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938660; c=relaxed/simple;
	bh=k2ruAa+jFVeZsE8ka2l3Hdm5Jd9qAxR1UtbojqZ/jhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofBTcWa0sYwOd5PIzqJXtTb5r2lbB8mlzi68KJW23ef6NqvNmXCZfd5q2rvaUulL1KSeRkT8frBCuIjdI934k1QII5IBs0ZisqkGkrpBoNKPt70RRpOuFtOiEKKehBT2JkoRb45G4MJwNWZh1YGYfjL2tjP2lGc4N5O4uYXo6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUhzEJFX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c548eb3380so8633256d6.1;
        Mon, 09 Sep 2024 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725938658; x=1726543458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpusLT/zlwIQUL2Z+vnefbnLz1uJqFE2LHDGvfzY+k8=;
        b=bUhzEJFXcMR9gwQqRZhrrlgObb+KRPsEDfndHoLpM8Zc/bz1Mt6mkV1SW8K6WSEe0T
         2UCT5pF1i6ZAbeHmy/BJoNkZGs7nrQX+5BJxeyjRVvd3QWynKZ8Htn5qw8h0EBtf0j4r
         tn/T4zX1hPp9ld4bN3yqSOEjoPKOZgiCbAyfoeaXDIUz/7n649upehqEK2YxyXdxX1bF
         yPuFQEEAsbSmNoCt5D+QZRNgT0wUh6usA7mU9tNYBMJ1mH8zB4daICkXY+vsMhLrMQvU
         6O5pSYx5gma++vp8mvUKsCm9OMs9/CJmn2Bf0HcLKPOGAm21cBGUvdozyjNpn0FFatan
         HMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725938658; x=1726543458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpusLT/zlwIQUL2Z+vnefbnLz1uJqFE2LHDGvfzY+k8=;
        b=vq9831+XZAE1vqrT3zYMab8B5Tx4idSuw6tw0IvcIi68FjQOLui6emGXvbUDheaWei
         KJXaghe8915GHIC0AR+eDGffPe3Ih2N8/ZcwMYvhG1tekvQ1Ws2MQMdvr4z9izzatm8q
         ZgAACUUJHlaBWYLSh+6nQjw9v7NO+G2fuUflmJkf1EpSOMJSU55LUkmOsmFPkIMOl6Xu
         CI7zq+daW7MDrA5DXrgXNg7MbDsKV8nFBL2XdrD9fX6IR9dLqmrX74G1vQ4UfPbvpCpI
         5PW76X0IsrwcZKs3T1LEOTr9etu8iy2QW7wSErfCcXmfzcS1rx/7/o6qTnC6FOTGfDSD
         ILzw==
X-Forwarded-Encrypted: i=1; AJvYcCVbgLryNcbLL9EWaQZojBCp2LxeoaE0ALVANKsVKHCCX8ZhlxCMYtKded+/ZBvtUiAXYT4WeulttflH@vger.kernel.org, AJvYcCVmyyUw32XrOwrPvdZ3fJYjbTjQZAdTFrIiM7bIpgCi787cwxgpRu+bhjcSE2E1McnHfddOlP0mSXv2HiIq@vger.kernel.org, AJvYcCXfot9uLdbQd3VHxtQgsIPco1UyDYuBIpvrVmFyF/8Dj/6nGS3dcZ+jb+5KUXaL5VHUZ04n9sEVmE9d@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9tI2H6zFDRDsn26sPDl4C2+fSEt/kdYppoLnuo3EjWjo127H
	nGT7kE91Sws348x6/ceKi6h3PumgyaKMCRf0EDMGTKf7CzWtWMJB
X-Google-Smtp-Source: AGHT+IEo5cFn/APVE3S5D3+2mXCfJSXmhr7QdndrsaR329YovAAWkXVYX7Cwx6mTBtaNotVNDHJ7vA==
X-Received: by 2002:a05:6214:3d01:b0:6c5:509c:4ff9 with SMTP id 6a1803df08f44-6c5509c51d2mr60568966d6.0.1725938657485;
        Mon, 09 Sep 2024 20:24:17 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5347747d7sm26249306d6.126.2024.09.09.20.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 20:24:16 -0700 (PDT)
Date: Mon, 9 Sep 2024 23:24:14 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	skhan@linuxfoundation.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <kzwfehd532aib5vmgecpp3gv3at6oza6nsr44t2t6pi3lgpkoe@txt7uytdnebo>
References: <20240909043254.611589-3-lanzano.alex@gmail.com>
 <202409100526.LydCADNj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409100526.LydCADNj-lkp@intel.com>

On Tue, Sep 10, 2024 at 06:13:04AM GMT, kernel test robot wrote:
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
> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240910/202409100526.LydCADNj-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100526.LydCADNj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409100526.LydCADNj-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:25:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      548 |         val = __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>          |                                                   ^
>    In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:25:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>          |                                                         ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>          |                                                   ^
>    In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:13:
>    In file included from include/linux/cgroup.h:25:
>    In file included from include/linux/kernel_stat.h:8:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/hexagon/include/asm/io.h:328:
>    include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      585 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>          |                                                       ~~~~~~~~~~ ^
>    In file included from drivers/iio/imu/bmi270/bmi270_core.c:4:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:21:
>    In file included from include/linux/mm.h:2228:
>    include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
> >> drivers/iio/imu/bmi270/bmi270_core.c:180:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      180 |                               FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
>          |                               ^
>    7 warnings and 1 error generated.
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

