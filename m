Return-Path: <linux-iio+bounces-15335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81BFA30A9E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 12:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FCD3A312C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA721D5A7;
	Tue, 11 Feb 2025 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3P0zPTl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9221F8BBF;
	Tue, 11 Feb 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273850; cv=none; b=FdWgDA9L+tArFNbdOYHbUIUI/JYCR34XwGJH8LNnPTr+cpFDPxkbVVqN7+CFmc5D0NJNqDoioqn20pHJiyF+NYEXrWIxDHadhNz3WTmM4tiQGvQAMABuApiWIFQ8+aC06rT5xPw9D7Qnbvf526yYch6BSSzK1sTWpc5T5J5AJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273850; c=relaxed/simple;
	bh=I5AdoWmvDU3PLEQCbDE5u9wLf7B+tx82l9Cux6XsAos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCIvWbIle2Y1uKk7KwTSC5aseynXNNefNi1z2W6OH1ff4lw19et1jqD1KS1k2RjFG6jT+VLw51yrnwlRYgfU/i+3/W1KQgu6mbq/5pSgI5A0/kUrs76PlhS2mfqKUJ/i+k9w27CyjjTH5VzMwN2ZxQkPw1bMR179eDDA29Kl2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3P0zPTl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739273849; x=1770809849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5AdoWmvDU3PLEQCbDE5u9wLf7B+tx82l9Cux6XsAos=;
  b=l3P0zPTli0n8CwFc60929ER0eF3mT0lfl7v5dYHZqlS5G2TC3ECeIkDA
   gsML5n356sdLz4zVf8uB1fQduqnNsRNgsYmdmSoQSCeTBphBXfPq1/mRb
   JBgKsmiyBlCh8hzLQxXg1oxc9Pk2+5uCs7jZTV3K6vJpZnlkS1n4p/Hbg
   5Y/BxkuyffCMnbwN2Ug9SQKirOad7Q5HOM8gfNE83Wy/qW0IrJkcmMmU5
   QNn1tKViOCgLhd0hWtwdc8uJJfFGMLEiWo0ql+bFt2OoIzV1xn+Q7d1JP
   oIKYqS+OxtbRxQetBE5Iyuq75peY6vLnGd4p9kQyhunor+7259Y3Te5Op
   w==;
X-CSE-ConnectionGUID: kizH9LRyRA6FGI8f1xGP7Q==
X-CSE-MsgGUID: YYCMM1ToSw6BiQ0G8kt9kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="40155613"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="40155613"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 03:37:28 -0800
X-CSE-ConnectionGUID: TJ+sGaBPSISuK0fXAhAI6w==
X-CSE-MsgGUID: GJZ279LaR/u2M3O1nsWMMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="113123900"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 03:37:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thoZt-0000000AUGl-0uDM;
	Tue, 11 Feb 2025 13:37:21 +0200
Date: Tue, 11 Feb 2025 13:37:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, Raag Jadav <raag.jadav@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, lgirdwood@gmail.com,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z6s2cGMM9R6SZ9Le@smile.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com>
 <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
 <7c42e438-22f9-40d9-bb8e-24feb7d58e64@app.fastmail.com>
 <Z6sYAxRIeCzw12nY@smile.fi.intel.com>
 <c1184a91-e216-423d-b956-d4b22116a171@app.fastmail.com>
 <Z6siYlWfvfUvNLpX@smile.fi.intel.com>
 <279d9f32-a1c9-41aa-b15a-e1485877b2d5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279d9f32-a1c9-41aa-b15a-e1485877b2d5@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 11:23:07AM +0100, Arnd Bergmann wrote:
> On Tue, Feb 11, 2025, at 11:11, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 10:39:16AM +0100, Arnd Bergmann wrote:
> >> On Tue, Feb 11, 2025, at 10:27, Andy Shevchenko wrote:
> >
> >> I don't mind moving that if it helps you, but don't see what
> >> the problem is here. Is this missing because of a circular
> >> #include list with linux/device.h including asm/io.h and vice
> >> versa? If that is the root cause, then I assume there will be
> >> additional problems either way until the loop can be broken.
> >
> > I don't see how. io.h already includes err.h, so whoever includes io.h should
> > have that as previously.
> 
> I mean I never understood what problem you are trying to solve
> exactly. From the log, it appears that the problem is an include
> loop between linux/device.h, linux/device/devres.h and asm/io.h,
> and anything that breaks the loop should work. Your suggestion of
> stopping asm/io.h from including linux/device.h sounds like
> the most promising here, but this should be possible regardless
> of whether IOMEM_ERR_PTR() gets moved.

The problem this series solves at the beginning is that not all the consumers
of device.h needs it, in many cases the device/devres.h (or subset of
device/*.h) is enough to include. While solving this, it appears that
the current code uses ERR_PTR() instead of IOMEM_ERR_PTR() in devm_*io*() APIs
and kernel test robot found this and complained about. While solving
this new issue, LKP found another issue that is circular dependency.
But the original code only wants to have an access to IOMEM_ERR_PTR() which
is in io.h and can be moved to err.h AFAICS. Does this sound reasonable?

-- 
With Best Regards,
Andy Shevchenko



