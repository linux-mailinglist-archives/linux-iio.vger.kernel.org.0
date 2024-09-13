Return-Path: <linux-iio+bounces-9519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D19786E8
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 19:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61829B25DE1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8284E14;
	Fri, 13 Sep 2024 17:36:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE001C14;
	Fri, 13 Sep 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249002; cv=none; b=uBmC/e4xpLvVno0HfH2hD6BmXoPVqUkwsMTyzL3Frt2Dwf0W5E+9gnpXNMb2Bm6GWMLFhYFWLpn/7Nt4gO1a4HhvntJzMpCE3mcoE315QmpmJyukYpuy66x6e5M4y800/SCDuuXqi6O/oHLpIa2/nItsBsZeWjsovwI8jX9/7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249002; c=relaxed/simple;
	bh=D11EquOkxJRaOVUkKtxsD3m2xYUCqKKmdjEKiBybbjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkHYvvWsJf1C2cvxPMzRpuuckcxpQGkQi+Y7M5zmktmU8/rgEKr4jcEMXpQqlDfuYwg5iYlXoD+Cl/eeebsBpUb8gFD/AXCmTwrNniVJoMkyhthl2b6UhOHLlhjui98X8jnekUSpz+oLxWt1l7ja2EZX42TqkL1jWh9JCwdbrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: rC3uDd1ZStKvMmGMZmghbw==
X-CSE-MsgGUID: itPzId6UQA+J2tcbHhARUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25095539"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25095539"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:36:41 -0700
X-CSE-ConnectionGUID: 1+fOcsm8QZ6oe9+CessA4g==
X-CSE-MsgGUID: URKtfhegR7+1jeTkfiofQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72954063"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:36:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1spADh-00000008ND0-0smQ;
	Fri, 13 Sep 2024 20:36:33 +0300
Date: Fri, 13 Sep 2024 20:36:32 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <ZuR4IE-mwhL27ZG0@smile.fi.intel.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
 <20240912121609.13438-3-ramona.nechita@analog.com>
 <CAHp75VdOjodDaz6J4sWOiT2HHmdXpOPcWeS5kz4e3rB_=gh3xw@mail.gmail.com>
 <SN6PR03MB4320EC2760F85BB6B0DDEED4F3652@SN6PR03MB4320.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR03MB4320EC2760F85BB6B0DDEED4F3652@SN6PR03MB4320.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 02:06:48PM +0000, Nechita, Ramona wrote:
> >>
> >> The filter mode / filter type property is used for ad4130 and ad7779
> >> drivers, therefore the ABI doc file for ad4130 was removed, merging
> >> both of them in the sysfs-bus-iio.

...

> >> +What:          /sys/bus/iio/devices/iio:deviceX/filter_type_available
> >> +What:          /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> >> +KernelVersion: 6.1
> >
> >I believe I have already commented on this. The commit message keeps silent about version changes. Why?
> 
> I mentioned it in the cover-letter, since the attributes of two devices were
> merged, and one of them was available in 6.1 ad the other in 6.2, it felt
> appropriate to leave it as 6.1.
> I was wondering if this is ok or if it should be kept as 6.2. Should this be
> mentioned in the commit message as well?

Please, mention in the commit message.

> >> +Contact:       linux-iio@vger.kernel.org
> >> +Description:
> >> +               Reading returns a list with the possible filter modes. Options
> >> +               for the attribute:
> >> +                       * "sinc3"       - The digital sinc3 filter. Moderate 1st conversion time.
> >> +                   Good noise performance.
> >> +                       * "sinc4"       - Sinc 4. Excellent noise performance. Long
> >> +                       1st conversion time.
> >> +                       * "sinc5"       - The digital sinc5 filter. Excellent noise performance
> >> +                       * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
> >> +                   time.
> >> +                       * "sinc3+rej60" - Sinc3 + 60Hz rejection.
> >> +                       * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
> >> +                   time.
> >> +                       * "sinc3+pf1"   - Sinc3 + device specific Post Filter 1.
> >> +                       * "sinc3+pf2"   - Sinc3 + device specific Post Filter 2.
> >> +                       * "sinc3+pf3"   - Sinc3 + device specific Post Filter 3.
> >> +                       * "sinc3+pf4"   - Sinc3 + device specific Post Filter 4.
> >
> >Also, the original file was more verbose for the complex cases, like
> >"sinc3+pfX", why has this been changed?
> 
> Since this is a more generic file I was advised to leave out specific
> details, should I include them just as they were in the original file?

I would leave the examples for the mentioned chip in the parentheses. But it's
up to Jonathan, I have no such device anyway, so personally I'm not affected
:-)

-- 
With Best Regards,
Andy Shevchenko



