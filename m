Return-Path: <linux-iio+bounces-27466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BCCEE894
	for <lists+linux-iio@lfdr.de>; Fri, 02 Jan 2026 13:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232D8301F8CD
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jan 2026 12:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03430FC32;
	Fri,  2 Jan 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfJ619Zu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1D30F81B;
	Fri,  2 Jan 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356783; cv=none; b=BiE+d82lebBH4uTeYrvcp/9ncyrfGHzKV2+jxXJTUYIUnkYu13du+soUhVQ8xgbg38m9OmNMUk0Q/2COHOAPERIzdqauhl+oN6b61nfo6KS33nFZvKD1ULqnu/6yhX6d8sGrexyA0Hm9rZok5DOOVsqQlOOq/LqSkjkSyPype1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356783; c=relaxed/simple;
	bh=BsOHflY8haQT4Qu9zg4qb1JZryz2EohKqSgjPXiupXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxNLa5r8HoBwrKHEHVixiI+srIWe2pYGjTb5xx5jevYiMVthRRKAFrae2tD0mdmk6cDIKOIm+EQ9EXjstacD4WfvQZ5f7tm8z8+2KWItg5Y9OljXlm8HdttWBkgoauv3GGvAoWqeIqBIw6uiY59dOEZhKiREGM1qMnIrYc7kVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfJ619Zu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767356782; x=1798892782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BsOHflY8haQT4Qu9zg4qb1JZryz2EohKqSgjPXiupXc=;
  b=jfJ619ZuOhgaRgZmaZx3QRkRzkS9H3nNIqpY2+MpJD/Cd1KxGFLBS/2A
   r6jUu+aFvw3+Cw/UYuJqflsOlM2E5BX3V/BfV2U6COy1qVk5CNTVg+QIz
   TLxN4DOFtkqOPaTx5osUPAQrdrBHFCMtcHkIlJ85RrecvCcaWafGMY6Yk
   SrztlW5Tq/4v2usIlVrdU36FtvCQEq8xXlDF2+wlcPBFSA4ksI5Qpqrz1
   ckdYpyQE3JIGmwmxdPD7vQNz+G4OonsYuOKLGO/468h2PtuW164Wp7fi2
   GRx2SUQf0WZ8A1X4wkyHAPV9clwPefxSlzUYKoZC850Ufb3QHt2oGavSj
   Q==;
X-CSE-ConnectionGUID: gnWJ1HuNRxaMDBeFfP0xqQ==
X-CSE-MsgGUID: bEPgJseESsGmUOnpA5+Asg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68835003"
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="68835003"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:26:21 -0800
X-CSE-ConnectionGUID: iN11QHfAS9iTAVuQj1Vl/g==
X-CSE-MsgGUID: lRE6rj3KTeyd3Ubb2lneLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="206298378"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:26:18 -0800
Date: Fri, 2 Jan 2026 14:26:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/4] iio: proximity: Add interrupt support for RFD77402
Message-ID: <aVe5Z9BvqJKmTi-d@smile.fi.intel.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 01, 2026 at 09:47:37PM +0530, Shrikant Raskar via B4 Relay wrote:
> This patch series adds:
>  - Add RF Digital vendor prefix
>  - YAML binding for RFD77402
>  - Add OF device ID for enumeration via DT
>  - Use kernel helper for result polling
>  - Interrupt handling support
> 
> These changes enable DT-based configuration and event-driven
> operation for the RFD77402 Time-of-Flight sensor.
> 
> Changelog:
> - Resend the patch series as v4 since not all patches were delivered
> in v3 due to SMTP daily sending limits.

Is this a Changelog between v1 and v3/v4 or between v2 and v3/v4?
For the former, please split, for the latter please add v1 to v2.

> - Add 'Reviewed-by' tag to dt-binding patch.
> - Update commit message in OF device ID patch.
> - Update commit message in the third patch.
> - Replace rfd77402_result_polling() with read_poll_timeout().
> - Add 'struct rfd77402_data' details in kernel-doc format.
> - Arrange includes in order.
> - Add comment for completion timeout value.
> - Remove blank lines.
> - Indent the comments to code.
> - Convert mutex_init() to devm_mutex_init().
> - Remove 'IRQF_TRIGGER_FALLING' flag from devm_request_threaded_irq().
> - Drop the duplicate message.
> - Replace 'dev_info' with 'dev_dbg()'.
> - Update 'dev_id' to 'pdata' in rfd77402_interrupt_handler().
> - Drop 'interrupt mode' comment
> - Use 'if(ret)' instead of 'if(ret < 0) for consistency.
> - Use 'return i2c_smbus_write_byte_data()' in 'rfd77402_config_irq'.

-- 
With Best Regards,
Andy Shevchenko



