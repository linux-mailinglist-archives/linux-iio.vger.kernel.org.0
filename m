Return-Path: <linux-iio+bounces-28042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA12D3C104
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E42D440D17
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B53A4AA8;
	Tue, 20 Jan 2026 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJKASBbM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC43A63E8
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895637; cv=none; b=rrTiHjZ0SwV8cwfCNdw+7dp32ieeJ1J0GK/gXcmtNaSQtxN+4jM6AqSUonLhlGjm9sQUz1n4CeMqj9Ostppnh6nTB5zeYAkAYdSyIZJegSR5QTEFxcL7KTFJtjkq8o8p9HfpvFRxuKBqa/H5bMXL34C6wp9Cqaq/qnBcT2403us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895637; c=relaxed/simple;
	bh=3xDom/92JHPfGjzwDPNrzmpLfAXPt6YZ+OIb4XbhZX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFqNd+ZFsxVWiJ/q62CgcIf/q5FYlDrPfs9YwerGmyiS3/wHXQLTunO5R8Bd0+lSY8Ka5970YpxWT+DDlYRCX189dETFKgL2RoLWtRqPD//evy/7bVFqaTVP5ERSFuMkGEhLjxXz1Mg3tkYh27AcIHXxJNks1g35JX3El5mgej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJKASBbM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895635; x=1800431635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3xDom/92JHPfGjzwDPNrzmpLfAXPt6YZ+OIb4XbhZX0=;
  b=JJKASBbMyVEWi2XkheGcN/Jtkm7NnY88WQLWZvD9W5oDQ2lPbJ5EzN7H
   QQl8zPDKQ8UDerI0nnvRSS8anr4RXDUv8JfKwU81+xO+34ULMUxR/hkPy
   lmvb7VO6cNmyGLRIVwIo0WX4o6NM1u62lwKmnTsExHnj1VqVqF4Xyvuef
   yq83ijNOS8e29NvzDbw4EdoFCjy5Xir6uyoMwXWqCD/vVsZlypTvqUTvY
   tP4DVyltMyif2uw7Pop505M+RgCR0S343Qd6bdYoFTef8eNW/XSlq0GIC
   VEx9K/ArGOA6eDAkxnfP1S1CQj4UGpR1h13//6LumTj6gQtiG+Kc7ZawC
   Q==;
X-CSE-ConnectionGUID: XNtEwGZbRE2oXuYx8/3XZA==
X-CSE-MsgGUID: q9BJAajHQNGrBxWXI/utaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="95569908"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="95569908"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:53:55 -0800
X-CSE-ConnectionGUID: iPlr6gxyRMG0qSNjisVz0A==
X-CSE-MsgGUID: ft91vphCTeOViac0nMGSWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210192993"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:53:52 -0800
Date: Tue, 20 Jan 2026 09:53:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 03/11] iio: adc: max1027: Reorder headers into
 alphabetical order
Message-ID: <aW80jf7oiqVt6C1k@smile.fi.intel.com>
References: <20260119212110.726941-1-jic23@kernel.org>
 <20260119212110.726941-4-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119212110.726941-4-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 09:21:02PM +0000, Jonathan Cameron wrote:

> Only delay.h was out of place. Move that before adding missing headers
> highlighted by iwyu.

Hmm... What's the justification for kernel.h? might_*()?

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Cc to be located here...

>  drivers/iio/adc/max1027.c | 2 +-

-- 
With Best Regards,
Andy Shevchenko



