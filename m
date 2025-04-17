Return-Path: <linux-iio+bounces-18215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B255CA92357
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6101885330
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A43253329;
	Thu, 17 Apr 2025 17:03:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70235973;
	Thu, 17 Apr 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909412; cv=none; b=sDvziscmVx7eml58SCmo02whDJl4SKFsm3kPCywM+GgDv0PPiI++c1nC8pEtwhGtSpQrxXMgj9wleIHfJmak+DeXC+g5mIsMvheu38XIZe6ENA8DMD09Qd86W+ary3+7tNDjolG88s/eHiHCWN7SbDrrJZeyheB4gGFH5go+k08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909412; c=relaxed/simple;
	bh=u2TJkLbhGbp9zkKfbZRts2Ws5XA9d12/sGNpfBxof9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI/V4VB0YWh09b/nrpojZaywugQNNd0XUOr67r+MnDS1BiOSBGrInRgNDwX/Cf2FZEEcy3645r125TxzrCkK33w8MuE/Iiuz2kfxXfI9Vf7Zv9MY5BQwcafjxyWzbljOf+dJlQmSBbC49a1IMR7pEQzSat4OzjG6hp3jiTkce24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: TQihoqV9QCyn/3I6M456Vw==
X-CSE-MsgGUID: Ww7mvA3YSS6c4MKkoXzkjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="45752721"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="45752721"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:01:20 -0700
X-CSE-ConnectionGUID: qOifIojCTIq+nHVmW37Phw==
X-CSE-MsgGUID: OZhLABtgTd29swPzawq8jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131754336"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:01:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5Sbx-0000000DGCi-27qC;
	Thu, 17 Apr 2025 20:01:13 +0300
Date: Thu, 17 Apr 2025 20:01:13 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/8] iio: more timestamp alignment
Message-ID: <aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 11:52:32AM -0500, David Lechner wrote:
> Wile reviewing [1], I noticed a few more cases where we can use
> aligned_s64 or need __aligned(8) on data structures used with
> iio_push_to_buffers_with_timestamp().
> 
> [1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/


Link: URL [1] :-)

This will help to maintainer with b4 as it manages tags.

> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Andy Shevchenko <andy@kernel.org>
for non-commented patches.

-- 
With Best Regards,
Andy Shevchenko



