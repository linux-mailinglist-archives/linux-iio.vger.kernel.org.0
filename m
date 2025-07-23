Return-Path: <linux-iio+bounces-21917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAAEB0F6E1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA313AFCEB
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DFF2F4A15;
	Wed, 23 Jul 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2lp58+m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E641E991B
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283960; cv=none; b=OtwbEMl7Cplo9TfhvzHipCPv988XWhnkDoi12f36M6kN2jdE7t5Ps0P12wsVplHgxW8zGgQj/4CJLMzEkUbE68Gnq3jNo5tt9S3+rIBBH0ktjO0yqU3u2SnZg/9GCDoGKbRFWxcodXLyAnzGhVjVdJCBoLfN/2P7KFtRw6OYJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283960; c=relaxed/simple;
	bh=oJEMVQVZFKvT4eXSIWC18xopqQ5WAyAa0oYvrGBYCss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqsl7M+pXR5FPeYJkwGlaUBvN0yWP2KqMkyOTF8C6m0Y0oWId3m7kWC9pcjNBBa1KvIUSGeD0paap/00j6gBUZXVm6K38kYfxhWrhB6egaA28145rlp2UnrY92Sy75aWVX1nhkn6M0vISt5AA0YOTSNJ6fq5mPk7wRS2aDYnBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2lp58+m; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753283958; x=1784819958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oJEMVQVZFKvT4eXSIWC18xopqQ5WAyAa0oYvrGBYCss=;
  b=Z2lp58+mT8VRElH1bPl9vSfV4em2BNNeQEwLgBp9IuaFesU9sl35iLha
   gEZrVkr5hCXa70zU9K/zuJxHthdXhBgWDgJSbu0b99iigapAEQRQu29qX
   i384arX9di37vddZcJlX91nV6u63A+hyUwePKA0QUwrryvquxb2ZHOH3g
   fsXa1Hj5fH0VkYtpG0Yu/ecfYTBtjuQh7ll0jChog3ZXaJqz75wLsO/YJ
   jMbg2LMrC/yUf5hen6UsV4CCiBOtNuUGV8ZgqYJFhqNb7rdY0ys0QjUoh
   uC82kYn9CY5dHnbcNf6WOnQDYFmIEN/24ARln7T4/os8Ez51FdxDqhtzn
   g==;
X-CSE-ConnectionGUID: wIFRA11jT9KQ14o8k9cPew==
X-CSE-MsgGUID: qRSjan7MTu2s1QA1T88olw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66267944"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="66267944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:19:18 -0700
X-CSE-ConnectionGUID: YsJYw1yET0e6C1AJ18/VPg==
X-CSE-MsgGUID: zJRvx7gxTpKU0LRETLYSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159314612"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:19:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uebFP-00000000K9p-3XvY;
	Wed, 23 Jul 2025 18:19:11 +0300
Date: Wed, 23 Jul 2025 18:19:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Hans de Goede <hansg@kernel.org>,
	Marek Vasut <marek.vasut+bmc150@mailbox.org>,
	linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
Message-ID: <aID9byW4WOsUExHR@smile.fi.intel.com>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
 <6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
 <30fb5c19-d4e5-4740-afc4-c15b256a99e0@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30fb5c19-d4e5-4740-afc4-c15b256a99e0@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 22, 2025 at 04:48:45PM +0200, Marek Vasut wrote:
> On 7/22/25 10:55 AM, Uwe Kleine-König wrote:
> > On Mon, Jun 16, 2025 at 02:42:54PM +0200, Hans de Goede wrote:

...

> > I don't have a system that triggers the problem, but there is
> > https://bugs.debian.org/1106411 which I guess is the same problem.
> 
> I think the debian person is on CC here already.

You can even Cc that bug report, messages will be added to it.

-- 
With Best Regards,
Andy Shevchenko



