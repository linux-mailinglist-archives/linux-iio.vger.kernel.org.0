Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD23F749D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbhHYLyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 07:54:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:12875 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240462AbhHYLyJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Aug 2021 07:54:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204639990"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="gz'50?scan'50,208,50";a="204639990"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 04:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="gz'50?scan'50,208,50";a="684495227"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2021 04:53:19 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIrT4-000078-Q2; Wed, 25 Aug 2021 11:53:18 +0000
Date:   Wed, 25 Aug 2021 19:52:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, p.zabel@pengutronix.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux-iio@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [RESEND v4 08/15] iio: adc: aspeed: Use model_data to set clk
 scaler.
Message-ID: <202108251932.q9vYzEYY-lkp@intel.com>
References: <202108250004.17P04ZJi095039@twspam01.aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <202108250004.17P04ZJi095039@twspam01.aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Billy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v5.14-rc7 next-20210824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Billy-Tsai/Add-support-for-ast2600-ADC/20210825-082858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: alpha-randconfig-r026-20210825 (attached as .config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/78a7c95363794cdf2453244b7e64b432d29d17f3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Billy-Tsai/Add-support-for-ast2600-ADC/20210825-082858
        git checkout 78a7c95363794cdf2453244b7e64b432d29d17f3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/adc/aspeed_adc.c: In function 'aspeed_adc_probe':
>> drivers/iio/adc/aspeed_adc.c:225:9: warning: argument 3 null where non-null expected [-Wnonnull]
     225 |         snprintf(clk_parent_name, 32, of_clk_get_parent_name(pdev->dev.of_node, 0));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/clk.h:13,
                    from drivers/iio/adc/aspeed_adc.c:9:
   include/linux/kernel.h:204:5: note: in a call to function 'snprintf' declared 'nonnull'
     204 | int snprintf(char *buf, size_t size, const char *fmt, ...);
         |     ^~~~~~~~


vim +225 drivers/iio/adc/aspeed_adc.c

   200	
   201	static int aspeed_adc_probe(struct platform_device *pdev)
   202	{
   203		struct iio_dev *indio_dev;
   204		struct aspeed_adc_data *data;
   205		int ret;
   206		u32 adc_engine_control_reg_val;
   207		unsigned long scaler_flags = 0;
   208		char clk_name[32], clk_parent_name[32];
   209	
   210		indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
   211		if (!indio_dev)
   212			return -ENOMEM;
   213	
   214		data = iio_priv(indio_dev);
   215		data->dev = &pdev->dev;
   216		data->model_data = of_device_get_match_data(&pdev->dev);
   217		platform_set_drvdata(pdev, indio_dev);
   218	
   219		data->base = devm_platform_ioremap_resource(pdev, 0);
   220		if (IS_ERR(data->base))
   221			return PTR_ERR(data->base);
   222	
   223		/* Register ADC clock prescaler with source specified by device tree. */
   224		spin_lock_init(&data->clk_lock);
 > 225		snprintf(clk_parent_name, 32, of_clk_get_parent_name(pdev->dev.of_node, 0));
   226		if (data->model_data->need_prescaler) {
   227			snprintf(clk_name, 32, "%s-prescaler",
   228				 data->model_data->model_name);
   229			data->clk_prescaler = clk_hw_register_divider(
   230				&pdev->dev, clk_name, clk_parent_name, 0,
   231				data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15, 0,
   232				&data->clk_lock);
   233			if (IS_ERR(data->clk_prescaler))
   234				return PTR_ERR(data->clk_prescaler);
   235			snprintf(clk_parent_name, 32, clk_name);
   236			scaler_flags = CLK_SET_RATE_PARENT;
   237		}
   238		/*
   239		 * Register ADC clock scaler downstream from the prescaler. Allow rate
   240		 * setting to adjust the prescaler as well.
   241		 */
   242		snprintf(clk_name, 32, "%s-scaler", data->model_data->model_name);
   243		data->clk_scaler = clk_hw_register_divider(
   244			&pdev->dev, clk_name, clk_parent_name, scaler_flags,
   245			data->base + ASPEED_REG_CLOCK_CONTROL, 0,
   246			data->model_data->scaler_bit_width, 0, &data->clk_lock);
   247		if (IS_ERR(data->clk_scaler)) {
   248			ret = PTR_ERR(data->clk_scaler);
   249			goto scaler_error;
   250		}
   251	
   252		data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
   253		if (IS_ERR(data->rst)) {
   254			dev_err(&pdev->dev,
   255				"invalid or missing reset controller device tree entry");
   256			ret = PTR_ERR(data->rst);
   257			goto reset_error;
   258		}
   259		reset_control_deassert(data->rst);
   260	
   261		ret = aspeed_adc_vref_config(indio_dev);
   262		if (ret)
   263			goto vref_config_error;
   264	
   265		if (data->model_data->wait_init_sequence) {
   266			/* Enable engine in normal mode. */
   267			writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
   268					  ASPEED_ADC_OP_MODE_NORMAL) |
   269				       ASPEED_ADC_ENGINE_ENABLE,
   270			       data->base + ASPEED_REG_ENGINE_CONTROL);
   271	
   272			/* Wait for initial sequence complete. */
   273			ret = readl_poll_timeout(data->base + ASPEED_REG_ENGINE_CONTROL,
   274						 adc_engine_control_reg_val,
   275						 adc_engine_control_reg_val &
   276						 ASPEED_ADC_CTRL_INIT_RDY,
   277						 ASPEED_ADC_INIT_POLLING_TIME,
   278						 ASPEED_ADC_INIT_TIMEOUT);
   279			if (ret)
   280				goto poll_timeout_error;
   281		}
   282	
   283		/* Start all channels in normal mode. */
   284		ret = clk_prepare_enable(data->clk_scaler->clk);
   285		if (ret)
   286			goto clk_enable_error;
   287	
   288		adc_engine_control_reg_val =
   289			ASPEED_ADC_CTRL_CHANNEL |
   290			FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_NORMAL) |
   291			ASPEED_ADC_ENGINE_ENABLE;
   292		writel(adc_engine_control_reg_val,
   293		       data->base + ASPEED_REG_ENGINE_CONTROL);
   294	
   295		indio_dev->name = data->model_data->model_name;
   296		indio_dev->info = &aspeed_adc_iio_info;
   297		indio_dev->modes = INDIO_DIRECT_MODE;
   298		indio_dev->channels = aspeed_adc_iio_channels;
   299		indio_dev->num_channels = data->model_data->num_channels;
   300	
   301		ret = iio_device_register(indio_dev);
   302		if (ret)
   303			goto iio_register_error;
   304	
   305		return 0;
   306	
   307	iio_register_error:
   308		writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
   309		       data->base + ASPEED_REG_ENGINE_CONTROL);
   310		clk_disable_unprepare(data->clk_scaler->clk);
   311	clk_enable_error:
   312	poll_timeout_error:
   313	vref_config_error:
   314		reset_control_assert(data->rst);
   315	reset_error:
   316		clk_hw_unregister_divider(data->clk_scaler);
   317	scaler_error:
   318		if (data->model_data->need_prescaler)
   319			clk_hw_unregister_divider(data->clk_prescaler);
   320		return ret;
   321	}
   322	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4s7p2LtH+B9WGPoQ5bYBAA==

--82I3+IH0IqGh5yIs--
