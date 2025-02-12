Return-Path: <linux-iio+bounces-15456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC87A32D92
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4959E3A7D1B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358C25A333;
	Wed, 12 Feb 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv9hbJOF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48B256C70;
	Wed, 12 Feb 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381661; cv=none; b=b/9R22eChwFIgafOfhmXCss2RXj2ALiLZffu3EEl/HCeFYX4wTmF/saGwNymeS+M1JM1QK0+3y6xFg/3i/U63e1HwHQ4vERI6/Z2VIviabkgm2A5qA00kPmQoYDgYcSYoOWqXzgoT+OCaycDF9OzSPAJ5s4SA1ULgUjHpmq/nxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381661; c=relaxed/simple;
	bh=tpEXLf1sOsIjYYF2jiTHF8Z5OELiNJ77sVQ7ndJer8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhXCxmMRx5A5Pca+giRJEV1JJQnDVvmXmjjmSr5CmkaC1mRfWtqGWCTrtY+PuoV5WK6tl2ALpnzArMQS+RTsY6m7n39ntKlATBY3y2DSC2ueTqq1DeRe70BflN0a6vM2SaNWbpb1uTdmJUjp3+3hMGoaoRqPF3nLHhI5Po2/KxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pv9hbJOF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739381660; x=1770917660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tpEXLf1sOsIjYYF2jiTHF8Z5OELiNJ77sVQ7ndJer8Q=;
  b=Pv9hbJOFalDUfHjm/6PYBVoE+ryHU5txkLsYpDp8nZsNnjpVcgGQSwe7
   02POlh9Rl9HKR5/rQ4HQN+fo6PQGF5T7rLEwtElyNxegREuXqig9cY1TB
   QTpdvmVtyt06mxnDxcfVk+ytm07WExCp//A5xoyKTrGkgLsiZw15KCccP
   NhilzUHi1YzSEhxujZxnR5E1Gc9OHI6wzNGu0vLzO7EMNJUDszcOmkaRE
   Laakjovqhfro753JsKiGMXfRStu6w4y4NvY+zgI1sCAlGuplnorWXDgy0
   Rpn86NWPfbLnHR1SJwkeFgZVb6iQFzluNSRpU3drHGrDrZRNDUMmpKbPT
   Q==;
X-CSE-ConnectionGUID: r1NFPBa0SPeXP8FF+p1r+g==
X-CSE-MsgGUID: ohYBPn6XTCKtZ/tKnpfncw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50273374"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50273374"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 09:34:18 -0800
X-CSE-ConnectionGUID: Ae8cs+FITvm9nz9eCjoNgg==
X-CSE-MsgGUID: szzSN6DhTCm3Bj/0Tlv1hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113795531"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 09:34:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiGck-0000000AuJf-0Ew8;
	Wed, 12 Feb 2025 19:34:10 +0200
Date: Wed, 12 Feb 2025 19:34:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <Z6zbkXi9koucyqe0@smile.fi.intel.com>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-3-clamor95@gmail.com>
 <Z6ywGgofzU1bvm0H@smile.fi.intel.com>
 <CAPVz0n1UuZPCb3Jdj_fK3Ut7WKBgtvj7aROqJ4YeYVMutuyv7A@mail.gmail.com>
 <Z6zIAGLot3YQLo9S@smile.fi.intel.com>
 <CAPVz0n0YFXUugt1E5siZSYbCBcp6LdNv136eTWGQTbLAXE4pxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0YFXUugt1E5siZSYbCBcp6LdNv136eTWGQTbLAXE4pxQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 07:28:01PM +0200, Svyatoslav Ryhel wrote:
> ср, 12 лют. 2025 р. о 18:10 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> пише:

...

> I will apply all your suggestions. Thank you.
> 
> Regards other patch series, may you please contain all advice inside
> patch series since it is quite hard to track between them. For future
> patches, I will try to avoid listed issues. Thank you.

Sure, it was just a hint. I will check the other series as well when
I have time and motivation.

-- 
With Best Regards,
Andy Shevchenko



