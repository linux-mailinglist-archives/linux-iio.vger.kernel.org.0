Return-Path: <linux-iio+bounces-234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93297F32E5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1401F224EA
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2659143;
	Tue, 21 Nov 2023 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuDJBjya"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0A139;
	Tue, 21 Nov 2023 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700582271; x=1732118271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=49M9Oew0DdxgYWQvk9O06uOPIWnVNtnr8w/4okhcBTY=;
  b=CuDJBjya9CkGg6erbkfyV57hII6n/mvOZEHPXFsWUHQROO4XdSfqzhs8
   klqfFSLbLtXNLgMfyH2wnHP+buE6uH+vbd2zxEjx11r1hoo8EVCjLvE8Q
   SPZppDJDfNFY+guBac/YBLetwQiaJTbk8V9ZBq7KZ1jFWhT9iYVjwrVfV
   RSnAnWOGK5hXzcSKypuBXc0SFoUNN6Q7k1CYJT8VfgI9423H9sp/jNdaN
   h80Oxpu2Z73l/eL5xmLa6YwCbxA3/XIOG5jBmTAd0nCtG1/8Gbeo+o8ed
   cA+r7ncUEj9JkNxlpeExVMQi5sh/9Wt+n3gLsY7xjx6gf46aXzDjU69p1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382261970"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="382261970"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716576255"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="716576255"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2023 07:57:46 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5T8B-0007yk-2Q;
	Tue, 21 Nov 2023 15:57:43 +0000
Date: Tue, 21 Nov 2023 23:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	linux-hwmon@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marius.cristea@microchip.com
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC193x
Message-ID: <202311212310.QEKkmOfh-lkp@intel.com>
References: <20231115134453.6656-3-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115134453.6656-3-marius.cristea@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e99f692d4e32e3250ab18d511894ca797407aec]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC193X/20231115-214733
base:   5e99f692d4e32e3250ab18d511894ca797407aec
patch link:    https://lore.kernel.org/r/20231115134453.6656-3-marius.cristea%40microchip.com
patch subject: [PATCH v3 2/2] iio: adc: adding support for PAC193x
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231121/202311212310.QEKkmOfh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311212310.QEKkmOfh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311212310.QEKkmOfh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/pac1934.c:1239:3: warning: variable 'cnt' is incremented both in the loop header and in the loop body [-Wfor-loop-analysis]
    1239 |                 cnt++;
         |                 ^
   drivers/iio/adc/pac1934.c:1236:44: note: incremented here
    1236 |         for (cnt = 0;  cnt < info->phys_channels; cnt++) {
         |                                                   ^
   1 warning generated.


vim +/cnt +1239 drivers/iio/adc/pac1934.c

  1226	
  1227	static int pac1934_chip_configure(struct pac1934_chip_info *info)
  1228	{
  1229		int cnt, ret;
  1230		struct i2c_client *client = info->client;
  1231		u8 regs[PAC1934_CTRL_STATUS_INFO_LEN], idx, ctrl_reg;
  1232		u32 wait_time;
  1233	
  1234		cnt = 0;
  1235		info->chip_reg_data.num_enabled_channels = 0;
  1236		for (cnt = 0;  cnt < info->phys_channels; cnt++) {
  1237			if (info->active_channels[cnt])
  1238				info->chip_reg_data.num_enabled_channels++;
> 1239			cnt++;
  1240		}
  1241	
  1242		/*
  1243		 * read whatever information was gathered before the driver was loaded
  1244		 * establish which channels are enabled/disabled and then establish the
  1245		 * information retrieval mode (using SKIP or no).
  1246		 * Read the chip ID values
  1247		 */
  1248		ret = i2c_smbus_read_i2c_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
  1249						    sizeof(regs),
  1250						    (u8 *)regs);
  1251		if (ret < 0) {
  1252			dev_err_probe(&client->dev, ret,
  1253				      "%s - cannot read regs from 0x%02X\n",
  1254				      __func__, PAC1934_CTRL_STAT_REGS_ADDR);
  1255			return ret;
  1256		}
  1257	
  1258		/* write the CHANNEL_DIS and the NEG_PWR registers */
  1259		regs[PAC1934_CHANNEL_DIS_REG_OFF] =
  1260			FIELD_PREP(PAC1934_CHAN_DIS_CH1_OFF_MASK, !(info->active_channels[PAC1934_CH_1])) |
  1261			FIELD_PREP(PAC1934_CHAN_DIS_CH2_OFF_MASK, !(info->active_channels[PAC1934_CH_2])) |
  1262			FIELD_PREP(PAC1934_CHAN_DIS_CH3_OFF_MASK, !(info->active_channels[PAC1934_CH_3])) |
  1263			FIELD_PREP(PAC1934_CHAN_DIS_CH4_OFF_MASK, !(info->active_channels[PAC1934_CH_4])) |
  1264			FIELD_PREP(PAC1934_SMBUS_TIMEOUT_MASK, 0) |
  1265			FIELD_PREP(PAC1934_SMBUS_BYTECOUNT_MASK, 0) |
  1266			FIELD_PREP(PAC1934_SMBUS_NO_SKIP_MASK, 0);
  1267	
  1268		regs[PAC1934_NEG_PWR_REG_OFF] =
  1269			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDI_MASK, info->bi_dir[PAC1934_CH_1]) |
  1270			FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDI_MASK, info->bi_dir[PAC1934_CH_2]) |
  1271			FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDI_MASK, info->bi_dir[PAC1934_CH_3]) |
  1272			FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDI_MASK, info->bi_dir[PAC1934_CH_4]) |
  1273			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[PAC1934_CH_1]) |
  1274			FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDV_MASK, info->bi_dir[PAC1934_CH_2]) |
  1275			FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDV_MASK, info->bi_dir[PAC1934_CH_3]) |
  1276			FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDV_MASK, info->bi_dir[PAC1934_CH_4]);
  1277	
  1278		/* no SLOW triggered REFRESH, clear POR */
  1279		regs[PAC1934_SLOW_REG_OFF] = 0;
  1280	
  1281		ret =  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR, 3, (u8 *)regs);
  1282		if (ret)
  1283			return ret;
  1284	
  1285		ctrl_reg = FIELD_PREP(PAC1934_CRTL_SAMPLE_RATE_MASK, info->crt_samp_spd_bitfield);
  1286	
  1287		ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_REG_ADDR, ctrl_reg);
  1288		if (ret)
  1289			return ret;
  1290	
  1291		/*
  1292		 * send a REFRESH to the chip, so the new settings take place
  1293		 * as well as resetting the accumulators
  1294		 */
  1295		ret = i2c_smbus_write_byte(client, PAC1934_REFRESH_REG_ADDR);
  1296		if (ret) {
  1297			dev_err(&client->dev,
  1298				"%s - cannot send 0x%02X\n",
  1299				__func__, PAC1934_REFRESH_REG_ADDR);
  1300			return ret;
  1301		}
  1302	
  1303		/*
  1304		 * get the current(in the chip) sampling speed and compute the
  1305		 * required timeout based on its value
  1306		 * the timeout is 1/sampling_speed
  1307		 */
  1308		idx = regs[PAC1934_CTRL_ACT_REG_OFF] >> PAC1934_SAMPLE_RATE_SHIFT;
  1309		wait_time = (1024 / samp_rate_map_tbl[idx]) * 1000;
  1310	
  1311		/*
  1312		 * wait the maximum amount of time to be on the safe side
  1313		 * the maximum wait time is for 8sps
  1314		 */
  1315		usleep_range(wait_time, wait_time + 100);
  1316	
  1317		INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1934_work_periodic_rfsh);
  1318		/* Setup the latest moment for reading the regs before saturation */
  1319		schedule_delayed_work(&info->work_chip_rfsh,
  1320				      msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
  1321	
  1322		devm_add_action_or_reset(&client->dev, pac1934_cancel_delayed_work,
  1323					 &info->work_chip_rfsh);
  1324	
  1325		return 0;
  1326	}
  1327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

