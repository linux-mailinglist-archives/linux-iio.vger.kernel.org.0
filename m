Return-Path: <linux-iio+bounces-19952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80091AC4458
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 22:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF2189BA4A
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 20:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459920D51C;
	Mon, 26 May 2025 20:19:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3A5661;
	Mon, 26 May 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290746; cv=none; b=h8G+wRK9xQWpkI/P+hRLtAX372BNf4siG4ypj68zbBSCCMVmp7xwnhXzvJZQoWhDPoIUkrsktA2kODpmdAAtJNhJGpsYCdSs6CX1mjOPT/jiaoO8BqiBxAAesQKBJrHw9pvIRrShasQS6qmYvw8I2TS671lpqT36UFJbK15vTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290746; c=relaxed/simple;
	bh=SOVWbK3QSKEq0vLkJ54MQxNa9vrqOZgfVx0HEQ/1Ngs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXmCNih8mrqEc+ND7sGeWathcYHEmAiv8gTdxdQEXJ2RlIwBMt+qi6iDsFMsGiTYviPMFQofBbQw9kqjouxqVBAmK8aSnUbbXstZ/lrLl196uFyjzQX/9nC6aevWNqK+iXY4vrd2hvUKWJDU6YzK0XCPwIjx7nDs7ksGudVNLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Fb5CKE31SRqLi9ZD9rnhoA==
X-CSE-MsgGUID: KCQipcNURqSCQfe5GmEpNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50426836"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="50426836"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 13:19:04 -0700
X-CSE-ConnectionGUID: 8rstve96Rd6UfTml34wfEg==
X-CSE-MsgGUID: IlfBLJEBSli0i37ioEzJCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="173391232"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 13:19:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uJeHh-00000000yYt-1udM;
	Mon, 26 May 2025 23:18:57 +0300
Date: Mon, 26 May 2025 23:18:57 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: fix suspend and resume triggering for bmi160
 and bmi270
Message-ID: <aDTMseDPCGoTRJR_@smile.fi.intel.com>
References: <20250525142530.71955-1-benato.denis96@gmail.com>
 <aDTHzs5AtiNmYIAF@smile.fi.intel.com>
 <86d1b019-faec-40ab-b850-8fad22dc4321@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d1b019-faec-40ab-b850-8fad22dc4321@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 26, 2025 at 10:13:00PM +0200, Denis Benato wrote:
> On 5/26/25 21:58, Andy Shevchenko wrote:
> > On Sun, May 25, 2025 at 04:25:28PM +0200, Denis Benato wrote:
> >> Two imu devices bmi160 and bmi270 are similar to bmi323, with the same bug and
> >> a common usecase: fix the aforementioned bug about triggering not resuming
> >> after sleep in the same way it was solved for the bmi323 device driver.
> >>
> >> The bmi270 patch has been tested on a device where the device irq pin
> >> is connected to the CPU ensuring it doesn't cause harm to devices that
> >> do not use hrtimer or other external triggers.
> >>
> >> Changelog from v1 [1]
> >> - include linux/pm.h where needed
> >> - used "Closed" to reference the solved issue for each driver
> >> - merged two lines into one (on both drivers)
> > I got this series twice without any (?) difference in the versions. Care to
> > explain what's going on?
> >
> I am sorry: mails were not being sent to the main lkml nor the iio mailing list and so
> I resent to everybody, otherwise doing "answer to all" would have created a mess
> where discussions would get lost.

Always mention this kind of things in a cover letter when resending and
ideally add a word 'resend' to the Subject.

-- 
With Best Regards,
Andy Shevchenko



