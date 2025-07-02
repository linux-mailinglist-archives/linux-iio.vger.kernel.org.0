Return-Path: <linux-iio+bounces-21233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A17AF1511
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C287A8832
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534A182D0;
	Wed,  2 Jul 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e67EGott"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494223D2A3;
	Wed,  2 Jul 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458295; cv=none; b=dioTpZlbdmUMF9JjqUek+uAc4SnYRDWZG98Xeglb2i+bn0hNW18plzJqmg0A3Wwq7JDAFWjCvKEbb7tzzsDu57zEfJHE9J2XeLqe6Om1Ar9rRjL20R4T1M0Wrzs/cTT0KwOkPfP+p3F1/XZhu66vr+5s7erF1roI5NC6aNhZwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458295; c=relaxed/simple;
	bh=Hw1kfrKKQBZrTYZcVSCZH9M8hggHGGEGpy1lOmtRGN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/0jUAmJ8lcxsK7cnD7upaB6gqmej2gIROjyKk5lFiX2O8DUEwkbnX7SgCLyYmBg0YWDc+JQa8Q97OWUcLaSU34ahy0Gt/VeDnHXKP5S1nyod3IKN0zkkbG8b/zrfBvcukdhi4zNWMmnsTEkQsJN+mG1Sq0fsJnrJ8bt1EsVVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e67EGott; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751458293; x=1782994293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hw1kfrKKQBZrTYZcVSCZH9M8hggHGGEGpy1lOmtRGN0=;
  b=e67EGott7ezTc8Xf8jbfwNlbExqfaPMBO4kIsDCASrrGdxxfjfId/hns
   2xAS2aRY1fM9pZEAQjD7A4v0KfV52YN94cUlNU3o3mLbPAOlGrvG62bQO
   tXpeDEF8psyxSqL8pS4G06JTNXEP9jvTAYTj/eOIHzigm4bfywkr86YS5
   GXvzTE7DQtn4jUrTyfkKHukz+0aH8tQafCM6KwJJoGxlFuY3BGOLR/fXz
   JCnkTMK6uTCTwWbW4W7PJlM8DsZQpxFkRNYQJAg+1R6EVV+V9Lfsm6shs
   CGkeRdO3wjgO7A52j4CRVZaLYVZdLI3QZNRaHawQITRUsKecB7MtP1Ojp
   A==;
X-CSE-ConnectionGUID: xtz1WZbCT060Zmbjk1GDkg==
X-CSE-MsgGUID: Zfq1/UvfSXaiyVOgHrLHTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64795504"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64795504"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:11:32 -0700
X-CSE-ConnectionGUID: QZEn8GA8SZKGqLdHF2IE2w==
X-CSE-MsgGUID: QVsgG8v+Rim98MLKHiu+fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154607439"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:11:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWwJC-0000000BueR-2VGc;
	Wed, 02 Jul 2025 15:11:26 +0300
Date: Wed, 2 Jul 2025 15:11:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Bastos <gustavobastos@usp.br>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iio: accel: sca3000: dead code issue
Message-ID: <aGUh7uXenHc7NYB2@smile.fi.intel.com>
References: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:00:55AM +0100, Colin King (gmail) wrote:

>                 ret = spi_w8r8(st->us,
> SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> 
> >>>  the call to spi_w8r8 returns 0 on success or -ve on an error

Where did you get this from, please?  Any link to elixir or Git repo?

> 
>                 if (ret)
>                         goto error_ret;

-- 
With Best Regards,
Andy Shevchenko



