Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627732B8BD7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 07:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgKSG5P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 01:57:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:62510 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSG5P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Nov 2020 01:57:15 -0500
IronPort-SDR: 3ZJaLRne24xOcoHb3l/LiQbXgi5rvSduUi7zi51TBvxXUrAPopohtzqoS1i1EywOIRUYVtRoD5
 yY9izHfdeILA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159014452"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="gz'50?scan'50,208,50";a="159014452"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 22:57:12 -0800
IronPort-SDR: /D04pXNHDZmI1T7nL/TCHLh02eS3uc/U21UafvfnO2wu2efORxI8KDKCTvUgfQ6GTDUJqWfpjF
 Bzu+NqWEMhBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="gz'50?scan'50,208,50";a="330817700"
Received: from lkp-server01.sh.intel.com (HELO beb8a34b6883) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2020 22:57:09 -0800
Received: from kbuild by beb8a34b6883 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfdsS-00002s-Ea; Thu, 19 Nov 2020 06:57:08 +0000
Date:   Thu, 19 Nov 2020 14:56:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ye Xiang <xiang.ye@intel.com>, jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     kbuild-all@lists.01.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Xiang <xiang.ye@intel.com>
Subject: Re: [PATCH 1/4] HID: hid-sensor-custom: Add custom sensor iio support
Message-ID: <202011191413.TlmB6kRb-lkp@intel.com>
References: <20201119030326.6447-2-xiang.ye@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20201119030326.6447-2-xiang.ye@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ye,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on linus/master v5.10-rc4 next-20201118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ye-Xiang/add-custom-hinge-sensor-support/20201119-110842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: c6x-randconfig-r003-20201119 (attached as .config)
compiler: c6x-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1f33733d65038ade4af057df7e5c126485ecb7c6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ye-Xiang/add-custom-hinge-sensor-support/20201119-110842
        git checkout 1f33733d65038ade4af057df7e5c126485ecb7c6
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=c6x 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/hid-sensor-custom.c: In function 'store_value':
   drivers/hid/hid-sensor-custom.c:401:7: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     401 |   int ret;
         |       ^~~
   In file included from include/linux/device.h:15,
                    from include/linux/miscdevice.h:7,
                    from drivers/hid/hid-sensor-custom.c:11:
   drivers/hid/hid-sensor-custom.c: In function 'get_known_custom_sensor_index':
>> drivers/hid/hid-sensor-custom.c:847:24: warning: format '%ld' expects argument of type 'long int', but argument 3 has type '__kernel_size_t' {aka 'unsigned int'} [-Wformat=]
     847 |   hid_err(hsdev->hdev, " %ld != %ld\n", strlen(buf),
         |                        ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   include/linux/hid.h:1180:2: note: in expansion of macro 'dev_err'
    1180 |  dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
         |  ^~~~~~~
   drivers/hid/hid-sensor-custom.c:847:3: note: in expansion of macro 'hid_err'
     847 |   hid_err(hsdev->hdev, " %ld != %ld\n", strlen(buf),
         |   ^~~~~~~
   drivers/hid/hid-sensor-custom.c:847:28: note: format string is defined here
     847 |   hid_err(hsdev->hdev, " %ld != %ld\n", strlen(buf),
         |                          ~~^
         |                            |
         |                            long int
         |                          %d
   In file included from include/linux/device.h:15,
                    from include/linux/miscdevice.h:7,
                    from drivers/hid/hid-sensor-custom.c:11:
   drivers/hid/hid-sensor-custom.c:847:24: warning: format '%ld' expects argument of type 'long int', but argument 4 has type '__kernel_size_t' {aka 'unsigned int'} [-Wformat=]
     847 |   hid_err(hsdev->hdev, " %ld != %ld\n", strlen(buf),
         |                        ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   include/linux/hid.h:1180:2: note: in expansion of macro 'dev_err'
    1180 |  dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
         |  ^~~~~~~
   drivers/hid/hid-sensor-custom.c:847:3: note: in expansion of macro 'hid_err'
     847 |   hid_err(hsdev->hdev, " %ld != %ld\n", strlen(buf),
         |   ^~~~~~~
   drivers/hid/hid-sensor-custom.c:847:35: note: format string is defined here
     847 |   hid_err(hsdev->hdev, " %ld != %ld\n", strlen(buf),
         |                                 ~~^
         |                                   |
         |                                   long int
         |                                 %d

vim +847 drivers/hid/hid-sensor-custom.c

   771	
   772	static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
   773	{
   774		struct hid_sensor_hub_attribute_info sensor_manufacturer = { 0 };
   775		struct hid_sensor_hub_attribute_info sensor_luid_info = { 0 };
   776		int report_size;
   777		int ret;
   778		u16 *w_buf;
   779		int w_buf_len;
   780		char *buf;
   781		int buf_len;
   782		int i;
   783		int index;
   784	
   785		w_buf_len = sizeof(u16) * HID_CUSTOM_MAX_FEATURE_BYTES;
   786		buf_len = sizeof(char) * HID_CUSTOM_MAX_FEATURE_BYTES;
   787		w_buf = kzalloc(w_buf_len, GFP_KERNEL);
   788		if (!w_buf)
   789			return -1;
   790	
   791		buf = kzalloc(buf_len, GFP_KERNEL);
   792		if (!buf) {
   793			kfree(w_buf);
   794			return -1;
   795		}
   796	
   797		/* get manufacturer info */
   798		ret = sensor_hub_input_get_attribute_info(
   799			hsdev, HID_FEATURE_REPORT, hsdev->usage,
   800			HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
   801		if (ret < 0)
   802			goto err_out;
   803	
   804		report_size =
   805			sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
   806					       sensor_manufacturer.index, w_buf_len,
   807					       w_buf);
   808		if (report_size <= 0) {
   809			hid_err(hsdev->hdev,
   810				"Failed to get sensor manufacturer info %d\n",
   811				report_size);
   812			goto err_out;
   813		}
   814	
   815		/* convert from wide char to char */
   816		for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
   817			buf[i] = (char)w_buf[i];
   818	
   819		/* ensure it's ISH sensor */
   820		if (strncmp(buf, "INTEL", strlen("INTEL")))
   821			goto err_out;
   822	
   823		memset(w_buf, 0, w_buf_len);
   824		memset(buf, 0, buf_len);
   825	
   826		/* get real usage id */
   827		ret = sensor_hub_input_get_attribute_info(
   828			hsdev, HID_FEATURE_REPORT, hsdev->usage,
   829			HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
   830		if (ret < 0)
   831			goto err_out;
   832	
   833		report_size = sensor_hub_get_feature(hsdev, sensor_luid_info.report_id,
   834						     sensor_luid_info.index, w_buf_len,
   835						     w_buf);
   836		if (report_size <= 0) {
   837			hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
   838				report_size);
   839			goto err_out;
   840		}
   841	
   842		/* convert from wide char to char */
   843		for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
   844			buf[i] = (char)w_buf[i];
   845	
   846		if (strlen(buf) != strlen(known_sensor_luid[0]) + 5) {
 > 847			hid_err(hsdev->hdev, " %ld != %ld\n", strlen(buf),
   848				strlen(known_sensor_luid[0]));
   849			goto err_out;
   850		}
   851	
   852		/* get table index with luid (not matching 'LUID: ' in luid) */
   853		index = get_luid_table_index(&buf[5]);
   854		kfree(w_buf);
   855		kfree(buf);
   856		return index;
   857	
   858	err_out:
   859		kfree(w_buf);
   860		kfree(buf);
   861		return -1;
   862	}
   863	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sDr/EyJPaCxB/xPjWwBBwchfYGcfKYrmAQA=

--C7zPtVaVf+AK4Oqc--
