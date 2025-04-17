Return-Path: <linux-iio+bounces-18221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C54A923E6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FB0440DC8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B05E2550C2;
	Thu, 17 Apr 2025 17:24:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21D254AE0;
	Thu, 17 Apr 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910685; cv=none; b=RRyik+QTH/MY+Bm9wazv2eHLrfjbmh/2bDKbGOxGHRs+07HniVY9dpAk1/ZXTiRSN78sGjD8iir0IjhW74Y8ZMMw71L3kPuaM+y+f8LFIS5j7XVX9yBBV4ZeBGjWkR+l2bsZGyH+FtsSJ46m4lgPUWUwAAh9qhM29rZoo4ogPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910685; c=relaxed/simple;
	bh=qH2/XSHUN/gQxa/P+Vyiqgjt1NICD5JZRdsXsv6lykY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdu3aT0edjJ8qQ1nituLrIMWtIPJ5mfUsFmHjR4mM/LkK4Gnkji1dlVO1CSIbz0lMonB89MaAhGbhgpEYITIcyxGA9byIUMUr9U12fIuKYEDJ9s3TT1CAAuW80+KLb6et2HjaJ+wHWPVwPalq/Ua67Hi6rIKtmh/H96eTMfEIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: jGKV27YgSg+5Zec3mhhSfg==
X-CSE-MsgGUID: KQKOGrZTThqlABJ7mtIAEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57165658"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57165658"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:24:43 -0700
X-CSE-ConnectionGUID: TxAjV8heRcO0ivFe+6k3tg==
X-CSE-MsgGUID: rmcBZv2pTR+5o16tdqoLxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="134969479"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:24:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5Sya-0000000DGZG-35a7;
	Thu, 17 Apr 2025 20:24:36 +0300
Date: Thu, 17 Apr 2025 20:24:36 +0300
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
Message-ID: <aAE5VAKCK9zfXH5D@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
 <aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
 <6ff6e3be-6193-4977-977b-24de89c09153@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff6e3be-6193-4977-977b-24de89c09153@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 12:16:53PM -0500, David Lechner wrote:
> On 4/17/25 12:01 PM, Andy Shevchenko wrote:
> > On Thu, Apr 17, 2025 at 11:52:32AM -0500, David Lechner wrote:
> >> Wile reviewing [1], I noticed a few more cases where we can use
> >> aligned_s64 or need __aligned(8) on data structures used with
> >> iio_push_to_buffers_with_timestamp().
> >>
> >> [1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/
> > 
> > 
> > Link: URL [1] :-)
> > 
> > This will help to maintainer with b4 as it manages tags.
> 
> In this case, I don't want b4 to add this Link: to all patches, it is just
> context for the cover letter and not so useful long-term.

Then tell it to not do that.
OTOH I dunno if it has a special filters for cover letter.

> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > for non-commented patches.

-- 
With Best Regards,
Andy Shevchenko



