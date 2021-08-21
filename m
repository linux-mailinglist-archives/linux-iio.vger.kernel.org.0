Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9E3F3851
	for <lists+linux-iio@lfdr.de>; Sat, 21 Aug 2021 05:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhHUD3i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 23:29:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:22925 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhHUD3h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Aug 2021 23:29:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="216598444"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="gz'50?scan'50,208,50";a="216598444"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 20:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="gz'50?scan'50,208,50";a="513164851"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2021 20:28:54 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mHHgj-000VU1-Ns; Sat, 21 Aug 2021 03:28:53 +0000
Date:   Sat, 21 Aug 2021 11:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mihail Chindris <mihail.chindris@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com
Subject: Re: [PATCH v4 3/6] iio: triggered-buffer: extend support to
 configure output buffers
Message-ID: <202108211108.gg3rDN7b-lkp@intel.com>
References: <20210820165927.4524-4-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20210820165927.4524-4-mihail.chindris@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mihail,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 94a853eca720ac9e385e59f27e859b4a01123f58]

url:    https://github.com/0day-ci/linux/commits/Mihail-Chindris/iio-Add-output-buffer-support-and-DAC-example/20210821-010349
base:   94a853eca720ac9e385e59f27e859b4a01123f58
config: i386-randconfig-a002-20210821 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/864c7d5f5d135f37baf9b65d13d186744535a8e4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mihail-Chindris/iio-Add-output-buffer-support-and-DAC-example/20210821-010349
        git checkout 864c7d5f5d135f37baf9b65d13d186744535a8e4
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   clang-14: warning: optimization flag '-falign-jumps=0' is not supported [-Wignored-optimization-argument]
   In file included from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:9:
   In file included from include/linux/device.h:15:
   In file included from include/linux/dev_printk.h:16:
   In file included from include/linux/ratelimit.h:6:
   In file included from include/linux/sched.h:14:
   In file included from include/linux/pid.h:5:
   In file included from include/linux/rculist.h:11:
   In file included from include/linux/rcupdate.h:27:
   In file included from include/linux/preempt.h:78:
   In file included from arch/x86/include/asm/preempt.h:7:
   In file included from include/linux/thread_info.h:60:
   arch/x86/include/asm/thread_info.h:172:13: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
           oldframe = __builtin_frame_address(1);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/thread_info.h:174:11: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
                   frame = __builtin_frame_address(2);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:57:41: warning: taking address of packed member 'msg' of class or structure '' may result in an unaligned pointer value [-Waddress-of-packed-member]
           ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
                                                  ^~~~~~~
>> drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:365:35: error: too few arguments to function call, expected 7, have 6
                                           IIO_BUFFER_DIRECTION_IN, NULL);
                                                                        ^
   include/linux/iio/triggered_buffer.h:25:5: note: 'devm_iio_triggered_buffer_setup_ext' declared here
   int devm_iio_triggered_buffer_setup_ext(struct device *dev,
       ^
   3 warnings and 1 error generated.


vim +365 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c

   234	
   235	/**
   236	 * cros_ec_sensors_core_init() - basic initialization of the core structure
   237	 * @pdev:		platform device created for the sensors
   238	 * @indio_dev:		iio device structure of the device
   239	 * @physical_device:	true if the device refers to a physical device
   240	 * @trigger_capture:    function pointer to call buffer is triggered,
   241	 *    for backward compatibility.
   242	 * @push_data:          function to call when cros_ec_sensorhub receives
   243	 *    a sample for that sensor.
   244	 *
   245	 * Return: 0 on success, -errno on failure.
   246	 */
   247	int cros_ec_sensors_core_init(struct platform_device *pdev,
   248				      struct iio_dev *indio_dev,
   249				      bool physical_device,
   250				      cros_ec_sensors_capture_t trigger_capture,
   251				      cros_ec_sensorhub_push_data_cb_t push_data)
   252	{
   253		struct device *dev = &pdev->dev;
   254		struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
   255		struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
   256		struct cros_ec_dev *ec = sensor_hub->ec;
   257		struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
   258		u32 ver_mask, temp;
   259		int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
   260		int ret, i;
   261	
   262		platform_set_drvdata(pdev, indio_dev);
   263	
   264		state->ec = ec->ec_dev;
   265		state->msg = devm_kzalloc(&pdev->dev,
   266					max((u16)sizeof(struct ec_params_motion_sense),
   267					state->ec->max_response), GFP_KERNEL);
   268		if (!state->msg)
   269			return -ENOMEM;
   270	
   271		state->resp = (struct ec_response_motion_sense *)state->msg->data;
   272	
   273		mutex_init(&state->cmd_lock);
   274	
   275		ret = cros_ec_get_host_cmd_version_mask(state->ec,
   276							ec->cmd_offset,
   277							EC_CMD_MOTION_SENSE_CMD,
   278							&ver_mask);
   279		if (ret < 0)
   280			return ret;
   281	
   282		/* Set up the host command structure. */
   283		state->msg->version = fls(ver_mask) - 1;
   284		state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
   285		state->msg->outsize = sizeof(struct ec_params_motion_sense);
   286	
   287		indio_dev->name = pdev->name;
   288	
   289		if (physical_device) {
   290			state->param.cmd = MOTIONSENSE_CMD_INFO;
   291			state->param.info.sensor_num = sensor_platform->sensor_num;
   292			ret = cros_ec_motion_send_host_cmd(state, 0);
   293			if (ret) {
   294				dev_warn(dev, "Can not access sensor info\n");
   295				return ret;
   296			}
   297			state->type = state->resp->info.type;
   298			state->loc = state->resp->info.location;
   299	
   300			/* Set sign vector, only used for backward compatibility. */
   301			memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
   302	
   303			for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
   304				state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
   305	
   306			/* 0 is a correct value used to stop the device */
   307			if (state->msg->version < 3) {
   308				get_default_min_max_freq(state->resp->info.type,
   309							 &frequencies[1],
   310							 &frequencies[2],
   311							 &state->fifo_max_event_count);
   312			} else {
   313				if (state->resp->info_3.max_frequency == 0) {
   314					get_default_min_max_freq(state->resp->info.type,
   315								 &frequencies[1],
   316								 &frequencies[2],
   317								 &temp);
   318				} else {
   319					frequencies[1] = state->resp->info_3.min_frequency;
   320					frequencies[2] = state->resp->info_3.max_frequency;
   321				}
   322				state->fifo_max_event_count = state->resp->info_3.fifo_max_event_count;
   323			}
   324			for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
   325				state->frequencies[2 * i] = frequencies[i] / 1000;
   326				state->frequencies[2 * i + 1] =
   327					(frequencies[i] % 1000) * 1000;
   328			}
   329	
   330			if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
   331				/*
   332				 * Create a software buffer, feed by the EC FIFO.
   333				 * We can not use trigger here, as events are generated
   334				 * as soon as sample_frequency is set.
   335				 */
   336				ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
   337								      INDIO_BUFFER_SOFTWARE, NULL,
   338								      cros_ec_sensor_fifo_attributes);
   339				if (ret)
   340					return ret;
   341	
   342				ret = cros_ec_sensorhub_register_push_data(
   343						sensor_hub, sensor_platform->sensor_num,
   344						indio_dev, push_data);
   345				if (ret)
   346					return ret;
   347	
   348				ret = devm_add_action_or_reset(
   349						dev, cros_ec_sensors_core_clean, pdev);
   350				if (ret)
   351					return ret;
   352	
   353				/* Timestamp coming from FIFO are in ns since boot. */
   354				ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
   355				if (ret)
   356					return ret;
   357	
   358			} else {
   359				/*
   360				 * The only way to get samples in buffer is to set a
   361				 * software trigger (systrig, hrtimer).
   362				 */
   363				ret = devm_iio_triggered_buffer_setup_ext(dev,
   364						indio_dev, NULL, trigger_capture,
 > 365						IIO_BUFFER_DIRECTION_IN, NULL);
   366				if (ret)
   367					return ret;
   368			}
   369		}
   370	
   371		return 0;
   372	}
   373	EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
   374	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/9DWx/yDrRhgMJTb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--/9DWx/yDrRhgMJTb--
