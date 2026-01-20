Return-Path: <linux-iio+bounces-28036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A67CED3BFF5
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C584FC45D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C738BDCE;
	Tue, 20 Jan 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcogLCmZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBA38B7D0
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891583; cv=none; b=Ix9NSV/42zz5LdZOigKtQPRUNFW1d1DlI1V2RFi4cdc9Y06NJHRs+B/H5NWiWI3byRcYhfUG7ATALIgPH8Yrtq3AIeuXwefR7xdT6uojYSXJcLeOShWzrbJL5veuT4gqbGDCH+HO9/5xFnrK34bJjxQT40wp0BFC6RWKQmmow34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891583; c=relaxed/simple;
	bh=zQTauf9+FCZgvacWS319fh01AB/IlHI0j/OyC2KznK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dnDRRKDpgEnrDnH7hDcjJ75snKGYzO8PK2X7qNroieB9oIQJjcMtMQm5rix3mu8ue2hUPYfSGAG0Z7uY9dQeY05HKsbpZwK62QFOOfHqoe2d0ATst2qRsDjfW6HuxFNG28k8Al6vSCTMN8emFOukzb/et97S0CGFSBb6rUOc3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcogLCmZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432dc56951eso3361434f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768891573; x=1769496373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klhXajdbwAk0QXfRXQmCUKn2nPx5fUGc/8woaWQokME=;
        b=KcogLCmZQeDzdYsxC/9cbHg3FS0eIzqtH7YliwYEa37cO4yNgq62wmSAhbT1g79BdM
         QIQmRj0Eoum4ANY6cMcBm+kQKWhENGjFTpwsvOw6c+R3L4vlYZ14E1YpCAk4m6o22D5s
         eMIrHGrFeJQu6GEchQMN99FEXe54f/8J43NE6M7I766pPnYsAmpR4vVFrkLofIVV3Ehy
         wyF3Y4zunu/zqPox+mDzmTnnvvNtNvFUdlGwA8q7a7+lnvlN1M3hSR6atWQrPd1rlslv
         k0G59Fu8hqvqBovOq1cSPMZVFx4H+KqCXgJiR+qcLfGy6qy1u6QEIIp+y3ClpKrXvW3R
         Djyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768891573; x=1769496373;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klhXajdbwAk0QXfRXQmCUKn2nPx5fUGc/8woaWQokME=;
        b=lBkWK6CKxl1MCwEmZJZKrIalS4ZpnHr/lDZG+yySqjxlrnyNT9z03gIlVTqhgzW5ah
         /6TN1hieWo5vw5n9d3qot71wN91YhE2PkQ3/O32pHUzwxFC/R8QF4rnpGU5VccORjWaA
         oKpibcW0YkqoWuycHqhd/d/zsH/CZ+hjU1yFqOfx2r7XNqsaeQdeJ+Tgn8e1mBw32nl5
         yfZG/0VABtDkbRgVf+0KPG5x093SycLcSpsEc55kBdOI2wZoc1+XRCpfnCasVuMmDxPl
         AhHbjjlfeUu1RqTohmuGcFG8otVUYgVkLsygIN3T8xtASJvkcQduMpfzSPOqnen4IWEb
         eXNA==
X-Forwarded-Encrypted: i=1; AJvYcCXKK9zcHl9HJUJdcxMNGJtTAAnmLBlqa6XDoA1h5ZUsliQJZK2GJcZ2NdyOJHXnC7f90HWzfiXq7IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybosqSEZhzj/9HgQSSbSL5GH3BRfac5RWDhRJo+Y1eWg2EZnMy
	yDhT2UvNegnNF9ruCIpZnzFrhlR/7LrGKWIIx/h26QLpdNcxmSpDCX56YsYXiLKTsNk=
X-Gm-Gg: AZuq6aKSxi+NDU1mdmNVXw/KsKnM5NShzBmCu3wX4MCvi5U0gttujANzld6mhqLoZOv
	tAiKJ4vH/IWmHj5vvjm1hGu3yxu7RF+uehxAeAJ79gPropuIyhpghBXLpCHYE5vSOWbuVLrZxVH
	zCGpNc6b3K4GE9ToXgU/UrR793uYXi9RoSW52ZtZH+3hSzJytKVEpsSERxkVAouX0mTCYr6n9L7
	TCVoj5F4TeLo0hyha0/ztYDlYlieddFxa57gFtk8V5BRtGpcUmCZ0dMfX4A3lSgp8Iq/mxOwUP1
	YsECvmGIRXCylc3R6DKNm+VnkoeLbVG/k4e6EDcGtQyTxG6wnvw/hc/U0MQAJ1R0eresxNf5qhV
	KaByD9T1SuYepUyVkJyp5ZW4RaAUKKzG4Xne5K6CqpsErqVixbKPdkTwQIOZcomYQbR8BrcnQ6z
	ASHWUEW/RyY4drX3oY
X-Received: by 2002:a05:6000:2c03:b0:431:3a5:d9c1 with SMTP id ffacd0b85a97d-4358ff5692cmr894098f8f.30.1768891572616;
        Mon, 19 Jan 2026 22:46:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356999810bsm27653160f8f.40.2026.01.19.22.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:46:12 -0800 (PST)
Date: Tue, 20 Jan 2026 09:46:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
Message-ID: <202601200451.4BeA8JAe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119100449.1559624-4-flavra@baylibre.com>

Hi Francesco,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Lavra/iio-imu-st_lsm6dsx-set-FIFO-ODR-for-accelerometer-and-gyroscope-only/20260119-181615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260119100449.1559624-4-flavra%40baylibre.com
patch subject: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation sensor
config: sparc-randconfig-r071-20260119 (https://download.01.org/0day-ci/archive/20260120/202601200451.4BeA8JAe-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.2.0
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601200451.4BeA8JAe-lkp@intel.com/

smatch warnings:
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c:90 st_lsm6dsx_sf_set_odr() error: uninitialized symbol 'odr_val'.

vim +/odr_val +90 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

aa03865dcb5ed7 Francesco Lavra 2026-01-19   70  int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
aa03865dcb5ed7 Francesco Lavra 2026-01-19   71  {
aa03865dcb5ed7 Francesco Lavra 2026-01-19   72  	struct st_lsm6dsx_hw *hw = sensor->hw;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   73  	const struct st_lsm6dsx_sf_settings *settings;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   74  	u8 data;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   75  	int err;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   76  
aa03865dcb5ed7 Francesco Lavra 2026-01-19   77  	guard(mutex)(&hw->page_lock);
aa03865dcb5ed7 Francesco Lavra 2026-01-19   78  
aa03865dcb5ed7 Francesco Lavra 2026-01-19   79  	err = st_lsm6dsx_sf_set_page(hw, true);
aa03865dcb5ed7 Francesco Lavra 2026-01-19   80  	if (err < 0)
aa03865dcb5ed7 Francesco Lavra 2026-01-19   81  		return err;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   82  
aa03865dcb5ed7 Francesco Lavra 2026-01-19   83  	settings = &hw->settings->sf_settings;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   84  	if (enable) {
aa03865dcb5ed7 Francesco Lavra 2026-01-19   85  		u8 odr_val;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   86  		const struct st_lsm6dsx_reg *reg = &settings->odr_table.reg;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   87  
aa03865dcb5ed7 Francesco Lavra 2026-01-19   88  		st_lsm6dsx_sf_get_odr_val(settings, sensor->hwfifo_odr_mHz,
aa03865dcb5ed7 Francesco Lavra 2026-01-19   89  					  &odr_val);

No error checking on st_lsm6dsx_sf_get_odr_val().  Probably this is
deliberate?

aa03865dcb5ed7 Francesco Lavra 2026-01-19  @90  		data = ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
aa03865dcb5ed7 Francesco Lavra 2026-01-19   91  		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
aa03865dcb5ed7 Francesco Lavra 2026-01-19   92  					 data);
aa03865dcb5ed7 Francesco Lavra 2026-01-19   93  		if (err < 0)
aa03865dcb5ed7 Francesco Lavra 2026-01-19   94  			goto out;
aa03865dcb5ed7 Francesco Lavra 2026-01-19   95  	}
aa03865dcb5ed7 Francesco Lavra 2026-01-19   96  
aa03865dcb5ed7 Francesco Lavra 2026-01-19   97  	err = regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
aa03865dcb5ed7 Francesco Lavra 2026-01-19   98  				 settings->fifo_enable.mask, enable);
aa03865dcb5ed7 Francesco Lavra 2026-01-19   99  	if (err < 0)
aa03865dcb5ed7 Francesco Lavra 2026-01-19  100  		goto out;
aa03865dcb5ed7 Francesco Lavra 2026-01-19  101  
aa03865dcb5ed7 Francesco Lavra 2026-01-19  102  	return st_lsm6dsx_sf_set_page(hw, false);
aa03865dcb5ed7 Francesco Lavra 2026-01-19  103  
aa03865dcb5ed7 Francesco Lavra 2026-01-19  104  out:
aa03865dcb5ed7 Francesco Lavra 2026-01-19  105  	st_lsm6dsx_sf_set_page(hw, false);
aa03865dcb5ed7 Francesco Lavra 2026-01-19  106  
aa03865dcb5ed7 Francesco Lavra 2026-01-19  107  	return err;
aa03865dcb5ed7 Francesco Lavra 2026-01-19  108  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


