Return-Path: <linux-iio+bounces-20402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5BBAD4EA9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781C418870C0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8323F409;
	Wed, 11 Jun 2025 08:42:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACB23AB90;
	Wed, 11 Jun 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631377; cv=none; b=LvplTdp5dt3hikXOcgnxabT9MGHXYSMbAK6xQ/8FO6IEbtVxw4mN6t/f123LCvKHjvbEf61T/zR75WymD60ewn12xxELLLBzuiLyXvDokV9DAkuRD0+kU7Z8nuDAhE5iYwulyh7KyYMMwNBD3AWG7B3ZwukIyWGUS6RkU2SiFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631377; c=relaxed/simple;
	bh=kAIWVDwlGAt3Hhgl8IRvo7RYS5PwtQyzoO9pObT1hMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUoRlzjEYFlmE/VeHKk6T2j2y93sJKOtQ9NzyFKsjOXE8B1AoISFLxqrMLJCMykZHA02yCccAD/06N22sz0tl8EX3gBvo/4kryYE4+L9KGNLJSxAFNez09W2js9+SV3mMKYK907hLmGSUSAuMquLJaV1MHLohOhaxS2MdB4L5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: m8RwiiFxRZOtjU0w77N5VQ==
X-CSE-MsgGUID: C3yqfSsLQ5ux3zqwGrcKRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="54394828"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="54394828"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:42:55 -0700
X-CSE-ConnectionGUID: I6apgXWYQ7eJanrq1jDrqw==
X-CSE-MsgGUID: wOzc54R/TkiIBIkA8br62g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147119752"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:42:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uPH2m-00000005aXC-3eUi;
	Wed, 11 Jun 2025 11:42:48 +0300
Date: Wed, 11 Jun 2025 11:42:48 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, bagasdotme@gmail.com,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/11] iio: accel: adxl313: introduce channel buffer
Message-ID: <aElBiPFiRZtdF0wk@smile.fi.intel.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
 <20250601172139.59156-3-l.rubusch@gmail.com>
 <CAHp75VfitLPHZ=SUS-ME_fhJqCAwuDAzzN8yt1gq5Drvk7ySow@mail.gmail.com>
 <CAFXKEHY-X-vA_9pzZgYX_HPd2gexi7r8DJJ6cp+H9Px3WY42aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHY-X-vA_9pzZgYX_HPd2gexi7r8DJJ6cp+H9Px3WY42aQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 10:01:39AM +0200, Lothar Rubusch wrote:
> On Sun, Jun 1, 2025 at 9:08 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sun, Jun 1, 2025 at 8:21 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > Add a scan_mask and scan_index to the iio channel. The scan_index
> >
> > IIO
> >
> > > prepares the buffer usage. According to the datasheet, the ADXL313
> > > uses 13 bit in full resolution. Add signedness, storage bits and
> >
> > bits
> > ...OR...
> > 13-bit wide data field
> >
> > > endianness.
> 
> As this is getting very annoying, I tried to set something up
> involving checkpatch, codespell and ispell. But I guess w/o
> grammatical checking. Just, in case, do I miss some simple tooling
> here, any suggestions?
> 
> As a consequence, the alternative in the year 2025 is probably using
> chatGPT for the commit messages and we probably never will have this
> discussion anymore. Hum... ?

It would be nice to have tool and not waste time on the commit message
unification.

-- 
With Best Regards,
Andy Shevchenko



