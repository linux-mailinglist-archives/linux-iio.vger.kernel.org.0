Return-Path: <linux-iio+bounces-26679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A4C9F480
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 15:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CAA3A791C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD482FC011;
	Wed,  3 Dec 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncQaxL0k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7622DF9E;
	Wed,  3 Dec 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771874; cv=none; b=N/61RJJHdSukIbLZogA7sit+ufIl4QaFkW2yjS+bVoVQSMyMpkqPfYO645eaQMBQkRQ56qhTB28WOi9m8qQWXypOTSg8/MGJVVPVR8Zxw1yqbz8ZW5gmNldOZ/yVxhrw1QYhaoJmd1122JvHc/0NJqWOxLO/QzkCj1zCMAL3g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771874; c=relaxed/simple;
	bh=cZ0KlLwbxEY8MgqhrLJP4JtNKtGttFep6mfEB4G2plE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFvrqxuvrpchMM0bV2GhYwrFNYcnzYVKQ7aZs+aYWTDblhDNWTbVFVHmDQaDP5C8vcSo5Fj2K45rYTD23NkGR0zWYq9I8Ea5aIKnpsysyLlcWZ5T0bPbUBwh6/qr0F6wTlVNzxBewHVzbUL5ImsY2FQUxHp+fnJm1fPyQYUUOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncQaxL0k; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764771873; x=1796307873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cZ0KlLwbxEY8MgqhrLJP4JtNKtGttFep6mfEB4G2plE=;
  b=ncQaxL0kjAFOJXHAAMgfFnJR0Uv1oBEEOtojslcdOM1WgMLjcs8hBtYe
   CcXcGjC38jbuaeCHiLaCCZeqMe8P+Rb2fPfqvWH+CCYRK7L5qeZkbBEJg
   A1a678NxqoquYroClYQjAyqW4si+ZAr/5WGqYatLf9BhocdIF4vAbFtfQ
   MgUxwTG2k4AXACp6NDRY74J5W+3XfoaoN0VdshYEQtOrKAX8q5vAv0Oze
   zhXhAK0MqU+qSb/shO4VDE/VqLbFjClYf8VxdHErWIM0BqJhDTVsIHqMm
   ZKsVQoxgwvzIp7hRaoR+pWSdtcH7ELt8NRdbYazyv2GGklnz4ldxKvIXw
   Q==;
X-CSE-ConnectionGUID: 85oDyfdATmmvwoXCZWeBWg==
X-CSE-MsgGUID: fGXW+EfxQTicOhiRY8p/GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66705416"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="66705416"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 06:24:33 -0800
X-CSE-ConnectionGUID: 911XSHwHRMSda2PljviQ6g==
X-CSE-MsgGUID: cKKXRpRlRmOWN44S0dEGXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="193777793"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 06:24:29 -0800
Date: Wed, 3 Dec 2025 16:24:26 +0200
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
Subject: Re: [PATCH 2/2] iio: adc: ad9467: add support for ad9211
Message-ID: <aTBIGnetgq_NiuqS@smile.fi.intel.com>
References: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
 <20251203-add-ad9211-v1-2-170e97e6df11@vaisala.com>
 <aTAxo5sM90vwgxTT@smile.fi.intel.com>
 <d9651903-6b3b-4d9f-aafa-6377e14879a8@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9651903-6b3b-4d9f-aafa-6377e14879a8@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 03:33:15PM +0200, Tomas Melin wrote:
> On 03/12/2025 14:48, Andy Shevchenko wrote:
> > On Wed, Dec 03, 2025 at 12:20:34PM +0000, Tomas Melin wrote:

...

> >> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
> > 
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
> 
> That will give
> 
> WARNING: Unknown link reference 'Datasheet:', use 'Link:' or
> 'Closes:' instead
> #22:
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
> 
> So I would like to keep it as is. Or then please convince checkpatch it
> should be accepted as a valid tag ;)

checkpatch is full of false-positives. It's a recommendation tool, don't stick
to it too much.

	git log --oneline --no-merges --grep ^Datasheet:

will give you list of examples existing in the Git history, 163 and counting.

The first one appeared in 2009 and started being used widely ca. 2015.

-- 
With Best Regards,
Andy Shevchenko



