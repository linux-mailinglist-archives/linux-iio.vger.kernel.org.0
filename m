Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1643FCD1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Oct 2021 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhJ2NCc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Oct 2021 09:02:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:20509 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbhJ2NCa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Oct 2021 09:02:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230610292"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="gz'50?scan'50,208,50";a="230610292"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 06:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="gz'50?scan'50,208,50";a="665821229"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2021 05:59:58 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgRUD-0000Kc-Hv; Fri, 29 Oct 2021 12:59:57 +0000
Date:   Fri, 29 Oct 2021 20:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com
Subject: Re: [v2 09/10] iio: imu: add BNO055 serdev driver
Message-ID: <202110292058.uRrG4q1i-lkp@intel.com>
References: <20211028101840.24632-10-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20211028101840.24632-10-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.15-rc7]
[cannot apply to jic23-iio/togreg next-20211029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andrea-Merello/utils_macro-introduce-find_closest_unsorted/20211028-191851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2f111a6fd5b5297b4e92f53798ca086f7c7d33a4
config: m68k-randconfig-r011-20211029 (attached as .config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/185166ebe83b933e30af55d4dc7972db6f9a8fb8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andrea-Merello/utils_macro-introduce-find_closest_unsorted/20211028-191851
        git checkout 185166ebe83b933e30af55d4dc7972db6f9a8fb8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/bno055/bno055.c:234:5: warning: no previous prototype for 'bno055_calibration_load' [-Wmissing-prototypes]
     234 | int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/bno055/bno055.c: In function 'bno055_fusion_enable_store':
>> drivers/iio/imu/bno055/bno055.c:917:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     917 |         int ret = 0;
         |             ^~~
   drivers/iio/imu/bno055/bno055.c: At top level:
>> drivers/iio/imu/bno055/bno055.c:1188:5: warning: no previous prototype for 'bno055_debugfs_reg_access' [-Wmissing-prototypes]
    1188 | int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/bno055/bno055.c: In function 'bno055_trigger_handler':
   drivers/iio/imu/bno055/bno055.c:1330:9: error: implicit declaration of function 'for_each_set_bitrange'; did you mean 'for_each_set_bit'? [-Werror=implicit-function-declaration]
    1330 |         for_each_set_bitrange(start, end, iio_dev->active_scan_mask,
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         for_each_set_bit
   drivers/iio/imu/bno055/bno055.c:1331:51: error: expected ';' before '{' token
    1331 |                               iio_dev->masklength) {
         |                                                   ^~
         |                                                   ;
   drivers/iio/imu/bno055/bno055.c:1364:1: warning: label 'done' defined but not used [-Wunused-label]
    1364 | done:
         | ^~~~
   drivers/iio/imu/bno055/bno055.c:1327:13: warning: unused variable 'ret' [-Wunused-variable]
    1327 |         int ret;
         |             ^~~
   drivers/iio/imu/bno055/bno055.c:1326:13: warning: unused variable 'quat' [-Wunused-variable]
    1326 |         int quat;
         |             ^~~~
   drivers/iio/imu/bno055/bno055.c:1325:14: warning: unused variable 'thr_hit' [-Wunused-variable]
    1325 |         bool thr_hit;
         |              ^~~~~~~
   drivers/iio/imu/bno055/bno055.c:1324:13: warning: unused variable 'buf_idx' [-Wunused-variable]
    1324 |         int buf_idx = 0;
         |             ^~~~~~~
   drivers/iio/imu/bno055/bno055.c:1323:23: warning: unused variable 'mask' [-Wunused-variable]
    1323 |         unsigned long mask;
         |                       ^~~~
   drivers/iio/imu/bno055/bno055.c:1322:14: warning: unused variable 'first' [-Wunused-variable]
    1322 |         bool first = true;
         |              ^~~~~
   drivers/iio/imu/bno055/bno055.c:1321:14: warning: unused variable 'xfer_pending' [-Wunused-variable]
    1321 |         bool xfer_pending = false;
         |              ^~~~~~~~~~~~
   drivers/iio/imu/bno055/bno055.c:1320:37: warning: unused variable 'prev_end' [-Wunused-variable]
    1320 |         int xfer_start, start, end, prev_end;
         |                                     ^~~~~~~~
   drivers/iio/imu/bno055/bno055.c:1320:13: warning: unused variable 'xfer_start' [-Wunused-variable]
    1320 |         int xfer_start, start, end, prev_end;
         |             ^~~~~~~~~~
   At top level:
   drivers/iio/imu/bno055/bno055.c:1262:12: warning: 'bno055_scan_xfer' defined but not used [-Wunused-function]
    1262 | static int bno055_scan_xfer(struct bno055_priv *priv,
         |            ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/bno055_calibration_load +234 drivers/iio/imu/bno055/bno055.c

734efd9783b7759 Andrea Merello 2021-10-28  232  
734efd9783b7759 Andrea Merello 2021-10-28  233  /* must be called in configuration mode */
734efd9783b7759 Andrea Merello 2021-10-28 @234  int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
734efd9783b7759 Andrea Merello 2021-10-28  235  {
734efd9783b7759 Andrea Merello 2021-10-28  236  	if (fw->size != BNO055_CALDATA_LEN) {
734efd9783b7759 Andrea Merello 2021-10-28  237  		dev_dbg(priv->dev, "Invalid calibration file size %d (expected %d)",
734efd9783b7759 Andrea Merello 2021-10-28  238  			fw->size, BNO055_CALDATA_LEN);
734efd9783b7759 Andrea Merello 2021-10-28  239  		return -EINVAL;
734efd9783b7759 Andrea Merello 2021-10-28  240  	}
734efd9783b7759 Andrea Merello 2021-10-28  241  
734efd9783b7759 Andrea Merello 2021-10-28  242  	dev_dbg(priv->dev, "loading cal data: %*ph", BNO055_CALDATA_LEN, fw->data);
734efd9783b7759 Andrea Merello 2021-10-28  243  	return regmap_bulk_write(priv->regmap, BNO055_CALDATA_START,
734efd9783b7759 Andrea Merello 2021-10-28  244  				fw->data, BNO055_CALDATA_LEN);
734efd9783b7759 Andrea Merello 2021-10-28  245  }
734efd9783b7759 Andrea Merello 2021-10-28  246  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OvLI2P/+D+xOfE+cvwEA

--J2SCkAp4GZ/dPZZf--
