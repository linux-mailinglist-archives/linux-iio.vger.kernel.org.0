Return-Path: <linux-iio+bounces-13186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79D9E7BB3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D01284151
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3965B1EF0B3;
	Fri,  6 Dec 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPVL+eqt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8741714DF;
	Fri,  6 Dec 2024 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523934; cv=none; b=ozTSA+zyLAnYEad/O2hGvCzYdAMGwZxz5KmUK98gJV/eu0K0XFe66RRhJxNssgCHxoKqO1PK++mk+GSgkaiCaOrOtBkcu2SvsKONayAaTWkeLkIAxbobwg70xAjnMA81TdWFSGFdEfbQ6w0d2NNJMaUz04fmy7ng1Xygxfo5FAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523934; c=relaxed/simple;
	bh=bCffiw8OTwFgkjUxdoGc91mQ61iZQnE3xHFFCbqUAlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSUqlniz/dg0ol0OwWpzARSfX7XKevyz5s4JPyQbvc1V7unuOmorYqFvR1j2gOUpyRCjg0K2qWZussK2Totgtd59S6cCPMPEP1BF4CJEhsJ8iS3kQaJ+tODceektTLVC2fZIitBW9+SH8cQK71beP4Y+m0r5ZdXKHbDEYopXrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPVL+eqt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733523932; x=1765059932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bCffiw8OTwFgkjUxdoGc91mQ61iZQnE3xHFFCbqUAlY=;
  b=BPVL+eqtQzBzftX/283oeX6TeY3nHfk3bEIM5nnGms5QAAcCOb4CXCSr
   CVvUp8zL2n5dRo/EaydciTP4AwTxmYHlmGct9XtzGU+pNQWEF1ZZxpWtE
   pai7pnFP4vi/wKNOiEh1C/uxhrIR0F37xgC63YIgkmVD8tWxqimvsaS6g
   yDe9aOSzR2XtqCShVuB0zi2EnUlCGXbJijOHqB+bs7WOxX9Uyv0yrZ4n6
   bEpWOlWKWaC7gDN1J9o5BZu0fES4Mp5Y15DzO9T2g5aqpdpFFLbMEvkGK
   qGX8ftseRzHjg+lEmsHBswXEiAAs2mUgTQXDjzdBRBA1RuYerGGyFSbR7
   Q==;
X-CSE-ConnectionGUID: YwXzhM3pRKO5Um7rlHcNuw==
X-CSE-MsgGUID: 4a4x9xJ1QNGnYHqgUlOyAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="44565162"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="44565162"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 14:25:31 -0800
X-CSE-ConnectionGUID: YiK7CDGQR8Kyz3eZXpGVJQ==
X-CSE-MsgGUID: NLDm8aHvRMWdUqnSlq2szA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="95009660"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 14:25:26 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJglH-0002J7-1P;
	Fri, 06 Dec 2024 22:25:23 +0000
Date: Sat, 7 Dec 2024 06:24:58 +0800
From: kernel test robot <lkp@intel.com>
To: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <202412070600.aufBle2b-lkp@intel.com>
References: <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>

Hi Mikael,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5de07b8a24cf44cdb78adeab790704bf577c2c1d]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikael-Gonella-Bolduc-via-B4-Relay/dt-bindings-iio-light-Add-APDS9160-binding/20241207-001144
base:   5de07b8a24cf44cdb78adeab790704bf577c2c1d
patch link:    https://lore.kernel.org/r/20241206-apds9160-driver-v2-2-be2cb72ef8f4%40dimonoff.com
patch subject: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241207/202412070600.aufBle2b-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070600.aufBle2b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070600.aufBle2b-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/iio/light/apds9160.c: In function 'apds9160_read_raw':
>> drivers/iio/light/apds9160.c:911:32: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     911 |                         *val = FIELD_GET(APDS9160_PS_DATA_MASK, *val);
         |                                ^~~~~~~~~
   drivers/iio/light/apds9160.c: At top level:
>> drivers/iio/light/apds9160.c:256:18: warning: 'apds9160_als_gain_avail' defined but not used [-Wunused-const-variable=]
     256 | static const int apds9160_als_gain_avail[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~


vim +/FIELD_GET +911 drivers/iio/light/apds9160.c

   889	
   890	static int apds9160_read_raw(struct iio_dev *indio_dev,
   891				     struct iio_chan_spec const *chan, int *val,
   892				     int *val2, long mask)
   893	{
   894		struct apds9160_chip *data = iio_priv(indio_dev);
   895		int ret = -EINVAL;
   896	
   897		switch (mask) {
   898		case IIO_CHAN_INFO_RAW:
   899			switch (chan->type) {
   900			case IIO_PROXIMITY: {
   901				__le16 buf;
   902	
   903				ret = regmap_bulk_read(data->regmap, chan->address,
   904						       &buf, 2);
   905				if (ret)
   906					return ret;
   907	
   908				ret = IIO_VAL_INT;
   909				*val = le16_to_cpu(buf);
   910				/* Remove overflow bits from result */
 > 911				*val = FIELD_GET(APDS9160_PS_DATA_MASK, *val);
   912			} break;
   913			case IIO_LIGHT:
   914			case IIO_INTENSITY: {
   915				u8 buf[3];
   916	
   917				ret = regmap_bulk_read(data->regmap, chan->address,
   918						       &buf, 3);
   919				if (ret)
   920					return ret;
   921	
   922				ret = IIO_VAL_INT;
   923				*val = get_unaligned_le24(buf);
   924			} break;
   925			case IIO_CURRENT:
   926				ret = IIO_VAL_INT;
   927				*val = data->ps_current;
   928				break;
   929			default:
   930				break;
   931			}
   932			break;
   933		case IIO_CHAN_INFO_HARDWAREGAIN:
   934			switch (chan->type) {
   935			case IIO_LIGHT:
   936				ret = IIO_VAL_INT;
   937				*val = data->als_hwgain;
   938				break;
   939			case IIO_PROXIMITY:
   940				ret = IIO_VAL_INT;
   941				*val = data->ps_gain;
   942				break;
   943			default:
   944				break;
   945			}
   946			break;
   947		case IIO_CHAN_INFO_INT_TIME:
   948			switch (chan->type) {
   949			case IIO_LIGHT:
   950				ret = IIO_VAL_INT;
   951				*val = data->als_itime;
   952				break;
   953			default:
   954				break;
   955			}
   956			break;
   957		case IIO_CHAN_INFO_SAMP_FREQ:
   958			switch (chan->type) {
   959			case IIO_PROXIMITY:
   960				ret = IIO_VAL_INT;
   961				*val = data->ps_rate;
   962				break;
   963			default:
   964				break;
   965			}
   966			break;
   967		case IIO_CHAN_INFO_CALIBSCALE:
   968			switch (chan->type) {
   969			case IIO_PROXIMITY:
   970				ret = IIO_VAL_INT;
   971				*val = data->ps_cancellation_level;
   972				break;
   973			default:
   974				break;
   975			}
   976			break;
   977		case IIO_CHAN_INFO_CALIBBIAS:
   978			switch (chan->type) {
   979			case IIO_PROXIMITY:
   980				ret = IIO_VAL_INT;
   981				*val = data->ps_cancellation_analog;
   982				break;
   983			case IIO_CURRENT:
   984				ret = IIO_VAL_INT;
   985				*val = data->ps_cancellation_current;
   986			default:
   987				break;
   988			}
   989			break;
   990		case IIO_CHAN_INFO_SCALE:
   991			switch (chan->type) {
   992			case IIO_LIGHT:
   993				ret = IIO_VAL_INT_PLUS_MICRO;
   994				*val = data->als_scale1;
   995				*val2 = data->als_scale2;
   996				break;
   997			default:
   998				break;
   999			}
  1000			break;
  1001		default:
  1002			break;
  1003		}
  1004	
  1005		return ret;
  1006	};
  1007	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

