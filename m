Return-Path: <linux-iio+bounces-14959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C681A26DD4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21333A603F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61BD207651;
	Tue,  4 Feb 2025 08:57:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951B207641
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659469; cv=none; b=e8ayC+H/tXW4p4VW1ZhJS0g50zr78cHLq2L8uoK8g/ChF2tt6+Z4bSOyomrtu0dSzt+JazLeV+lXhwp6MwdnZibtykl/fIqfZDokyidyGe4CWrCJhePwf/+h0fHNokVtKw+senC+ff2YPfTuXETRf6K7W/bbkKdMbKeqfFUq+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659469; c=relaxed/simple;
	bh=eVeozBf4wpq86NhE9S3C3sQL2NOMurswc2M5/jG8nLo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrpmHdqcVLSg8VwFKNuM5Wmq3AbHMr1lM+6NFxLAhwqDhbBEzGf2AAxTF+mwsNU6ifhlc7QfGy56xMCMq86Sadt61HAGy/cbuovQCWC7HS6fbJoq787FkDk0EDuJHf8ymeJmuw16EJcMcSgCbEozQYAnRzVtN9MkTDtc1rF1dJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnHJL01z0z6D9XP;
	Tue,  4 Feb 2025 16:55:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F39AC140498;
	Tue,  4 Feb 2025 16:57:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 09:57:43 +0100
Date: Tue, 4 Feb 2025 08:57:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: <oe-kbuild-all@lists.linux.dev>, Nuno Sa <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: [jic23-iio:testing 23/47] drivers/iio/dac/adi-axi-dac.c:731
 axi_dac_bus_set_io_mode() warn: always true condition '(mode >= 0) =>
 (0-u32max >= 0)'
Message-ID: <20250204085744.000075d4@huawei.com>
In-Reply-To: <rhmmbt3yqfqhodivu2smuu4g2i77sqyzr3jjjxtvjsny7a6jgd@64bong6elaul>
References: <202502040758.DJqHqhLO-lkp@intel.com>
	<rhmmbt3yqfqhodivu2smuu4g2i77sqyzr3jjjxtvjsny7a6jgd@64bong6elaul>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 09:43:17 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan,
> 
> On 04.02.2025 07:23, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > head:   315198c0a370da031f5c3d504b99f771a0c545ab
> > commit: 493122c53af1915b4b5b5f47a8c446973ebff052 [23/47] iio: dac: adi-axi-dac: add bus mode setup
> > config: m68k-randconfig-r071-20250204 (https://download.01.org/0day-ci/archive/20250204/202502040758.DJqHqhLO-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 14.2.0
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202502040758.DJqHqhLO-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode() warn: always true condition '(mode >= 0) => (0-u32max >= 0)'
> > 
> > vim +731 drivers/iio/dac/adi-axi-dac.c
> > 
> >    724	
> >    725	static int axi_dac_bus_set_io_mode(struct iio_backend *back,
> >    726					   enum ad3552r_io_mode mode)
> >    727	{
> >    728		struct axi_dac_state *st = iio_backend_get_priv(back);
> >    729		int ival, ret;
> >    730	  
> >  > 731		if (!(mode >= AD3552R_IO_MODE_SPI && mode <= AD3552R_IO_MODE_QSPI))  
> >    732  
> 
> not clear to me the reason of this warning, maybe because mode is an enum ?
> Should i take any action ?

Currently there are only a few modes in there and that range covers them all I think.
So warning is correct, but we perhaps want this check there as hardening against future
addition of more modes.  Maybe an explicit switch with all modes listed and a default
will have same effect and be better defense anyway against future changes?

Jonathan


> 
> 			return -EINVAL;
> >    733	
> >    734		guard(mutex)(&st->lock);
> >    735	
> >    736		ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> >    737				AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
> >    738				FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
> >    739		if (ret)
> >    740			return ret;
> >    741	
> >    742		return regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, ival,
> >    743				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0, 10,
> >    744				100 * KILO);
> >    745	}
> >    746	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki  
> 
> Thanks,
> regards,
> angelo


