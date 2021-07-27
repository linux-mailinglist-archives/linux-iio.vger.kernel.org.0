Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6B3D7488
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 13:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhG0Lqq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 07:46:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:64378 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236087AbhG0Lqq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Jul 2021 07:46:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199607483"
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="gz'50?scan'50,208,50";a="199607483"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 04:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="gz'50?scan'50,208,50";a="498771266"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2021 04:46:40 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8LXj-0006lC-VZ; Tue, 27 Jul 2021 11:46:39 +0000
Date:   Tue, 27 Jul 2021 19:45:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     kbuild-all@lists.01.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <202107271937.8vfzyty1-lkp@intel.com>
References: <20210727051627.12234-3-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20210727051627.12234-3-puranjay12@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Puranjay,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on linus/master v5.14-rc3 next-20210726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Puranjay-Mohan/iio-accel-add-support-for-ADXL355/20210727-131822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: openrisc-randconfig-s031-20210727 (attached as .config)
compiler: or1k-linux-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://github.com/0day-ci/linux/commit/a0ad8ce87d3d3357c64f98bec48b75d07b961da8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Puranjay-Mohan/iio-accel-add-support-for-ADXL355/20210727-131822
        git checkout a0ad8ce87d3d3357c64f98bec48b75d07b961da8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/iio/accel/adxl355_core.c:204:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] regval @@     got int @@
   drivers/iio/accel/adxl355_core.c:204:16: sparse:     expected restricted __be32 [usertype] regval
   drivers/iio/accel/adxl355_core.c:204:16: sparse:     got int
>> drivers/iio/accel/adxl355_core.c:341:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] out @@     got int @@
   drivers/iio/accel/adxl355_core.c:341:29: sparse:     expected restricted __be16 [usertype] out
   drivers/iio/accel/adxl355_core.c:341:29: sparse:     got int

vim +204 drivers/iio/accel/adxl355_core.c

   195	
   196	static int adxl355_read_axis(struct adxl355_data *data, u8 addr)
   197	{
   198		__be32 regval;
   199		int ret;
   200	
   201		ret = regmap_bulk_read(data->regmap, addr, data->transf_buf, 3);
   202		if (ret < 0)
   203			return ret;
 > 204		regval = data->transf_buf[0] + (data->transf_buf[1] << 8)
   205					     + (data->transf_buf[2] << 16);
   206	
   207		return be32_to_cpu(regval) >> 8;
   208	}
   209	
   210	static int adxl355_find_match(const int (*freq_tbl)[2], const int n,
   211				      const int val, const int val2)
   212	{
   213		int i;
   214	
   215		for (i = 0; i < n; i++) {
   216			if (freq_tbl[i][0] == val && freq_tbl[i][1] == val2)
   217				return i;
   218		}
   219	
   220		return -EINVAL;
   221	}
   222	
   223	static int adxl355_set_odr(struct adxl355_data *data,
   224				   enum adxl355_odr odr)
   225	{
   226		int ret = 0;
   227	
   228		mutex_lock(&data->lock);
   229	
   230		if (data->odr == odr)
   231			goto out_unlock;
   232	
   233		ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
   234		if (ret < 0)
   235			goto out_unlock;
   236	
   237		ret = regmap_update_bits(data->regmap, ADXL355_FILTER,
   238					 ADXL355_FILTER_ODR_MSK,
   239					 FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr));
   240		if (ret < 0)
   241			goto out_unlock;
   242	
   243		data->odr = odr;
   244		adxl355_fill_3db_frequency_table(data);
   245	
   246	out_unlock:
   247		ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
   248		mutex_unlock(&data->lock);
   249		return ret;
   250	}
   251	
   252	static int adxl355_set_hpf_3db(struct adxl355_data *data,
   253				       enum adxl355_hpf_3db hpf)
   254	{
   255		int ret = 0;
   256	
   257		mutex_lock(&data->lock);
   258	
   259		if (data->hpf_3db == hpf)
   260			goto out_unlock;
   261	
   262		ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
   263		if (ret < 0)
   264			goto out_unlock;
   265	
   266		ret = regmap_update_bits(data->regmap, ADXL355_FILTER,
   267					 ADXL355_FILTER_HPF_MSK,
   268					 FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
   269		if (!ret)
   270			data->hpf_3db = hpf;
   271	
   272	out_unlock:
   273		ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
   274		mutex_unlock(&data->lock);
   275		return ret;
   276	}
   277	
   278	static int adxl355_set_calibbias(struct adxl355_data *data,
   279					 int channel2, int calibbias)
   280	{
   281		int ret = 0;
   282	
   283		data->transf_buf[0] = (calibbias >> 8) & 0xFF;
   284		data->transf_buf[1] = calibbias & 0xFF;
   285		data->transf_buf[2] = 0;
   286	
   287		mutex_lock(&data->lock);
   288	
   289		ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
   290		if (ret < 0)
   291			goto out_unlock;
   292	
   293		switch (channel2) {
   294		case IIO_MOD_X:
   295			ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_X_H,
   296						data->transf_buf, 2);
   297			if (ret < 0)
   298				goto out_unlock;
   299			data->x_calibbias = calibbias;
   300			break;
   301		case IIO_MOD_Y:
   302			ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_Y_H,
   303						data->transf_buf, 2);
   304			if (ret < 0)
   305				goto out_unlock;
   306			data->y_calibbias = calibbias;
   307			break;
   308		case IIO_MOD_Z:
   309			ret = regmap_bulk_write(data->regmap, ADXL355_OFFSET_Z_H,
   310						data->transf_buf, 2);
   311			if (ret < 0)
   312				goto out_unlock;
   313			data->z_calibbias = calibbias;
   314			break;
   315		default:
   316			ret = -EINVAL;
   317			break;
   318		}
   319	
   320	out_unlock:
   321		ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
   322		mutex_unlock(&data->lock);
   323		return ret;
   324	}
   325	
   326	static int adxl355_read_raw(struct iio_dev *indio_dev,
   327				    struct iio_chan_spec const *chan,
   328				    int *val, int *val2, long mask)
   329	{
   330		struct adxl355_data *data = iio_priv(indio_dev);
   331		int ret;
   332		__be16 out;
   333	
   334		switch (mask) {
   335		case IIO_CHAN_INFO_RAW:
   336			switch (chan->type) {
   337			case IIO_TEMP:
   338				ret = adxl355_get_temp_data(data, chan->address);
   339				if (ret < 0)
   340					return ret;
 > 341				out = (data->transf_buf[1] << 8) + data->transf_buf[0];
   342				*val = be16_to_cpu(out);
   343	
   344				return IIO_VAL_INT;
   345			case IIO_ACCEL:
   346				ret = adxl355_read_axis(data, chan->address);
   347				if (ret < 0)
   348					return ret;
   349				*val = sign_extend32(ret >> (chan->scan_type.shift),
   350						     chan->scan_type.realbits - 1);
   351				return IIO_VAL_INT;
   352			default:
   353				return -EINVAL;
   354			}
   355	
   356		case IIO_CHAN_INFO_SCALE:
   357			switch (chan->type) {
   358			case IIO_TEMP:
   359				*val = TEMP_SCALE_VAL;
   360				*val2 = TEMP_SCALE_VAL2;
   361				return IIO_VAL_INT_PLUS_MICRO;
   362			case IIO_ACCEL:
   363				*val = 0;
   364				*val2 = ADXL355_NSCALE;
   365				return IIO_VAL_INT_PLUS_NANO;
   366			default:
   367				return -EINVAL;
   368			}
   369		case IIO_CHAN_INFO_OFFSET:
   370			*val = TEMP_OFFSET_VAL;
   371			*val2 = TEMP_OFFSET_VAL2;
   372			return IIO_VAL_INT_PLUS_MICRO;
   373		case IIO_CHAN_INFO_CALIBBIAS:
   374			if (chan->channel2 == IIO_MOD_X)
   375				*val = data->x_calibbias;
   376			else if (chan->channel2 == IIO_MOD_Y)
   377				*val = data->y_calibbias;
   378			else
   379				*val = data->z_calibbias;
   380			*val = sign_extend32(*val, 15);
   381			return IIO_VAL_INT;
   382		case IIO_CHAN_INFO_SAMP_FREQ:
   383			*val = adxl355_odr_table[data->odr][0];
   384			*val2 = adxl355_odr_table[data->odr][1];
   385			return IIO_VAL_INT_PLUS_MICRO;
   386		case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
   387			*val = data->adxl355_hpf_3db_table[data->hpf_3db][0];
   388			*val2 = data->adxl355_hpf_3db_table[data->hpf_3db][1];
   389			return IIO_VAL_INT_PLUS_MICRO;
   390		default:
   391			return -EINVAL;
   392		}
   393	}
   394	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/9DWx/yDrRhgMJTb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
uAG+rTACAA==

--/9DWx/yDrRhgMJTb--
