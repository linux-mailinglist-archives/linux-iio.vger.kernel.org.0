Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F51CD229
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 08:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEKG6n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 02:58:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:31103 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgEKG6n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 May 2020 02:58:43 -0400
IronPort-SDR: nILQaefWZw0tu8K/2RdUe1JewqdS4OWJcOiQBWxjC3wa8+ERlUIZctDztfWDRIzzr5u/4vPttf
 hLMi7vwbz0vg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 23:31:39 -0700
IronPort-SDR: ToJ6OY7SwH4gQphoPOsJ0muuqLavohYaSgan6fQ83igkCYZgt899DLDsezVO9LWYOsOOAcK3mZ
 ICm5d6WrDHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,378,1583222400"; 
   d="gz'50?scan'50,208,50";a="371126167"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2020 23:31:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jY1y7-0000fb-P4; Mon, 11 May 2020 14:31:15 +0800
Date:   Mon, 11 May 2020 14:31:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, jic23@kernel.org
Cc:     kbuild-all@lists.01.org, bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v2 3/3] iio: cros_ec_light: Add support for RGB sensor
Message-ID: <202005111425.AoUFxet5%lkp@intel.com>
References: <20200506230324.139241-4-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20200506230324.139241-4-gwendal@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gwendal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on chrome-platform-linux/for-next linus/master v5.7-rc5 next-20200508]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Gwendal-Grignou/iio-cros_ec-Add-support-for-RGB-light-sensor/20200507-074251
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-a003-20200511 (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   drivers/iio/light/cros_ec_light_prox.c:51:2: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     CROS_EC_LIGHT_RGB_SPACE_MASK,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:38: error: initializer element is not constant
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                         ^
   drivers/iio/light/cros_ec_light_prox.c:51:2: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     CROS_EC_LIGHT_RGB_SPACE_MASK,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:38: note: (near initialization for 'cros_ec_light_prox_bitmasks[3]')
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                         ^
   drivers/iio/light/cros_ec_light_prox.c:51:2: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     CROS_EC_LIGHT_RGB_SPACE_MASK,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   drivers/iio/light/cros_ec_light_prox.c:52:2: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     CROS_EC_LIGHT_RGB_SPACE_MASK | CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:38: error: initializer element is not constant
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                         ^
   drivers/iio/light/cros_ec_light_prox.c:52:2: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     CROS_EC_LIGHT_RGB_SPACE_MASK | CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:38: note: (near initialization for 'cros_ec_light_prox_bitmasks[4]')
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                         ^
   drivers/iio/light/cros_ec_light_prox.c:52:2: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     CROS_EC_LIGHT_RGB_SPACE_MASK | CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/dev_printk.h:14:0,
                    from include/linux/device.h:15,
                    from drivers/iio/light/cros_ec_light_prox.c:8:
   drivers/iio/light/cros_ec_light_prox.c: In function 'cros_ec_light_capture':
   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> drivers/iio/light/cros_ec_light_prox.c:403:2: note: in expansion of macro 'if'
     if ((scan_mask & CROS_EC_LIGHT_XYZ_SPACE_MASK) ||
     ^~
   drivers/iio/light/cros_ec_light_prox.c:404:19: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
         (scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> drivers/iio/light/cros_ec_light_prox.c:403:2: note: in expansion of macro 'if'
     if ((scan_mask & CROS_EC_LIGHT_XYZ_SPACE_MASK) ||
     ^~
   drivers/iio/light/cros_ec_light_prox.c:404:19: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
         (scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> drivers/iio/light/cros_ec_light_prox.c:403:2: note: in expansion of macro 'if'
     if ((scan_mask & CROS_EC_LIGHT_XYZ_SPACE_MASK) ||
     ^~
   drivers/iio/light/cros_ec_light_prox.c:404:19: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
         (scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c: In function 'cros_ec_light_prox_update_scan_mode':
   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
   drivers/iio/light/cros_ec_light_prox.c:434:7: note: in expansion of macro 'if'
     else if (*scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)
          ^~
   drivers/iio/light/cros_ec_light_prox.c:434:24: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     else if (*scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
   drivers/iio/light/cros_ec_light_prox.c:434:7: note: in expansion of macro 'if'
     else if (*scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)
          ^~
   drivers/iio/light/cros_ec_light_prox.c:434:24: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     else if (*scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:39:40: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    #define CROS_EC_LIGHT_RGB_SPACE_MASK (6, 4)
                                           ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
   drivers/iio/light/cros_ec_light_prox.c:434:7: note: in expansion of macro 'if'
     else if (*scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)
          ^~
   drivers/iio/light/cros_ec_light_prox.c:434:24: note: in expansion of macro 'CROS_EC_LIGHT_RGB_SPACE_MASK'
     else if (*scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/if +403 drivers/iio/light/cros_ec_light_prox.c

   378	
   379	static irqreturn_t cros_ec_light_capture(int irq, void *p)
   380	{
   381		struct iio_poll_func *pf = p;
   382		struct iio_dev *indio_dev = pf->indio_dev;
   383		struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
   384		int ret, i, idx = 0;
   385		s16 data;
   386		const unsigned long scan_mask = *indio_dev->active_scan_mask;
   387	
   388		mutex_lock(&st->cmd_lock);
   389	
   390		/* Clear capture data. */
   391		memset(st->samples, 0, indio_dev->scan_bytes);
   392	
   393		/* Read first channel. */
   394		ret = cros_ec_sensors_read_cmd(indio_dev, 1, &data);
   395		if (ret < 0) {
   396			mutex_unlock(&st->cmd_lock);
   397			goto done;
   398		}
   399		if (scan_mask & CROS_EC_LIGHT_CLEAR_OR_PROXIMITY_MASK)
   400			((s16 *)st->samples)[idx++] = data;
   401	
   402		/* Read remaining channels. */
 > 403		if ((scan_mask & CROS_EC_LIGHT_XYZ_SPACE_MASK) ||
   404		    (scan_mask & CROS_EC_LIGHT_RGB_SPACE_MASK)) {
   405			ret = cros_ec_light_extra_send_host_cmd(
   406					st, 1, sizeof(st->resp->data));
   407			if (ret < 0) {
   408				mutex_unlock(&st->cmd_lock);
   409				goto done;
   410			}
   411			for (i = 0; i < CROS_EC_SENSOR_MAX_AXIS; i++)
   412				((s16 *)st->samples)[idx++] = st->resp->data.data[i];
   413		}
   414		mutex_unlock(&st->cmd_lock);
   415	
   416		iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
   417						   iio_get_time_ns(indio_dev));
   418	
   419	done:
   420		iio_trigger_notify_done(indio_dev->trig);
   421	
   422		return IRQ_HANDLED;
   423	}
   424	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
kB7O4S3/AUSreYkm+QEA

--C7zPtVaVf+AK4Oqc--
