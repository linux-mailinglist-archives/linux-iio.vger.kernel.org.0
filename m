Return-Path: <linux-iio+bounces-17742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D75A7D971
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D2B1793D6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ECB22FE06;
	Mon,  7 Apr 2025 09:16:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2523E229
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017379; cv=none; b=p9R2jv3oDb1X9gyhzV37r/QqidP5Yae6O+7CZC00KY1tThFKqm9oIJ72z+XfsvPA7+0FGESGPbhv1VaPLDuHqOmyT+K9L2TFa4WCUafphhjb2BB58jR2yEzPldGQIkJ+CQZFe/H5uEJyiKZkmncVL/H6Tr3Ys4jwfuPtH1N40ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017379; c=relaxed/simple;
	bh=lOGNzd7IgLUxLT6JzP1LxQjTS39TGMSy8OIgl8J+77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeuvtryDNJFwTzHlIgNb6nMTwJ3bM4rQldD/uU81F/0W0Z3+YSAqfiha6NJ2owRsNL7vg4/TN5351O8+hkCB1RdMLK3yN7XJ+GMcGN9ZTaB5b0GlJ2lXE/iWbw3pb0OeV7NJKNvI7flT9CX9l7I9p0dHJuI9qkdRvXQTYn9WtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Zz9aFQVqTnawcpDtuA3fNg==
X-CSE-MsgGUID: 3xQW5//pTZCK5pftXadPww==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45529837"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45529837"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:16:16 -0700
X-CSE-ConnectionGUID: IN4LQFufRqma4B035QZBIQ==
X-CSE-MsgGUID: TV+Ero6yRSquWPVmdstsvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="128767635"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:16:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1iaS-0000000A12X-0FEa;
	Mon, 07 Apr 2025 12:16:12 +0300
Date: Mon, 7 Apr 2025 12:16:11 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/20] iio: adc: ad7266: Fix potential timestamp
 alignment issue.
Message-ID: <Z_OX2zUP6HgaTlEQ@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-2-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:42PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> On architectures where an s64 is only aligned to 32 bits insufficient

32-bit ?

> padding would be left between the earlier elements and the timestamp.
> Use aligned_s64 to enforce the correct placement and ensure the
> storage is large enough.

-- 
With Best Regards,
Andy Shevchenko



