Return-Path: <linux-iio+bounces-20897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C98AE3AEA
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 11:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3134188EB8A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05E2309B3;
	Mon, 23 Jun 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noHCv6rM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57635971;
	Mon, 23 Jun 2025 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671915; cv=none; b=PJn27a5xAEeJsbySuSBKsdrd939Kirq9d0i7vR7XD9rYq9N0AXb7PMtSU53UooLZu1HaKdkLP3KagxtJOSOzI3ZX/j4A3dy7qeUwSYAdsvyHAAYdIS4f1y62b2sgHLQFDk4qucdK78WzrdVeabEAThAYTOBr33b50Vj+wtkoqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671915; c=relaxed/simple;
	bh=kXiOfxa3J3JmlR3MEGfPhywgkFNNHsfSFLr3+LMaIiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp4tebuYEVYLsQ0zLqpEGPBd1T27pgxmS1L7ii9Eow8v4qOT05X709pg5+TXCtcy/8mmlIXqtd8Fkbfkv1tO8dKRrvxar2MLMVFyUq8dMhFYfiNYDOeYTfk4U2HiKVAGC9sAKpUtDRlk8GXp7RIVrz4VQP2o/3cWh7HQoWqATNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noHCv6rM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750671914; x=1782207914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kXiOfxa3J3JmlR3MEGfPhywgkFNNHsfSFLr3+LMaIiU=;
  b=noHCv6rMsnBTLZ3wGMlIqWjfBht2GVRt4rdq98kp4yfjmK6rYbwqwrA5
   q7Rv+v2f4/fI8Azbx+zH4mD6E3+ihKMYj6gaIR2w5G76bocDTP7oumsYF
   f0QqfvMH+x7EbQFtp9TXjh+rMUyn95vvuxsyl5gle4Fst+HmGZN8EsJi4
   1QYWODUlS+2PYgeVazqHHqImbXiGkK0l1NvK9JHPOocypHAfxMG5gqyDG
   UV6lvwHuvaMgzhBXwqBL/FoQU3ae89Aiv5LF+NzIgbIqjKmY/6G5pkk2j
   fENjqciRpUSdmvJBpz+gyOwhnDIfogGYu8tulXA39bHmqVX3t7HYn96wa
   A==;
X-CSE-ConnectionGUID: tB7B93k5Rvmj2bZoqoTk9w==
X-CSE-MsgGUID: GqzaoOqTRoms4ZdHhiBBig==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78284126"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="78284126"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:45:13 -0700
X-CSE-ConnectionGUID: xNIn+CZ8Q8mY+SbwyUDZMg==
X-CSE-MsgGUID: S0AtyyNsTnGjFVtWqTtqtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151324443"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:45:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTdje-000000097r1-3Mrc;
	Mon, 23 Jun 2025 12:45:06 +0300
Date: Mon, 23 Jun 2025 12:45:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 0/7] iio: accel: adxl345: add interrupt based sensor
 events
Message-ID: <aFkiIl4ZAdpRTZe4@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622155010.164451-1-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 22, 2025 at 03:50:03PM +0000, Lothar Rubusch wrote:
> Add several interrupt based sensor detection events:
> - refactoring and fixes
> - activity/inactivity linked and auto-sleep
> - AC-coupled activity/inactivity
> - Extend inactivity for inactivity under 1s (using free-fall register)
> - documentation

Thanks for a new version, looks much better with new helpers.
I still have a few nit-picks, though.

-- 
With Best Regards,
Andy Shevchenko



