Return-Path: <linux-iio+bounces-25396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFDAC0302E
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31183AAED3
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30834C833;
	Thu, 23 Oct 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqhMYiWG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4028CF7C;
	Thu, 23 Oct 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244385; cv=none; b=qKe5mxdTlaDps0or2cygyK/saYtezSaNrXayXLRaqzWcuVuJV+7NPWjuSKQZUENGFxALPNp8KKJKBcmU4c/G2ilKeDzEwa9uSokM2QJZ/bTwZtAPQKDPYx170T5WMJslvRr76W0w5jT0ZcEoviiMFHNDpwS9v9uJ6J7Sbn/ynxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244385; c=relaxed/simple;
	bh=Gy86uPw0GMS0aTDE3I7lBaDqSTWlw2dIyTY5N2sn1w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTPHzfnQAvIme/VGb3wUcdBzQCNIjyAMcZlekSlBuUxXRshV19egeV4kJ6MyTVRfl82E37BL4ThEAE/zRY8E8qmh8en8G6myU+wbQXGkkChYKeOs/5vXyrYHXNVZqv5v789DNgCzBopKfM6pGJEFq78QM9EcqZGQphnXUufr0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqhMYiWG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761244384; x=1792780384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gy86uPw0GMS0aTDE3I7lBaDqSTWlw2dIyTY5N2sn1w8=;
  b=ZqhMYiWGKGIgWNRTADXcpziiK0hKe7GqHpVkd10L+pGx3PlCgz3d70qR
   taIiCossjLFA1mpP6AxGO9JpjWTXXbz3GJworWIOH2Uxy4JgpPkt1bNfg
   kJbLeA83Rff9h28EMvuYWv1o5t4AMfmSRQZ6lD4nGapYij8xblsy1sqyk
   U4N1TB8uhcIJLObHq8KJH+L8mhkFYT1+kWqcZdX8Xh8RvwTBALRe7IA8l
   MgMWupINLOYjj4R4Yy0GPDGnDslNJQP1QcBdu74jseucuKFK4zrY7oMqX
   byN6m5s+cDlEk1GAC7M1e1stvKnYhbk/n12PMg93Af7jk2oCD4jQJQuTL
   A==;
X-CSE-ConnectionGUID: HTwwhQ9HT0mbbynDai/qCg==
X-CSE-MsgGUID: ByJyAHe+QTueI4yAb0r8ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80859665"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="80859665"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:33:02 -0700
X-CSE-ConnectionGUID: oKGdB9QJT6mH32is+QHqdA==
X-CSE-MsgGUID: 38ZfxTWkTVi5lD3sSrT/Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="189484420"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:32:59 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vC07M-000000020uM-0Sfa;
	Thu, 23 Oct 2025 21:32:56 +0300
Date: Thu, 23 Oct 2025 21:32:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Frank Zago <frank@zago.net>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: position: Add support for ams AS5600 angle
 sensor
Message-ID: <aPp010RxM3Dp_fAd@smile.fi.intel.com>
References: <20251020201653.86181-1-duttaditya18@gmail.com>
 <20251020201653.86181-3-duttaditya18@gmail.com>
 <20251023191627.00003b52@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023191627.00003b52@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 23, 2025 at 07:16:27PM +0100, Jonathan Cameron wrote:
> On Tue, 21 Oct 2025 01:46:53 +0530
> Aditya Dutt <duttaditya18@gmail.com> wrote:

...

> > +		if (chan->channel == 0) {
> > +			/* Whole angle range = 2*pi / 4096 */
> > +			*val = 2 * 3141592;

Can you, please, add a definition of PI * 10^6 to units.h? We have already
users of this value and of the PI * 10^5.

...

> > +			/* Partial angle = (range / 4096) * (2*pi / 4096) */
> Use multi line comment syntax for htis.

Also you may use Greek PI (as unicode character) in the comments and messages.
We've been living decades in the unicode time!

-- 
With Best Regards,
Andy Shevchenko



