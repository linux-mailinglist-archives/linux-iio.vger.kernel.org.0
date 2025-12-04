Return-Path: <linux-iio+bounces-26730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0D1CA3936
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 13:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57254306B156
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA27533ADB2;
	Thu,  4 Dec 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzQqqQb3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32C33508C;
	Thu,  4 Dec 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850490; cv=none; b=FLa2LjafjpzrOW9qVUvpK74s3NqDDCYwUNhfPUgWHp9l4R4lgn/1jdNuXd+J8M+HRzCgiMxKhdevz3pE8AwD4ojFMaUBJojkVsLjQlkgLTsEDrpwJptGZe7eITmaKF/zkhJ0MWPgtzB5lP5NAR5WvQ4Zf7PHyOUvbSzt6UC1rP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850490; c=relaxed/simple;
	bh=MPq0zB2XEgEFHAyQydLvh1QQ6ccbl96AUloCUxPSaQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZprmsgnMDyTIto8BO6ykhkmEc1+mbStINnQ6tQ/D3wMCS7ZXCqHkYFn9OleY0ts0zT8kSeTeg8y1BOeeuuDyQ0kh55rzsI2ttStZz/JuDWnNnR3lwvjopajA+3udq1kJZ2ZCBnWn6TIFhrBdyTxW3RZ9TKvW3G1ze4XP/ywwVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzQqqQb3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764850490; x=1796386490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MPq0zB2XEgEFHAyQydLvh1QQ6ccbl96AUloCUxPSaQ8=;
  b=HzQqqQb3okszCJQkbeeKAjLmAPeq0TKKfFK9wGH9cwPtenp+7hV++exA
   SRQRTzY4gG1/3HvAptN5/wjtEaWC55lJIELFgh0QwgNpZR4YYGfQ7wB3O
   eCOK27AkiWS5re2sEoRQxpdYzM1bjIg/eQGxefQ+dHo2F49uIY7Pp8Ohe
   Tv/VF7jGWlbeBFxCbBy37EET5gyNx6FTdHgJWJ1wNk6e31tLcyolinXA2
   vhAt6XVCajMujRX2g2pfINVbhMKxiPx3wytJCTuw7/Je6fOyLiUz3eLsb
   7m9Ym94KA1DkgxTkVhmhIIoz9IbHc7/Js5LKP8hiBa0Wmh1lXtwI0lKR1
   g==;
X-CSE-ConnectionGUID: RBcg+quXSgWK0L4k3+F04A==
X-CSE-MsgGUID: RIcPCb3BTLOzWwq9mOCL/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="89515280"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="89515280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 04:14:49 -0800
X-CSE-ConnectionGUID: WMUx0yiSRXqVtyx0Pwj9mg==
X-CSE-MsgGUID: /LA5He7LTY6/0yc0CxyUOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="199925103"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 04:14:45 -0800
Date: Thu, 4 Dec 2025 14:14:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: add support for ad9211
Message-ID: <aTF7M7NAFJM1OpWl@smile.fi.intel.com>
References: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
 <20251204-add-ad9211-v2-2-a1561f977ee5@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204-add-ad9211-v2-2-a1561f977ee5@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 04, 2025 at 08:01:04AM +0000, Tomas Melin wrote:
> The AD9211 is a 10-bit monolithic sampling analog-to-digital
> converter optimized for high performance, low power, and ease
> of use. The product operates at up to a 300 MSPS conversion
> rate and is optimized for outstanding dynamic performance
> in wideband carrier and broadband systems.
> 
> The scale table implemented here is not an exact match with the
> datasheet as the table presented there is missing some information.
> The reference presents these values as being linear,
> but that does not add up. There is information missing in the table.
> Implemented scale table matches values at the middle and at the ends,
> smoothing the curve towards middle and end.
> Impact on end result from deviation in scale factor affects only software
> using it for scaling. All the possible hw-settings are also available with
> this implementation.


Some amendment in the headers would be nice to have,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

+ array_size.h

>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/of.h>
> +#include <linux/units.h>
>  

You can drop one blank line here.

-- 
With Best Regards,
Andy Shevchenko



