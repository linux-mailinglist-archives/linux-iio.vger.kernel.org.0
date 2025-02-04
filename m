Return-Path: <linux-iio+bounces-14991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA63A27B3A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B049618868E0
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52968217647;
	Tue,  4 Feb 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwynTe1n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CB217658;
	Tue,  4 Feb 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697284; cv=none; b=g3tnm1yawWdoUQ4GoasFuCQiqu5nbHgKsf2Tzl9+jL4AqF2xDCjRrKCBYpEzbQMJIR31Pl2+8UQwYVbTtSjTQbfVo59r1cbUo3R7kPTW5rNLyR9lii7yDYyNZdAvcYYbwrDKjc6echeIPjG22XgPFMVZr/VVnjrJIreHrKpbxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697284; c=relaxed/simple;
	bh=5OL1rXLC4ed1yv0J7a+qTrQUTfSLB9RE3Knf5PomOz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnwqdfWGp4gUuBu7moXyHshz5qYmrPucbGi+x0Ii/hnK80QTlSWJX18btfhlMHDMWwO3Ojncoaq+vtSRCQW8oT/U9D6OlYbvcfGRbY92uYUCnpmKqs0a2tMS5TsghekQe2b7cG8/A7yRMc9wy+gYacl/0p1Smwg/94r4er0QhWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwynTe1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4046AC4CEDF;
	Tue,  4 Feb 2025 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697283;
	bh=5OL1rXLC4ed1yv0J7a+qTrQUTfSLB9RE3Knf5PomOz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwynTe1nwdIxQmOvOkWuSTp7h3S35GRpDIdrPXRvNzpFtuEY+do51JPADAoWk5l6p
	 PEUu27D5KDHkjZZBVR+m9PsPCqC8IX5Z8dV7hrMc97RZ1MIje/N9aS4WVQcQoEUYn+
	 f63p4PwwS98NT5kbCCGnUv8e47h2QfzaOhG+Hn/bFgD/01ibYzyZZXYBeOtgU0vWN+
	 DkYR0ORhmDYI8bqL/bdot3JTkh3UqfPrnsY/0ASUH0w5uMlny4Jh6ug+eKxJe6CGwY
	 NwYm7dn+QUkgSbU6VmzuWKJe0eyGs8Y/nmSWT0yR2oE5Uyb6zQ8pqOfYjtywvYQcVL
	 QsRVR1T8b+YSQ==
Date: Tue, 4 Feb 2025 19:27:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 oe-kbuild-all@lists.linux.dev, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org
Subject: Re: [jic23-iio:testing 23/47] drivers/iio/dac/adi-axi-dac.c:731
 axi_dac_bus_set_io_mode() warn: always true condition '(mode >= 0) =>
 (0-u32max >= 0)'
Message-ID: <20250204192755.1567b092@jic23-huawei>
In-Reply-To: <l575dzyjzix2xnljfadw5uuu3qdzhmtcbkyg6eaccf2h5dtvsz@ju5mqszl2vzb>
References: <202502040758.DJqHqhLO-lkp@intel.com>
	<rhmmbt3yqfqhodivu2smuu4g2i77sqyzr3jjjxtvjsny7a6jgd@64bong6elaul>
	<20250204085744.000075d4@huawei.com>
	<l575dzyjzix2xnljfadw5uuu3qdzhmtcbkyg6eaccf2h5dtvsz@ju5mqszl2vzb>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 10:12:05 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 04.02.2025 08:57, Jonathan Cameron wrote:
> > On Tue, 4 Feb 2025 09:43:17 +0100
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >   
> > > Hi Jonathan,
> > > 
> > > On 04.02.2025 07:23, kernel test robot wrote:  
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > > > head:   315198c0a370da031f5c3d504b99f771a0c545ab
> > > > commit: 493122c53af1915b4b5b5f47a8c446973ebff052 [23/47] iio: dac: adi-axi-dac: add bus mode setup
> > > > config: m68k-randconfig-r071-20250204 (https://download.01.org/0day-ci/archive/20250204/202502040758.DJqHqhLO-lkp@intel.com/config)
> > > > compiler: m68k-linux-gcc (GCC) 14.2.0
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202502040758.DJqHqhLO-lkp@intel.com/
> > > > 
> > > > smatch warnings:
> > > > drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode() warn: always true condition '(mode >= 0) => (0-u32max >= 0)'
> > > > 
> > > > vim +731 drivers/iio/dac/adi-axi-dac.c
> > > > 
> > > >    724	
> > > >    725	static int axi_dac_bus_set_io_mode(struct iio_backend *back,
> > > >    726					   enum ad3552r_io_mode mode)
> > > >    727	{
> > > >    728		struct axi_dac_state *st = iio_backend_get_priv(back);
> > > >    729		int ival, ret;
> > > >    730	    
> > > >  > 731		if (!(mode >= AD3552R_IO_MODE_SPI && mode <= AD3552R_IO_MODE_QSPI))    
> > > >    732    
> > > 
> > > not clear to me the reason of this warning, maybe because mode is an enum ?
> > > Should i take any action ?  
> > 
> > Currently there are only a few modes in there and that range covers them all I think.
> > So warning is correct, but we perhaps want this check there as hardening against future
> > addition of more modes.  Maybe an explicit switch with all modes listed and a default
> > will have same effect and be better defense anyway against future changes?
> > 
> > Jonathan  
> 
> thanks, clear now. 
> Is maintaining the waring an issue ?
> Another chance may be adding a AD3552R_IO_MODE_MAX as last item ?

Hmm. If these are the only plausible modes for enum ad3552r_io_mode
ever to have, we could just drop the check.

> 
> angelo
> > 
> >   
> > > 
> > > 			return -EINVAL;  
> > > >    733	
> > > >    734		guard(mutex)(&st->lock);
> > > >    735	
> > > >    736		ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > >    737				AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
> > > >    738				FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
> > > >    739		if (ret)
> > > >    740			return ret;
> > > >    741	
> > > >    742		return regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, ival,
> > > >    743				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0, 10,
> > > >    744				100 * KILO);
> > > >    745	}
> > > >    746	
> > > > 
> > > > -- 
> > > > 0-DAY CI Kernel Test Service
> > > > https://github.com/intel/lkp-tests/wiki    
> > > 
> > > Thanks,
> > > regards,
> > > angelo  
> >   
> 


