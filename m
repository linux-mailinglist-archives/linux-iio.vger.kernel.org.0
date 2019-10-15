Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C7D73B1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfJOKpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 06:45:39 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:23344
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbfJOKpj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 06:45:39 -0400
X-IronPort-AV: E=Sophos;i="5.67,299,1566856800"; 
   d="scan'208";a="322757829"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 12:45:06 +0200
Date:   Tue, 15 Oct 2019 12:45:06 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Dan Robertson <dan@dlrobertson.com>
cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>,
        kbuild-all@lists.01.org
Subject: Re: [PATCH v3 2/2] iio: (bma400) add driver for the BMA400 (fwd)
Message-ID: <alpine.DEB.2.21.1910151243270.2818@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

acc_config is unsigned, so it won't be negative (line 390).

julia

---------- Forwarded message ----------
Date: Mon, 14 Oct 2019 07:23:53 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3 2/2] iio: (bma400) add driver for the BMA400

Hi Dan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[cannot apply to v5.4-rc2 next-20191011]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dan-Robertson/iio-add-driver-for-Bosch-BMA400-accelerometer/20191014-035631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/iio/accel/bma400_core.c:390:6-16: WARNING: Unsigned expression compared with zero: acc_config < 0

# https://github.com/0day-ci/linux/commit/76b89222e99357a9fdbcfb61982e10d2fe74a409
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 76b89222e99357a9fdbcfb61982e10d2fe74a409
vim +390 drivers/iio/accel/bma400_core.c

76b89222e99357 Dan Robertson 2019-10-12  372
76b89222e99357 Dan Robertson 2019-10-12  373  static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
76b89222e99357 Dan Robertson 2019-10-12  374  					       int val)
76b89222e99357 Dan Robertson 2019-10-12  375  {
76b89222e99357 Dan Robertson 2019-10-12  376  	int ret;
76b89222e99357 Dan Robertson 2019-10-12  377  	unsigned int acc_config;
76b89222e99357 Dan Robertson 2019-10-12  378
76b89222e99357 Dan Robertson 2019-10-12  379  	if (val & ~BMA400_TWO_BITS_MASK)
76b89222e99357 Dan Robertson 2019-10-12  380  		return -EINVAL;
76b89222e99357 Dan Robertson 2019-10-12  381
76b89222e99357 Dan Robertson 2019-10-12  382  	/*
76b89222e99357 Dan Robertson 2019-10-12  383  	 * The oversampling ratio is stored in a different register
76b89222e99357 Dan Robertson 2019-10-12  384  	 * based on the power-mode.
76b89222e99357 Dan Robertson 2019-10-12  385  	 */
76b89222e99357 Dan Robertson 2019-10-12  386  	switch (data->power_mode) {
76b89222e99357 Dan Robertson 2019-10-12  387  	case POWER_MODE_LOW:
76b89222e99357 Dan Robertson 2019-10-12  388  		ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG,
76b89222e99357 Dan Robertson 2019-10-12  389  				  &acc_config);
76b89222e99357 Dan Robertson 2019-10-12 @390  		if (acc_config < 0)
76b89222e99357 Dan Robertson 2019-10-12  391  			return acc_config;
76b89222e99357 Dan Robertson 2019-10-12  392
76b89222e99357 Dan Robertson 2019-10-12  393  		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
76b89222e99357 Dan Robertson 2019-10-12  394  				   (acc_config & ~BMA400_LP_OSR_MASK) |
76b89222e99357 Dan Robertson 2019-10-12  395  				   (val << BMA400_LP_OSR_SHIFT));
76b89222e99357 Dan Robertson 2019-10-12  396  		if (ret < 0) {
76b89222e99357 Dan Robertson 2019-10-12  397  			dev_err(data->dev, "Failed to write out OSR");
76b89222e99357 Dan Robertson 2019-10-12  398  			return ret;
76b89222e99357 Dan Robertson 2019-10-12  399  		}
76b89222e99357 Dan Robertson 2019-10-12  400
76b89222e99357 Dan Robertson 2019-10-12  401  		data->oversampling_ratio = val;
76b89222e99357 Dan Robertson 2019-10-12  402  		return 0;
76b89222e99357 Dan Robertson 2019-10-12  403  	case POWER_MODE_NORMAL:
76b89222e99357 Dan Robertson 2019-10-12  404  		ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG,
76b89222e99357 Dan Robertson 2019-10-12  405  				  &acc_config);
76b89222e99357 Dan Robertson 2019-10-12  406  		if (ret < 0)
76b89222e99357 Dan Robertson 2019-10-12  407  			return ret;
76b89222e99357 Dan Robertson 2019-10-12  408
76b89222e99357 Dan Robertson 2019-10-12  409  		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
76b89222e99357 Dan Robertson 2019-10-12  410  				   (acc_config & ~BMA400_NP_OSR_MASK) |
76b89222e99357 Dan Robertson 2019-10-12  411  				   (val << BMA400_NP_OSR_SHIFT));
76b89222e99357 Dan Robertson 2019-10-12  412  		if (ret < 0) {
76b89222e99357 Dan Robertson 2019-10-12  413  			dev_err(data->dev, "Failed to write out OSR");
76b89222e99357 Dan Robertson 2019-10-12  414  			return ret;
76b89222e99357 Dan Robertson 2019-10-12  415  		}
76b89222e99357 Dan Robertson 2019-10-12  416
76b89222e99357 Dan Robertson 2019-10-12  417  		data->oversampling_ratio = val;
76b89222e99357 Dan Robertson 2019-10-12  418  		return 0;
76b89222e99357 Dan Robertson 2019-10-12  419  	default:
76b89222e99357 Dan Robertson 2019-10-12  420  		return -EINVAL;
76b89222e99357 Dan Robertson 2019-10-12  421  	}
76b89222e99357 Dan Robertson 2019-10-12  422  	return ret;
76b89222e99357 Dan Robertson 2019-10-12  423  }
76b89222e99357 Dan Robertson 2019-10-12  424

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
