Return-Path: <linux-iio+bounces-5212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5DE8CD266
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D41AB20AEE
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BEB149E0F;
	Thu, 23 May 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/m+ByQR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF3149DEB
	for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468144; cv=none; b=aTRX7ceJAxl6FEvejZF1C/vHIyBCxIhlD/iCnj+i4zx10a96A5gGWxFpefhOSPwjXVy8pcHUYeJ6UWZ63tBhHB/ZNn4S12691eaEo3GKtNEu8Ism/v+qTS/pEaDmFWDnAjCtW9WFbZlXjH1UG+Bj8u3buXy7m2loT29ppzUtjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468144; c=relaxed/simple;
	bh=NxkdAdrJdInDnQmRVOBymr54RQlzSPSCJD6k5LWkhYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fXffT7P9EqdHrhRsKT0p5lcIOnp7xLYVeqxVbHeHsow6N8O08uDLiIyI9Fbz6YQrzn3hTmK8z/L4QNl/vpncWENW61PNT5kMw1m7Y0Ppr18EsErMVtliGwp47QsSsm6qZ4Xi3Hz21IXbgWeuJpIDaGONgHEi5c8MhUXwWfrYl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i/m+ByQR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73441edf7so43208521fa.1
        for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716468141; x=1717072941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFU7oe29wmWrSHAWUNO1lKOXXAdRLnYpFR9nmVzit9Y=;
        b=i/m+ByQRqn8Nd+LNIObZSaInmdiknv2iVi28VA+/w3Y6mXM/aaobtCzek/vuWp1hyu
         Kz9p7+KjYW7olySkalcUQNyjcMF/r3gkhZhgCT+lM5qBy9i42TnVjVZswORcKAJNRHFE
         05WE6pPGVud9tHrCpTQKPl62vb5/OyP35mggQdMtodUYLodh3jo3vqnFhz8AvaVtEVxb
         O7BT2Fio8cQmZGfRhvNXmc3VCBB5dQgHn77QvWasfb3wA0fUw/OWxZ56gmzTVOTTuAgC
         LC3+AWsCcdLhUauKokr9i53WfcWJyJ8Ra2Tug8j3GuOP3CbY0/PhsUOY+7v+GfjQ6LZi
         9S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468141; x=1717072941;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFU7oe29wmWrSHAWUNO1lKOXXAdRLnYpFR9nmVzit9Y=;
        b=Bm0H3hknTgEn0UTMS6WG49bjbUVbz4kcj6GEvKbOS6A/LY4ToYy/D2ilRY7jTNX91o
         OD+33i2KreB+c8oF+axLod1HExS213eR9UenTK58ni41DZM3yYr3J6SmzOYUIIvKtzUK
         we9UzbLTKfk/AHuZHnRTU0aMf8SzD8OPkfF44tk/O4fw+o9gucWNgs28f53q2JhurLPp
         yj3dQSPu21KbBGizRLT6vviOeC5TDF4Vd20G9SiML9s5c2yQN6I5EGgUVakWO7IkyQN3
         4XTAM+YfwLsGeguNuq7icBxPv8v2m1oF776s+5y42arNiJfIxfW1K2oFBkepYh91nvkh
         46Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVh1NBu/sSjJnzGAIILwCbBOUzC4xCUPWvY6ihvR6bsnSUwUtee1d3+eC2XdgxIQdN/+Yu4NuEYZ1GL6flXkXmP7ByCVPBI7QxC
X-Gm-Message-State: AOJu0Yz6A2MeREIYu3qCKiN+dQOMwVLKIsUYdHxcmJT+YSkYAsCdfiEz
	lNSdt+KN8brD6jNZFzBWVSWfmfnaNJ8DsSD2ZEFCZN+jpwJfiebOddyzzROcG68=
X-Google-Smtp-Source: AGHT+IG3pezFMtkMlzalGpaEUoGKwhfiLMGTt+4yA3z1pbJAP8F/Z0+LeagQc9XdwWQbIpirFEUQzA==
X-Received: by 2002:a2e:a549:0:b0:2df:b7cf:9607 with SMTP id 38308e7fff4ca-2e9494f2a5bmr38375081fa.22.1716468140465;
        Thu, 23 May 2024 05:42:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fc82eeb4sm26079305e9.0.2024.05.23.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:42:20 -0700 (PDT)
Date: Thu, 23 May 2024 15:42:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Yasin Lee <yasin.lee.x@outlook.com>,
	jic23@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	swboyd@chromium.org, nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240515-083021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: alpha-randconfig-r081-20240516 (https://download.01.org/0day-ci/archive/20240517/202405170824.uhEslLI0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405170824.uhEslLI0-lkp@intel.com/

smatch warnings:
drivers/iio/proximity/hx9031as.c:1118 hx9031as_raw_data_show() error: snprintf() is printing too much 8192 vs 512
drivers/iio/proximity/hx9031as.c:1240 hx9031as_channel_en_show() error: snprintf() is printing too much 8192 vs 512
drivers/iio/proximity/hx9031as.c:1466 hx9031as_threshold_show() error: snprintf() is printing too much 8192 vs 512
drivers/iio/proximity/hx9031as.c:1491 hx9031as_dump_show() error: snprintf() is printing too much 8192 vs 1024
drivers/iio/proximity/hx9031as.c:1513 hx9031as_offset_dac_show() error: snprintf() is printing too much 8192 vs 512

vim +1118 drivers/iio/proximity/hx9031as.c

5e5a419c9407f6 Yasin Lee 2024-05-10  1110  static ssize_t hx9031as_raw_data_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
5e5a419c9407f6 Yasin Lee 2024-05-10  1111  {
5e5a419c9407f6 Yasin Lee 2024-05-10  1112  	char buf[BUF_SIZE] = {0};
5e5a419c9407f6 Yasin Lee 2024-05-10  1113  	char *p = buf;
5e5a419c9407f6 Yasin Lee 2024-05-10  1114  	int ii = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1115  
5e5a419c9407f6 Yasin Lee 2024-05-10  1116  	hx9031as_sample();
5e5a419c9407f6 Yasin Lee 2024-05-10  1117  	for (ii = 0; ii < HX9031AS_CH_NUM; ii++) {
5e5a419c9407f6 Yasin Lee 2024-05-10 @1118  		p += snprintf(p, PAGE_SIZE, "ch[%d]: DIFF=%-8d, RAW=%-8d, OFFSET=%-8d, BL=%-8d, LP=%-8d\n",
                                                                         ^^^^^^^^^
This doesn't work at all.  It should be BUF_SIZE instead of PAGE_SIZE
but also PAGE_SIZE is a fixed size where the number of bytes remaining
should get smaller as we write further into the buffer.

Also use scnprintf() instead of snprintf() unless you need to check the
results.  The normal way to write this is:

	int off = 0;

	hx9031as_sample();
	for (ii = 0; ii < HX9031AS_CH_NUM; ii++) {
		off += scnprintf(buf + off, BUF_SIZE - off,
                                 ^^^^^^^^^  ^^^^^^^^^^^^^^

				 "ch[%d]: DIFF=%-8d, RAW=%-8d, OFFSET=%-8d, BL=%-8d, LP=%-8d\n",
				 ii, hx9031as_pdata.diff[ii], hx9031as_pdata.raw[ii], ...

5e5a419c9407f6 Yasin Lee 2024-05-10  1119  						ii, hx9031as_pdata.diff[ii], hx9031as_pdata.raw[ii], hx9031as_pdata.dac[ii],
5e5a419c9407f6 Yasin Lee 2024-05-10  1120  						hx9031as_pdata.bl[ii], hx9031as_pdata.lp[ii]);
5e5a419c9407f6 Yasin Lee 2024-05-10  1121  	}
5e5a419c9407f6 Yasin Lee 2024-05-10  1122  
5e5a419c9407f6 Yasin Lee 2024-05-10  1123  	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
5e5a419c9407f6 Yasin Lee 2024-05-10  1124  }
5e5a419c9407f6 Yasin Lee 2024-05-10  1125  
5e5a419c9407f6 Yasin Lee 2024-05-10  1126  static const struct file_operations hx9031as_raw_data_fops = {
5e5a419c9407f6 Yasin Lee 2024-05-10  1127  	.read = hx9031as_raw_data_show,
5e5a419c9407f6 Yasin Lee 2024-05-10  1128  };
5e5a419c9407f6 Yasin Lee 2024-05-10  1129  
5e5a419c9407f6 Yasin Lee 2024-05-10  1130  static ssize_t hx9031as_reg_write_store(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)
5e5a419c9407f6 Yasin Lee 2024-05-10  1131  {
5e5a419c9407f6 Yasin Lee 2024-05-10  1132  	int ret = -1;
5e5a419c9407f6 Yasin Lee 2024-05-10  1133  	unsigned int reg_address = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1134  	unsigned int val = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1135  	uint8_t addr = 0;
5e5a419c9407f6 Yasin Lee 2024-05-10  1136  	uint8_t tx_buf[1] = {0};
5e5a419c9407f6 Yasin Lee 2024-05-10  1137  	char buf[BUF_SIZE];
5e5a419c9407f6 Yasin Lee 2024-05-10  1138  
5e5a419c9407f6 Yasin Lee 2024-05-10  1139  	ENTER;
5e5a419c9407f6 Yasin Lee 2024-05-10  1140  	if (count > BUF_SIZE)
5e5a419c9407f6 Yasin Lee 2024-05-10  1141  		return -EINVAL;
5e5a419c9407f6 Yasin Lee 2024-05-10  1142  
5e5a419c9407f6 Yasin Lee 2024-05-10  1143  	if (copy_from_user(buf, user_buf, count))

We don't know that this is NUL terminated.  What about if count == 1
and the rest of the buffer is uninitialized.  Same issues in other
functions as well.

5e5a419c9407f6 Yasin Lee 2024-05-10  1144  		return -EFAULT;
5e5a419c9407f6 Yasin Lee 2024-05-10  1145  
5e5a419c9407f6 Yasin Lee 2024-05-10  1146  	if (sscanf(buf, "%x,%x", &reg_address, &val) != 2) {
5e5a419c9407f6 Yasin Lee 2024-05-10  1147  		PRINT_ERR("please input two HEX numbers: aa,bb (aa: reg_address, bb: value_to_be_set)\n");
5e5a419c9407f6 Yasin Lee 2024-05-10  1148  		return -EINVAL;
5e5a419c9407f6 Yasin Lee 2024-05-10  1149  	}
5e5a419c9407f6 Yasin Lee 2024-05-10  1150  
5e5a419c9407f6 Yasin Lee 2024-05-10  1151  	addr = (uint8_t)reg_address;
5e5a419c9407f6 Yasin Lee 2024-05-10  1152  	tx_buf[0] = (uint8_t)val;
5e5a419c9407f6 Yasin Lee 2024-05-10  1153  
5e5a419c9407f6 Yasin Lee 2024-05-10  1154  	ret = hx9031as_write(addr, tx_buf, 1);
5e5a419c9407f6 Yasin Lee 2024-05-10  1155  	if (ret != 0)
5e5a419c9407f6 Yasin Lee 2024-05-10  1156  		PRINT_ERR("hx9031as_write failed\n");
5e5a419c9407f6 Yasin Lee 2024-05-10  1157  
5e5a419c9407f6 Yasin Lee 2024-05-10  1158  	PRINT_INF("WRITE:Reg0x%02X=0x%02X\n", addr, tx_buf[0]);
5e5a419c9407f6 Yasin Lee 2024-05-10  1159  	return count;
5e5a419c9407f6 Yasin Lee 2024-05-10  1160  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


