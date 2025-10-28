Return-Path: <linux-iio+bounces-25551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA71C1371D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C18188E0A5
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAA52D3EE5;
	Tue, 28 Oct 2025 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOhoZ/Cq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB33C38;
	Tue, 28 Oct 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638893; cv=none; b=WYCUo/Vww/6xzNQ5s1u9UGywsLuTMFu86LOV0/24aS/dWVdUOsNMaZscJmxaOQYe8ytsvUW/RCdoAA82rcr38gdNhfHzn4YSUUQv/0tu+XfZZWFnD/0XiuQQDIl3/ATr88au5RRLHoWdvN+TH1AJIC9okZ761YEju1Qv478Qc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638893; c=relaxed/simple;
	bh=3dcAMZ0XBouz2oNM2bODG9GI8iKKSobfua0eziIQOZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSt5uwNK6XclDmRmm4j1lftmWV8D0GoSBpKsfVn1v3FqmeEcASGfo5JXaeShY/TeJ/yFDtl8CHXsUcA1Jdklf086EhWI2iQkpWkmIGy9WTOvkxEprC869llLiUTcyX+QCMbvjDTb7k/X0W/VMvyHy73kOTGt90AohqVaSTydQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOhoZ/Cq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761638892; x=1793174892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3dcAMZ0XBouz2oNM2bODG9GI8iKKSobfua0eziIQOZY=;
  b=nOhoZ/CqhMxZde4D+S16i1O8rr7ovX2TXUzplNQD454ahZfkfKZwpMuf
   m0KIoaROWId821jP+YW6jAGIuaVZZBAZSLewmBHJBpoPOWfLycY6S/kDZ
   475jYLfdsAzYv2YoP0WFo27kc2hgymklGAY7GfLcYhHK/Kxx9rNUwOmOz
   V55EKoQLALk7NEaqLV9qXB2PYPoUc48mV1KfNu5OJmq7yXeNh5Tcb7gpG
   7Dni3+LR2F7y4afo1mBe1S/TztN8xe4Pd3V96QGu3aeD3G+rF0X731IjZ
   eVshxKCuvaNUdO5CZKeF51yCHS7n8dU8UJGHepcH5LMFu5sdkeRofmQIY
   g==;
X-CSE-ConnectionGUID: 6aQjuCH5QPuCb2YFLjYOww==
X-CSE-MsgGUID: QDcD3LXfQ1qmMYI0uxBj3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63621544"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63621544"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:08:11 -0700
X-CSE-ConnectionGUID: mU2CN2XBSYyKoOuvdZqQog==
X-CSE-MsgGUID: BX4eDgl4QparbrGGxboMlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185366020"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:08:09 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDekP-00000003FGM-0g2Z;
	Tue, 28 Oct 2025 10:08:05 +0200
Date: Tue, 28 Oct 2025 10:08:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: Re: [PATCH v1 2/6] units: Add =?utf-8?Q?va?=
 =?utf-8?B?bHVlIG9mIM+AICogMTDigbk=?=
Message-ID: <aQB55GjWQL3VD1MO@smile.fi.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
 <20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
 <20251027193033.69728215@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027193033.69728215@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 07:30:33PM +0000, David Laight wrote:
> On Mon, 27 Oct 2025 15:34:51 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > There are a few drivers that want to have this value, and at least one
> > known to come soon. Let's define a value for them.

> > +/* Value of π * 10⁹ */
> > +#define PI	3141592653LL
> 
> Is that the right value?
> IIRC the next digits are 58979 (I used to know the next few as well)
> which means it should be rounded up.

Right, today I have the same thought that actually ChromeOS driver has a
off-by-one issue there.

Btw, do you know if we can have compile-time divisions that can make 32-bit
constants out of the 64-bit input? DIV_ROUND_CLOSEST_ULL() doesn't seem allow
that.

-- 
With Best Regards,
Andy Shevchenko



