Return-Path: <linux-iio+bounces-23068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA0B2DFFA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8375E0407
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A729ACDB;
	Wed, 20 Aug 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdIQ3WYL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252B277CBD;
	Wed, 20 Aug 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701390; cv=none; b=jdATYZuZ0zPqgTKNyYDAd7jc3Ji7Tjc0bd2rT0zs9Y1g0cctlKN6uiJe2knUe4TuI0EOkkOm/OmYNPSsAjOJVuLTtweuENsvATglOf9rPnERHV59rP3WJ9IKwDPfGsvd7VKL//lC6Mr9f7qloPvAqxL5P8sbDv24g3Qiu5l54M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701390; c=relaxed/simple;
	bh=6OqNnv0Po5WlEaWZUkUwFAcnNDErT5+Nunnm5wdNxFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSL9SGiOaQ1jrH9h6scVbcHMG2u30Lham21RKqIUqyMlGGd2vuF8lR4Hlckm/Jd0ElyoPG32B3f4QmiyrouLUIafv7sFL4uWyPHuFsUa1+FEhcqPkMLK7j+ONinj8YV+YMxSHxVOXMRHGI2LqpgZvjb+Rr4QaOXwGTp+1yki+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdIQ3WYL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701389; x=1787237389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6OqNnv0Po5WlEaWZUkUwFAcnNDErT5+Nunnm5wdNxFs=;
  b=KdIQ3WYLEMhYF9j9y9pGOKLdvJA/cXsIYduDmI6qFKjNh3LpQLnvAGR4
   A4Ks2GXzm63MFqFsI7uR3bcmKV3xMtMudEuPxBDZq7WQHSuDyW2rnN01m
   TNhBvPKT95ExFOqzpted+m4QT2JhW7/pqPImx82BP3kNdvYoSr/YNS7y2
   L0Vt0VhChUqKCPxrhKZM5IexwELI3+Tl4vvXMZgZjWC8TeMPkP3DJhOLI
   SiV+ajafdYy6JG3T/T6YZRpqTakD3peIwWlIsy92LiYgeSG8bSnmyasns
   BizRpG9W3WIlPGjUh5EXq6H+6hzwr9yRVSAFUnc+/6WR5zgxEPqleu5Sw
   g==;
X-CSE-ConnectionGUID: jBHKHaZPTG+XKWX25q5yDA==
X-CSE-MsgGUID: AwPEcqCaTPG/akVis5Dnew==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57922482"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57922482"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:49:48 -0700
X-CSE-ConnectionGUID: K7fCKTj9SVmzGIFaX70sig==
X-CSE-MsgGUID: k8sP5J43SC+U7wgGrnHKlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167651732"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:49:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uok8F-00000006xkb-3Djl;
	Wed, 20 Aug 2025 17:49:43 +0300
Date: Wed, 20 Aug 2025 17:49:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v4 2/3] iio: pressure: bmp280: Remove noisy dev_info()
Message-ID: <aKXgh-gBs6r1zPY-@smile.fi.intel.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
 <20250818092740.545379-3-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818092740.545379-3-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 18, 2025 at 10:27:31AM +0100, Salah Triki wrote:
> Remove `dev_info()` call as it was considered noisy and is not
> necessary for normal driver operation.

I agree with this.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



