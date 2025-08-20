Return-Path: <linux-iio+bounces-23070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D7B2E009
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EE93AB879
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B92320CBA;
	Wed, 20 Aug 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jng3HBmc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2351E8333;
	Wed, 20 Aug 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701590; cv=none; b=U7V/RoYDTTZhhwn9Ba8lfTtXe2z4ZZwI8FoZyT9NARAketfuqCrMO+QoBkLDIbEWuggozDkV5Vq21UZg5ti3IP5XIQIg0Qqfob2yt2W8CsKfGtOPizGJlHifdcUaK5tWckoSDMa1tzWeUDaDggOOnNwlZrXgN9bkdmsfRxh3S/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701590; c=relaxed/simple;
	bh=DuozIY34HgS+BwDxHT09/b5JJZ7Ya21YPltqzQjkc/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdhE24JXXR/BBHJdU3RDGJ8by1+HVZENPYboqa3oYhCy7PGEVEMHrughVJYg5DQNbH2V/8TOgw0aaWjU+mbHBkfGWT6y7weMi8dj2afj9VTfEXj5Ht1qCLl+qkoKe0ZLbnwgvra3tMDl/tEs03xmQOr7FrzViuMYwne1DCrWrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jng3HBmc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701589; x=1787237589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DuozIY34HgS+BwDxHT09/b5JJZ7Ya21YPltqzQjkc/Q=;
  b=jng3HBmcgGbfCSh0Fa14+Q7QmGkU/bDpytxxKEMeuhiL1hFjWexB+2W0
   ftNhJggSR8DjYv+zBKus2Ebao3sL9AsPSZoAm3RGKs5FNa+CxgdrvpjZw
   VyU4EuHOPUtxU6YeJT+YSaj7q+cA219fwlAEjnvQH/AyagxIDm05yL91R
   JyUJeeC/GrAKCiIQg3lzylG0eyS7NaqzfeuRJ+fuznVKW7pt5sdFR9htR
   1ZjEaBMxWdCachj4bacuxT02CYh5Stdr4qRFHNpa+Kj8+es86cfktbTlo
   zDM67ZYYArIBHSdS4lGX1dgMIoD3SrkV7ypiuZvAwgPFCcBFS4BN8DAYn
   Q==;
X-CSE-ConnectionGUID: MjPSgMvPRrudrfs2PSitWw==
X-CSE-MsgGUID: ZQKHXfZeQCiFq0pxIBn5RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57827925"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57827925"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:53:09 -0700
X-CSE-ConnectionGUID: RTLcwGsJSoOgSVydQzmpLg==
X-CSE-MsgGUID: Vty51ntxS8eIeE3fyVic4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205307942"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:53:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uokBU-00000006xoi-1YiV;
	Wed, 20 Aug 2025 17:53:04 +0300
Date: Wed, 20 Aug 2025 17:53:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v3 0/2] iio: pressure: bmp280: GPIO error handling and
 cleanup
Message-ID: <aKXhULr5u6BHk0WI@smile.fi.intel.com>
References: <20250818082409.543197-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818082409.543197-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 18, 2025 at 09:23:29AM +0100, Salah Triki wrote:
> Hi all,
> 
> This patch series improves the GPIO handling in the bmp280 driver.

Is this similar to what I just reviewed? I'm sorry I got lost.
But if it's different, it needs to be amended in the same way.

-- 
With Best Regards,
Andy Shevchenko



