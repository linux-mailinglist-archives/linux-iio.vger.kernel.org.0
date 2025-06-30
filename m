Return-Path: <linux-iio+bounces-21145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39341AED80E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4730B175E19
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C40244676;
	Mon, 30 Jun 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAAZaIID"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AF24167B;
	Mon, 30 Jun 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273990; cv=none; b=EUCjZl06qJuqZpxSkMBOHTWubW8Xsf8NuXA/o6Kd+a2wCVid7KayZDD8olaz1CtJVYOlRdtDDY94D/Ohh6V5hRQT8pbXEo8nPwMnIJs6bUpnqh2U369C3u/eMg0Y1OIAmqUwbpoihkEijgfVRAtfL1IpbudEbbK2JRFj5r3PsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273990; c=relaxed/simple;
	bh=ToR84roctDFgModJjPWdh8vmMesg9jhp9CpxHg/WepA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clVL03hhu2vKma36dNBcY1bA39sfvr5PoEAUNIiSzQDO7jumnlrDswDa0x/a97enWPtMUOc+P7xfHiWAKbdkSHqEcJsZWvInIxi5mL3oVcTBjfMErdanG6bY+Uh6LJBOWD7tsgKFpLRr3jxQ/xwkRDO7i4jeG5Pq9a2fCsVUsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAAZaIID; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751273989; x=1782809989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ToR84roctDFgModJjPWdh8vmMesg9jhp9CpxHg/WepA=;
  b=AAAZaIIDQwF5MvxWkj2sIJEcClcbyJ8KHDdTE7KBQ5vPGgsMmKxQp2Sj
   W2HWEAce+MpVxWFrB9CGwP3aR4U2vNfga0ij2ogUVSw4fwltO/vOKj+wU
   NOyFs2GSA7TxYHn+qRvyesoD3hbB+ovfWyrbZP83dvjgliAsGNHy0gEsZ
   J8APZX4cmnjG+V5UDw+u8UOrRUxrUd0ILSxwGjsLAJaf4h9avq97EEjEj
   sjXT4fn3dD2TyhABqm4cSZygD3gHrWq9CJLf1o9Nu9dvLkeb/z7zWfRG+
   7DCkcBTojxhqARaEkAVXH4goRFdVGd6wxa8JNWgwY5krRlMLegRXPqAXF
   Q==;
X-CSE-ConnectionGUID: OcIEsDwzRfCr1TZk4zM0/g==
X-CSE-MsgGUID: XfQ8kdTnQxKa19wBSHzMvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53432609"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53432609"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 01:59:48 -0700
X-CSE-ConnectionGUID: BVYIGSW6RvWln2vN5yuMjg==
X-CSE-MsgGUID: udy0AnRZTmK8B0TqmXKTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="190577484"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 01:59:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWAMY-0000000BFpk-0osG;
	Mon, 30 Jun 2025 11:59:42 +0300
Date: Mon, 30 Jun 2025 11:59:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
Message-ID: <aGJR_YyW5tCMjxUD@smile.fi.intel.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
 <20250628155643.7c18e023@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628155643.7c18e023@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 28, 2025 at 03:56:43PM +0100, Jonathan Cameron wrote:
> On Fri, 27 Jun 2025 18:40:00 -0500
> David Lechner <dlechner@baylibre.com> wrote:

...

> > -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
> > +	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);
> 
> Ah. You do it here. Fair enough and no problem wrt to patch 1 then.

Hmm... Should the second 8 be something like sizeof(unsigned long lone) for
semantic distinguishing with 8-bit bytes?

-- 
With Best Regards,
Andy Shevchenko



