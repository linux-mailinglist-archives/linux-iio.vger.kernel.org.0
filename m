Return-Path: <linux-iio+bounces-17208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE36A6CBAC
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 18:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C09174B3A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06757233D64;
	Sat, 22 Mar 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QA8Ngd+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C14233705
	for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742664346; cv=none; b=C2lLdHjw+bZLRFi2DMapf8xRGnSEp4DZi85YibTpRaO/k1cQQVu8xF7zMbOfrPeQV7fZwgaLyE3DmHVcaBTgdThScNB/SttffK6oGSkyhyGajGXW8duFm4VAqVVcWTtxYqBzjMzTciZnlst4MbTQph/KAe3EAoIqg2qCvr+w6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742664346; c=relaxed/simple;
	bh=KVVLbJ1zXJko3vgx6YQzBovfOIgGOqxXxDsSp81uYyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=USz9qd8KSeP4p2YtFt+9f6JRV5+COW7UpPoo8k5MNAbpVzxmc9DeAZpsPZ6vRdNF5gnWG7Bm/4KznAKvQC70x+ToSkbr2xJeMzyQZya+hpTV9MviK9Y4eXM8JUAwzU8w3wBJJObP0L8+MftFfMFJTn3Wy/1UrjI178zsrwJ0hcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QA8Ngd+d; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so32293315e9.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742664343; x=1743269143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6maXy0URBuJqvOhBuuvKx2+7wYA7mqrbNOfziAWZLY=;
        b=QA8Ngd+dvbtVFLhtcvrzigX61KxqTaGdnAOK62tzSJKLpyKkS7g+Bc6RG5Jf0hZQgn
         fGnHFB+A0hhFmSs6gXWa2F6Ikwh3ppVR0xOHZtl6oKXkXz1k6SjJxSe5ANtYo1R1kZg1
         aeADeIQpjMoLjBj/v7SRGgQyJmKdkMxtEKQv7z6RAJI1tpR7suGMvtq24UTBwFzCanPS
         lw9AqiuLJkAlJP6NKq2pymgX8c9uY16/+ekjA52CoCnsssmbl88FT/St4/dcyc6rymjy
         BwKFFipJunc5qyosr3mvilNxP5f6E2ASO8PjtzOj594aF4kpU7eJG/Tr1iUefP7LxpV/
         5jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742664343; x=1743269143;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6maXy0URBuJqvOhBuuvKx2+7wYA7mqrbNOfziAWZLY=;
        b=pj406rGjfLI+IKLdGWUv97jT6V52OekHZ1ZYIKN2brQP82GzMwRZdzl1+7wL9hpFeu
         Fn2B3XkyTEya4ftnpORc0ZyRj/vS23QbYKTtxpJvTDI8rVCFMAsQERtn0YvEAcsRumKX
         wz22woiApnB0zhCWUOm2YzEmg0hnHYKBpDg+N29vvZhIXqzst15LrPsafPjZNUnZLrhn
         VJ8xAusYYXAZZV7nyPvT/DQfidliqREI504RIZqk0ezQQ+h7ccmgqEgoF+BWbSZUZil3
         b+LKPy0+HyD0tXMlJ1o2Fkf+ION3MmmbPrB+Y3mgSdLhL9Tqp2MoJB44sMQxxQnolXLS
         1iYA==
X-Forwarded-Encrypted: i=1; AJvYcCXw+w1HVLR2iz664Z9Dmx1K3rZHyancRbpcSItOdgcsPap8ZwchhTghXQIGB4cF4qHmhjYZBmODbhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8r2X0xwQKYaHEdDQIFqEDY6v0aPhfp47FHeBWWr9dFUi1+I3
	QYtJXoM2op9bua9qaFNHqGii2iywYmqwX4wzppNvAsFDl3LkNptYuxyHCqy0Ego=
X-Gm-Gg: ASbGncvTzKthRuqRna/AT3WSc2uTZzLcK32LQGJHlqAwN3dOY/XGYZwuVidchBXvFFJ
	jZ+vTISYDn3SmE3Gb/aVhtyepgx1Kfxo1cajVHhQDh1HY0Qj577ZiBNVGlMDVbbXdk3M1pnZ8FE
	ZKcj0h63aJC3fcfq3jq1jATBOfnGRbTXwHJ7xKQxi7rCdmEx16nT0b4Pc73FokmAxKKq6J9yRA/
	3Xvwk4mttnMb4tfNg8Vq20ht70bZfbg/Rp/pE9GEL76O5wwfgiQdrBdPJjtp9U5s2FGwDVBA1hm
	a217X4/br+6hNpfPRtSWFNegPD2RppxZu38BzFqtLxeyjJskvQ==
X-Google-Smtp-Source: AGHT+IHwieQKergX1rC+mWOvJOQ5sn9Ft8OV5mIRdJ/Pxfgl8ge9rxEOgVtIeqtby3893whER7DmRQ==
X-Received: by 2002:a05:600c:5742:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-43d510fff60mr50928825e9.19.1742664342720;
        Sat, 22 Mar 2025 10:25:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd26cecsm61977195e9.17.2025.03.22.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 10:25:42 -0700 (PDT)
Date: Sat, 22 Mar 2025 20:25:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 09/10] iio: adc: ad7606: dynamically allocate channel
 info
Message-ID: <72d776ae-4373-4a78-ba00-fa809478b453@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-9-4b605427774c@baylibre.com>

Hi David,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad7606-check-for-NULL-before-calling-sw_mode_config/20250319-065737
base:   9f36acefb2621d980734a5bb7d74e0e24e0af166
patch link:    https://lore.kernel.org/r/20250318-iio-adc-ad7606-improvements-v2-9-4b605427774c%40baylibre.com
patch subject: [PATCH v2 09/10] iio: adc: ad7606: dynamically allocate channel info
config: arm64-randconfig-r071-20250322 (https://download.01.org/0day-ci/archive/20250322/202503222246.RafigmhQ-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503222246.RafigmhQ-lkp@intel.com/

smatch warnings:
drivers/iio/adc/ad7606.c:1270 ad7606_probe_channels() warn: potentially one past the end of array 'channels[i]'

vim +1270 drivers/iio/adc/ad7606.c

87cf5705725eeb David Lechner      2025-03-18  1196  static int ad7606_probe_channels(struct iio_dev *indio_dev)
e571c1902116a3 Alexandru Ardelean 2024-09-19  1197  {
e571c1902116a3 Alexandru Ardelean 2024-09-19  1198  	struct ad7606_state *st = iio_priv(indio_dev);
87cf5705725eeb David Lechner      2025-03-18  1199  	struct device *dev = indio_dev->dev.parent;
87cf5705725eeb David Lechner      2025-03-18  1200  	struct iio_chan_spec *channels;
87cf5705725eeb David Lechner      2025-03-18  1201  	bool slow_bus;
87cf5705725eeb David Lechner      2025-03-18  1202  	int ret, i;
87cf5705725eeb David Lechner      2025-03-18  1203  
87cf5705725eeb David Lechner      2025-03-18  1204  	slow_bus = !st->bops->iio_backend_config;
87cf5705725eeb David Lechner      2025-03-18  1205  	indio_dev->num_channels = st->chip_info->num_adc_channels;
87cf5705725eeb David Lechner      2025-03-18  1206  
87cf5705725eeb David Lechner      2025-03-18  1207  	/* Slow buses also get 1 more channel for soft timestamp */
87cf5705725eeb David Lechner      2025-03-18  1208  	if (slow_bus)
87cf5705725eeb David Lechner      2025-03-18  1209  		indio_dev->num_channels++;
87cf5705725eeb David Lechner      2025-03-18  1210  
87cf5705725eeb David Lechner      2025-03-18  1211  	channels = devm_kcalloc(dev, indio_dev->num_channels, sizeof(*channels),
87cf5705725eeb David Lechner      2025-03-18  1212  				GFP_KERNEL);
87cf5705725eeb David Lechner      2025-03-18  1213  	if (!channels)
f3838e934dfff2 Alexandru Ardelean 2024-09-19  1214  		return -ENOMEM;
f3838e934dfff2 Alexandru Ardelean 2024-09-19  1215  
87cf5705725eeb David Lechner      2025-03-18  1216  	for (i = 0; i < indio_dev->num_channels; i++) {
87cf5705725eeb David Lechner      2025-03-18  1217  		struct iio_chan_spec *chan = &channels[i];
87cf5705725eeb David Lechner      2025-03-18  1218  
87cf5705725eeb David Lechner      2025-03-18  1219  		chan->type = IIO_VOLTAGE;
87cf5705725eeb David Lechner      2025-03-18  1220  		chan->indexed = 1;
87cf5705725eeb David Lechner      2025-03-18  1221  		chan->channel = i;
87cf5705725eeb David Lechner      2025-03-18  1222  		chan->scan_index = i;
87cf5705725eeb David Lechner      2025-03-18  1223  		chan->scan_type.sign = 's';
87cf5705725eeb David Lechner      2025-03-18  1224  		chan->scan_type.realbits = st->chip_info->bits;
87cf5705725eeb David Lechner      2025-03-18  1225  		chan->scan_type.storagebits = st->chip_info->bits > 16 ? 32 : 16;
87cf5705725eeb David Lechner      2025-03-18  1226  		chan->scan_type.endianness = IIO_CPU;
f3838e934dfff2 Alexandru Ardelean 2024-09-19  1227  
87cf5705725eeb David Lechner      2025-03-18  1228  		if (indio_dev->modes & INDIO_DIRECT_MODE)
87cf5705725eeb David Lechner      2025-03-18  1229  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
87cf5705725eeb David Lechner      2025-03-18  1230  
87cf5705725eeb David Lechner      2025-03-18  1231  		if (st->sw_mode_en) {
87cf5705725eeb David Lechner      2025-03-18  1232  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
87cf5705725eeb David Lechner      2025-03-18  1233  			chan->info_mask_separate_available |=
87cf5705725eeb David Lechner      2025-03-18  1234  				BIT(IIO_CHAN_INFO_SCALE);
87cf5705725eeb David Lechner      2025-03-18  1235  
87cf5705725eeb David Lechner      2025-03-18  1236  			/*
87cf5705725eeb David Lechner      2025-03-18  1237  			 * All chips with software mode support oversampling,
87cf5705725eeb David Lechner      2025-03-18  1238  			 * so we skip the oversampling_available check. And the
87cf5705725eeb David Lechner      2025-03-18  1239  			 * shared_by_type instead of shared_by_all on slow
87cf5705725eeb David Lechner      2025-03-18  1240  			 * buses is for backward compatibility.
87cf5705725eeb David Lechner      2025-03-18  1241  			 */
87cf5705725eeb David Lechner      2025-03-18  1242  			if (slow_bus)
87cf5705725eeb David Lechner      2025-03-18  1243  				chan->info_mask_shared_by_type |=
87cf5705725eeb David Lechner      2025-03-18  1244  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
87cf5705725eeb David Lechner      2025-03-18  1245  			else
87cf5705725eeb David Lechner      2025-03-18  1246  				chan->info_mask_shared_by_all |=
87cf5705725eeb David Lechner      2025-03-18  1247  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
87cf5705725eeb David Lechner      2025-03-18  1248  
87cf5705725eeb David Lechner      2025-03-18  1249  			chan->info_mask_shared_by_all_available |=
87cf5705725eeb David Lechner      2025-03-18  1250  				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
87cf5705725eeb David Lechner      2025-03-18  1251  		} else {
87cf5705725eeb David Lechner      2025-03-18  1252  			chan->info_mask_shared_by_type |=
87cf5705725eeb David Lechner      2025-03-18  1253  				BIT(IIO_CHAN_INFO_SCALE);
87cf5705725eeb David Lechner      2025-03-18  1254  
87cf5705725eeb David Lechner      2025-03-18  1255  			if (st->chip_info->oversampling_avail)
87cf5705725eeb David Lechner      2025-03-18  1256  				chan->info_mask_shared_by_all |=
87cf5705725eeb David Lechner      2025-03-18  1257  					BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
87cf5705725eeb David Lechner      2025-03-18  1258  		}
87cf5705725eeb David Lechner      2025-03-18  1259  
87cf5705725eeb David Lechner      2025-03-18  1260  		if (!slow_bus)
87cf5705725eeb David Lechner      2025-03-18  1261  			chan->info_mask_shared_by_all |=
87cf5705725eeb David Lechner      2025-03-18  1262  				BIT(IIO_CHAN_INFO_SAMP_FREQ);
87cf5705725eeb David Lechner      2025-03-18  1263  
87cf5705725eeb David Lechner      2025-03-18  1264  		ret = st->chip_info->scale_setup_cb(indio_dev, chan);
e571c1902116a3 Alexandru Ardelean 2024-09-19  1265  		if (ret)
e571c1902116a3 Alexandru Ardelean 2024-09-19  1266  			return ret;
e571c1902116a3 Alexandru Ardelean 2024-09-19  1267  	}
e571c1902116a3 Alexandru Ardelean 2024-09-19  1268  
87cf5705725eeb David Lechner      2025-03-18  1269  	if (slow_bus)
87cf5705725eeb David Lechner      2025-03-18 @1270  		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
                                                                ^^^^^^^^^^^
i is == indio_dev->num_channels so this is out of bounds by one element.

87cf5705725eeb David Lechner      2025-03-18  1271  
87cf5705725eeb David Lechner      2025-03-18  1272  	indio_dev->channels = channels;
87cf5705725eeb David Lechner      2025-03-18  1273  
e571c1902116a3 Alexandru Ardelean 2024-09-19  1274  	return 0;
e571c1902116a3 Alexandru Ardelean 2024-09-19  1275  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


