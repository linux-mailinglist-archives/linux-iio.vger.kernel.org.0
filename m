Return-Path: <linux-iio+bounces-26453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED9C84AFD
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 12:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1352C350E09
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 11:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02542315D2E;
	Tue, 25 Nov 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyzGnPcy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF03148C4;
	Tue, 25 Nov 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069284; cv=none; b=L8qJP1RqqvNJtOcGL3GzhF4G5Kq6Rfl446KFqJBA+GtvArGER98PljTB/zWpPVqFlhDOxlIIe9jC2Os94/N0XeWYFocvkzX1EU9LRCr8c0nJ/Z4pguiUKtOzYaWFM7Wgu92gpVdgdpwSM8bQe50FcAS02jkGtwc4pzA+wpZRSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069284; c=relaxed/simple;
	bh=ZbTIQfo+qtm21lpbeXPAGmpekhzgYHQyoJTK/6bx07M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5afYdfOvXVoYwWHUeuJ42ZGaQ2k/gQTh+Ljlrnv7XUh3GQ4YfXxp0cYvz2uqkh9bO/Mvodg6+lFxnbsK2vdDqDWBj3O8VomTlRKtwdeebRpgKs9zzw0xBxEkeEP4CMLfpcAjDsxKY0+rzgCrvHYiKGryiS/kb93ZotH88D/M4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyzGnPcy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764069283; x=1795605283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZbTIQfo+qtm21lpbeXPAGmpekhzgYHQyoJTK/6bx07M=;
  b=hyzGnPcyDkwYtxOfixxzz4HbLNXHDEu6OqyanmAEtjMOwTGMJnUD86US
   tTOJuQnOCV6cflDrcAIWoGbjbLdN1xYEg//dUBCrqNy7o8g2QKK78fAJ6
   zWIALl+8KGzd4prmpwcC4vdbyL5cGmqrcPWwA/80WCpqT7t1Rvr3HyuGu
   vE4Ti3Ha23o4eG6WmH3gFrmTBvyNrsaA9ZjXKEF4tNaQrzyuS/VrTk4s2
   uYap/ZzhctXMAoNI3WoBT0no7XZHMdLt/xFBSy0PFVLAWxGWKpONQuD+R
   2UFs+bWCJ6u3/WeGmihuYn/yJtk2KPcxCtyztM9TsJdwcUMq2RSWS8gwM
   A==;
X-CSE-ConnectionGUID: C7v0lX36Ry+miSpjdVsu+w==
X-CSE-MsgGUID: hMcwmSn2Ryyt80AUH6MN3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65972474"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="65972474"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 03:14:42 -0800
X-CSE-ConnectionGUID: t+oNietcR7q6AXzLLxkbvg==
X-CSE-MsgGUID: 0jg7QcHpSjStYUMbZIBDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="223583514"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 03:14:39 -0800
Date: Tue, 25 Nov 2025 13:14:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: guptarud@gmail.com, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio: accel: Prevent NULL pointer dereference in
 interrupt setup
Message-ID: <aSWPnRBRdPS8vnir@smile.fi.intel.com>
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
 <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
 <d3318386-2646-4f1c-ab4b-6ae3bc71e9bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3318386-2646-4f1c-ab4b-6ae3bc71e9bb@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 25, 2025 at 11:45:22AM +0100, Konrad Dybcio wrote:
> On 11/25/25 12:35 AM, Rudraksha Gupta via B4 Relay wrote:
> > 
> > The bmc150_accel_set_interrupt() function assumes that the interrupt
> > info is provided. However, when no IRQ is provided, the info pointer
> > remains NULL, leading to a kernel oops:
> 
> Hm, are you sure your device really doesn't have a pin connected to
> the IC's interrupt line?

I don't know the actual case here, but in general such a design occurred
in real life. So, shouldn't be a surprise to see another polling only mode
connection like this.

-- 
With Best Regards,
Andy Shevchenko



