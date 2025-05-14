Return-Path: <linux-iio+bounces-19514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB5AB6B5E
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 14:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93684A8580
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850D277807;
	Wed, 14 May 2025 12:22:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25D27702E;
	Wed, 14 May 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225370; cv=none; b=hUSsd1DmSGXo80q5QYOQCXlEe0HKgsEtAZbzobDSKZ5phTL5POLKuMNdsOIlSHk3mUoBwexAGZumILi2fgX5MSGlrMsNl5yHQGo+C3t1mfyGy3w1KFLuMXHwaCUWi6sp4oe9O1TyFSy2QScT5AOPAteflI84AEgYhCpy39EYvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225370; c=relaxed/simple;
	bh=ShtTxybA8pSJ7wyMwMRyYgxu02/LISKACxEbjzHDZ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCbILQTjZyqakl8mjya2dHlCY/XhmBC3AHKvUWrTu7U3JBlt+si9iHsvyJxctyNqqSU9DIIYJhSlwK9WTJ1gQBauzhgRrY/JU27zUT/cg21/hqnxefOg+MODN4Q0oQTP/jqOGBgCb72FGJbJ87MO0VlLWrP9JD9ASl4vehtbP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: qHvms8rGQKOyNORvdbYkkQ==
X-CSE-MsgGUID: ZLm7p5hIQhu+HbZetW8r6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66526241"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="66526241"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:22:48 -0700
X-CSE-ConnectionGUID: jVh6CU3DTDishg36Z2t4Xg==
X-CSE-MsgGUID: ywqvxL3qQsahLY7v8B01SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138946955"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:22:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uFB8D-00000001Y1g-3TVL;
	Wed, 14 May 2025 15:22:41 +0300
Date: Wed, 14 May 2025 15:22:41 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	u.kleine-koenig@baylibre.com, robh@kernel.org, tglx@linutronix.de,
	jirislaby@kernel.org, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-adc: Fix race in installing chained IRQ
 handler
Message-ID: <aCSLEZoeafOporMf@smile.fi.intel.com>
References: <20250514085138.3221059-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514085138.3221059-1-nichen@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 14, 2025 at 04:51:38PM +0800, Chen Ni wrote:
> Fix a race where a pending interrupt could be received and the handler
> called before the handler's data has been setup, by converting to
> irq_set_chained_handler_and_data().

Sounds like it needs a Fixes tag.

-- 
With Best Regards,
Andy Shevchenko



