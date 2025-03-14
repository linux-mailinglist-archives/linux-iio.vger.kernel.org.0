Return-Path: <linux-iio+bounces-16840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE9DA613C9
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 15:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CE9160B61
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4461FBC94;
	Fri, 14 Mar 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAvJ9C+5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5261F1818;
	Fri, 14 Mar 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963044; cv=none; b=f66ixtUMkMtQimbkYaPeP42ywMpmHqc0ikLm7oih+fZ2SRjQEfrmzf+VeQvGWHtPkkVktChIXX+/Tgc4BtjoOIxx3Gm6mC26HZ3Y8r81rM0xp2DQL/L7RcQpqKbKT6Bu5tpIxCaqAWSxXk9ADk70s43G6CbUNoayeRjT9JT4xi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963044; c=relaxed/simple;
	bh=+jWeC/xSDCzP0BWQNTUeRpH28NuICQiZEGJ73gy54F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkhxlrQRYtGpPjKZL7NvsQjzThCq1He3Uok8DzjCJvVj84h5kRyQvN3wkZ+DtIgN/TvE/TdSD1ChCIBum8JuQTwgZVTrV0dp1NFAWhFzbmxdda4by+tqGRJ7WsPSvUo0zqEgd0u+veMAwHhl46GEDcERpSgQPnR9goXkUvCjijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAvJ9C+5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741963042; x=1773499042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+jWeC/xSDCzP0BWQNTUeRpH28NuICQiZEGJ73gy54F0=;
  b=UAvJ9C+5xTFRloNlQ85VqxKE5mIbihEab0r9cbUEQvvQ6XZwod20ci2M
   /C+Kq7ej9Emp7tMRp8alX1UIlpH3nV3Vuardl2tW+KVsAKKhz/GIRM18x
   J5spS9E1h1e1+K8rig0hXQqAUAd3N0VEaABMF7WD71vSoRZUUWsGajhuq
   ntAHn/voyVsAPOJaeJEMQfOu85PCT7S0cElTXSkTsV5UtfJxW2ptFz+Lp
   gRcehwTuAKsOBbed43/XFgbVK9+a2piYbHh6GIJ1yi1n7wB3ae7JuZtER
   ziqMnyWa4tZceUegF3VFZAHtaZCq2dwwOlYQBv/v6f5oDbw9ClwiOH7+3
   Q==;
X-CSE-ConnectionGUID: VPYtbaA+QqOzZYox6EaIiA==
X-CSE-MsgGUID: BNr2AWAnTGGuF0Ydoq2PDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42845261"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42845261"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:37:20 -0700
X-CSE-ConnectionGUID: MEndl2yRTBebsctmfPOEOQ==
X-CSE-MsgGUID: OushhPWLRVWYnzPewFG0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121093838"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:37:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tt69x-00000002UAd-0ELI;
	Fri, 14 Mar 2025 16:37:13 +0200
Date: Fri, 14 Mar 2025 16:37:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z9Q_GK0_4J6ga1or@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
 <0d7b37fd-be93-42d7-9610-d2184c601981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7b37fd-be93-42d7-9610-d2184c601981@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 14, 2025 at 11:22:37AM +0200, Matti Vaittinen wrote:
> On 13/03/2025 15:19, Andy Shevchenko wrote:
> > On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:

...

> > > +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
> > > +	if (ret)
> > > +		return IRQ_NONE;
> > > +
> > > +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
> > > +	if (ret)
> > > +		return IRQ_NONE;
> > 
> > Only I don't get why you can't use bulk read here.
> > The registers seem to be sequential.
> 
> After taking another look - there seems to be undocumented register (0x1b)
> between the BD79124_REG_EVENT_FLAG_HI (0x1a) and the
> BD79124_REG_EVENT_FLAG_LO (0x1c).
> 
> I won't touch it unless there is a real verified performance problem.

...

> > In the similar way bulk write.
> 
> definitely not due to the 0x1b.

Okay, it seems I misinterpreted the values you have in regmap configuration,
I was under the impression that regmap is 16-bit data, but it is about address.

So, we need to know why the heck HW has sparse registers for what is supposed
to be sequential. This needs a good comment.

-- 
With Best Regards,
Andy Shevchenko



