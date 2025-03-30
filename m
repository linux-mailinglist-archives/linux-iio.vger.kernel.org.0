Return-Path: <linux-iio+bounces-17381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC6A75BB0
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 20:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B55D7A2173
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1C1DD9AD;
	Sun, 30 Mar 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRqsi6n3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547821D61BC;
	Sun, 30 Mar 2025 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743358033; cv=none; b=jlEjS5sm17dGgGdeo8k/1hkSMA9ZBjDtlanJcl3MN1CQBRwVc2Xr8rOhyTN8KPKy6412ypKOcJxCpAns7NiEVLbvs+nYIV4mGH6wuxlbDl0I4fv6heLHDvQBTrzEazUVbZ6+t8Xx3bHRl9euQX9Op1shKnDSECgoMeMzNbnDX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743358033; c=relaxed/simple;
	bh=9L+rkjvLISsAkTy8wBCwcU83sAKXupjGFDQkxg92qx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roxoEJ3cjJb1uFOiRC5kQm+2uwTbvfnXsd02ZzINrfYJoiYVOujcAEHjIhA96l1LrNKp6nrEUOllcEupe9iq1XiX2CzNFAkDiCUoohF9Tgllqr979VOp1OiutNUbvZqAfRxkscfJiP5FjXCY7MoCQHU73D8ecg/00cvb2yZC4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRqsi6n3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054E8C4CEDD;
	Sun, 30 Mar 2025 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743358032;
	bh=9L+rkjvLISsAkTy8wBCwcU83sAKXupjGFDQkxg92qx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRqsi6n39l45qx8OyexNvZRR8ud3YvcOOy05DcKkNVydnBEakybz+2UDFidBhE6PG
	 +M7o8Z1fb01/KcWTOrax0iWNKcpRBUkUYUNfcsYqHs5MIslZjFQbx7jK59/nCvdHpM
	 KvC7i+uIlHXgk2H5eGWAx6Ua6Wus4nk1M57u0rNk7tNawn19h1p+bH8l/MtWUu997e
	 pi3wpI+75y6ZSey3TV4OGSyTufnWrP6t9hqIxOowwegRm+9QrswL3ib3D78YB0LxNX
	 rRsmNAJ2h9xJItQQEdp2x1oyZZDpDr3gTl4fnqbiUb34JRZdmWiP7VutAnQ7z1npU4
	 1W+2eHhj+PpIA==
Date: Sun, 30 Mar 2025 19:07:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 linux-iio@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Michael Hennerich <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 09/10] iio: adc: ad7606: dynamically allocate channel
 info
Message-ID: <20250330190703.51e97942@jic23-huawei>
In-Reply-To: <4854b569-5032-4b75-80a6-8c5822845dc7@baylibre.com>
References: <72d776ae-4373-4a78-ba00-fa809478b453@stanley.mountain>
	<4854b569-5032-4b75-80a6-8c5822845dc7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 08:50:15 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/22/25 12:25 PM, Dan Carpenter wrote:
> > Hi David,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad7606-check-for-NULL-before-calling-sw_mode_config/20250319-065737
> > base:   9f36acefb2621d980734a5bb7d74e0e24e0af166
> > patch link:    https://lore.kernel.org/r/20250318-iio-adc-ad7606-improvements-v2-9-4b605427774c%40baylibre.com
> > patch subject: [PATCH v2 09/10] iio: adc: ad7606: dynamically allocate channel info
> > config: arm64-randconfig-r071-20250322 (https://download.01.org/0day-ci/archive/20250322/202503222246.RafigmhQ-lkp@intel.com/config)
> > compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202503222246.RafigmhQ-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/iio/adc/ad7606.c:1270 ad7606_probe_channels() warn: potentially one past the end of array 'channels[i]'
> > 
> > vim +1270 drivers/iio/adc/ad7606.c
> > 
> > 87cf5705725eeb David Lechner      2025-03-18  1196  static int ad7606_probe_channels(struct iio_dev *indio_dev)
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1197  {
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1198  	struct ad7606_state *st = iio_priv(indio_dev);
> > 87cf5705725eeb David Lechner      2025-03-18  1199  	struct device *dev = indio_dev->dev.parent;
> > 87cf5705725eeb David Lechner      2025-03-18  1200  	struct iio_chan_spec *channels;
> > 87cf5705725eeb David Lechner      2025-03-18  1201  	bool slow_bus;
> > 87cf5705725eeb David Lechner      2025-03-18  1202  	int ret, i;
> > 87cf5705725eeb David Lechner      2025-03-18  1203  
> > 87cf5705725eeb David Lechner      2025-03-18  1204  	slow_bus = !st->bops->iio_backend_config;
> > 87cf5705725eeb David Lechner      2025-03-18  1205  	indio_dev->num_channels = st->chip_info->num_adc_channels;
> > 87cf5705725eeb David Lechner      2025-03-18  1206  
> > 87cf5705725eeb David Lechner      2025-03-18  1207  	/* Slow buses also get 1 more channel for soft timestamp */
> > 87cf5705725eeb David Lechner      2025-03-18  1208  	if (slow_bus)
> > 87cf5705725eeb David Lechner      2025-03-18  1209  		indio_dev->num_channels++;
> > 87cf5705725eeb David Lechner      2025-03-18  1210  
> > 87cf5705725eeb David Lechner      2025-03-18  1211  	channels = devm_kcalloc(dev, indio_dev->num_channels, sizeof(*channels),
> > 87cf5705725eeb David Lechner      2025-03-18  1212  				GFP_KERNEL);
> > 87cf5705725eeb David Lechner      2025-03-18  1213  	if (!channels)
> > f3838e934dfff2 Alexandru Ardelean 2024-09-19  1214  		return -ENOMEM;
> > f3838e934dfff2 Alexandru Ardelean 2024-09-19  1215  
> > 87cf5705725eeb David Lechner      2025-03-18  1216  	for (i = 0; i < indio_dev->num_channels; i++) {  
> 
> The fix is to change this line to:
> 
> 							for (i = 0; i < st->chip_info->num_adc_channels; i++) {
> 
Tweaked and applied.

> > 87cf5705725eeb David Lechner      2025-03-18  1217  		struct iio_chan_spec *chan = &channels[i];
> > 87cf5705725eeb David Lechner      2025-03-18  1218  
> > 87cf5705725eeb David Lechner      2025-03-18  1219  		chan->type = IIO_VOLTAGE;
> > 87cf5705725eeb David Lechner      2025-03-18  1220  		chan->indexed = 1;
> > 87cf5705725eeb David Lechner      2025-03-18  1221  		chan->channel = i;
> > 87cf5705725eeb David Lechner      2025-03-18  1222  		chan->scan_index = i;
> > 87cf5705725eeb David Lechner      2025-03-18  1223  		chan->scan_type.sign = 's';
> > 87cf5705725eeb David Lechner      2025-03-18  1224  		chan->scan_type.realbits = st->chip_info->bits;
> > 87cf5705725eeb David Lechner      2025-03-18  1225  		chan->scan_type.storagebits = st->chip_info->bits > 16 ? 32 : 16;
> > 87cf5705725eeb David Lechner      2025-03-18  1226  		chan->scan_type.endianness = IIO_CPU;
> > f3838e934dfff2 Alexandru Ardelean 2024-09-19  1227  
> > 87cf5705725eeb David Lechner      2025-03-18  1228  		if (indio_dev->modes & INDIO_DIRECT_MODE)
> > 87cf5705725eeb David Lechner      2025-03-18  1229  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> > 87cf5705725eeb David Lechner      2025-03-18  1230  
> > 87cf5705725eeb David Lechner      2025-03-18  1231  		if (st->sw_mode_en) {
> > 87cf5705725eeb David Lechner      2025-03-18  1232  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> > 87cf5705725eeb David Lechner      2025-03-18  1233  			chan->info_mask_separate_available |=
> > 87cf5705725eeb David Lechner      2025-03-18  1234  				BIT(IIO_CHAN_INFO_SCALE);
> > 87cf5705725eeb David Lechner      2025-03-18  1235  
> > 87cf5705725eeb David Lechner      2025-03-18  1236  			/*
> > 87cf5705725eeb David Lechner      2025-03-18  1237  			 * All chips with software mode support oversampling,
> > 87cf5705725eeb David Lechner      2025-03-18  1238  			 * so we skip the oversampling_available check. And the
> > 87cf5705725eeb David Lechner      2025-03-18  1239  			 * shared_by_type instead of shared_by_all on slow
> > 87cf5705725eeb David Lechner      2025-03-18  1240  			 * buses is for backward compatibility.
> > 87cf5705725eeb David Lechner      2025-03-18  1241  			 */
> > 87cf5705725eeb David Lechner      2025-03-18  1242  			if (slow_bus)
> > 87cf5705725eeb David Lechner      2025-03-18  1243  				chan->info_mask_shared_by_type |=
> > 87cf5705725eeb David Lechner      2025-03-18  1244  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> > 87cf5705725eeb David Lechner      2025-03-18  1245  			else
> > 87cf5705725eeb David Lechner      2025-03-18  1246  				chan->info_mask_shared_by_all |=
> > 87cf5705725eeb David Lechner      2025-03-18  1247  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> > 87cf5705725eeb David Lechner      2025-03-18  1248  
> > 87cf5705725eeb David Lechner      2025-03-18  1249  			chan->info_mask_shared_by_all_available |=
> > 87cf5705725eeb David Lechner      2025-03-18  1250  				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> > 87cf5705725eeb David Lechner      2025-03-18  1251  		} else {
> > 87cf5705725eeb David Lechner      2025-03-18  1252  			chan->info_mask_shared_by_type |=
> > 87cf5705725eeb David Lechner      2025-03-18  1253  				BIT(IIO_CHAN_INFO_SCALE);
> > 87cf5705725eeb David Lechner      2025-03-18  1254  
> > 87cf5705725eeb David Lechner      2025-03-18  1255  			if (st->chip_info->oversampling_avail)
> > 87cf5705725eeb David Lechner      2025-03-18  1256  				chan->info_mask_shared_by_all |=
> > 87cf5705725eeb David Lechner      2025-03-18  1257  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> > 87cf5705725eeb David Lechner      2025-03-18  1258  		}
> > 87cf5705725eeb David Lechner      2025-03-18  1259  
> > 87cf5705725eeb David Lechner      2025-03-18  1260  		if (!slow_bus)
> > 87cf5705725eeb David Lechner      2025-03-18  1261  			chan->info_mask_shared_by_all |=
> > 87cf5705725eeb David Lechner      2025-03-18  1262  				BIT(IIO_CHAN_INFO_SAMP_FREQ);
> > 87cf5705725eeb David Lechner      2025-03-18  1263  
> > 87cf5705725eeb David Lechner      2025-03-18  1264  		ret = st->chip_info->scale_setup_cb(indio_dev, chan);
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1265  		if (ret)
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1266  			return ret;
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1267  	}
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1268  
> > 87cf5705725eeb David Lechner      2025-03-18  1269  	if (slow_bus)
> > 87cf5705725eeb David Lechner      2025-03-18 @1270  		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
> >                                                                 ^^^^^^^^^^^
> > i is == indio_dev->num_channels so this is out of bounds by one element.
> > 
> > 87cf5705725eeb David Lechner      2025-03-18  1271  
> > 87cf5705725eeb David Lechner      2025-03-18  1272  	indio_dev->channels = channels;
> > 87cf5705725eeb David Lechner      2025-03-18  1273  
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1274  	return 0;
> > e571c1902116a3 Alexandru Ardelean 2024-09-19  1275  }
> >   
> 


