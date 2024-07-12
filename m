Return-Path: <linux-iio+bounces-7533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA5292F9B6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AD51F22E89
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BA16A93F;
	Fri, 12 Jul 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcJ3Gp2k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7C15EFB7;
	Fri, 12 Jul 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785127; cv=none; b=eKhckaRy8l6fDATq4kSMUvc592lCIPIWRP9Lt71zy5pXL49dwBEs0V5KyHtwQJnxkqWnFsnurZPw3/38XkxEVbOnxKW/6solTWthpfvwxEEgsnBdzkDtRoen3+qwCzbvxKc+SmycJpVmHxMCdXL0vrcnlNdFqKpKXcIt4t2XCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785127; c=relaxed/simple;
	bh=bsD+Y3lBDQsozn6E7ODrLjRhG7eiCoBDGZkxWlj2klY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWcvxzPQYYjx1p6HLisJf6HpWMmEV0s1MlQ3qROUiHXuijqBc8wxJBE+DLV0jFjb/zc/2TqKTsL/OTPOz6KLzGX+T55YEPfaXAzaWkxW0FAVfOJldRgT2pYbcK/pd5NXs45nBj3473AT9H/zeANkG1WtWsk1zky70RHWpBODhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcJ3Gp2k; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720785126; x=1752321126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bsD+Y3lBDQsozn6E7ODrLjRhG7eiCoBDGZkxWlj2klY=;
  b=dcJ3Gp2kNcZeCFKUQQZG41spKpsoKP94hZZJrf0uRS3zlg9Uhxi6pm9Y
   7Ct91s0TpFkQFSsHEogg8Pn/+/0kZXDMlx8DryhLSbtoM4mCiYEYgi6BF
   pWyfuDo4BMlNkTMBSAf0y3+pSZwlQNwSH72d3G8ZVpbeM9oQK2h6bWL6Y
   xMEiLRZ56zKWacn9BXSCB2Zl6YvI83DFNcZOIvg6ZFmGHonkkNMBDFlBH
   OPo2uM6lm2BD1AsiBnxrjBwO0UtRE4rqqn37P5g20XQZoGEuKDxr/GAwj
   Zt+TH7VpOQ6fwUldtOBceFjvs/uvZYAfgHMGmilnlwLFblfYgVm6vELOS
   Q==;
X-CSE-ConnectionGUID: i2cmzJ1mSQ2AS27CR+st7Q==
X-CSE-MsgGUID: FfxWhCIvRVq97006DyDrcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18171239"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18171239"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 04:51:26 -0700
X-CSE-ConnectionGUID: r8iYMDWrQS2qIHSv20W1WA==
X-CSE-MsgGUID: GWNudzkCSUS72bGX0haq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48797070"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2024 04:51:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSEo4-000aiu-0N;
	Fri, 12 Jul 2024 11:51:20 +0000
Date: Fri, 12 Jul 2024 19:50:38 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: humidity: Add support for ENS21x
Message-ID: <202407121921.LHla7p7i-lkp@intel.com>
References: <20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>

Hi Joshua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1ebab783647a9e3bf357002d5c4ff060c8474a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Felmeden/dt-bindings-iio-humidity-add-ENS21x-sensor-family/20240711-022826
base:   1ebab783647a9e3bf357002d5c4ff060c8474a0a
patch link:    https://lore.kernel.org/r/20240710-ens21x-v3-2-4e3fbcf2a7fb%40thegoodpenguin.co.uk
patch subject: [PATCH v3 2/2] iio: humidity: Add support for ENS21x
config: loongarch-randconfig-r122-20240712 (https://download.01.org/0day-ci/archive/20240712/202407121921.LHla7p7i-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240712/202407121921.LHla7p7i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407121921.LHla7p7i-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/humidity/ens21x.c:84:23: sparse: sparse: restricted __be32 degrades to integer
>> drivers/iio/humidity/ens21x.c:143:26: sparse: sparse: cast to restricted __le32
>> drivers/iio/humidity/ens21x.c:283:19: sparse: sparse: cast to restricted __le16

vim +84 drivers/iio/humidity/ens21x.c

    80	
    81	/* calculate 17-bit crc7 */
    82	static u8 ens21x_crc7(u32 val)
    83	{
  > 84		u32 val_be = (htonl(val & 0x1ffff) >> 0x8);
    85	
    86		return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
    87	}
    88	
    89	static int ens21x_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
    90	{
    91		u32 regval, regval_le;
    92		int ret, tries;
    93		struct ens21x_dev *dev_data = iio_priv(indio_dev);
    94	
    95		/* assert read */
    96		i2c_smbus_write_byte_data(dev_data->client, ENS21X_REG_SENS_START,
    97					  temp ? ENS21X_SENS_START_T_START :
    98						 ENS21X_SENS_START_H_START);
    99	
   100		/* wait for conversion to be ready */
   101		switch (dev_data->part_id) {
   102		case ENS210:
   103		case ENS210A:
   104			msleep(ENS210_CONST_CONVERSION_TIME);
   105			break;
   106		case ENS211:
   107		case ENS212:
   108			msleep(ENS212_CONST_CONVERSION_TIME);
   109			break;
   110		case ENS213A:
   111		case ENS215:
   112			msleep(ENS215_CONST_CONVERSION_TIME);
   113			break;
   114		default:
   115			dev_err(&dev_data->client->dev, "unrecognised device");
   116			return -ENODEV;
   117		}
   118	
   119		tries = 10;
   120		while (tries-- > 0) {
   121			usleep_range(4000, 5000);
   122			ret = i2c_smbus_read_byte_data(dev_data->client,
   123						       ENS21X_REG_SENS_STAT);
   124			if (ret < 0)
   125				continue;
   126			if (!(ret & (temp ? ENS21X_SENS_STAT_T_ACTIVE :
   127					    ENS21X_SENS_STAT_H_ACTIVE)))
   128				break;
   129		}
   130		if (tries < 0) {
   131			dev_err(&indio_dev->dev, "timeout waiting for sensor reading\n");
   132			return -EIO;
   133		}
   134	
   135		/* perform read */
   136		ret = i2c_smbus_read_i2c_block_data(
   137			dev_data->client, temp ? ENS21X_REG_T_VAL : ENS21X_REG_H_VAL, 3,
   138			(u8 *)&regval_le);
   139		if (ret < 0) {
   140			dev_err(&dev_data->client->dev, "failed to read register");
   141			return -EIO;
   142		} else if (ret == 3) {
 > 143			regval = le32_to_cpu(regval_le);
   144			if (ens21x_crc7(regval) == ((regval >> 17) & 0x7f)) {
   145				*val = regval & 0xffff;
   146				return IIO_VAL_INT;
   147			}
   148			/* crc fail */
   149			dev_err(&indio_dev->dev, "ens invalid crc\n");
   150			return -EIO;
   151		}
   152	
   153		dev_err(&indio_dev->dev, "expected 3 bytes, received %d\n", ret);
   154		return -EIO;
   155	}
   156	
   157	static int ens21x_read_raw(struct iio_dev *indio_dev,
   158				   struct iio_chan_spec const *channel, int *val,
   159				   int *val2, long mask)
   160	{
   161		struct ens21x_dev *dev_data = iio_priv(indio_dev);
   162		int ret = -EINVAL;
   163	
   164		switch (mask) {
   165		case IIO_CHAN_INFO_RAW:
   166			mutex_lock(&dev_data->lock);
   167			ret = ens21x_get_measurement(
   168				indio_dev, channel->type == IIO_TEMP, val);
   169			mutex_unlock(&dev_data->lock);
   170			break;
   171		case IIO_CHAN_INFO_SCALE:
   172			if (channel->type == IIO_TEMP) {
   173				*val = ENS21X_CONST_TEMP_SCALE_INT;
   174				*val2 = ENS21X_CONST_TEMP_SCALE_DEC;
   175			} else {
   176				*val = ENS21X_CONST_HUM_SCALE_INT;
   177				*val2 = ENS21X_CONST_HUM_SCALE_DEC;
   178			}
   179			ret = IIO_VAL_INT_PLUS_MICRO;
   180			break;
   181		case IIO_CHAN_INFO_OFFSET:
   182			if (channel->type == IIO_TEMP) {
   183				*val = ENS21X_CONST_TEMP_OFFSET_INT;
   184				*val2 = ENS21X_CONST_TEMP_OFFSET_DEC;
   185				ret = IIO_VAL_INT_PLUS_MICRO;
   186				break;
   187			}
   188			*val = 0;
   189			ret =  IIO_VAL_INT;
   190			break;
   191		default:
   192			break;
   193		}
   194		return ret;
   195	}
   196	
   197	static const struct iio_chan_spec ens21x_channels[] = {
   198		/* Temperature channel */
   199		{
   200			.type = IIO_TEMP,
   201			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
   202					      BIT(IIO_CHAN_INFO_SCALE) |
   203					      BIT(IIO_CHAN_INFO_OFFSET),
   204		},
   205		/* Humidity channel */
   206		{
   207			.type = IIO_HUMIDITYRELATIVE,
   208			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
   209					      BIT(IIO_CHAN_INFO_SCALE) |
   210					      BIT(IIO_CHAN_INFO_OFFSET),
   211		}
   212	};
   213	
   214	static const struct iio_info ens21x_info = {
   215		.read_raw = ens21x_read_raw,
   216	};
   217	
   218	static int ens21x_probe(struct i2c_client *client)
   219	{
   220		const struct i2c_device_id *id = i2c_client_get_device_id(client);
   221		const struct of_device_id *match;
   222		struct ens21x_dev *dev_data;
   223		struct iio_dev *indio_dev;
   224		uint16_t part_id_le, part_id;
   225		int ret, tries;
   226	
   227		if (!i2c_check_functionality(client->adapter,
   228				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
   229				I2C_FUNC_SMBUS_WRITE_BYTE |
   230				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
   231			dev_err(&client->dev,
   232				"adapter does not support some i2c transactions\n");
   233			return -EOPNOTSUPP;
   234		}
   235	
   236		match = i2c_of_match_device(ens21x_of_match, client);
   237		if (!match)
   238			return -ENODEV;
   239	
   240		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
   241		if (!indio_dev)
   242			return -ENOMEM;
   243	
   244		dev_data = iio_priv(indio_dev);
   245		i2c_set_clientdata(client, indio_dev);
   246		dev_data->client = client;
   247		mutex_init(&dev_data->lock);
   248	
   249		/* reset device */
   250		ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
   251						ENS21X_SYS_CTRL_SYS_RESET);
   252		if (ret)
   253			return ret;
   254	
   255		/* wait for device to become active */
   256		usleep_range(4000, 5000);
   257	
   258		/* disable low power mode */
   259		ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL, 0x00);
   260		if (ret)
   261			return ret;
   262	
   263		/* wait for device to become active */
   264		tries = 10;
   265		while (tries-- > 0) {
   266			msleep(20);
   267			ret = i2c_smbus_read_byte_data(client, ENS21X_REG_SYS_STAT);
   268			if (ret < 0)
   269				return ret;
   270			if (ret & ENS21X_SYS_STAT_SYS_ACTIVE)
   271				break;
   272		}
   273		if (tries < 0) {
   274			dev_err(&client->dev,
   275				"timeout waiting for ens21x to become active\n");
   276			return -EIO;
   277		}
   278	
   279		/* get part_id */
   280		part_id_le = i2c_smbus_read_word_data(client, ENS21X_REG_PART_ID);
   281		if (part_id_le < 0)
   282			return part_id_le;
 > 283		part_id = le16_to_cpu(part_id_le);
   284	
   285		if (part_id != id->driver_data) {
   286			dev_err(&client->dev,
   287				"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
   288				id->driver_data);
   289			return -ENODEV;
   290		}
   291	
   292		/* reenable low power */
   293		ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
   294						ENS21X_SYS_CTRL_LOW_POWER_ENABLE);
   295		if (ret)
   296			return ret;
   297	
   298		dev_data->part_id = part_id;
   299	
   300		indio_dev->name = id->name;
   301		indio_dev->modes = INDIO_DIRECT_MODE;
   302		indio_dev->channels = ens21x_channels;
   303		indio_dev->num_channels = ARRAY_SIZE(ens21x_channels);
   304		indio_dev->info = &ens21x_info;
   305	
   306		return devm_iio_device_register(&client->dev, indio_dev);
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

