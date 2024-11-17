Return-Path: <linux-iio+bounces-12366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4909D0532
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FE62823D1
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB261DAC93;
	Sun, 17 Nov 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmeZq9g5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5241DAC83;
	Sun, 17 Nov 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868570; cv=none; b=G6slznlQ7IDC+Wo14Q+ZJ/1KufDdQf9JBwE8ywtPp0FQPl/22PafUmkPhKbnpC7FtHmumtWUJmHC5LdStvCcVREFWdnLTVGNWSyNDTqPYSfGoyB02ces/s/Hr2RVWrhPSNgp/Ycs28NSDSp/PJ2yI0k1gqo2B1t5KtNGmulS1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868570; c=relaxed/simple;
	bh=0ioLdMkZxydkHixL/mc8uvNwqbZTPJyV3EDH8DzfVz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOiurL6Om5oTvAJ35FLN0d0IagmGMne013gfAbvfV6ttdIrh2JlpIv/zPCHcH4IQBqP7I61h2Kxo26y5cTSoSvXSHxMjxTghBI7CsIf+5PytnVIIBQTO/ASxfEH99fk8gyRBh/HV1cr21sEIjc+BaScdn/nFCXfI8HIKcaqWwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmeZq9g5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731868568; x=1763404568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ioLdMkZxydkHixL/mc8uvNwqbZTPJyV3EDH8DzfVz4=;
  b=MmeZq9g505Sg/r3vSYTn2xezvU/WjCvRqdxSd3DPi5/dLNwb65d5nmEt
   T6qqsqqJXBLqM4gXhEXzH3w27J01cHdU+knRjP40G/5/btfX+IrMwiRUF
   9uzR5QSElul/QZeIe3ZUt3uM2mtV/33twdnanHBvCCqwuMVlPJ3zl9P04
   9UyQdMo06wk9q7mE8x5hl/nqEm6XuOyTQPxw7P5c4VDScWzSs+e9IbgGy
   268I9+D7/Rplx9p7UhibhVO7puvzlZV0PQyzpKqRDRsWRZ3ZvF4xk3AmW
   QK9sMerhWR9LdQxvFRmYlJuXZiHH4DvCENdfdpQTgAzoO0WVrNmesa1Qt
   Q==;
X-CSE-ConnectionGUID: YJRN0Lw7TQOYxvYp9ydkyA==
X-CSE-MsgGUID: Tgd8cJ8zTsOuuTyu4eUY9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="49255293"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="49255293"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 10:36:08 -0800
X-CSE-ConnectionGUID: oTwMlP9tS2qTiCGnSHNewQ==
X-CSE-MsgGUID: j77u9Kw+SLycRTb3LJphWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94064867"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2024 10:36:06 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCk7v-0001zh-1Q;
	Sun, 17 Nov 2024 18:36:03 +0000
Date: Mon, 18 Nov 2024 02:35:19 +0800
From: kernel test robot <lkp@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 22/22] iio: accel: adxl345: add debug printout
Message-ID: <202411180235.gb4VHLRO-lkp@intel.com>
References: <20241114231002.98595-23-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114231002.98595-23-l.rubusch@gmail.com>

Hi Lothar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lothar-Rubusch/iio-accel-adxl345-fix-comment-on-probe/20241115-190245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241114231002.98595-23-l.rubusch%40gmail.com
patch subject: [PATCH 22/22] iio: accel: adxl345: add debug printout
config: x86_64-randconfig-121-20241117 (https://download.01.org/0day-ci/archive/20241118/202411180235.gb4VHLRO-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241118/202411180235.gb4VHLRO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411180235.gb4VHLRO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/iio/accel/adxl345_core.c:613:6: sparse: sparse: symbol 'adxl345_empty_fifo' was not declared. Should it be static?
>> drivers/iio/accel/adxl345_core.c:720:46: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected signed short [usertype] *fifo_buf @@     got restricted __le16 * @@
   drivers/iio/accel/adxl345_core.c:720:46: sparse:     expected signed short [usertype] *fifo_buf
   drivers/iio/accel/adxl345_core.c:720:46: sparse:     got restricted __le16 *

vim +720 drivers/iio/accel/adxl345_core.c

   606	
   607	/**
   608	 * Empty the fifo. This is needed also in case of overflow or error handling.
   609	 * Read out all remaining elements and reset the fifo_entries counter.
   610	 *
   611	 * @st: The instance to the state object of the sensor.
   612	 */
 > 613	void adxl345_empty_fifo(struct adxl34x_state *st)
   614	{
   615		int regval;
   616		int fifo_entries;
   617	
   618		/* In case the HW is not "clean" just read out remaining elements */
   619		adxl345_get_fifo_entries(st, &fifo_entries);
   620		if (fifo_entries > 0)
   621			adxl345_read_fifo_elements(st, fifo_entries);
   622	
   623		/* Reset the INT_SOURCE register by reading the register */
   624		regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
   625	}
   626	
   627	static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
   628	{
   629		struct adxl34x_state *st = iio_priv(indio_dev);
   630		struct adxl34x_platform_data *data = &st->data;
   631		int ret;
   632	
   633		ret = adxl345_set_interrupts(st);
   634		if (ret)
   635			return -EINVAL;
   636	
   637		/* Default to FIFO mode: STREAM, since it covers the general usage
   638		 * and does not bypass the FIFO
   639		 */
   640		data->fifo_mode = ADXL_FIFO_STREAM;
   641		adxl345_set_fifo(st);
   642	
   643		return 0;
   644	}
   645	
   646	static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
   647	{
   648		struct adxl34x_state *st = iio_priv(indio_dev);
   649		struct adxl34x_platform_data *data = &st->data;
   650		int ret;
   651	
   652		/* Turn off interrupts */
   653		st->int_map = 0x00;
   654	
   655		ret = adxl345_set_interrupts(st);
   656		if (ret) {
   657			pr_warn("%s(): Failed to disable INTs\n", __func__);
   658			return -EINVAL;
   659		}
   660	
   661		/* Set FIFO mode: BYPASS, according to the situation */
   662		data->fifo_mode = ADXL_FIFO_BYPASS;
   663		adxl345_set_fifo(st);
   664	
   665		return 0;
   666	}
   667	
   668	static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
   669		.postenable = adxl345_buffer_postenable,
   670		.predisable = adxl345_buffer_predisable,
   671	};
   672	
   673	static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
   674	{
   675		int ret;
   676		unsigned int regval;
   677	
   678		*int_stat = 0;
   679		ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
   680		if (ret) {
   681			pr_warn("%s(): Failed to read INT_SOURCE register\n", __func__);
   682			return -EINVAL;
   683		}
   684	
   685		*int_stat = 0xff & regval;
   686		pr_debug("%s(): int_stat 0x%02X (INT_SOURCE)\n", __func__, *int_stat);
   687	
   688		return 0;
   689	}
   690	
   691	static int adxl345_push_fifo_data(struct iio_dev *indio_dev,
   692					  u8 status,
   693					  int fifo_entries)
   694	{
   695		struct adxl34x_state *st = iio_priv(indio_dev);
   696		int ndirs = 3; /* 3 directions */
   697		int i, ret;
   698	
   699		if (fifo_entries <= 0)
   700			return true;
   701	
   702		ret = adxl345_read_fifo_elements(st, fifo_entries);
   703		if (ret)
   704			return false;
   705	
   706		for (i = 0; i < ndirs * fifo_entries; i += ndirs) {
   707			/* To ensure that the FIFO has completely popped, there must be at least 5
   708			 * us between the end of reading the data registers, signified by the
   709			 * transition to register 0x38 from 0x37 or the CS pin going high, and the
   710			 * start of new reads of the FIFO or reading the FIFO_STATUS register. For
   711			 * SPI operation at 1.5 MHz or lower, the register addressing portion of the
   712			 * transmission is sufficient delay to ensure the FIFO has completely
   713			 * popped. It is necessary for SPI operation greater than 1.5 MHz to
   714			 * de-assert the CS pin to ensure a total of 5 us, which is at most 3.4 us
   715			 * at 5 MHz operation.
   716			 */
   717			if (st->fifo_delay && (fifo_entries > 1))
   718				udelay(3);
   719	
 > 720			adxl345_debug_fifo(__func__, st->fifo_buf, i);
   721			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
   722		}
   723	
   724		return true;
   725	}
   726	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

