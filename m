Return-Path: <linux-iio+bounces-21817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC88B0C32A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA304E4C5C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25312D0C82;
	Mon, 21 Jul 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh9VHwm8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DF2BDC25;
	Mon, 21 Jul 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097676; cv=none; b=DvJzxxNaz9eT+C+aEc8BbYCspqmwbZzZfL5QY53FWDREdUVa/JG7A55GNAnJ08CYlWJfaTfvyyisS+dhMVl4+ebVFt15OjpF0tCfbAxFvn4W8iY3KG8Te39g2+y2l3O8DG1RLH183GF4Zwpbc4alvudXKoVfOR8gOour2oI2Gsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097676; c=relaxed/simple;
	bh=Ld07cusvj33WkOhHuc88EdKRhRaiuoqYOgCzTacGRsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwYLh3QS5vOPodLt+MtVywsp2DOTdhHpOgTt7Jj8ZrhJ32S6TUp0juO4niFmbMUpLUInWAd87wvGHbhA0/p3IdFF7UuZLQKk37jYsO2bYA4Dhne8SXaKoY52O73QUCeyYXKO/SiW/L1OOFwqcKANp3DZ5GkTv/yv6a206gtjR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh9VHwm8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097675; x=1784633675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ld07cusvj33WkOhHuc88EdKRhRaiuoqYOgCzTacGRsQ=;
  b=lh9VHwm8SWz5B0YgnRbHhvuSZv+LziRvDeMghsvcnAGvSmXXnUTKkdlN
   Pd/xOZAbkIyiSRScy2Hd0QnVVnSPaLKid3SG4EnyYPe2XMqOu+UsVm/eo
   eDH030LSLTk6bxADV5nl2q3tu41Zt/BxAc2ii/AYdvtLze3KrVdo9OZ2g
   lyV4XBC8V4vGbcjLXJ+m+KxiuLK+m+QiYjYS/kia56P3mA9KNxBPIZXub
   825V7N8BPTZyaUpocEtRgMAt4X9PsXoyBIi/wvRlRux7cwYzUvgMMFg5l
   mstYPK2LMNdYif0O5MbGoLggv4ItdDfvfP30IciH+WAGZJSMQ56bCeYev
   Q==;
X-CSE-ConnectionGUID: G10SpBRmSQmkijmnpGEBsQ==
X-CSE-MsgGUID: eH2ozryURKekqjsd5XorIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65999255"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65999255"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:34:34 -0700
X-CSE-ConnectionGUID: s1G6XQ7ES76w4cqFCZDU9Q==
X-CSE-MsgGUID: Se2oBYjySmuR/r3Ll5F1ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="162855980"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:34:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udomn-0000000HKIR-3Rcd;
	Mon, 21 Jul 2025 14:34:25 +0300
Date: Mon, 21 Jul 2025 14:34:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v1 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <aH4lwVpaiau1Ick3@smile.fi.intel.com>
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721075525.29636-2-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 09:55:19AM +0200, AngeloGioacchino Del Regno wrote:
> Some devices connected over the SPMI bus may be big, in the sense
> that those may be a complex of devices managed by a single chip
> over the SPMI bus, reachable through a single SID.
> 
> Add new functions aimed at managing sub-devices of a SPMI device
> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
> for adding a new subdevice and removing it respectively, and also
> add their devm_* variants.
> 
> The need for such functions comes from the existance of	those
> complex Power Management ICs (PMICs), which feature one or many
> sub-devices, in some cases with these being even addressable on
> the chip in form of SPMI register ranges.
> 
> Examples of those devices can be found in both Qualcomm platforms
> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
> sub-devices, and in newer MediaTek platforms showing similar HW
> features and a similar layout with those also having many subdevs.

...

>  EXPORT_SYMBOL_GPL(devm_spmi_controller_add);

> +EXPORT_SYMBOL_GPL(devm_spmi_subdevice_alloc_and_add);

I am wondering how hard to move these to a dedicated namespace.
Basically you can define a default namespace, and at the same time
add import to all (current) users.

...

> +	dev_set_name(&sdev->dev,
> +		     "%d-%02x.%d.auto", sdev->ctrl->nr, sdev->usid, sub_sdev->devid);

No error check?

-- 
With Best Regards,
Andy Shevchenko



