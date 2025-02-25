Return-Path: <linux-iio+bounces-16061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB0A4419E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56060176574
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F426B080;
	Tue, 25 Feb 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnFEFeYs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE326A0A4;
	Tue, 25 Feb 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492012; cv=none; b=teFmOvRnMjmkh470H2jkWcSNdIcO9mtfXdoJLYFK8fZglQLoD//kzQXB5GzMfDavAIZ3hJ2lJbwfc4uKIjjEaPU5MRc1eI3jrRQREHaskBtEdoMmIYOhwMvfalFqOwqpOyb/6+yNRvSTbHQyJtQaN45I+wwHgHHukReV1q24v9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492012; c=relaxed/simple;
	bh=z0NM4k/FSSDfqS2mjYdariSVt/ETmZ+fP+JtXH7aT5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1C6hLOlHdfmtj7KtYo1bCKaRtMjxFOOrcSWzU27NtkQ5SMoIO7xfmXMai76pqDSd8TOo1K3kHC/2tCCE/B/P6HTOtq/IQkarssn8vLiuHw5Hhi4z5ux3xZFTDRSp1bYWK+qCyrV/NDeCkvV1o5mCJLBA/v2cpam6hX7W2OgwFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnFEFeYs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740492010; x=1772028010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0NM4k/FSSDfqS2mjYdariSVt/ETmZ+fP+JtXH7aT5c=;
  b=BnFEFeYs5WvgShhEO3zjeYqdiwPp8U1AL5wJ9Vwwyu4kGCrPqTGtP2t9
   +n5wcvlmF9OdQKINQGmtXi/1ispDF2G6AcYelMFia1BULqpIyB9mj4VFW
   6SpEeQIPnHj83pipWCZpF5unakpFfDFgMTGCH1VxYH/tJjHXPoS0C77w4
   br9tsK/dUX7ivzRRxvsdAJ+GXCGsmvoLp5jh1+bNBKBdncRqGY8N6Me+v
   1OdDEjOF661hSIlPuyywPJiDLiZ7jpnn478/UIJT7DFHL87lAPiJZm9xs
   S3ByjzUAg7wkFqRYTd66qQcjmjj4hFgnnyDBSY7QZFfuH/BOejApO1bfF
   g==;
X-CSE-ConnectionGUID: SqwrGY74SfeYSku1DNJ6EA==
X-CSE-MsgGUID: yotztxgiSOmvf8pldCj9bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41500373"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41500373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:00:09 -0800
X-CSE-ConnectionGUID: 5wdBO304QIGqIKmBnH0WxA==
X-CSE-MsgGUID: o2kscnJVSLCiJ/DTQH/+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120502479"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:00:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmvTa-0000000F0fX-0FCE;
	Tue, 25 Feb 2025 15:59:58 +0200
Date: Tue, 25 Feb 2025 15:59:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
Message-ID: <Z73M3Ua6u1FpgBEK@smile.fi.intel.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com>
 <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
 <Z72d7TzZ21WITW3f@smile.fi.intel.com>
 <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893a3c45-537e-47ad-afbd-1e5d3b9abe2c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 25, 2025 at 03:29:17PM +0200, Matti Vaittinen wrote:
> On 25/02/2025 12:39, Andy Shevchenko wrote:
> > On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
> > > On 25/02/2025 12:21, Andy Shevchenko wrote:
> > > > On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:

...

> > > > > 
> > > > > I did not check how many users are you proposing for this, but if
> > > > > there's only one, then IMO this should not be a global function yet.
> > > > > It just feels to special case to me. But let's see what the others
> > > > > think.
> > > > 
> > > > The problem is that if somebody hides it, we might potentially see
> > > > a duplication in the future. So I _slightly_ prefer to publish and
> > > > then drop that after a few cycles if no users appear.
> > > 
> > > After taking a very quick grep I spotted one other existing place where we
> > > might be able to do direct conversion to use this function.
> > > 
> > > drivers/net/ethernet/freescale/gianfar.c
> > > 
> > > That'd be 2 users.
> > 
> > I haven't checked myself, I believe your judgement,
> 
> I took a better look and you obviously shouldn't believe :) The gianfar used
> of_node instead of the fwnode. So, it'd be a single caller at starters.

...which is the same as dev_of_node(), which means that you can use your
function there.

-- 
With Best Regards,
Andy Shevchenko



