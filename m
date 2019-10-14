Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A24D676F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfJNQfz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 12:35:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:2300 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731960AbfJNQfy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Oct 2019 12:35:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 09:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="278916691"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2019 09:35:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iK3K3-000DCB-1R; Tue, 15 Oct 2019 00:35:51 +0800
Date:   Tue, 15 Oct 2019 00:35:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     kbuild-all@lists.01.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Subject: Re: [PATCH v2 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <201910150017.MkSBCEcB%lkp@intel.com>
References: <20191012035420.13904-3-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012035420.13904-3-dan@dlrobertson.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[cannot apply to v5.4-rc3 next-20191014]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dan-Robertson/dt-bindings-iio-accel-bma400-add-bindings/20191014-034052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

smatch warnings:
drivers/iio/accel/bma400_core.c:422 bma400_set_accel_oversampling_ratio() warn: unsigned 'acc_config' is never less than zero.

vim +/acc_config +422 drivers/iio/accel/bma400_core.c

   404	
   405	static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
   406						       int val)
   407	{
   408		int ret;
   409		unsigned int acc_config;
   410	
   411		if (val & ~BMA400_TWO_BITS_MASK)
   412			return -EINVAL;
   413	
   414		/*
   415		 * The oversampling ratio is stored in a different register
   416		 * based on the power-mode.
   417		 */
   418		switch (data->power_mode) {
   419		case POWER_MODE_LOW:
   420			ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG,
   421					  &acc_config);
 > 422			if (acc_config < 0)
   423				return acc_config;
   424	
   425			ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
   426					   (acc_config & ~BMA400_LP_OSR_MASK) |
   427					   (val << BMA400_LP_OSR_SHIFT));
   428			if (ret < 0) {
   429				dev_err(data->dev, "Failed to write out OSR");
   430				return ret;
   431			}
   432	
   433			data->oversampling_ratio = val;
   434			return 0;
   435		case POWER_MODE_NORMAL:
   436			ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG,
   437					  &acc_config);
   438			if (ret < 0)
   439				return ret;
   440	
   441			ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
   442					   (acc_config & ~BMA400_NP_OSR_MASK) |
   443					   (val << BMA400_NP_OSR_SHIFT));
   444			if (ret < 0) {
   445				dev_err(data->dev, "Failed to write out OSR");
   446				return ret;
   447			}
   448	
   449			data->oversampling_ratio = val;
   450			return 0;
   451		default:
   452			return -EINVAL;
   453		}
   454		return ret;
   455	}
   456	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
