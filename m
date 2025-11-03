Return-Path: <linux-iio+bounces-25816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D327C2A674
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 08:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8B7B4E85C2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76D29B764;
	Mon,  3 Nov 2025 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjHwSot9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D923EA82;
	Mon,  3 Nov 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156286; cv=none; b=dHZ27+OgihnksN/F2BfL7U4WFRQBPXJXz8tAIvwxu51f+H7tW+S80MNzRMvfAZsYFwzcyCfDxX9Ckbgbc4SwBxuBvtR0Z9JMmJ5G1euipcIyxFPBX//r66uk8s+/WzlOzEU65NTCjFcf8dclT8HWdkbkbd9iQxPk+JQcKQPl6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156286; c=relaxed/simple;
	bh=CzFv5QtTw+xxN2lhxtaOKfWAs6w/cC9PXnYPBftch+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwzDka0l+c40YsTYg470TZC/ZjqxB7I0HpE1XFgMquPn0++T1hEREN26fgPVXICX1Nu/UBRx2e9jmPcsfijTi3c3rONVtduceDft0C0GXR0QF1jaz/ydVDWGkvB/tOedOgRD6OWLXO0ODjhdMr35I5LyZZNP6kBthTIxLusQDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjHwSot9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762156285; x=1793692285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CzFv5QtTw+xxN2lhxtaOKfWAs6w/cC9PXnYPBftch+8=;
  b=LjHwSot9qdbTRRh2UArI75WUKix+V2RxS5YRLNH8yltJeS9wAKXDQOnE
   IApTtVHI20A75XhJgxWl0A0p0JLDIMKaj5PMwvMn2pxv7OFQeovqbiofK
   Z/r0lRsmOkImuNz9Qtuj09dMMrLgcJfQ+hIquVmczy6OIkXksldNh0hj9
   k2JlNSVXlINxHxAVxeAMwCavP/afFmtEzeS6Hpn9NeJu1V+X3sNTtfQp2
   C3191BbxOgzkygvSbHP0l8/87jDK9qzVNX1B3/7B2M2/Dlr+h52fb7MFo
   pPtWiNrWztY3abVQyBgxalEyOcxI2thlKLN13/COHz3FpW0D5xfqIS8m2
   g==;
X-CSE-ConnectionGUID: pVXHbwEcQpmpPfZCdaRnMQ==
X-CSE-MsgGUID: +s+AUinlQMSX+WdprkkuKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="66839124"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="66839124"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:51:24 -0800
X-CSE-ConnectionGUID: QA9eUSzpSVu3aRL5VPuxqw==
X-CSE-MsgGUID: v+EbVtIyR0+YA4ipkPUPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="224043544"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:51:21 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFpLR-0000000552S-0Yeh;
	Mon, 03 Nov 2025 09:51:17 +0200
Date: Mon, 3 Nov 2025 09:51:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
Message-ID: <aQhe9IjEW07PP6Or@smile.fi.intel.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <aQR1N__AwvPm21tm@smile.fi.intel.com>
 <406fbb02-5a2b-4097-a645-b97d3d74287c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <406fbb02-5a2b-4097-a645-b97d3d74287c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 01, 2025 at 05:07:38PM +0530, Ajith Anandhan wrote:
> On 10/31/25 2:07 PM, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 10:04:08PM +0530, Ajith Anandhan wrote:
> > > This RFC patch series adds support for the Texas Instruments ADS1120,
> > > a precision 16-bit delta-sigma ADC with SPI interface.
> > > 
> > > The driver provides:
> > > - 4 single-ended voltage input channels
> > > - Programmable gain amplifier (1 to 128)
> > > - Configurable data rates (20 to 1000 SPS)
> > > - Single-shot conversion mode
> > > 
> > > I'm looking for feedback on:
> > > 1. The implementation approach for single-shot conversions
> > > 2. Any other suggestions for improvement
> > > 
> > > Datasheet: https://www.ti.com/lit/gpn/ads1120
> > The cover letter missed to answer the Q: Why a new driver? Have you checked the
> > existing drivers? Do we have a similar enough one that may be extended to
> > support this chip?
> > 
> Thank you for the feedback.
> 
> I evaluated the following existing driver before creating a new one:
> 
> ads124s08.c - TI ADS124S08
> 
> - This is the closest match (both are delta-sigma, SPI-based)
> 
> - However, significant differences exist:
> 
>     * Different register layout (ADS124S08 has more registers)
> 
>     * Different command set ADS124S08 has built-in MUX for differential
> inputs
> 
>     * Different register addressing and bit fields and conversion timing and
> data retrieval.
> 
> would require extensive conditional code paths that might reduce
> maintainability for both devices. A separate, focused driver seemed cleaner.

Good, please add this summary to the cover letter of next version.

-- 
With Best Regards,
Andy Shevchenko



