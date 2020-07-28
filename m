Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BD2300DD
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 06:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgG1Eq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 00:46:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:22419 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG1Eq3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jul 2020 00:46:29 -0400
IronPort-SDR: rz+CWTYb35Gj5mflU/rHXNML/oWkUqnC47xTQSo8gOL/pX/mzepC4knssoRIZv6m+lhGNTy46C
 s2qToMi8K/9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="139183429"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="gz'50?scan'50,208,50";a="139183429"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 21:46:19 -0700
IronPort-SDR: LaGQg20q5I0xBy1R8D9x7xvrz2dYay5XqVukF6OZGErMdcdBYjRpExc7biLh/DsnTH2HWX+mEC
 FmTZXpl77+3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="gz'50?scan'50,208,50";a="490212618"
Received: from lkp-server01.sh.intel.com (HELO 99889102fa3d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2020 21:46:14 -0700
Received: from kbuild by 99889102fa3d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0HVF-0000Al-Tr; Tue, 28 Jul 2020 04:46:13 +0000
Date:   Tue, 28 Jul 2020 12:45:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Eggers <ceggers@arri.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     kbuild-all@lists.01.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>
Subject: Re: [PATCH 2/2] iio: light: as73211: New driver
Message-ID: <202007281229.IO7n9y8a%lkp@intel.com>
References: <20200727144741.3927-3-ceggers@arri.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20200727144741.3927-3-ceggers@arri.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on robh/for-next linux/master linus/master v5.8-rc7 next-20200727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christian-Eggers/dt-bindings-iio-light-add-AMS-AS73211-support/20200727-234842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: sparc64-randconfig-s031-20200728 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-94-geb6779f6-dirty
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/light/as73211.c:473:35: sparse: sparse: cast to restricted __le16
>> drivers/iio/light/as73211.c:473:35: sparse: sparse: cast to restricted __le16
>> drivers/iio/light/as73211.c:473:35: sparse: sparse: cast to restricted __le16
>> drivers/iio/light/as73211.c:473:35: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:477:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:477:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:477:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:477:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:478:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:478:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:478:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:478:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:479:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:479:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:479:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:479:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:498:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:498:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:498:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:498:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:499:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:499:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:499:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:499:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:500:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:500:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:500:43: sparse: sparse: cast to restricted __le16
   drivers/iio/light/as73211.c:500:43: sparse: sparse: cast to restricted __le16

vim +473 drivers/iio/light/as73211.c

   439	
   440	static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
   441	{
   442		struct iio_poll_func *pf = p;
   443		struct iio_dev *indio_dev = pf->indio_dev;
   444		struct as73211_data *data = iio_priv(indio_dev);
   445		int data_result, ret;
   446	
   447		mutex_lock(&data->mutex);
   448	
   449		data_result = as73211_req_data(data);
   450	
   451		/* Optimization for reading all (color + temperature) channels */
   452		if (*indio_dev->active_scan_mask == 0xf) {
   453			u8 addr = as73211_channels[0].address;
   454			struct i2c_msg msgs[] = {
   455				{
   456					.addr = data->client->addr,
   457					.flags = 0,
   458					.len = 1,
   459					.buf = &addr
   460				},
   461				{
   462					.addr = data->client->addr,
   463					.flags = I2C_M_RD,
   464					.len = 4 * sizeof(*data->buffer),
   465					.buf = (u8 *)&data->buffer[0]
   466				},
   467			};
   468			ret = i2c_transfer(data->client->adapter, msgs, ARRAY_SIZE(msgs));
   469			if (ret < 0)
   470				goto done;
   471	
   472			/* Temperature channel is not affected by overflows */
 > 473			data->buffer[0] = le16_to_cpu(data->buffer[0]);
   474	
   475			if (data_result == 0) {
   476				/* convert byte order (AS73211 sends LSB first) */
   477				data->buffer[1] = le16_to_cpu(data->buffer[1]);
   478				data->buffer[2] = le16_to_cpu(data->buffer[2]);
   479				data->buffer[3] = le16_to_cpu(data->buffer[3]);
   480			} else {
   481				/* saturate all channels (useful for overflows) */
   482				data->buffer[1] = 0xffff;
   483				data->buffer[2] = 0xffff;
   484				data->buffer[3] = 0xffff;
   485			}
   486	
   487		}
   488		/* Optimization for reading all color channels */
   489		else if (*indio_dev->active_scan_mask == 0xe) {
   490			/* AS73211 starts reading at address 2 */
   491			ret = i2c_master_recv(data->client,
   492					(char *)&data->buffer[1], 3 * sizeof(*data->buffer));
   493			if (ret < 0)
   494				goto done;
   495	
   496			if (data_result == 0) {
   497				/* convert byte order (as73211 sends LSB first) */
   498				data->buffer[1] = le16_to_cpu(data->buffer[1]);
   499				data->buffer[2] = le16_to_cpu(data->buffer[2]);
   500				data->buffer[3] = le16_to_cpu(data->buffer[3]);
   501			} else {
   502				/* saturate all channels (useful for overflows) */
   503				data->buffer[1] = 0xffff;
   504				data->buffer[2] = 0xffff;
   505				data->buffer[3] = 0xffff;
   506			}
   507		} else {
   508			unsigned int i, j = 0;
   509	
   510			/* generic case */
   511			for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
   512				struct iio_chan_spec const *channel = &as73211_channels[i];
   513	
   514				/* Read data even on error in order to avoid "result buffer overrun" */
   515				ret = i2c_smbus_read_word_data(data->client,
   516					channel->address);
   517				if (ret < 0)
   518					goto done;
   519	
   520				if (data_result == 0) {
   521					data->buffer[j++] = ret;
   522				} else {
   523					/* saturate all channels (useful for overflows) */
   524					data->buffer[j++] = 0xffff;
   525				}
   526			}
   527		}
   528	
   529		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
   530			iio_get_time_ns(indio_dev));
   531	
   532	done:
   533		mutex_unlock(&data->mutex);
   534		iio_trigger_notify_done(indio_dev->trig);
   535	
   536		return IRQ_HANDLED;
   537	}
   538	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--uAKRQypu60I7Lcqm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ZfPwZeCsECC+9b0qkxYRPHzH9x9JGiYV3Z4BAA==

--uAKRQypu60I7Lcqm--
