Return-Path: <linux-iio+bounces-11480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52469B33EF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51796B2265E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FA31DDC11;
	Mon, 28 Oct 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xs1Y9ZPE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869F18E778;
	Mon, 28 Oct 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126747; cv=none; b=oEhRmit7EQq88/gz9nrbhqPxfkCQbBj2mQ1Q3sHzue2KQPNJ61wpnWP2o7LtCwNoUqCjUdLUbZQe5MPJKUhhHfKi3+XKHL70tC2CRJXGkx5xQOD6gEyRdKmzBV6Tp5qiD1mkDTjUmqQT+73kmEZQtb/WJkVZos8mMZOWZyHsdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126747; c=relaxed/simple;
	bh=UnDAvpzTjiJ2n7QorFmV93OWIKQH82nfR4Oun/gbU5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gma3GAuedIa8FncakEUftL//DYpjffCRU/wDOiHzHn8n4eU6ByY3KGwfvvqoUNvwKkJ0x+eMG7IqRsjWg+M4XLqUcmqjZUo2J8IsaiCWmdMNXco+/m7xkRDEvzT9uFvDba9uC/37JtWMhiiySRT0S6vcqx77U4Bgn2EGfwLlxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xs1Y9ZPE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730126745; x=1761662745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UnDAvpzTjiJ2n7QorFmV93OWIKQH82nfR4Oun/gbU5A=;
  b=Xs1Y9ZPEWNWyWt0jNvnjURxdH0O5es88ZJ3b7It5Ply6wcqK05UdD6iJ
   3DJue9rO05Uofs9wA3PT6rvtyNTBjkPMQs8O5TlLWao1Wv9yScs7+ei/t
   MP4NCzO2TtDEG5kpR2vwmkjwDG/3hEx5+E+PpRYl21gYc5pnn6mwY2vsP
   gCrgUqDNobRyzIXT52Ho8SEtSu1GSk9G6VtiTadfbZ2y9qP3MJItYZR4F
   zraXcvIZrPsl1mZu9Av2BFpuoZbuQnTt4Wr/SQLrLcNaMDtIJH4R4ay0+
   G93Lvn/15PbuztMpwN7q2knw1FHkz9acrByFS4qwBiZOnGmOkghN+DyAR
   g==;
X-CSE-ConnectionGUID: kjmqCBqEQ72CB5/8FPF/vg==
X-CSE-MsgGUID: W+5WEPZyTkiQ8x1w/9c1xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47186266"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47186266"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:45:44 -0700
X-CSE-ConnectionGUID: 4vzrq205TqGg5djw1tymcQ==
X-CSE-MsgGUID: +juHO9pRRQC0nMF8RrENCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="82456817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:45:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5Qzv-000000085kO-3T5j;
	Mon, 28 Oct 2024 16:45:35 +0200
Date: Mon, 28 Oct 2024 16:45:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: light: stk3310: log error if reading the
 chip id fails
Message-ID: <Zx-jj8FEldW6sG55@smile.fi.intel.com>
References: <20241028142000.1058149-1-aren@peacevolution.org>
 <20241028142000.1058149-6-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028142000.1058149-6-aren@peacevolution.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 28, 2024 at 10:19:59AM -0400, Aren Moynihan wrote:
> If the chip isn't powered, this call is likely to return an error.
> Without a log here the driver will silently fail to probe. Common errors
> are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
> isn't powered).

The commit message does not explain why dev_err_probe() has been chosen
and not simple dev_err().

-- 
With Best Regards,
Andy Shevchenko



