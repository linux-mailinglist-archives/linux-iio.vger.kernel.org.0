Return-Path: <linux-iio+bounces-7718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF693805C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728461C20935
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4007D41D;
	Sat, 20 Jul 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuzQq9Sm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23E55C08;
	Sat, 20 Jul 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467814; cv=none; b=S4DlQ1UqAolL2CUd5655tEzv2J1oyfQckGXusLl1Bd1Ktmb8i9ep419D6GiY1xz//xwQB7bXhhEw/Mkl6ckTnRsOzjlIfyQ2Vmzt2/Z0/PYznXJrS1VO/1hN9AImdeXMrgNnIOxheq//9G35vZgBtvy/kOzx7B7+NZxGFRxnvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467814; c=relaxed/simple;
	bh=a3rPb2yeYm6YZfZtQomB5Xpvt38n+mcAWaElo0/Q6Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLqiy8HBdLQ3rIyjkXabZMlMW5hE1AlYWMRtfaczBHZSQgkDzoNFmgfVqJBkOFgaMcslqR/cXtGj1A+WXe+vOL2kFTY2vLMnfp98CNjdKP+MwlLyKGE0gesAG68CzLFy9PEReePbXDCjdBDElVbqlsPKt4QCETuYhLXzMrHgx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuzQq9Sm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721467813; x=1753003813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a3rPb2yeYm6YZfZtQomB5Xpvt38n+mcAWaElo0/Q6Zo=;
  b=IuzQq9SmP5eH1cFqTPBTCNUWHWv/IYaXEWpIw/B0RI2HeE14QOspVdqI
   epEi57MB2IFYxUbtnVTm4PY4/dtNfznI6mJbUYsdzXasFKyRPPxZUL7Gb
   T03RAhHvKqIvN2aUeB7qtZym8ogt7nQHjGnKA/IrR+JfwfY+YvGkTByvy
   E6mcHfTpSRWnCb4+xPZlNezxlmvZ+4OR1YOBtEAU7NH5AQKMlKlHBjQIe
   HFZ45COMpnEDXNUe/q6WbD5kSu4BwIx1J2JYRhGuiOLJku7QOQkU1FAy/
   fdieUnmRjafGhv+Wvw14CUyoV5JNESbMX8PN3dMUxQ2RfEgtbA3ddL/a/
   Q==;
X-CSE-ConnectionGUID: JD8RxLOWSiqG9wwabzh+wA==
X-CSE-MsgGUID: Ad0ikuZwT0mUjnYPDrlRLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="29753361"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="29753361"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 02:30:12 -0700
X-CSE-ConnectionGUID: vXA0l/36Q7u9Lgc6VR1cww==
X-CSE-MsgGUID: d0EPUdaMRmGEdBFg+843JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="51380593"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Jul 2024 02:30:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sV6Pj-000j4Q-1m;
	Sat, 20 Jul 2024 09:30:03 +0000
Date: Sat, 20 Jul 2024 17:29:59 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: humidity: Add support for ENS210
Message-ID: <202407201729.dZc0rJ8y-lkp@intel.com>
References: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>

Hi Joshua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1ebab783647a9e3bf357002d5c4ff060c8474a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Felmeden/dt-bindings-iio-humidity-add-ENS210-sensor-family/20240719-210648
base:   1ebab783647a9e3bf357002d5c4ff060c8474a0a
patch link:    https://lore.kernel.org/r/20240719-ens21x-v4-2-6044e48a376a%40thegoodpenguin.co.uk
patch subject: [PATCH v4 2/2] iio: humidity: Add support for ENS210
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240720/202407201729.dZc0rJ8y-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407201729.dZc0rJ8y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407201729.dZc0rJ8y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from include/linux/i2c.h:13,
                    from drivers/iio/humidity/ens210.c:19:
   drivers/iio/humidity/ens210.c: In function 'ens210_probe':
>> drivers/iio/humidity/ens210.c:251:25: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
     251 |                         "Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:160:58: note: in expansion of macro 'dev_fmt'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/iio/humidity/ens210.c:250:17: note: in expansion of macro 'dev_info'
     250 |                 dev_info(&client->dev,
         |                 ^~~~~~~~
   drivers/iio/humidity/ens210.c:251:66: note: format string is defined here
     251 |                         "Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
         |                                                              ~~~~^
         |                                                                  |
         |                                                                  long unsigned int
         |                                                              %04x
>> drivers/iio/humidity/ens210.c:200:37: warning: unused variable 'id' [-Wunused-variable]
     200 |         const struct i2c_device_id *id = i2c_client_get_device_id(client);
         |                                     ^~
--
>> drivers/iio/humidity/ens210.c:83: warning: Function parameter or struct member 'chip_info' not described in 'ens210_data'
>> drivers/iio/humidity/ens210.c:83: warning: Excess struct member 'res_index' description in 'ens210_data'


vim +251 drivers/iio/humidity/ens210.c

    72	
    73	/**
    74	 * struct ens210_data - Humidity/Temperature sensor device structure
    75	 * @client:	i2c client
    76	 * @lock:	lock protecting the i2c conversion
    77	 * @res_index:	index to selected sensor resolution
    78	 */
    79	struct ens210_data {
    80		struct i2c_client *client;
    81		const struct ens210_chip_info *chip_info;
    82		struct mutex lock;
  > 83	};
    84	
    85	/* calculate 17-bit crc7 */
    86	static u8 ens210_crc7(u32 val)
    87	{
    88		__be32 val_be = (cpu_to_be32(val & 0x1ffff) >> 0x8);
    89	
    90		return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
    91	}
    92	
    93	static int ens210_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
    94	{
    95		u32 regval;
    96		u8 regval_le[3];
    97		int ret;
    98		struct ens210_data *data = iio_priv(indio_dev);
    99	
   100		/* assert read */
   101		ret = i2c_smbus_write_byte_data(data->client, ENS210_REG_SENS_START,
   102					  temp ? ENS210_SENS_START_T_START :
   103						 ENS210_SENS_START_H_START);
   104		if (ret)
   105			return ret;
   106	
   107		/* wait for conversion to be ready */
   108		msleep(data->chip_info->conv_time_msec);
   109	
   110		ret = i2c_smbus_read_byte_data(data->client,
   111					       ENS210_REG_SENS_STAT);
   112		if (ret < 0)
   113			return ret;
   114	
   115		/* perform read */
   116		ret = i2c_smbus_read_i2c_block_data(
   117			data->client, temp ? ENS210_REG_T_VAL : ENS210_REG_H_VAL, 3,
   118			(u8 *)&regval_le);
   119		if (ret < 0) {
   120			dev_err(&data->client->dev, "failed to read register");
   121			return -EIO;
   122		} else if (ret != 3) {
   123			dev_err(&indio_dev->dev, "expected 3 bytes, received %d\n", ret);
   124			return -EIO;
   125		}
   126	
   127		regval = get_unaligned_le24(regval_le);
   128		if (ens210_crc7(regval) != ((regval >> 17) & 0x7f)) {
   129			/* crc fail */
   130			dev_err(&indio_dev->dev, "ens invalid crc\n");
   131			return -EIO;
   132		}
   133	
   134		*val = regval & 0xffff;
   135		return IIO_VAL_INT;
   136	}
   137	
   138	static int ens210_read_raw(struct iio_dev *indio_dev,
   139				   struct iio_chan_spec const *channel, int *val,
   140				   int *val2, long mask)
   141	{
   142		struct ens210_data *data = iio_priv(indio_dev);
   143		int ret = -EINVAL;
   144	
   145		switch (mask) {
   146		case IIO_CHAN_INFO_RAW:
   147			scoped_guard(mutex, &data->lock) {
   148				ret = ens210_get_measurement(
   149					indio_dev, channel->type == IIO_TEMP, val);
   150				if (ret)
   151					return ret;
   152				return IIO_VAL_INT;
   153			}
   154			return ret;
   155		case IIO_CHAN_INFO_SCALE:
   156			if (channel->type == IIO_TEMP) {
   157				*val = 15;
   158				*val2 = 625000;
   159			} else {
   160				*val = 1;
   161				*val2 = 953125;
   162			}
   163			return IIO_VAL_INT_PLUS_MICRO;
   164		case IIO_CHAN_INFO_OFFSET:
   165			if (channel->type == IIO_TEMP) {
   166				*val = -17481;
   167				*val2 = 600000;
   168				ret = IIO_VAL_INT_PLUS_MICRO;
   169				break;
   170			}
   171			*val = 0;
   172			return IIO_VAL_INT;
   173		default:
   174			return -EINVAL;
   175		}
   176		return ret;
   177	}
   178	
   179	static const struct iio_chan_spec ens210_channels[] = {
   180		{
   181			.type = IIO_TEMP,
   182			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
   183					      BIT(IIO_CHAN_INFO_SCALE) |
   184					      BIT(IIO_CHAN_INFO_OFFSET),
   185		},
   186		{
   187			.type = IIO_HUMIDITYRELATIVE,
   188			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
   189					      BIT(IIO_CHAN_INFO_SCALE) |
   190					      BIT(IIO_CHAN_INFO_OFFSET),
   191		}
   192	};
   193	
   194	static const struct iio_info ens210_info = {
   195		.read_raw = ens210_read_raw,
   196	};
   197	
   198	static int ens210_probe(struct i2c_client *client)
   199	{
 > 200		const struct i2c_device_id *id = i2c_client_get_device_id(client);
   201		struct ens210_data *data;
   202		struct iio_dev *indio_dev;
   203		uint16_t part_id;
   204		int ret;
   205	
   206		if (!i2c_check_functionality(client->adapter,
   207				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
   208				I2C_FUNC_SMBUS_WRITE_BYTE |
   209				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
   210			dev_err_probe(&client->dev, -EOPNOTSUPP,
   211				"adapter does not support some i2c transactions\n");
   212			return -EOPNOTSUPP;
   213		}
   214	
   215		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
   216		if (!indio_dev)
   217			return -ENOMEM;
   218	
   219		data = iio_priv(indio_dev);
   220		i2c_set_clientdata(client, indio_dev);
   221		data->client = client;
   222		mutex_init(&data->lock);
   223		data->chip_info = i2c_get_match_data(client);
   224	
   225		ret = devm_regulator_get_enable(&client->dev, "vdd");
   226		if (ret)
   227			return ret;
   228	
   229		/* reset device */
   230		ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
   231						ENS210_SYS_CTRL_SYS_RESET);
   232		if (ret)
   233			return ret;
   234	
   235		/* wait for device to become active */
   236		usleep_range(4000, 5000);
   237	
   238		/* disable low power mode */
   239		ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL, 0x00);
   240		if (ret)
   241			return ret;
   242	
   243		/* wait for device to finish */
   244		usleep_range(4000, 5000);
   245	
   246		/* get part_id */
   247		part_id = i2c_smbus_read_word_data(client, ENS210_REG_PART_ID);
   248	
   249		if (part_id != data->chip_info->part_id) {
 > 250			dev_info(&client->dev,
 > 251				"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
   252				data->chip_info->part_id);
   253		}
   254	
   255		/* reenable low power */
   256		ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
   257						ENS210_SYS_CTRL_LOW_POWER_ENABLE);
   258		if (ret)
   259			return ret;
   260	
   261		indio_dev->name = data->chip_info->name;
   262		indio_dev->modes = INDIO_DIRECT_MODE;
   263		indio_dev->channels = ens210_channels;
   264		indio_dev->num_channels = ARRAY_SIZE(ens210_channels);
   265		indio_dev->info = &ens210_info;
   266	
   267		return devm_iio_device_register(&client->dev, indio_dev);
   268	}
   269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

