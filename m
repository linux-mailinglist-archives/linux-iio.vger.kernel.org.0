Return-Path: <linux-iio+bounces-12029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B519C1C04
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 12:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A9B2260E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF21E32B3;
	Fri,  8 Nov 2024 11:15:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C771E25EA
	for <linux-iio@vger.kernel.org>; Fri,  8 Nov 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064532; cv=none; b=LBK3wua/Z9fgq9zLQSiL4x09ntuzM0u/oBx1z3DB/CwNYvpOYRWismfW2d443G6iowH24bPDXgPwS+zJi+BcMJbUvMTLKDyr0Vend1RhoFRpTcctLXJK2taFtejCl2IHjOFQ+EnDO7CtN+lwFCBqz3GdzwFpyR7WMsY4eEPBcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064532; c=relaxed/simple;
	bh=OG6FDNL9ckSgFGH1LOdxsxNfiiu0eMrH0g6Iri6m0Ec=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWIZ3l4VtCkYL4vkScelWirWAjbNO20RWpDn5M73jNo/6E3ULcBPX/c3PkeTEV0TOpm+TwrfaylLMcS+GSIPoxyEGIjd1TokIvX6eWpxfBjaDBqFNUkxKrSDgvFn1DCsJKOgEzbl0z1eSyFFDLUIGDcrlnLwSxfXrq0PiJsG6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlGW5459vz6K6Qf;
	Fri,  8 Nov 2024 19:12:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 047201401F4;
	Fri,  8 Nov 2024 19:15:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 12:15:26 +0100
Date: Fri, 8 Nov 2024 11:15:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: kernel test robot <lkp@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, <linux-iio@vger.kernel.org>, "Will
 Deacon" <will@kernel.org>
Subject: Re: [jic23-iio:togreg 7/7] include/linux/iio/iio.h:788:16: sparse:
 sparse: incorrect type in return expression (different modifiers)
Message-ID: <20241108111524.0000326f@huawei.com>
In-Reply-To: <20241108110303.00005bac@huawei.com>
References: <202411081329.1XVxvCVQ-lkp@intel.com>
	<20241108103830.00005f19@huawei.com>
	<20241108110303.00005bac@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 8 Nov 2024 11:03:03 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 8 Nov 2024 10:38:30 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Fri, 8 Nov 2024 13:13:17 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >   
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > > head:   6415477ba63dea58b5cbf9ddcae75f18f33c71a4
> > > commit: 6415477ba63dea58b5cbf9ddcae75f18f33c71a4 [7/7] iio: Move __private marking before struct element priv in struct iio_dev
> > > config: x86_64-randconfig-122-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081329.1XVxvCVQ-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081329.1XVxvCVQ-lkp@intel.com/reproduce)    
> > 
> > This isn't going well and we need to resolve this fast.
> > 
> > I'll have a brief go at figuring out what is tripping sparse
> > up but if not I'll pull the patch for this cycle.  
> 
> Superficially it seems the macro magic trips up on pointer types.
> I'm not sure if this is a fundamental issue or just a corner case that
> needs some tweaks.
> 
> A few ways around this occur.
> 
> 1) Store the pointer in an uintptr_t
> 2) Store offset from the parent structure instead of the pointer.
> 
> Either is probably to high risk to slip in at this point in the cycle.
> So I'll drop the patch for now.
A quick coffee later...

(and now I see Andy replied to what I thought was a trivial change)

This is probably a side effect of me fixing the kernel-doc issue (*sigh*)
Should be

Inititially we had
void  *priv __private; that tripped up kernel doc.
I foolishly move the __private so we had
void __private *priv;

Should have been

void * __private priv;

Anyhow, I'll flip to that for now and we can work out a longer term
clean plan next cycle.

Jonathan

> 
> Jonathan
> 
> > 
> > Any suggestions welcome!
> > 
> > Jonathan
> >   
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202411081329.1XVxvCVQ-lkp@intel.com/
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > >    drivers/iio/proximity/srf04.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/srf08.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/rfd77402.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/mb1232.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/sx9360.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/sx9310.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/vl53l0x-i2c.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/irsd200.c: note: in included file (through include/linux/iio/buffer.h):    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/isl29501.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/aw96103.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/sx9500.c: note: in included file:    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/sx_common.c: note: in included file (through include/linux/iio/buffer.h):    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > --
> > >    drivers/iio/proximity/hx9023s.c: note: in included file (through include/linux/iio/buffer.h):    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const    
> > > >> include/linux/iio/iio.h:788:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected void * @@     got void [noderef] *const @@      
> > >    include/linux/iio/iio.h:788:16: sparse:     expected void *
> > >    include/linux/iio/iio.h:788:16: sparse:     got void [noderef] *const
> > > 
> > > vim +788 include/linux/iio/iio.h
> > > 
> > > 6f7c8ee585e9db drivers/staging/iio/iio.h Jonathan Cameron   2011-04-15  784  
> > > 6d4ebd565d15f3 include/linux/iio/iio.h   Alexandru Ardelean 2020-06-30  785  /* The information at the returned address is guaranteed to be cacheline aligned */
> > > f8c6f4e9a40d47 drivers/staging/iio/iio.h Jonathan Cameron   2011-10-06  786  static inline void *iio_priv(const struct iio_dev *indio_dev)
> > > 6f7c8ee585e9db drivers/staging/iio/iio.h Jonathan Cameron   2011-04-15  787  {
> > > 9a5a2483bc60c1 include/linux/iio/iio.h   Andy Shevchenko    2024-11-01 @788  	return ACCESS_PRIVATE(indio_dev, priv);
> > > 6f7c8ee585e9db drivers/staging/iio/iio.h Jonathan Cameron   2011-04-15  789  }
> > > 6f7c8ee585e9db drivers/staging/iio/iio.h Jonathan Cameron   2011-04-15  790  
> > > 
> > > :::::: The code at line 788 was first introduced by commit
> > > :::::: 9a5a2483bc60c12d73ac6ca5ac5ab95361a895f4 iio: Mark iio_dev::priv member with __private
> > > 
> > > :::::: TO: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > :::::: CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >     
> > 
> >   
> 
> 


