Return-Path: <linux-iio+bounces-18570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1086A995C6
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C6218898ED
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BCD288CBC;
	Wed, 23 Apr 2025 16:52:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F0283CBE;
	Wed, 23 Apr 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427141; cv=none; b=FdnOo+iV2HUi/tR8R19riM2Vd4WHchCDkj53LZ1B3J1nKb5GqTiQd5/iERQCORUddapvkZ09l/DbMC7Zl1y40okUo+IO2d49J/OViGXN0LjxwQgXltvOdpod7xAVjDAVLJRzLV7h7VxkhW03AYKsitfxxVTlLUVzoL1AU1NWNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427141; c=relaxed/simple;
	bh=U2YyWhUTicbwTOh8eX4yTkro+SROMld4NCwJfUFwNyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4nxAvQpQLYK7h5M7Ggo8LyH3WReqvOysbe5Hv3j4/4fRYCotOhrQN5w7Ai4BMBoAxCb1LDjfMMfm3e3uKyjDIljk0VKbJgEBobQ+C1YMtp/PkwUQ5Wggfj0+z3LKiKeNcaYSQJ6wa/Oa9sgU5MtEslXrHaW2xFspSh7J78jV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: x+83gatzQ6qr+9XvmobN6w==
X-CSE-MsgGUID: bmRmHubcQF2eMg821Jx3QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="49696226"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="49696226"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:52:20 -0700
X-CSE-ConnectionGUID: 97kzSc65R/qtFRaVTufbeA==
X-CSE-MsgGUID: 29xBDD7YSwmONmO2q6ANiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137225871"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:52:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7dKX-0000000F7a8-36fm;
	Wed, 23 Apr 2025 19:52:13 +0300
Date: Wed, 23 Apr 2025 19:52:13 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <aAkavQVd7Px3qPU0@smile.fi.intel.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-3-94341574240f@analog.com>
 <20250421144800.0db0a84e@jic23-huawei>
 <PH0PR03MB7141E6D1A077B0E02368CBDDF9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141E6D1A077B0E02368CBDDF9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 23, 2025 at 07:50:51AM +0000, Paller, Kim Seer wrote:
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Monday, April 21, 2025 9:48 PM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > On Mon, 21 Apr 2025 12:24:54 +0800
> > Kim Seer Paller <kimseer.paller@analog.com> wrote:

...

> > > +	mask = GENMASK(chan->address + 1, chan->address);
> > 
> > I think maybe we need a macro to get the mask from the channel number?
> > Using address for this seems overkill given how simple that maths is.
> > Ideally that macro could perhaps be used in the code below to avoid
> > all the defines I suggested.
> 
> The motivation for using the chan->address field was to hide the calculation a bit.
> However, would using a macro like 
> #define AD3530R_OP_MODE_CHAN_MSK(chan)	GENMASK(2 * chan + 1, 2 * chan) 
> be a good approach in this case? This drops the need for the address field and
> can also be used to explicitly set the operating mode for the 4 fields of the register.
> What do you think?

Please, note that doing GENMASK(foo + X, foo) is highly discouraged as it may
give a very bad generated code (although I haven't checked recently if it's
still the case). The preferred way is GENMASK(X, 0) << foo. Where X is a
compile time constant.

-- 
With Best Regards,
Andy Shevchenko



