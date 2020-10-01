Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484A3280A69
	for <lists+linux-iio@lfdr.de>; Fri,  2 Oct 2020 00:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgJAWqy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Oct 2020 18:46:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:20806 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWqy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Oct 2020 18:46:54 -0400
IronPort-SDR: 5x8oWPZPya87PJgaT0h5QPC7kWQaI+aQS3Lj9jCGPbsVwknoSmISiq68rLf9OhD7NpmiAMEVZ0
 BX8ETuZHfmjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="150651619"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="gz'50?scan'50,208,50";a="150651619"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 15:46:51 -0700
IronPort-SDR: ARVSkE9zJfvs0iUCuvrqWpdZIhbP3DNeWDuJaCxIVD22WnIG22bZWBS2Yi4h8wj9CIcwaakv0U
 O4xXtXx8551Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="gz'50?scan'50,208,50";a="295151115"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2020 15:46:49 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO7Lc-0000mQ-Ge; Thu, 01 Oct 2020 22:46:48 +0000
Date:   Fri, 2 Oct 2020 06:46:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     kbuild-all@lists.01.org, jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] iio: adc: ad7887: invert/rework external ref logic
Message-ID: <202010020651.AJIzQmxM-lkp@intel.com>
References: <20201001141143.925-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20201001141143.925-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexandru,

I love your patch! Yet something to improve:

[auto build test ERROR on iio/togreg]
[also build test ERROR on linux/master linus/master v5.9-rc7 next-20201001]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alexandru-Ardelean/iio-adc-ad7887-invert-rework-external-ref-logic/20201001-220829
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: c6x-randconfig-r034-20200930 (attached as .config)
compiler: c6x-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/98dbf5fa747aac2e245826d8c6cd34b087aeaa27
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alexandru-Ardelean/iio-adc-ad7887-invert-rework-external-ref-logic/20201001-220829
        git checkout 98dbf5fa747aac2e245826d8c6cd34b087aeaa27
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=c6x 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad7887.c: In function 'ad7887_probe':
>> drivers/iio/adc/ad7887.c:276:22: error: 'struct ad7887_platform_data' has no member named 'use_onchip_ref'
     276 |  if (!pdata || !pdata->use_onchip_ref)
         |                      ^~

vim +276 drivers/iio/adc/ad7887.c

6fe8135fccd66ae drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-05-18  234  
fc52692c49969ec drivers/iio/adc/ad7887.c              Greg Kroah-Hartman 2012-12-21  235  static int ad7887_probe(struct spi_device *spi)
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  236  {
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  237  	struct ad7887_platform_data *pdata = spi->dev.platform_data;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  238  	struct ad7887_state *st;
82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  239  	struct iio_dev *indio_dev;
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  240  	uint8_t mode;
bf5d2613c9083b8 drivers/staging/iio/adc/ad7887_core.c Lars-Peter Clausen 2012-11-05  241  	int ret;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  242  
82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  243  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  244  	if (indio_dev == NULL)
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  245  		return -ENOMEM;
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  246  
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  247  	st = iio_priv(indio_dev);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  248  
98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  249  	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  250  	if (IS_ERR(st->reg)) {
98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  251  		if (PTR_ERR(st->reg) != -ENODEV)
82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  252  			return PTR_ERR(st->reg);
bf5d2613c9083b8 drivers/staging/iio/adc/ad7887_core.c Lars-Peter Clausen 2012-11-05  253  
98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  254  		st->reg = NULL;
98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  255  	}
98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  256  
98dbf5fa747aac2 drivers/iio/adc/ad7887.c              Alexandru Ardelean 2020-10-01  257  	if (st->reg) {
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  258  		ret = regulator_enable(st->reg);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  259  		if (ret)
82429e0d33ece55 drivers/iio/adc/ad7887.c              Sachin Kamat       2013-07-23  260  			return ret;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  261  	}
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  262  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  263  	st->chip_info =
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  264  		&ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data];
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  265  
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  266  	spi_set_drvdata(spi, indio_dev);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  267  	st->spi = spi;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  268  
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  269  	indio_dev->name = spi_get_device_id(spi)->name;
6fe8135fccd66ae drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-05-18  270  	indio_dev->info = &ad7887_info;
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  271  	indio_dev->modes = INDIO_DIRECT_MODE;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  272  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  273  	/* Setup default message */
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  274  
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  275  	mode = AD7887_PM_MODE4;
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05 @276  	if (!pdata || !pdata->use_onchip_ref)
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  277  		mode |= AD7887_REF_DIS;
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  278  	if (pdata && pdata->en_dual)
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  279  		mode |= AD7887_DUAL;
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  280  
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  281  	st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  282  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  283  	st->xfer[0].rx_buf = &st->data[0];
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  284  	st->xfer[0].tx_buf = &st->tx_cmd_buf[0];
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  285  	st->xfer[0].len = 2;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  286  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  287  	spi_message_init(&st->msg[AD7887_CH0]);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  288  	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  289  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  290  	if (pdata && pdata->en_dual) {
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  291  		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  292  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  293  		st->xfer[1].rx_buf = &st->data[0];
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  294  		st->xfer[1].tx_buf = &st->tx_cmd_buf[2];
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  295  		st->xfer[1].len = 2;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  296  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  297  		st->xfer[2].rx_buf = &st->data[2];
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  298  		st->xfer[2].tx_buf = &st->tx_cmd_buf[0];
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  299  		st->xfer[2].len = 2;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  300  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  301  		spi_message_init(&st->msg[AD7887_CH0_CH1]);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  302  		spi_message_add_tail(&st->xfer[1], &st->msg[AD7887_CH0_CH1]);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  303  		spi_message_add_tail(&st->xfer[2], &st->msg[AD7887_CH0_CH1]);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  304  
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  305  		st->xfer[3].rx_buf = &st->data[2];
fce7c3eac7d4ca7 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  306  		st->xfer[3].tx_buf = &st->tx_cmd_buf[2];
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  307  		st->xfer[3].len = 2;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  308  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  309  		spi_message_init(&st->msg[AD7887_CH1]);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  310  		spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  311  
b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  312  		indio_dev->channels = st->chip_info->dual_channels;
b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  313  		indio_dev->num_channels = st->chip_info->num_dual_channels;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  314  	} else {
b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  315  		indio_dev->channels = st->chip_info->channels;
b0ec7a44393e0d7 drivers/iio/adc/ad7887.c              Beniamin Bia       2019-11-25  316  		indio_dev->num_channels = st->chip_info->num_channels;
596d06097f7843e drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  317  	}
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  318  
65dd3d3d7a9bca6 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  319  	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
65dd3d3d7a9bca6 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  320  			&ad7887_trigger_handler, &ad7887_ring_setup_ops);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  321  	if (ret)
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  322  		goto error_disable_reg;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  323  
26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  324  	ret = iio_device_register(indio_dev);
26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  325  	if (ret)
26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  326  		goto error_unregister_ring;
26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  327  
26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  328  	return 0;
26d25ae3f0d8ffe drivers/staging/iio/adc/ad7887_core.c Jonathan Cameron   2011-09-02  329  error_unregister_ring:
65dd3d3d7a9bca6 drivers/staging/iio/adc/ad7887.c      Lars-Peter Clausen 2012-11-05  330  	iio_triggered_buffer_cleanup(indio_dev);
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  331  error_disable_reg:
bf5d2613c9083b8 drivers/staging/iio/adc/ad7887_core.c Lars-Peter Clausen 2012-11-05  332  	if (st->reg)
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  333  		regulator_disable(st->reg);
f39e086adcbdb95 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2011-05-18  334  
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  335  	return ret;
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  336  }
2b4756aa36909a9 drivers/staging/iio/adc/ad7887_core.c Michael Hennerich  2010-11-22  337  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sSoAY+suk5u24+6rTh//BwQ6VIMsWwEA

--HlL+5n6rz5pIUxbD--
