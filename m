Return-Path: <linux-iio+bounces-25815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 632E3C2A5B4
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 08:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E6342692
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC872BEC21;
	Mon,  3 Nov 2025 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbwEfPEf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D72BE7BB
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155551; cv=none; b=Vjglf4dGO+h3Gkguo0m5KqZp3KiRMwU8sNU6RI+eUXxz7V9qM0WnUXNB0C7imqtJ1SogTgFVbkPBOnO6B3PhRZ0Rf+C2qBZfrBZqxTjGxRznPZlsWBoAaQdc2zATeDJvFudY9CuQj1yj7e23Kx20cR/g7nl0tojI+Pb1owpfHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155551; c=relaxed/simple;
	bh=pP4FI3JUws2ERrPs37rF79tn0wXHcdyHuReOqZrpnkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZh+j9+zdWktkB+dENSUUEDNcli5Qq6TkaojUTZ/CE3GbaH8naHtB6C9H+REQpYXeMuaro6lAV9ErnIbEXvBU2QX2k1VPNHwt3ZCu3mZ+WRiFl43KyCnrDSrLEt2q7raftaGHkYVTUgroyYtURAuDziU/3zi1FjqP/uCFTzGIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbwEfPEf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762155549; x=1793691549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pP4FI3JUws2ERrPs37rF79tn0wXHcdyHuReOqZrpnkw=;
  b=JbwEfPEf5PxBYtpkbF/YThF9p5ziA0EI9I2MA0bqNZs4+roWhirvPGxd
   tgd7++ac7XzteLm+WnlP+YfQ8qguemRQg7BrXB4hCn2briT0RmotvwJi+
   gN6qwm+5G6NsPiX55OUnRbGxqvpgsDBPPGxXuXNLEjulzl6x2VBfqUV0i
   zj7ckoOCnvJw4+baqu9vpQQ1lHr7luehDAIFzBcEPlNBGiD7ECrjAPRTr
   Q9j9t87obH6mEOgHSAhsZsBxFAvRwtSMWM3VMARVE5AkSI0uSLUAMzTM/
   Wark+jYadDEEGM2K+deJjfCf2UOKvvcOFA8SqYsw592iC9ma+/QIGF/tO
   w==;
X-CSE-ConnectionGUID: Bt8d+I+bQmqrflDZ348Ttg==
X-CSE-MsgGUID: AhxuMemTRH+a8NXqBGpxYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74827984"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="74827984"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:39:09 -0800
X-CSE-ConnectionGUID: HmJscCvtQcSQk7ZtfZlUng==
X-CSE-MsgGUID: arTkJhN0SbOmnL3ssNBA3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186672752"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:39:07 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFp9b-000000054oo-1msZ;
	Mon, 03 Nov 2025 09:39:03 +0200
Date: Mon, 3 Nov 2025 09:39:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 06/10] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <aQhcFl4fE5Akn397@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
 <20251101164612.449606c2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251101164612.449606c2@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 01, 2025 at 04:46:12PM +0000, Jonathan Cameron wrote:
> On Fri, 31 Oct 2025 12:31:27 +0000
> Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> Looks good to me.  A few minor things inline.
> In particular a question of which include is missing for the byteorder stuff.
> Maybe Andy can help with a suggestion on that?

asm/byteorder.h

...

> > +	st->d16 = cpu_to_be16(val);
> 
> Should have an include for this.  Probably
> 
> linux/byteorder/generic.h
> though the kernel (and iio) has a random mix of that and
> asm/byteorder.h

Can somebody go and fix all of them to be asm/byteorder.h? Yeah, it might need
some thinking as in some _rare_ cases the author might imply the explicit
choice of the algo in use. But then it might be problematic on some architectures
as well...

> Hmm. linux/unaligned.h is using asm/byteorder.h so maybe that's the better choice

Yes.

-- 
With Best Regards,
Andy Shevchenko



