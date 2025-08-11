Return-Path: <linux-iio+bounces-22571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4444AB209AE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F0942251E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B62D8363;
	Mon, 11 Aug 2025 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbPBI8AH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D13263C8E;
	Mon, 11 Aug 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917826; cv=none; b=CJUZnVIxPMZRuSnQaTYFvLZGnhtV3B0/ps2BWUZ+hZRAF5lgdce3CiSce7XAIMBYGGfdgStDjiP/7SbBlvMqoZbcKDTe/cMjlKWhO53QyONBc0JupD5ckey5ujnSki1Di2ACCMFUFz8u4yLDVZHHDn3fLXouGo4q+ECSDhfja5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917826; c=relaxed/simple;
	bh=Qwn7PQpy+Ilx1ZMVgBKoiHSJ8+JjakaEkhRsJQobszU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGyVt6bhoEoW3984pJEAPhEPuJaJf/tdj3T4RLp+rPpRW7Fv5oQxh4FX7obbgAkM0wviHlPY19pWhTmnpnf6vAV5Irs3JgqvBAwrzlmh12wQV0C3K92GDBLa54GPCrgOpUTvAImz/b7dmrvhAoU4L9RUKacK8LQoSeGZH2OD+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbPBI8AH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754917825; x=1786453825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qwn7PQpy+Ilx1ZMVgBKoiHSJ8+JjakaEkhRsJQobszU=;
  b=TbPBI8AHcVDUS5B3+AZzHQxhivBknjcsL12IDG7sdy0TZTH+bqHBowgK
   HFxeb72NyahvcLvLXlh0dk2zSnjcR9H+feN48LEPgxGdGwUdcr1cbqx5Q
   xsXMHRuKS5NaAPhauruX+saHQrF5rUmz0Z7KIgfv2g0XNmdtfAd5k6to/
   +pTIJmvz3Fg0mcYhuYVrjEb5PFzkwTpOyAeza/lJlrqmE10q2K21mlJF8
   iIDLDFUTiuBT5IbF///eFSNAVIzMaWa3QMvorEYuvwQf9wbrOIH2E1izV
   jGRvXhCkVkjVP+h92s3uKlHXp8a9u3+nUESQwTLesHBEVRqypaC6F6icP
   Q==;
X-CSE-ConnectionGUID: RpNFWjxjTya4VwtB+L5yWA==
X-CSE-MsgGUID: k3beOPxSTJ6jycDknH7mFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57235093"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57235093"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:10:24 -0700
X-CSE-ConnectionGUID: clnapwvIQEyeYWRrme7gjw==
X-CSE-MsgGUID: EgyUTF4xQLq0p80+Py96RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165814002"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:10:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ulSI6-000000052mR-0VQx;
	Mon, 11 Aug 2025 16:10:18 +0300
Date: Mon, 11 Aug 2025 16:10:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: liziyao@uniontech.com
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>,
	WangYuli <wangyuli@uniontech.com>, Jun Zhan <zhanjun@uniontech.com>
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
Message-ID: <aJnrucmDghe1K8Rc@smile.fi.intel.com>
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
 <aJnrZNCpBYD92-n1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnrZNCpBYD92-n1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 11, 2025 at 04:08:53PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 30, 2025 at 08:56:16PM +0800, Cryolitia PukNgae via B4 Relay wrote:
> > 
> > Some GPD devices ship a buggy firmware that describes on-device BMI260
> > with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
> > let's match the correct ID to detect the device. The buggy ID "BMI0160"
> > is kept as well to maintain compatibility with older firmwares.
> 
> I think I saw this patch already and there was even an (unfinished)
> discussion...
> https://lore.kernel.org/linux-iio/20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com/
> 
> So, why are you sending the same patch again?

Oh, my gosh, it's this discussion already! Please, ignore my above comment.

-- 
With Best Regards,
Andy Shevchenko



