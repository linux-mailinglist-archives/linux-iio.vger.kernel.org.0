Return-Path: <linux-iio+bounces-27738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF6ED1DAF6
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E7A0302EADD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30516355058;
	Wed, 14 Jan 2026 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKuZKsNh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7D22D7B1;
	Wed, 14 Jan 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384017; cv=none; b=bVY4YCEfco08sqXsa5gtXRbuFT8WazHHTrqApTvpNu3ix05fGOg8XIlUgjq8H++r4XE2joE3hXZJqupCpsmpcmsIhA7T4FBkQyUGVpETD3vwLOgxXAqFKqJFqtFI8fKBIDO+VXRpR/Asx56nqwyrhb03zM44m8lBRU5Z7FBGV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384017; c=relaxed/simple;
	bh=T6BHk44vsQtBlOD4ayZq0pBKHQqXt6qq9pI/yJ5e4aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGFsHIw4aox6c8IycRLWjA+IJ4iXyw3SbQf/BsYzlrLbEiXTh8gv46l7LliVPWcLAw+svgML7zcs2pmZZ4li/8ylnNSDzKFmiJZW7gxT5HcgANalvrldD+YUk0N1zTY/cWcXPCIQW/pxj2OJmZ1F5wB4S6unFddoBp9w12bCvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKuZKsNh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768384015; x=1799920015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6BHk44vsQtBlOD4ayZq0pBKHQqXt6qq9pI/yJ5e4aU=;
  b=GKuZKsNhgBdqHUe8DWp0jnif/reHKHgStD4wFh6pE1XHK8Xhdic0iJDN
   w1HhPrDzJTHPx6YzBEjUAqPvfxGHZ9oPjrFp5eYVJTAYesAbgRQ4p5z3h
   IqluWHL27Nab7u5z30hq/+uIL+7/IfHV9nzW/yE5zM3J3DRPeIhASox4s
   pfzsIhzHaz/Qdpu4jwyNTLUVG6f5xLxv4RxxmX9GCmY4THbUuJv8g7KiI
   Q1tFDd0F8A2p/Je1K2eoUcuab+8XRpoQxcohOzqDyjE3rWxYeH99hvkqj
   5fd1c8RM+dxZCVdNHaBhpxlgeRTqft0Fk/Q82IhbLQy0POdhjJyhvqSwL
   g==;
X-CSE-ConnectionGUID: dITuDlaYRc2x04/I0Lwvrw==
X-CSE-MsgGUID: XSG9fTttRPqTOvn14WYu3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87094333"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="87094333"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:46:54 -0800
X-CSE-ConnectionGUID: qoQsJx2OSqa5Cs9cM7B4AQ==
X-CSE-MsgGUID: l9fZD3pzSl2LXQsgoS0fbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="203851893"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:46:48 -0800
Date: Wed, 14 Jan 2026 11:46:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
	sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v8 00/10] SPMI: Implement sub-devices and migrate drivers
Message-ID: <aWdmBUO4U3izZCEa@smile.fi.intel.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
 <aWdlSlI85ro7SbJv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWdlSlI85ro7SbJv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 11:43:38AM +0200, Andy Shevchenko wrote:
> On Wed, Jan 14, 2026 at 10:27:32AM +0100, AngeloGioacchino Del Regno wrote:
> > Changes in v8:
> >  - Renamed *res to *sub_sdev in devm_spmi_subdevice_remove() (Andy)
> >  - Changed kerneldoc wording to "error pointer" for function
> >    spmi_subdevice_alloc_and_add() (Andy)
> >  - Shuffled around some assignments in spmi_subdevice_alloc_and_add() (Andy)
> >  - Used device_property_read_u32() instead of of_property_read_u32()
> >    in all of the migrated drivers (Andy)
> >  - Changed .max_register field in all of the migrated drivers from
> >    0x100 to 0xff (Andy)
> >  - Kept `sta1` declaration in reversed xmas tree order in function
> >    iadc_poll_wait_eoc() of qcom-spmi-iadc.c (Andy)
> 
> Thanks, in principle I'm okay with this version, but it would be nice to have
> clarification on the max_register for sure (it doesn't prevent the series from
> being applied).

And FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



