Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72B44FD61
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhKODMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:12:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:2422 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235690AbhKODMO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 22:12:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220258390"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="gz'50?scan'50,208,50";a="220258390"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 19:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="gz'50?scan'50,208,50";a="453860471"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2021 19:09:12 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmSMp-000M1G-FG; Mon, 15 Nov 2021 03:09:11 +0000
Date:   Mon, 15 Nov 2021 11:08:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gilles Talis <gilles.talis@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        linux-iio@vger.kernel.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gilles Talis <gilles.talis@gmail.com>
Subject: Re: [PATCH 1/2] iio: humidity: Add support for Sensirion SHTC3 sensor
Message-ID: <202111151158.nlAtroXL-lkp@intel.com>
References: <20211114132335.47651-2-gilles.talis@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20211114132335.47651-2-gilles.talis@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gilles,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next v5.16-rc1 next-20211112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gilles-Talis/iio-humidity-add-support-for-Sensirion-SHTC3/20211114-212618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: s390-randconfig-s032-20211115 (attached as .config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/d4b528fcce840650354227c99ec7f6c0bdd076b0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gilles-Talis/iio-humidity-add-support-for-Sensirion-SHTC3/20211114-212618
        git checkout d4b528fcce840650354227c99ec7f6c0bdd076b0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/iio/humidity/shtc3.c:88:39: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [addressable] [usertype] cmd @@     got restricted __be16 @@
   drivers/iio/humidity/shtc3.c:88:39: sparse:     expected unsigned short [addressable] [usertype] cmd
   drivers/iio/humidity/shtc3.c:88:39: sparse:     got restricted __be16
>> drivers/iio/humidity/shtc3.c:88:56: sparse: sparse: Using plain integer as NULL pointer
   drivers/iio/humidity/shtc3.c:93:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [addressable] [usertype] cmd @@     got restricted __be16 @@
   drivers/iio/humidity/shtc3.c:93:36: sparse:     expected unsigned short [addressable] [usertype] cmd
   drivers/iio/humidity/shtc3.c:93:36: sparse:     got restricted __be16
   drivers/iio/humidity/shtc3.c:93:54: sparse: sparse: Using plain integer as NULL pointer
>> drivers/iio/humidity/shtc3.c:122:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] cmd @@     got restricted __be16 @@
   drivers/iio/humidity/shtc3.c:122:13: sparse:     expected unsigned short [usertype] cmd
   drivers/iio/humidity/shtc3.c:122:13: sparse:     got restricted __be16
   drivers/iio/humidity/shtc3.c:189:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [addressable] [usertype] cmd @@     got restricted __be16 @@
   drivers/iio/humidity/shtc3.c:189:38: sparse:     expected unsigned short [addressable] [usertype] cmd
   drivers/iio/humidity/shtc3.c:189:38: sparse:     got restricted __be16
   drivers/iio/humidity/shtc3.c:204:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [addressable] [usertype] cmd @@     got restricted __be16 @@
   drivers/iio/humidity/shtc3.c:204:38: sparse:     expected unsigned short [addressable] [usertype] cmd
   drivers/iio/humidity/shtc3.c:204:38: sparse:     got restricted __be16
   drivers/iio/humidity/shtc3.c:204:60: sparse: sparse: Using plain integer as NULL pointer

vim +88 drivers/iio/humidity/shtc3.c

    85	
    86	static int shtc3_sleep(struct i2c_client *client)
    87	{
  > 88		return shtc3_send_cmd(client, SHTC3_CMD_SLEEP, 0);
    89	}
    90	
    91	static int shtc3_wakeup(struct i2c_client *client)
    92	{
    93		if (shtc3_send_cmd(client, SHTC3_CMD_WAKEUP, 0) < 0)
    94			return -EIO;
    95	
    96		/* Wait for device to wake up */
    97		usleep_range(180, 240);
    98	
    99		return 0;
   100	}
   101	
   102	static int shtc3_read_channel(struct i2c_client *client, bool temp)
   103	{
   104		int ret;
   105		u16 cmd;
   106		u16 meas;
   107	
   108		ret = shtc3_wakeup(client);
   109		if (ret < 0)
   110			return ret;
   111	
   112		/*
   113		 * Sensor sends back measurement results after measurement command
   114		 * has been issued by the host.
   115		 * Sensor sends 3 bytes (2 bytes of data + 1 byte of CRC) for each
   116		 * channel sequentially
   117		 * The command issued by the host determines the channel for which
   118		 * the sensor will first send the data.
   119		 * We select the channel for which we need the results
   120		 * then only read back the 2 bytes corresponding to this channel.
   121		 */
 > 122		cmd = temp ? SHTC3_CMD_TEMP_MEAS_LP_CS : SHTC3_CMD_RH_MEAS_LP_CS;
   123		ret = shtc3_send_cmd(client, cmd, &meas);
   124		if (ret < 0)
   125			return ret;
   126	
   127		/* Go back to sleep */
   128		shtc3_sleep(client);
   129	
   130		return meas;
   131	}
   132	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--wac7ysb48OaltWcw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wac7ysb48OaltWcw--
