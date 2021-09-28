Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8541BA70
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbhI1WeX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 18:34:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:10817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242929AbhI1WeW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Sep 2021 18:34:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="204306810"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="gz'50?scan'50,208,50";a="204306810"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 15:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="gz'50?scan'50,208,50";a="554368063"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2021 15:32:32 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVLeK-0001Zw-Ac; Tue, 28 Sep 2021 22:32:32 +0000
Date:   Wed, 29 Sep 2021 06:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     kbuild-all@lists.01.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 36/48] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
Message-ID: <202109290654.q78br8Dx-lkp@intel.com>
References: <20210928133143.157329-37-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20210928133143.157329-37-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miquel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on jic23-iio/togreg robh/for-next v5.15-rc3 next-20210922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/TI-AM437X-ADC1/20210928-213524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: microblaze-randconfig-r033-20210928 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/43a01cf6413f2be038b0d466c7c3f6f16b40e2c3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/TI-AM437X-ADC1/20210928-213524
        git checkout 43a01cf6413f2be038b0d466c7c3f6f16b40e2c3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/mfd/ti_am335x_tscadc.c: In function 'ti_tscadc_probe':
>> drivers/mfd/ti_am335x_tscadc.c:124:31: warning: variable 'use_mag' set but not used [-Wunused-but-set-variable]
     124 |         bool use_tsc = false, use_mag = false;
         |                               ^~~~~~~
   In file included from drivers/mfd/ti_am335x_tscadc.c:20:
   drivers/mfd/ti_am335x_tscadc.c: At top level:
   include/linux/mfd/ti_am335x_tscadc.h:126:38: error: 'HZ_PER_MHZ' undeclared here (not in a function)
     126 | #define TSC_ADC_CLK             (3 * HZ_PER_MHZ)
         |                                      ^~~~~~~~~~
   drivers/mfd/ti_am335x_tscadc.c:354:28: note: in expansion of macro 'TSC_ADC_CLK'
     354 |         .target_clk_rate = TSC_ADC_CLK,
         |                            ^~~~~~~~~~~


vim +/use_mag +124 drivers/mfd/ti_am335x_tscadc.c

   114	
   115	static	int ti_tscadc_probe(struct platform_device *pdev)
   116	{
   117		struct ti_tscadc_dev *tscadc;
   118		struct resource *res;
   119		struct clk *clk;
   120		struct device_node *node;
   121		struct mfd_cell *cell;
   122		struct property *prop;
   123		const __be32 *cur;
 > 124		bool use_tsc = false, use_mag = false;
   125		u32 val;
   126		int err;
   127		int tscmag_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
   128		int readouts = 0, mag_tracks = 0;
   129	
   130		/* Allocate memory for device */
   131		tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
   132		if (!tscadc)
   133			return -ENOMEM;
   134	
   135		tscadc->dev = &pdev->dev;
   136	
   137		if (!pdev->dev.of_node) {
   138			dev_err(&pdev->dev, "Could not find valid DT data.\n");
   139			return -EINVAL;
   140		}
   141	
   142		tscadc->data = of_device_get_match_data(&pdev->dev);
   143	
   144		if (ti_adc_with_touchscreen(tscadc)) {
   145			node = of_get_child_by_name(pdev->dev.of_node, "tsc");
   146			of_property_read_u32(node, "ti,wires", &tscmag_wires);
   147			of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
   148			of_node_put(node);
   149			if (tscmag_wires)
   150				use_tsc = true;
   151		} else {
   152			/*
   153			 * When adding support for the magnetic stripe reader, here is
   154			 * the place to look for the number of tracks used from device
   155			 * tree. Let's default to 0 for now.
   156			 */
   157			mag_tracks = 0;
   158			tscmag_wires = mag_tracks * 2;
   159			if (tscmag_wires)
   160				use_mag = true;
   161		}
   162	
   163		node = of_get_child_by_name(pdev->dev.of_node, "adc");
   164		of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
   165			adc_channels++;
   166			if (val > 7) {
   167				dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
   168					val);
   169				of_node_put(node);
   170				return -EINVAL;
   171			}
   172		}
   173	
   174		of_node_put(node);
   175	
   176		total_channels = tscmag_wires + adc_channels;
   177		if (total_channels > 8) {
   178			dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
   179			return -EINVAL;
   180		}
   181	
   182		if (total_channels == 0) {
   183			dev_err(&pdev->dev, "Need atleast one channel.\n");
   184			return -EINVAL;
   185		}
   186	
   187		if (use_tsc && (readouts * 2 + 2 + adc_channels > 16)) {
   188			dev_err(&pdev->dev, "Too many step configurations requested\n");
   189			return -EINVAL;
   190		}
   191	
   192		err = platform_get_irq(pdev, 0);
   193		if (err < 0)
   194			return err;
   195		else
   196			tscadc->irq = err;
   197	
   198		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   199		tscadc->tscadc_base = devm_ioremap_resource(&pdev->dev, res);
   200		if (IS_ERR(tscadc->tscadc_base))
   201			return PTR_ERR(tscadc->tscadc_base);
   202	
   203		tscadc->tscadc_phys_base = res->start;
   204		tscadc->regmap = devm_regmap_init_mmio(&pdev->dev,
   205						       tscadc->tscadc_base,
   206						       &tscadc_regmap_config);
   207		if (IS_ERR(tscadc->regmap)) {
   208			dev_err(&pdev->dev, "regmap init failed\n");
   209			return PTR_ERR(tscadc->regmap);
   210		}
   211	
   212		spin_lock_init(&tscadc->reg_lock);
   213		init_waitqueue_head(&tscadc->reg_se_wait);
   214	
   215		pm_runtime_enable(&pdev->dev);
   216		pm_runtime_get_sync(&pdev->dev);
   217	
   218		/*
   219		 * The TSC_ADC_Subsystem has 2 clock domains: OCP_CLK and ADC_CLK.
   220		 * ADCs produce a 12-bit sample every 15 ADC_CLK cycles.
   221		 * am33xx ADCs expect to capture 200ksps.
   222		 * am47xx ADCs expect to capture 867ksps.
   223		 * We need ADC clocks respectively running at 3MHz and 13MHz.
   224		 * These frequencies are valid since TSC_ADC_SS controller design
   225		 * assumes the OCP clock is at least 6x faster than the ADC clock.
   226		 */
   227		clk = devm_clk_get(&pdev->dev, NULL);
   228		if (IS_ERR(clk)) {
   229			dev_err(&pdev->dev, "failed to get fck\n");
   230			err = PTR_ERR(clk);
   231			goto err_disable_clk;
   232		}
   233	
   234		tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
   235		regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
   236	
   237		/*
   238		 * Set the control register bits. tscadc->ctrl stores the configuration
   239		 * of the CTRL register but not the subsystem enable bit which must be
   240		 * added manually when timely.
   241		 */
   242		tscadc->ctrl = CNTRLREG_STEPID;
   243		if (ti_adc_with_touchscreen(tscadc)) {
   244			tscadc->ctrl |= CNTRLREG_TSC_STEPCONFIGWRT;
   245			if (use_tsc) {
   246				tscadc->ctrl |= CNTRLREG_TSC_ENB;
   247				if (tscmag_wires == 5)
   248					tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
   249				else
   250					tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
   251			}
   252		} else {
   253			tscadc->ctrl |= CNTRLREG_MAG_PREAMP_PWRDOWN |
   254					CNTRLREG_MAG_PREAMP_BYPASS;
   255		}
   256		regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
   257	
   258		tscadc_idle_config(tscadc);
   259	
   260		/* Enable the TSC module enable bit */
   261		regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
   262	
   263		/* TSC or MAG Cell */
   264		if (tscmag_wires > 0) {
   265			cell = &tscadc->cells[cell_idx++];
   266			cell->name = tscadc->data->secondary_feature_name;
   267			cell->of_compatible = tscadc->data->secondary_feature_compatible;
   268			cell->platform_data = &tscadc;
   269			cell->pdata_size = sizeof(tscadc);
   270		}
   271	
   272		/* ADC Cell */
   273		if (adc_channels > 0) {
   274			cell = &tscadc->cells[cell_idx++];
   275			cell->name = tscadc->data->adc_feature_name;
   276			cell->of_compatible = tscadc->data->adc_feature_compatible;
   277			cell->platform_data = &tscadc;
   278			cell->pdata_size = sizeof(tscadc);
   279		}
   280	
   281		err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
   282				      tscadc->cells, cell_idx, NULL, 0, NULL);
   283		if (err < 0)
   284			goto err_disable_clk;
   285	
   286		platform_set_drvdata(pdev, tscadc);
   287		return 0;
   288	
   289	err_disable_clk:
   290		pm_runtime_put_sync(&pdev->dev);
   291		pm_runtime_disable(&pdev->dev);
   292	
   293		return err;
   294	}
   295	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--G4iJoqBmSsgzjUCe
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
XaXbznLVOseA4N1L/B/4z5m65q8BAA==

--G4iJoqBmSsgzjUCe--
