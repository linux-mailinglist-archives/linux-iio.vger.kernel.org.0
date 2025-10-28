Return-Path: <linux-iio+bounces-25552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF68C13732
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72043351AEB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A02D7398;
	Tue, 28 Oct 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9O+pVQb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C062AE8E;
	Tue, 28 Oct 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638958; cv=none; b=Y4g0SZh2yq0X1nyUUmnRMhVvB95IimllWw+ntbKPliMpv7XAHU2JfAKAbg6qaiosZalXDpvd4zWglKrN4M4Om8vkD3/G9dvB3B7Vlw1kCY3vNoYxw8bnw8IvG8J9A9z8CuvnCxjcSd3Me6mt/nIo0mK74QIUoLf9SynE+Wm5RWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638958; c=relaxed/simple;
	bh=7z/1gXzlcZ6ipm71AwPYEiMUwyR4gAvf8U8KsM3aVVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSNNjaBgF8Uju635agIlSaoF23QGdxYojzdczAbxjnerOMprxrqErOomTSvuA+6Y71dq34L3GYEAWhmbsXqN8EqnMzO/3bQ0ViqiUUHp4YnlbSzxjpEi2VJpwmKXTcrCAl2CcguRd1rtkmtHQes01MOn/43i4zzJyfSLoiAqDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9O+pVQb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761638957; x=1793174957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7z/1gXzlcZ6ipm71AwPYEiMUwyR4gAvf8U8KsM3aVVY=;
  b=k9O+pVQb1DHN0wu9UpyNqRqK+M56vSJCtYKFkmxV0tj3vnYUegAqUxpM
   9097kmZsa5yriHKbDCAJDivuUXW6eRr8FAMgXTQfQhSK7zTf0aFgzROGM
   wOuU/x05I+aZcdNZu/IFc5CNZLFUwb0toQw7tfWgtjlat9IKdlxgmg5F/
   O4668NdRM/Nmekq+rSWQUsXxC0hFKMlBSb0Vw30FEMGfySLFwPtKPzgZ+
   EYnJ7bxn9CMjSg1pVXSW80Gh63i8oH/2x1K6QhUIxdiCXbgt7BtvFWD5u
   OaXTu6fIuoJx0lpQOXvkROBxNHiYrydnTjEg/T8tyFNI++TQPsFJphRpI
   g==;
X-CSE-ConnectionGUID: 0IwPRJ6GQ9uwlWciR86DOQ==
X-CSE-MsgGUID: AF7MK445R0CjoymHlwKiSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63767813"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63767813"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:09:16 -0700
X-CSE-ConnectionGUID: t5vVe9UuTEq2SveKnIcwng==
X-CSE-MsgGUID: q2VaOrUDT/WqwGq3tF2ATw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185610959"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 01:09:13 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDelS-00000003FGw-0pnx;
	Tue, 28 Oct 2025 10:09:10 +0200
Date: Tue, 28 Oct 2025 10:09:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
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
Message-ID: <aQB6JdePRUuegGxn@smile.fi.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
 <20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
 <20251027145213.7c93a3e2@jic23-huawei>
 <66c8f410-6bba-41d2-88e2-46dbe133adaa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c8f410-6bba-41d2-88e2-46dbe133adaa@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 09:59:10AM -0500, David Lechner wrote:
> On 10/27/25 9:52 AM, Jonathan Cameron wrote:
> > On Mon, 27 Oct 2025 15:34:51 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> >> There are a few drivers that want to have this value, and at least one
> >> known to come soon. Let's define a value for them.
> > 
> > Is there any way we can make the x10^9 bit obvious in the naming?  Or do
> > something a bit nasty like defining a macro along the lines of
> > 
> > PI(scale)?
> > e.g. PI(NANO), PI(10000) 
> > 
> This was my first thought when looking at this as well.
> 
> Or something like PI_x10(6).

We need a good macro that may _at compile-time_ convert 64-bit input to 32-bit
value that may be suitable for 32-bit arithmetics / architectures.


-- 
With Best Regards,
Andy Shevchenko



