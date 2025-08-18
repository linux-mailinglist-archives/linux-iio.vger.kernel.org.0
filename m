Return-Path: <linux-iio+bounces-22925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04FAB2AC18
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2BB7A8C58
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA34248F77;
	Mon, 18 Aug 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYf5Tz43"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5724886A;
	Mon, 18 Aug 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529626; cv=none; b=FkR7sxRAvrWHl5gEeBuxRqRmZVCvPGjT6Rx6ekImACPsHLvXi86A/9JTYK7p1usbIa55jMOICjxFd/IGpl/zlVg2uSsGekXz++ZOk5r00h0U7U0jMsKE8qey0lC/9SsicHy8ySGs+pPpCtsuLVkmO5Ppj8GJXZzCPD6cGSQ5pVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529626; c=relaxed/simple;
	bh=K3wfM6saGhUQWs89b5LMhe+u1iiQN3dMtS9kmXFdJas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpKfgOjpq5r6babPwewO9Xvo4d2hPayGp11NQ5q8XqEF42zj1fvLqhPQl1bOmN+76jCCvQ6Oq7jEkDkEVeNquEAGSmMoq65NyCeP4iV8FhQulDvMTR/vuscd0Memez9Sy7rWBQrAdCCOrIPtDXAqyF5Q28Mp6ul3qakT6YP1Ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYf5Tz43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11F8C4CEEB;
	Mon, 18 Aug 2025 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755529625;
	bh=K3wfM6saGhUQWs89b5LMhe+u1iiQN3dMtS9kmXFdJas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYf5Tz43JJDCueeJYfM24Nubfegp36SkiqBO5owWlKF88+zKayugejamGBvPxpvac
	 IutJYpI3U4nNwsnKYp7X37bRfj8Vc1qv9Ax53V9i12l77BJxB6U4/BkmeFUKVE0Ald
	 xFtiXI+zsDo2FC/sYvBo6t91CQ1YCkPEdGgRZ8zAn4g4+xh6gDzErqX58lbsCRAKv/
	 McSfemHdViSeMM2JwBvSABK0V+hZLAFlHpvqqu8iThMW6+MUMofhJ7yHA5wQRinWwi
	 vijNcGLbFY8z3slMLw07SfGqBElMOheFmL2FFA5OoScAgbdULf46D1A2dAcETyUfeU
	 T+NUq9+AFq02Q==
Date: Mon, 18 Aug 2025 08:06:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Ben Collins <bcollins@watter.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <20250818150659.GA2948920@ax162>
References: <20250815164627.22002-4-bcollins@watter.com>
 <202508161646.PDl6V4EU-lkp@intel.com>
 <20250816110243.06fbf7fb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816110243.06fbf7fb@jic23-huawei>

Hi Jonathan,

On Sat, Aug 16, 2025 at 11:02:43AM +0100, Jonathan Cameron wrote:
> On Sat, 16 Aug 2025 16:46:12 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Ben,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on jic23-iio/togreg]
> > [also build test WARNING on linus/master v6.17-rc1 next-20250815]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Collins/dt-bindings-iio-mcp9600-Add-compatible-for-microchip-mcp9601/20250816-005705
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > patch link:    https://lore.kernel.org/r/20250815164627.22002-4-bcollins%40watter.com
> > patch subject: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
> > config: riscv-randconfig-001-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202508161646.PDl6V4EU-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):

<trim unrelated -Wnull-pointer-arithmetic>

> > >> drivers/iio/temperature/mcp9600.c:440:53: warning: invalid conversion specifier '\x0a' [-Wformat-invalid-specifier]  
> >      440 |                                 "Expected id %02x, but device responded with %02\n",
> >          |                                                                              ~~~^
> >    include/linux/dev_printk.h:156:62: note: expanded from macro 'dev_warn'
> >      156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |                                                                     ^~~
> >    include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
> >       19 | #define dev_fmt(fmt) fmt
> >          |                      ^~~
> >    include/linux/dev_printk.h:110:16: note: expanded from macro 'dev_printk_index_wrap'
> >      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> >          |                              ^~~
> > >> drivers/iio/temperature/mcp9600.c:441:26: warning: data argument not used by format string [-Wformat-extra-args]  
> >      440 |                                 "Expected id %02x, but device responded with %02\n",
> >          |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      441 |                                  chip_info->chip_id, dev_id);
> >          |                                                      ^
> >    include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
> >      156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |                                                                     ~~~     ^
> >    include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> >      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> >          |                              ~~~    ^
> >    drivers/iio/temperature/mcp9600.c:428:22: warning: unused variable 'ret' [-Wunused-variable]
> >      428 |         int ch_sel, dev_id, ret;
> >          |                             ^~~
> >    10 warnings generated.
> > 
> > 
> > vim +/x0a +440 drivers/iio/temperature/mcp9600.c
> > 
> >    422	
> >    423	static int mcp9600_probe(struct i2c_client *client)
> >    424	{
> >    425		const struct mcp_chip_info *chip_info = i2c_get_match_data(client);
> 
> Probably a false positive as I don't think we can probe without something matching and hence
> that not being NULL but an error check on that match is still a nice to have and should
> resolve this build warning.  Note there is very little chance a compiler could ever figure
> out if this can be NULL or not so it's a reasonable warning!

I am not sure I follow if you are referring to the -Wformat warnings
above. Isn't it pointing out that the second specifier is missing the
actual type? Shouldn't it be '%02x' or something of the sort?

Cheers,
Nathan

