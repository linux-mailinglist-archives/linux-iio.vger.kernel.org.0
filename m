Return-Path: <linux-iio+bounces-15553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1FA37044
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 20:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27353B0B1A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B91F37BA;
	Sat, 15 Feb 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYxAA92b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9861624D3;
	Sat, 15 Feb 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739646086; cv=none; b=Ohm5oOGvo4CL1Pwp20hRg5YzCV0tMECeafzkHm9EQHOSVDV5hNpxGvw2TVWzhop+cYhXBBp+0iMwuEP6TvtaVs0MiMIrHU/e3rg0rjWhRR+LZlcpis5lz/gP7dqxbndFXTRCw7eRDgqX0UqVOzs8NobpDa+XJP13BoBRJSjp22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739646086; c=relaxed/simple;
	bh=n2T5ALAvOjzcLfMUoAUQzDS5Pil5vEK2a1j8TFhdPwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0u6O+lNVwTGeMcYAoDeahsoV2Q0rqLwXGNBQ/+TI0pFLO9aTE9a1eKUfYnhZz9X8fgQT+SsKMl2FDcy9aSbB5WkFaJGVlSrXjyN2aKrlDojjgX198u2K3idHvbuKRIp55kBE85sfgmAK0luAub01QpGmiu39D5E+kZQUb09r/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYxAA92b; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739646084; x=1771182084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n2T5ALAvOjzcLfMUoAUQzDS5Pil5vEK2a1j8TFhdPwc=;
  b=SYxAA92bwBAKd7ikL8uHL0XMGdrM936Zunf+dsIp/uRu93KEZHyAaPtu
   UcVsxSzrL6qt9ojlByJm/ptaiSEQ0MAyc/JQsVB19Y3f+hd6YQCxkdf63
   sElI0Z9itucEsWK/ZJj+Tn2VFL3c2lkREeRI4a1mQqg2mwTYFxiF6a7F4
   X0LeykQf4CcOKIZaalMNVoJzLIPEWnxB7uNyBOzveneCO9Wan0Kq0+t9g
   ut9dQAVL/OOAaK/kG//gLBn+0DRHztHLGchfiEk7LwrahefJ86XYQ8saW
   QQr36DBGVtof+UxZMmcxL97KvqvsIl8TuG9yblMewAn9OREMjvmOEu+CZ
   w==;
X-CSE-ConnectionGUID: hdR84jj3RP2sPtuS8OeY/w==
X-CSE-MsgGUID: R9DeAuqdQkGzlRBlS9eOuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="44306130"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="44306130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 11:01:23 -0800
X-CSE-ConnectionGUID: fJ40fCTkSL6yxIi6UPX3jw==
X-CSE-MsgGUID: E8f7gK+JSIG+E9h2IMF7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113618487"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Feb 2025 11:01:19 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjNPh-001B63-1m;
	Sat, 15 Feb 2025 19:01:17 +0000
Date: Sun, 16 Feb 2025 03:00:59 +0800
From: kernel test robot <lkp@intel.com>
To: Esteban Blanc <eblanc@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
Subject: Re: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
Message-ID: <202502160240.IoVS8Klu-lkp@intel.com>
References: <20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a@baylibre.com>

Hi Esteban,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/dt-bindings-iio-adc-add-ADI-ad4030-ad4630-and-ad4632/20250214-202727
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a%40baylibre.com
patch subject: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250216/202502160240.IoVS8Klu-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160240.IoVS8Klu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160240.IoVS8Klu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad4030.c: In function 'ad4030_get_chan_scale':
>> drivers/iio/adc/ad4030.c:375:27: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     375 |                 scan_type = iio_get_current_scan_type(indio_dev,
         |                           ^


vim +/const +375 drivers/iio/adc/ad4030.c

   365	
   366	static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
   367					 struct iio_chan_spec const *chan,
   368					 int *val,
   369					 int *val2)
   370	{
   371		struct ad4030_state *st = iio_priv(indio_dev);
   372		struct iio_scan_type *scan_type;
   373	
   374		if (chan->differential) {
 > 375			scan_type = iio_get_current_scan_type(indio_dev,
   376							      st->chip->channels);
   377			*val = (st->vref_uv * 2) / MILLI;
   378			*val2 = scan_type->realbits;
   379			return IIO_VAL_FRACTIONAL_LOG2;
   380		}
   381	
   382		*val = st->vref_uv / MILLI;
   383		*val2 = chan->scan_type.realbits;
   384		return IIO_VAL_FRACTIONAL_LOG2;
   385	}
   386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

