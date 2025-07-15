Return-Path: <linux-iio+bounces-21660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E48B053A7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9100E5600A4
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02B2727F8;
	Tue, 15 Jul 2025 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H77OT8Fe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72336EEA6;
	Tue, 15 Jul 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565822; cv=none; b=BZZY6Cv16AyKzyHB2orqt9UnYIUXNrrAJCorg4PHCTsGrmZ51jg78vw78oLxbG1L0rrw4rpsl0AMQv+1MCFhhZllMFy50YmWqDjDTUHY9rQtjDTdkBeasQ9VfTTuRx0nfq4G9knpRbPXVpCpc87PPTVpRLgi3odX6GlYxoS8t4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565822; c=relaxed/simple;
	bh=ZQxtMTkGnFlj91RUnC4NU4MxooM4ERCPKHnwfsPtraQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpMqsT8WMXyQ44a47Xw+DBa5LK8Qcmh2c7aKp0HnovRl2GKeOWEwxAqnvRhUm5kp2vs7eIn11JeXp4rAW2ht6T6E8xfyC0Ou/KpdpwiiXfzu7HCnmlBzVPV5ovFmTc64oANErXKE9FSnjzuQ1PPWcPpcrWZKZ4lK2a59oZiJAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H77OT8Fe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752565821; x=1784101821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQxtMTkGnFlj91RUnC4NU4MxooM4ERCPKHnwfsPtraQ=;
  b=H77OT8FeZI+T+BkC9ipoSUAKNSTdkgGliaQgnwfBFHf6g0TstW5w5UIg
   FF2RisEk8YtbHgTBsLdlelW07nbhJtVEoQlRHcoAEob+XMQDgjDdhePFt
   2qGNvVW0YJNJGVHFIQU1Nz6yAsOmebgYqhWoWFQNUBx8Zbl3RiV+fOn2X
   1JAJwlPsfMzTiKx1mqy1bg5YO/N1qUd94PMs1y+p0BnALX4D/1M46krkQ
   rdFyXl8Ge2SUY07wS6Y0DRIyZnU/8cpqElOqm9vf/F2GK2XwYaYvG9XWc
   bFmLLFFVSTe4Nn4noobCxK05f8Xievu9qrgsBybL666subUpXcy61jvoO
   A==;
X-CSE-ConnectionGUID: MLm/oXJET5iPr4oYfDLzRA==
X-CSE-MsgGUID: prcgX8CuQU2IkBudcPMzUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53888189"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53888189"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:50:20 -0700
X-CSE-ConnectionGUID: bDU0YayKSXudbgD5Ax6uaw==
X-CSE-MsgGUID: E9tDyhmkT1aOwWGAEhv95g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="188141927"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:50:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ubaQV-0000000FaW9-22W4;
	Tue, 15 Jul 2025 10:50:11 +0300
Date: Tue, 15 Jul 2025 10:50:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aHYIMxIKVh8pgze7@smile.fi.intel.com>
References: <20250526085041.9197-1-ak@it-klinger.de>
 <20250526085041.9197-3-ak@it-klinger.de>
 <aDTMSwhodZQLzZ4q@smile.fi.intel.com>
 <aHS-B5KmBKX72OZc@mail.your-server.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHS-B5KmBKX72OZc@mail.your-server.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 10:21:27AM +0200, Andreas Klinger wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Mo, 26. Mai 23:17:

...

> > > +struct veml6046x00_data {
> > > +	struct regmap *regmap;
> > > +	struct iio_trigger *trig;
> > > +	struct veml6046x00_rf rf;
> > 
> > Does pahole agree on the choice of the layout?
> 
> This is the output of pahole:
> 
> struct veml6046x00_data {
>         struct regmap *            regmap;               /*     0     4 */
>         struct iio_trigger *       trig;                 /*     4     4 */
>         struct veml6046x00_rf      rf;                   /*     8    20 */
> 
>         /* size: 28, cachelines: 1, members: 3 */
>         /* last cacheline: 28 bytes */
> };
> 
> I don't see anything wrong or did i miss something?

Neither me. Thanks for double checking.

-- 
With Best Regards,
Andy Shevchenko



