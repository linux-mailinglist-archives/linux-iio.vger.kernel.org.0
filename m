Return-Path: <linux-iio+bounces-21715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E7B07197
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5857A279D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F52F002A;
	Wed, 16 Jul 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDmcV8sT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F142BFC85;
	Wed, 16 Jul 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657968; cv=none; b=eNPSnBlRjrnc5ngDlH027/udcpxdQJGTAMsNLC+ddGUIYp7Dr/c/DuQYkYcU/kviP8ky7PHoAxXWHhWDUqCUVnzAI9ztZHQuRnQWN/xmC1Yc0exx56jQ+efyR42y3wzd6QdvpS/b3f21frXtv4req4V4SWsH2oFGnoYvYHXZBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657968; c=relaxed/simple;
	bh=rfjHtiCeF271t5do673xiX7n1ZAh1z0gfq1XzRBPHvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTueEAEitMf5M73iGHsgI6WBklaKzWAgC4bZU1tu8IksT7optloRaoCg/jUi9vZGPGS1w8EQCBXI1E6/LLdm+vfoptMXelU+5fKsSHu8VxbgTC9YNCv9zMoEmc7a1fr7ucOroU3RJs2HC0FI/1uYscpnFGlhInVy5MB2TBe9HeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDmcV8sT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752657967; x=1784193967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rfjHtiCeF271t5do673xiX7n1ZAh1z0gfq1XzRBPHvU=;
  b=CDmcV8sTO5vcuY2xoMFnPKKdIlgn6UAIaKfxdtQiu00J48XZXU9GrOxE
   yy8fo9qPeizV989mrzcw4XAjmpfYHUcj4XCMj+ZkBjoN96y0h/HU8fKgR
   UROHHHzMgpUJkKX0sk2cG0SIA+Mi7Kv5aR53r6rOApnmxA0xqWUw2nmWJ
   R4l+/sBCTr14ESekFQORwuXHKa1aV/ejbtB8jDqgNWNIfucO6gil9GwPW
   AufLqKmdPVtSUh+BEURBIXNNo+eyHW3J8u8S7ocyeTsOeaO4OOEp7vfXp
   4z8dQA+zjFKZyvXn5DHpRkTE0c2KfaIPuCYeAARQ0mYOXqlAUX6DSfQvg
   w==;
X-CSE-ConnectionGUID: AQ+zbDSIQsy7P5llT95O/Q==
X-CSE-MsgGUID: ZKTQvZ1QSe+itnQqMlfydQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54006236"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54006236"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:26:06 -0700
X-CSE-ConnectionGUID: zoF5FblBTxWSbMeFy9JXVw==
X-CSE-MsgGUID: 3VErqQCySQmwwmDWnqiRmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161776446"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:26:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubyOl-0000000Fth3-3bnN;
	Wed, 16 Jul 2025 12:25:59 +0300
Date: Wed, 16 Jul 2025 12:25:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <aHdwJ--tK4ANBlT4@smile.fi.intel.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
 <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
 <FR2PPF4571F02BC5366477EC02E9C44041A8C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aHD7zEzvVuwSB9Ke@smile.fi.intel.com>
 <FR2PPF4571F02BC69DF6807BAA188B2B3A08C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aHYwmEv1sCI-qi0T@smile.fi.intel.com>
 <FR2PPF4571F02BC1A8F6E7F098A498E0B9C8C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR2PPF4571F02BC1A8F6E7F098A498E0B9C8C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 03:26:48PM +0000, Remi Buisson wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com> 
> >Sent: Tuesday, July 15, 2025 12:43 PM
> >On Tue, Jul 15, 2025 at 09:11:47AM +0000, Remi Buisson wrote:
> >> >From: Andy Shevchenko <andriy.shevchenko@intel.com> 
> >> >Sent: Friday, July 11, 2025 1:56 PM
> >> >On Fri, Jul 11, 2025 at 11:32:48AM +0000, Remi Buisson wrote:
> >> >> >From: Andy Shevchenko andriy.shevchenko@intel.com<mailto:andriy.shevchenko@intel.com>
> >> >> >Sent: Thursday, July 10, 2025 11:30 AM
> >> >> >On Thu, Jul 10, 2025 at 08:57:57AM +0000, Remi Buisson via B4 Relay wrote:

...

> >> >> It's probably safer to keep the delay even in case of failure to make sure
> >> >> the device is ready before next operation.
> >> >
> >> >I am not sure about it. Why? This has to be well justified as it's quite
> >> >unusual pattern.
> >
> >> Ok I understand, the hardware needs that delay if the access was actually
> >> done on the bus (to not jeopardize next access).  If a regmap error means
> >> that no real access occured then the delay is avoidable.
> >
> >Perhaps you need to have this delay embedded in the IO accessors? Also do
> >read _and_ write need this or only one of them?

> It's required for both indirect read and write BUT not when writing the first data
> which need to be done in a single burst.
> Could you please be more specific on how to add delays to IO accessors?

I don't remember if regmap core supports already such a delay, but always
working case is to redefine your own regmap_read()/regmap_write() callbacks.

-- 
With Best Regards,
Andy Shevchenko



