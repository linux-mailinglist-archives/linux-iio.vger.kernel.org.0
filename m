Return-Path: <linux-iio+bounces-9545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A29790AB
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8571F22A80
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF41CF5C8;
	Sat, 14 Sep 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCMaev+i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9501482F3;
	Sat, 14 Sep 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314694; cv=none; b=IaGd50mwkxtw5eZbPDDVKQe/0v/BpU5HIl7KyZAxZvDbS2PSZEi19hvnh93KsaRRtBOnad5tihs0l5lE54Tq81CxpmjwGKzCWs8w4MsjGg05rwF+uRPkS2aoy+6csYHnxX89yIeiBcWM1XEIaHF4fn8UAvO+mB7ULHapdIuUnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314694; c=relaxed/simple;
	bh=D3alaH9FVz0eNtgjK7+8PY9RsxlT58gKMLTR4lhwrXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRJYvDzEvRj1/Y1ZsZ56vLW/b8KJojSmfvRhbqASLZCQqhzFRZhwDvuSaUWLh5W5+ZwvmFHQU4X3+zmmjk6OoaOIj3rSpqfu0YtAvnkMiuo6ZafxPDKGp7ryVum5LnB0NifB/Sool1+qJmbQPBJkWW/Zy4YyAj6QNFOhG14lID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCMaev+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DEDC4CEC0;
	Sat, 14 Sep 2024 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726314693;
	bh=D3alaH9FVz0eNtgjK7+8PY9RsxlT58gKMLTR4lhwrXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SCMaev+iHtp/B5hdrJYkCRC444/iSywfihSD5qTRX7OiROVFtpWnz5SXQO2ITH2vU
	 pZ/chHUhdmG4sFh17S9zvNgykKRxXa1Uw9tMUKOabCsoaZ92DPrnBZDaPI8V9SWTSZ
	 LglwUcYsHsEmvWh2SijxAJAIo7g+ry9rkeox96gBPEocX9L5EzofIiBvr4X8dDYlRn
	 QuVHJa5d/0wjmdad2NgPpm1Hyb7r238/n10aOKA3KZ+Wl6gsK8QqHhdbH6+3Sinw/C
	 WwZfejSQ2SkF9U9/KQ8KEkk/8Jerm2qRmDxDvmEGjxYHfDRxkaAYSacvZtEYk7hxQr
	 FmqxioiFxaHMg==
Date: Sat, 14 Sep 2024 12:51:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jagath Jog J <jagathjog1996@gmail.com>,
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, oe-kbuild-all@lists.linux.dev,
 skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <20240914125123.13ec48f1@jic23-huawei>
In-Reply-To: <f5zruqfmohoaohr2qwqug33dsar5q3fubhspbwuisxxblni6h4@paioiqyjzeg5>
References: <20240909043254.611589-3-lanzano.alex@gmail.com>
	<202409100026.17N3K11W-lkp@intel.com>
	<f5zruqfmohoaohr2qwqug33dsar5q3fubhspbwuisxxblni6h4@paioiqyjzeg5>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 23:21:52 -0400
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> On Tue, Sep 10, 2024 at 01:03:04AM GMT, kernel test robot wrote:
> > Hi Alex,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on jic23-iio/togreg]
> > [also build test ERROR on robh/for-next linus/master v6.11-rc7 next-20240909]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Lanzano/dt-bindings-iio-imu-add-bmi270-bindings/20240909-123509
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > patch link:    https://lore.kernel.org/r/20240909043254.611589-3-lanzano.alex%40gmail.com
> > patch subject: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
> > config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240910/202409100026.17N3K11W-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100026.17N3K11W-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409100026.17N3K11W-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/iio/imu/bmi270/bmi270_core.c: In function 'bmi270_configure_imu':  
> > >> drivers/iio/imu/bmi270/bmi270_core.c:180:31: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]  
> >      180 |                               FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
> >          |                               ^~~~~~~~~~
> > 
> > 
> > vim +/FIELD_PREP +180 drivers/iio/imu/bmi270/bmi270_core.c
> > 
> >    165	
> >    166	static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
> >    167	{
> >    168		int ret;
> >    169		struct device *dev = bmi270_device->dev;
> >    170		struct regmap *regmap = bmi270_device->regmap;
> >    171	
> >    172		ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
> >    173				      BMI270_PWR_CTRL_AUX_EN_MSK |
> >    174				      BMI270_PWR_CTRL_GYR_EN_MSK |
> >    175				      BMI270_PWR_CTRL_ACCEL_EN_MSK);
> >    176		if (ret)
> >    177			return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
> >    178	
> >    179		ret = regmap_set_bits(regmap, BMI270_ACC_CONF_REG,  
> >  > 180				      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,  
> >    181						 BMI270_ACC_CONF_ODR_100HZ) |
> >    182				      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
> >    183						 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
> >    184				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
> >    185		if (ret)
> >    186			return dev_err_probe(dev, ret, "Failed to configure accelerometer");
> >    187	
> >    188		ret = regmap_set_bits(regmap, BMI270_GYR_CONF_REG,
> >    189				      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
> >    190						 BMI270_GYR_CONF_ODR_200HZ) |
> >    191				      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
> >    192						 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
> >    193				      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
> >    194		if (ret)
> >    195			return dev_err_probe(dev, ret, "Failed to configure gyroscope");
> >    196	
> >    197		/* Enable FIFO_WKUP, Disable ADV_PWR_SAVE and FUP_EN */
> >    198		ret = regmap_write(regmap, BMI270_PWR_CONF_REG,
> >    199				   BMI270_PWR_CONF_FIFO_WKUP_MSK);
> >    200		if (ret)
> >    201			return dev_err_probe(dev, ret, "Failed to set power configuration");
> >    202	
> >    203		return 0;
> >    204	}
> >    205	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki  
> 
> I am having trouble reproducing this build error on both jic23-iio/togreg and
> linus/master v6.11.rc7 on an aarch64 box with the same compiler version.
> Maybe a config option is causing this?
> 
> However, I will add #include <linux/bitfield.h> to remedy this issue if
> some edge case is being hit.
Makes sense anyways roughly speaking we should aim for "include what you use"
for headers to avoid this sort of subtle build issue.
There are exceptions for one or two headers that are always included via
another path, but bitfield.h isn't one of those.

Jonathan

> 
> Best regards,
> Alex


