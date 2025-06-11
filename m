Return-Path: <linux-iio+bounces-20447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8970EAD5A85
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F4188FD59
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C2F1AC43A;
	Wed, 11 Jun 2025 15:23:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE921A83E8;
	Wed, 11 Jun 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655438; cv=none; b=LRvRB6iw7xVfOIBoSJgzMP05MesPhgXEh67PWmaJqA5xag0Hrq/U2bADk8oKvlW+N4CfQsmTUmU8ixdko/KO0yeVnkyoE44kWtzybew6TXasnKePGucGBQo38JHvMcNTq0gwfSf2S/cdXMCP/z32CTI0zXPjX3iIQjte9K+yrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655438; c=relaxed/simple;
	bh=hB5NPzsdUKebHol986TcEN09r28kynGS/+NNFkmxmzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmntVkmvZuSS5Z4N/o9Kc5SVGF++Y42xTF5a77+CO7HfmQdqNOMlrt0Z7rfyodrQ1dljMILz+u5Yr4srYkrOFLHem2Ogc3+zLYE0u6yl229cufmX53m4gx1qAuQSVkYl4lpgttx+k5UXs4x/kkqhQr0biV6RyT5ouovovnlk5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: +WLqTz+BQeODSi6TrAhnjw==
X-CSE-MsgGUID: 0oHJv4/ESO+LHUoXzmFWZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51683821"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51683821"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:23:57 -0700
X-CSE-ConnectionGUID: OaO9Uf/1S+ayfF1UV7Aezg==
X-CSE-MsgGUID: 99Z2mP0LSCKA1zYlRdO/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="148136517"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:23:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uPNIs-00000005gQ6-0e5X;
	Wed, 11 Jun 2025 18:23:50 +0300
Date: Wed, 11 Jun 2025 18:23:49 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, corbet@lwn.net, lucas.p.stankus@gmail.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, bagasdotme@gmail.com,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
Message-ID: <aEmfhauUtXowGzUz@smile.fi.intel.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
 <20250601172139.59156-8-l.rubusch@gmail.com>
 <CAHp75VemOXhpRp2hfDhvzi3y5j5oL-_0xMmWRWkwEtX7Ks5nMQ@mail.gmail.com>
 <CAFXKEHZcS2qpb1zp6kkQm_Pb-MxYHErpjD=q6huuLm1Nq=xjqA@mail.gmail.com>
 <20250611161504.56d402e2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611161504.56d402e2@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 04:15:04PM +0100, Jonathan Cameron wrote:
> On Wed, 11 Jun 2025 16:49:34 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > On Sun, Jun 1, 2025 at 9:38 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Jun 1, 2025 at 8:22 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:  

...

> > > > -               return adxl313_fifo_push(indio_dev, samples);
> > > > +               ret = adxl313_fifo_push(indio_dev, samples);  
> > >
> > > This is not needed...
> > >  
> > 
> > IMHO this will be needed, or shall be needed in the follow up context.
> > 
> > The [going to be renamed] function push_events() shall evaluate the
> > interrupt status register for the events the driver can handle and
> > also eventually drain the FIFO in case of watermark. It shall
> > distinguish between failure, events / drain the FIFO which can be
> > handled, and events which cannot be handled so far. It's not a if /
> > else, there can be some event, and some fifo data. Therefore I'd like
> > not a simple return here, but init a ret var.
> > 
> > I interpreted your reviews, to change the particular implementation as
> > if there was just activity. Then in a follow up patch, rewrite it
> > again, now to distinguish just bewteen just activity and inactivity
> > e.g. by if/else. Eventually rewrite it by a third approach to
> > distinghish activity, inactivity, AC-coupled activity and AC-coupled
> > inactivity, might be now switch/case. Eventually you might complain
> > that my patches contain way too much modification of every line in
> > every patch.
> > 
> > I'd rather like to start right away with the final structure with just
> > the first element - e.g. "activity" - leads to results like the above.
> > Less churn among patches, but having just one element looks like
> > having taken an over-complicated approach.
> 
> I'd do the from the first but with the comment up with where ret is
> declared.  
> 
> > Perhaps it's my patch split? Unsure, I tried to note in the commit message:
> > > This is a preparatory patch. Some of the definitions and functions are
> > > supposed to be extended for inactivity later on.  
> > Perhaps it needs more feedback here?
> > 
> > Another example is seting up the read/write_event_config() or
> > read/write_event_value() functions. I mean, eventually this will
> > become a switch/case implementation. Of course with just one element
> > switch/case seems to be obvious overkill. Going by your advice, I
> > changed it to if(!..) return, it's definitely cleaner. Definitely in
> > the follow up patches this will be rewritten, though.
> Don't do that. Just use the switch from the start.

But at the same time if switch becomes nested and 2+ levels, it's better
to split the inner parts to the helpr functions or so. Doing a switch
with 2+ levels looks ugly independently on the approach taken.

> Sometimes we will give review feedback that doesn't take the whole
> series into account (because it takes much longer to review a full series
> then reread the feedback to spot anything that turned out to be due
> to a later change)  In those cases it is fine to just reply to the
> comment with - "The switch gathers additional elements in patches X,Y,Z
> and so is introduced in this first patch to reduce churn.

Indeed.

> > Please, let me know what is the best approach or what I can improve to
> > avoid such "ping pong patching" as you name it?
> > 
> > Might be that you're right here in this particular case, but then it
> > would be better to discuss the final structure, isn't it?

-- 
With Best Regards,
Andy Shevchenko



