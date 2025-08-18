Return-Path: <linux-iio+bounces-22929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCBB2AC90
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111F61675E4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D72A1DA3D;
	Mon, 18 Aug 2025 15:18:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06C21ABDB;
	Mon, 18 Aug 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530334; cv=none; b=j45Qz58haPzOAqaL0QjsoeNnubp0CCobmDz6QvEBcHtX9oSSGcpWr5PPzjJ4JrabgkwaVmUmIfwDdM4sC9s4qmN8EzegkzUU4gLP1B0lh+i4vi9hRkh/9ZR3reldSgpp6d5XwzHcZdB0tCT35AvQfiJz08naBrJCOBbwLFK64zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530334; c=relaxed/simple;
	bh=ukmlTHTouf5G9dMeqhHxsdEphPg6Nyz2tjN77gIOvQc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv7ppXTA9SVW5CseTWCrTayDmREqETqngDzEzHe4pPBS9lFgatV4xy94uJ1LTPFGB0kLW63RlywVF71KoU2NNeWUTbbLt+RWfCv5Oy7HC5kW/fjxQDI4Nl3HqTBd2jpcWquXPZBx7Dha1RuwlnZdZWlx+1G/O0Ea/oDL2LlDrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5GX54YLFz6D9JR;
	Mon, 18 Aug 2025 23:16:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 55A881402F8;
	Mon, 18 Aug 2025 23:18:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 18 Aug
 2025 17:18:41 +0200
Date: Mon, 18 Aug 2025 16:18:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, kernel test robot <lkp@intel.com>,
	Ben Collins <bcollins@watter.com>, David Lechner <dlechner@baylibre.com>,
	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <20250818161840.00002ecd@huawei.com>
In-Reply-To: <20250818150659.GA2948920@ax162>
References: <20250815164627.22002-4-bcollins@watter.com>
	<202508161646.PDl6V4EU-lkp@intel.com>
	<20250816110243.06fbf7fb@jic23-huawei>
	<20250818150659.GA2948920@ax162>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 18 Aug 2025 08:06:59 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Jonathan,
> 
> On Sat, Aug 16, 2025 at 11:02:43AM +0100, Jonathan Cameron wrote:
> > On Sat, 16 Aug 2025 16:46:12 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >   
> > > Hi Ben,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on jic23-iio/togreg]
> > > [also build test WARNING on linus/master v6.17-rc1 next-20250815]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Collins/dt-bindings-iio-mcp9600-Add-compatible-for-microchip-mcp9601/20250816-005705
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > > patch link:    https://lore.kernel.org/r/20250815164627.22002-4-bcollins%40watter.com
> > > patch subject: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
> > > config: riscv-randconfig-001-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/config)
> > > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508161646.PDl6V4EU-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202508161646.PDl6V4EU-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):  
> 
> <trim unrelated -Wnull-pointer-arithmetic>
> 
> > > >> drivers/iio/temperature/mcp9600.c:440:53: warning: invalid conversion specifier '\x0a' [-Wformat-invalid-specifier]    
> > >      440 |                                 "Expected id %02x, but device responded with %02\n",
> > >          |                                                                              ~~~^
> > >    include/linux/dev_printk.h:156:62: note: expanded from macro 'dev_warn'
> > >      156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |                                                                     ^~~
> > >    include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
> > >       19 | #define dev_fmt(fmt) fmt
> > >          |                      ^~~
> > >    include/linux/dev_printk.h:110:16: note: expanded from macro 'dev_printk_index_wrap'
> > >      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> > >          |                              ^~~  
> > > >> drivers/iio/temperature/mcp9600.c:441:26: warning: data argument not used by format string [-Wformat-extra-args]    
> > >      440 |                                 "Expected id %02x, but device responded with %02\n",
> > >          |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >      441 |                                  chip_info->chip_id, dev_id);
> > >          |                                                      ^
> > >    include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
> > >      156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |                                                                     ~~~     ^
> > >    include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
> > >      110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
> > >          |                              ~~~    ^
> > >    drivers/iio/temperature/mcp9600.c:428:22: warning: unused variable 'ret' [-Wunused-variable]
> > >      428 |         int ch_sel, dev_id, ret;
> > >          |                             ^~~
> > >    10 warnings generated.
> > > 
> > > 
> > > vim +/x0a +440 drivers/iio/temperature/mcp9600.c
> > > 
> > >    422	
> > >    423	static int mcp9600_probe(struct i2c_client *client)
> > >    424	{
> > >    425		const struct mcp_chip_info *chip_info = i2c_get_match_data(client);  
> > 
> > Probably a false positive as I don't think we can probe without something matching and hence
> > that not being NULL but an error check on that match is still a nice to have and should
> > resolve this build warning.  Note there is very little chance a compiler could ever figure
> > out if this can be NULL or not so it's a reasonable warning!  
> 
> I am not sure I follow if you are referring to the -Wformat warnings
> above. Isn't it pointing out that the second specifier is missing the
> actual type? Shouldn't it be '%02x' or something of the sort?

I think I completely misread the report!  Sorry about that. Ignore my comment.

Jonathan

> 
> Cheers,
> Nathan
> 


