Return-Path: <linux-iio+bounces-24457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF53BA3A97
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695043BE325
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3F32EBDF2;
	Fri, 26 Sep 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpLbGLiB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94846283CB5;
	Fri, 26 Sep 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890669; cv=none; b=gptkAgggd+cGizmahCwhtY8rCLwCK79kFnzP6ZLkqkAURrpOnvDfSrbeqMjNOGmtt5mBWFbxJAm2XU4ufayQ2Z6FIRzu72JfXC37n9qwWn6pdkz5giIOx2bx8XSOJ0aLZGeJFgpuWXFe+yhvKL7P5UIA9uf0+jluBO9tGsuh9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890669; c=relaxed/simple;
	bh=YOV8kARbSyHERIV3BOJ0NkrVjbQ35l4jpMmPcR4lpwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrJiBqI7IjXCzR4ilr3RcpTAipLydcdiMBKO5u2BXoKq4xttNY+s0iLnaPf0A4RoQAKe95lrUikqu7oEMwl9NSan66NEYOFgx7z5um77GVOUnmPdbbc582Ohz+sLNAOziHwOkRNYIvSZYWiEXL+d5+bAEPDU7Tj6SGdvlCeANEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpLbGLiB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758890668; x=1790426668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOV8kARbSyHERIV3BOJ0NkrVjbQ35l4jpMmPcR4lpwI=;
  b=kpLbGLiBOvuTNJTHJCclm9PtfrwHJUhLcN7JJ+EcDkwF416JHLFGMFoi
   x7MStDgi3mNYw95X+JB23DhzHiiEmpfuPc5ASMrUMXkIWucfgMI3EpRaz
   ZSfQMD7IgbFEfajrlhSIP5hw5bkrg+7cW33uB4AKXB6Mkm+oOetZk36lS
   gN09Y2vim6zRlF/KAOeLWYHtmkcsehe7QtDKn5NjzWesdE/VELhO5mFpS
   hidO8lS3UAMefFlN/Nl0DKTDyEgxvfcSSwxebOX7qWE+ECy91p5MgKMzC
   Ov9eS1v4JDJ7dd/WLuZXdC2JDIpAqflgZDVDnuWeYP9A71/+GhE8gQgkU
   A==;
X-CSE-ConnectionGUID: 9etnI7StTSmW7zVNaHEglw==
X-CSE-MsgGUID: xiTYTtjVTDKbmf0F8fKDIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61331494"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61331494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:44:27 -0700
X-CSE-ConnectionGUID: Okz+aTvERQW9YtuQA0189g==
X-CSE-MsgGUID: ElUcopUYT82x8T5Me6b3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="181910463"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Sep 2025 05:44:22 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v27oB-0006Dp-0l;
	Fri, 26 Sep 2025 12:44:19 +0000
Date: Fri, 26 Sep 2025 20:43:34 +0800
From: kernel test robot <lkp@intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com, naresh.solanki@9elements.com,
	michal.simek@amd.com, grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de, marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: Re: [PATCH v2 4/4] iio: mpl3115: add support for sampling frequency
Message-ID: <202509262005.y59poUS9-lkp@intel.com>
References: <20250925204538.63723-5-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925204538.63723-5-apokusinski01@gmail.com>

Hi Antoni,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.17-rc7 next-20250925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoni-Pokusinski/dt-bindings-iio-pressure-add-binding-for-mpl3115/20250926-044905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250925204538.63723-5-apokusinski01%40gmail.com
patch subject: [PATCH v2 4/4] iio: mpl3115: add support for sampling frequency
config: i386-buildonly-randconfig-001-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262005.y59poUS9-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262005.y59poUS9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262005.y59poUS9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/pressure/mpl3115.c:204:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     204 |                 ret = FIELD_GET(MPL3115_CTRL2_ST, ret);
         |                       ^
>> drivers/iio/pressure/mpl3115.c:249:6: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     249 |                                         FIELD_PREP(MPL3115_CTRL2_ST, i));
         |                                         ^
   2 errors generated.


vim +/FIELD_GET +204 drivers/iio/pressure/mpl3115.c

   169	
   170	static int mpl3115_read_raw(struct iio_dev *indio_dev,
   171				    struct iio_chan_spec const *chan,
   172				    int *val, int *val2, long mask)
   173	{
   174		struct mpl3115_data *data = iio_priv(indio_dev);
   175		int ret;
   176	
   177		switch (mask) {
   178		case IIO_CHAN_INFO_RAW:
   179			if (!iio_device_claim_direct(indio_dev))
   180				return -EBUSY;
   181	
   182			ret = mpl3115_read_info_raw(data, chan, val);
   183			iio_device_release_direct(indio_dev);
   184			return ret;
   185	
   186		case IIO_CHAN_INFO_SCALE:
   187			switch (chan->type) {
   188			case IIO_PRESSURE:
   189				*val = 0;
   190				*val2 = 250; /* want kilopascal */
   191				return IIO_VAL_INT_PLUS_MICRO;
   192			case IIO_TEMP:
   193				*val = 0;
   194				*val2 = 62500;
   195				return IIO_VAL_INT_PLUS_MICRO;
   196			default:
   197				return -EINVAL;
   198			}
   199		case IIO_CHAN_INFO_SAMP_FREQ:
   200			ret = i2c_smbus_read_byte_data(data->client, MPL3115_CTRL_REG2);
   201			if (ret < 0)
   202				return ret;
   203	
 > 204			ret = FIELD_GET(MPL3115_CTRL2_ST, ret);
   205	
   206			*val = mpl3115_samp_freq_table[ret][0];
   207			*val2 = mpl3115_samp_freq_table[ret][1];
   208			return IIO_VAL_INT_PLUS_MICRO;
   209		}
   210		return -EINVAL;
   211	}
   212	
   213	static int mpl3115_read_avail(struct iio_dev *indio_dev,
   214				      struct iio_chan_spec const *chan,
   215				      const int **vals, int *type, int *length,
   216				      long mask)
   217	{
   218		if (mask != IIO_CHAN_INFO_SAMP_FREQ)
   219			return -EINVAL;
   220	
   221		*type = IIO_VAL_INT_PLUS_MICRO;
   222		*length = ARRAY_SIZE(mpl3115_samp_freq_table) * 2;
   223		*vals = (int *)mpl3115_samp_freq_table;
   224		return IIO_AVAIL_LIST;
   225	}
   226	
   227	static int mpl3115_write_raw(struct iio_dev *indio_dev,
   228				     const struct iio_chan_spec *chan,
   229				     int val, int val2, long mask)
   230	{
   231		struct mpl3115_data *data = iio_priv(indio_dev);
   232		int i, ret;
   233	
   234		if (mask != IIO_CHAN_INFO_SAMP_FREQ)
   235			return -EINVAL;
   236	
   237		for (i = 0; i < ARRAY_SIZE(mpl3115_samp_freq_table); i++)
   238			if (val == mpl3115_samp_freq_table[i][0] &&
   239			    val2 == mpl3115_samp_freq_table[i][1])
   240				break;
   241	
   242		if (i == ARRAY_SIZE(mpl3115_samp_freq_table))
   243			return -EINVAL;
   244	
   245		if (!iio_device_claim_direct(indio_dev))
   246			return -EBUSY;
   247	
   248		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG2,
 > 249						FIELD_PREP(MPL3115_CTRL2_ST, i));
   250		iio_device_release_direct(indio_dev);
   251		return ret;
   252	}
   253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

