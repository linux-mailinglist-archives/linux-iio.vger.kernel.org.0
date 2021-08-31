Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318A33FCFFB
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 01:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhHaXhb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 19:37:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:49768 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhHaXh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 31 Aug 2021 19:37:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218308288"
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="gz'50?scan'50,208,50";a="218308288"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 16:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="gz'50?scan'50,208,50";a="531400836"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Aug 2021 16:36:28 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLDIp-0007Cx-9u; Tue, 31 Aug 2021 23:36:27 +0000
Date:   Wed, 1 Sep 2021 07:35:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roan van Dijk <roan@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH 3/3] drivers: iio: chemical: Add support for Sensirion
 SCD4x CO2 sensor
Message-ID: <202109010738.qbI1D4Th-lkp@intel.com>
References: <20210831074832.16310-4-roan@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20210831074832.16310-4-roan@protonic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linux/master linus/master v5.14]
[cannot apply to iio/togreg next-20210831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Roan-van-Dijk/iio-chemical-Add-support-for-Sensirion-SCD4x-CO2-sensor/20210831-202025
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: hexagon-randconfig-r036-20210901 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b1fde8a2b681dad2ce0c082a5d6422caa06b0bc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/605896bbee687d465d4ae58d910878e9b85f0035
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Roan-van-Dijk/iio-chemical-Add-support-for-Sensirion-SCD4x-CO2-sensor/20210831-202025
        git checkout 605896bbee687d465d4ae58d910878e9b85f0035
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/chemical/scd4x.c:503:20: warning: no previous prototype for function 'scd4x_suspend' [-Wmissing-prototypes]
   int __maybe_unused scd4x_suspend(struct device *dev)
                      ^
   drivers/iio/chemical/scd4x.c:503:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __maybe_unused scd4x_suspend(struct device *dev)
   ^
   static 
>> drivers/iio/chemical/scd4x.c:517:20: warning: no previous prototype for function 'scd4x_resume' [-Wmissing-prototypes]
   int __maybe_unused scd4x_resume(struct device *dev)
                      ^
   drivers/iio/chemical/scd4x.c:517:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __maybe_unused scd4x_resume(struct device *dev)
   ^
   static 
>> drivers/iio/chemical/scd4x.c:613:5: warning: no previous prototype for function 'scd4x_probe' [-Wmissing-prototypes]
   int scd4x_probe(struct i2c_client *client, const struct i2c_device_id *id)
       ^
   drivers/iio/chemical/scd4x.c:613:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int scd4x_probe(struct i2c_client *client, const struct i2c_device_id *id)
   ^
   static 
   3 warnings generated.


vim +/scd4x_suspend +503 drivers/iio/chemical/scd4x.c

   502	
 > 503	int __maybe_unused scd4x_suspend(struct device *dev)
   504	{
   505		struct iio_dev *indio_dev = dev_get_drvdata(dev);
   506		struct scd4x_state *state  = iio_priv(indio_dev);
   507		int ret;
   508	
   509		ret = scd4x_send_command(state, CMD_STOP_MEAS);
   510		if (ret)
   511			return ret;
   512	
   513		return regulator_disable(state->vdd);
   514	}
   515	EXPORT_SYMBOL(scd4x_suspend);
   516	
 > 517	int __maybe_unused scd4x_resume(struct device *dev)
   518	{
   519		struct iio_dev *indio_dev = dev_get_drvdata(dev);
   520		struct scd4x_state *state = iio_priv(indio_dev);
   521		int ret;
   522	
   523		ret = regulator_enable(state->vdd);
   524		if (ret)
   525			return ret;
   526	
   527		return scd4x_send_command(state, CMD_START_MEAS);
   528	}
   529	EXPORT_SYMBOL(scd4x_resume);
   530	
   531	static void scd4x_stop_meas(void *data)
   532	{
   533		struct scd4x_state *state = data;
   534	
   535		scd4x_send_command(state, CMD_STOP_MEAS);
   536	}
   537	
   538	static void scd4x_disable_regulator(void *data)
   539	{
   540		struct scd4x_state *state = data;
   541	
   542		regulator_disable(state->vdd);
   543	}
   544	
   545	static irqreturn_t scd4x_trigger_handler(int irq, void *p)
   546	{
   547		struct iio_poll_func *pf = p;
   548		struct iio_dev *indio_dev = pf->indio_dev;
   549		struct scd4x_state *state = iio_priv(indio_dev);
   550		struct {
   551			int data[3];
   552			int64_t ts __aligned(8);
   553		} scan;
   554		int ret;
   555	
   556		mutex_lock(&state->lock);
   557		ret = scd4x_read_poll(state);
   558		memset(&scan, 0, sizeof(scan));
   559		memcpy(scan.data, state->meas, sizeof(state->meas));
   560		mutex_unlock(&state->lock);
   561		if (ret)
   562			goto out;
   563	
   564		iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
   565	out:
   566		iio_trigger_notify_done(indio_dev->trig);
   567		return IRQ_HANDLED;
   568	}
   569	
   570	static int scd4x_set_trigger_state(struct iio_trigger *trig, bool state)
   571	{
   572		struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
   573		struct scd4x_state *st = iio_priv(indio_dev);
   574	
   575		if (state)
   576			enable_irq(st->irq);
   577		else
   578			disable_irq(st->irq);
   579	
   580		return 0;
   581	}
   582	
   583	static const struct iio_trigger_ops scd4x_trigger_ops = {
   584		.set_trigger_state = scd4x_set_trigger_state,
   585		.validate_device = iio_trigger_validate_own_device,
   586	};
   587	
   588	static int scd4x_setup_trigger(struct iio_dev *indio_dev)
   589	{
   590		struct device *dev = indio_dev->dev.parent;
   591		struct iio_trigger *trig;
   592		int ret;
   593	
   594		trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
   595					      iio_device_id(indio_dev));
   596		if (!trig) {
   597			dev_err(dev, "failed to allocate trigger\n");
   598			return -ENOMEM;
   599		}
   600	
   601		trig->ops = &scd4x_trigger_ops;
   602		iio_trigger_set_drvdata(trig, indio_dev);
   603	
   604		ret = devm_iio_trigger_register(dev, trig);
   605		if (ret)
   606			return ret;
   607	
   608		indio_dev->trig = iio_trigger_get(trig);
   609	
   610		return ret;
   611	}
   612	
 > 613	int scd4x_probe(struct i2c_client *client, const struct i2c_device_id *id)
   614	{
   615		static const unsigned long scd4x_scan_masks[] = { 0x07, 0x00 };
   616		struct device *dev = &client->dev;
   617		struct iio_dev *indio_dev;
   618		struct scd4x_state *state;
   619		int ret;
   620	
   621		indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
   622		if (!indio_dev)
   623			return -ENOMEM;
   624	
   625		state = iio_priv(indio_dev);
   626		mutex_init(&state->lock);
   627		state->dev = dev;
   628		crc8_populate_msb(scd4x_crc8_table, SCD4X_CRC8_POLYNOMIAL);
   629	
   630		indio_dev->info = &scd4x_info;
   631		indio_dev->name = client->name;
   632		indio_dev->channels = scd4x_channels;
   633		indio_dev->num_channels = ARRAY_SIZE(scd4x_channels);
   634		indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
   635		indio_dev->available_scan_masks = scd4x_scan_masks;
   636	
   637		state->vdd = devm_regulator_get(dev, "vdd");
   638		if (IS_ERR(state->vdd))
   639			return dev_err_probe(dev, PTR_ERR(state->vdd), "failed to get regulator\n");
   640	
   641		ret = regulator_enable(state->vdd);
   642		if (ret)
   643			return ret;
   644	
   645		ret = devm_add_action_or_reset(dev, scd4x_disable_regulator, state);
   646		if (ret)
   647			return ret;
   648	
   649		ret = scd4x_send_command(state, CMD_STOP_MEAS);
   650		if (ret) {
   651			dev_err(dev, "failed to stop measurement: %d\n", ret);
   652			return ret;
   653		}
   654	
   655		/* execution time */
   656		msleep_interruptible(500);
   657	
   658		if (state->irq > 0) {
   659			ret = scd4x_setup_trigger(indio_dev);
   660			if (ret) {
   661				dev_err(dev, "failed to setup trigger: %d\n", ret);
   662				return ret;
   663			}
   664		}
   665	
   666		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd4x_trigger_handler, NULL);
   667		if (ret)
   668			return ret;
   669	
   670		ret = devm_iio_device_register(dev, indio_dev);
   671		if (ret) {
   672			dev_err(dev, "failed to register iio device\n");
   673			return ret;
   674		}
   675	
   676		ret = scd4x_send_command(state, CMD_START_MEAS);
   677		if (ret) {
   678			dev_err(dev, "failed to start measurement: %d\n", ret);
   679			return ret;
   680		}
   681	
   682		ret = devm_add_action_or_reset(dev, scd4x_stop_meas, state);
   683		if (ret)
   684			return ret;
   685	
   686		return 0;
   687	}
   688	EXPORT_SYMBOL(scd4x_probe);
   689	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
UZbsWNlSuWn3ROzEZfNffE3u2C+wAQA=

--jRHKVT23PllUwdXP--
