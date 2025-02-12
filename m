Return-Path: <linux-iio+bounces-15453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8643A32D46
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AAC188455C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F1255E27;
	Wed, 12 Feb 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWDWbshd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004C210186;
	Wed, 12 Feb 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380903; cv=none; b=l+wfg1kqgN+elyYm33UYhxwBGFNkfWmulaeJsiZIxsSABLJPB1t4T+YchoazK3uO1pznGiffu0rzM+O3k4UGM6QSiOod3+7IRSyihTNc3CKoLIuxlvaMndWvBqadjgx7WurbrkomAc54c5K4cOu7Q/A0B4Zj9g4Bh1j4mUCn6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380903; c=relaxed/simple;
	bh=nolWRzPJ6MEbNPZiHMLJ2uG/vr/D35MvHlOOxlCi11g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phr931ECCj8d/JH8Ej1S3lT495n6eznWQjdnQH7dJ7N8lj+Wk18khrukd82nsu4wOzLd7XBzT4fbQnMcyxkTf2j8S+etx47p8Ei69otT3hZTd6L1lgulzI+GLy8mR5wxfaa7Vx+TzBNQRvmx/PdLHuW+87K+ACFi64OJOmUwA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWDWbshd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739380901; x=1770916901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nolWRzPJ6MEbNPZiHMLJ2uG/vr/D35MvHlOOxlCi11g=;
  b=SWDWbshdm5ZxDnB9L8DTw7AX8XXBt71VdCUlZ5yFfg9ZOsnznS2+F/S+
   ihZAAUSKMtu9GXXa49/V1rCPgQM80B7TlxutWCwXbqwL7MCARElk/FyW2
   M5W9+JiimahGVPahcylcjyosFEtN7i9EkfrZ951vaGf21wyjmqtp5n+gZ
   KFtbJCpdutyPQdzInyTv7EZySGLnL/sjEe58hfQC4cPmhib/JC3kD6QCC
   tSD4alRQ3RA29/xT7lNXJabBRK0cuDhq5oHCbW1ahPE5L07ndgfwPpGeI
   IaMELsZQx5N/ePksN1d2mCn9FVUNzlg0QfOiezXItTbDXOrarrIlpCg+f
   Q==;
X-CSE-ConnectionGUID: D/RU5+N8TRCjtkK5gtewig==
X-CSE-MsgGUID: 4qTz8j3ARjanMWaGd93GfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43985410"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="43985410"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 09:21:40 -0800
X-CSE-ConnectionGUID: Gd1R56xNQ3yWbtCkqsX7hw==
X-CSE-MsgGUID: 8mQIpSAGRyWcfud8p8yvuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118056261"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 09:21:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiGQY-0000000Au8J-3zXp;
	Wed, 12 Feb 2025 19:21:34 +0200
Date: Wed, 12 Feb 2025 19:21:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
	dmitry.torokhov@gmail.com, jic23@kernel.org,
	przemyslaw.kitszel@intel.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 00/12] Split devres APIs to device/devres.h and
 introduce devm_kmemdup_array()
Message-ID: <Z6zYnt4-6KDwErjU@smile.fi.intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <Z6yAbfVtm8nlZzqu@smile.fi.intel.com>
 <Z6zKrvdPYPKPcjk2@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zKrvdPYPKPcjk2@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 06:22:06PM +0200, Raag Jadav wrote:
> On Wed, Feb 12, 2025 at 01:05:17PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 12, 2025 at 11:55:01AM +0530, Raag Jadav wrote:
> > > This series
> > > 
> > > 1. Splits device/devres.h for the users that are only interested in devres APIs.
> > >    Original work by Andy Shevchenko:
> > >    https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com
> > > 
> > > 2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
> > >    across drivers.
> > > 
> > > The idea behind embedding both work into a single series is to make the review
> > > process easier and reduce conflicts while merging.
> > > 
> > > Current proposal is to merge initial patches with an immutable tag (volunteered
> > > by Andy) for other subsystems to use. Feel free to share a better alternative.
> > 
> > > v5: Move IOMEM_ERR_PTR() to err.h (Andy)
> > >     Reduce distribution to pinctrl/iio/input patches
> > 
> > Weren't there two more patches that were actually Acked by Jonathan?
> 
> Nope, iio only has one user each.

Okay, so we basically waiting then for Greg KH to review / ack the couple of
patches (2 and 4) and Dmitry and Jonathan one patch for each.

-- 
With Best Regards,
Andy Shevchenko



