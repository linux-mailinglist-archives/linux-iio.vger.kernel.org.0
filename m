Return-Path: <linux-iio+bounces-23795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D69B46003
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA225C8770
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06483191BD;
	Fri,  5 Sep 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoTQeufT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006C3191A7;
	Fri,  5 Sep 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093122; cv=none; b=Ik9gbcR9tzMQbM0Kn7353N3CJI9OFGyTE7TSocqJOI0vHUBd13kGJNHGH4/EmSoY27doNZZE1gNceX2Fe/6CqExn1bC69+99iz4lS677CELfPozIILc7wCBVKjwKWmo7ck5trl5evdbCXKQtnRUTP2lVNqcWh8hJp6hDXksfCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093122; c=relaxed/simple;
	bh=IMDqUchRWei8ch0qZ6bEW5tozje/JKQvbHTAiw8Z21E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPWh0UtUCQonZlCxw+xbLHXHjhL42gc7g+bnF60CFAdmJW95gRBiybYHZ3dDg9Mr0Wjes1wGzJd6B07XnonOtFaZbCV/rm+pa1LXIgGHjPsi56iaqpNPvI9hJc2xwlqKZq6HoynywsYZcdg6/gTt6LBIL2xzG13o94TGab58FCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoTQeufT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757093121; x=1788629121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IMDqUchRWei8ch0qZ6bEW5tozje/JKQvbHTAiw8Z21E=;
  b=VoTQeufTZXpZtEk4QGTDu1+j3dbChxX+RhleHrof93jjwUde3eGkbxhQ
   9U2DkohwC8sZLBUXdkKzMk1GtTZd6AYB9KBHHc4Qa6Ctlz9UHjwH9Hgq3
   8WHLN7H6MBKFFeGv49ZpMuK2OEASnq7JUdNHNDAgnt1CKdF0GcnnsHnss
   uj3hNW8zn9ank0/6g5wUNq3vPy40iV68BOed0bMtbYzUfzhnkeBeuN87l
   ejcFPRvicOeNaoA27WDLC8TlvUV61kduePdSWkDFWJwkABLAqVZ3dZtrY
   nDhQrdCnNiFQrmgKRnxEjLgfW8UJtMi0iB1PpttcBlfsspKPhmDPfFBkQ
   A==;
X-CSE-ConnectionGUID: KVb1nCkoSFawiX0ZWh3DKg==
X-CSE-MsgGUID: eoIZaeoARua7mHYHpL2qGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63278240"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63278240"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 10:25:20 -0700
X-CSE-ConnectionGUID: rOaCboCETHWXpbh7jbWHcg==
X-CSE-MsgGUID: FIWU5TZZQMemxRXzs9qlQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="173017248"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 10:25:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uuaBW-0000000Bg3H-1Je2;
	Fri, 05 Sep 2025 20:25:14 +0300
Date: Fri, 5 Sep 2025 20:25:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
Subject: Re: [PATCH v3 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <aLsc-pMSnL0LPTIH@smile.fi.intel.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <6228c10d731b6946a68e1c3c95643065cc81329a.1757001160.git.Jonathan.Santos@analog.com>
 <aLsclc2WHsbR1jfa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLsclc2WHsbR1jfa@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 05, 2025 at 08:23:33PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 05, 2025 at 06:49:42AM -0300, Jonathan Santos wrote:

...

> > +	if (scan_type->sign == 's')
> > +		val2 = scan_type->realbits - 1;
> > +	else
> > +		val2 = scan_type->realbits;
> 
> Wasn't smatch happy about this check?

I meant unhappy

-- 
With Best Regards,
Andy Shevchenko



