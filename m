Return-Path: <linux-iio+bounces-23577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D069EB3E39E
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350D416FA26
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184D2561AF;
	Mon,  1 Sep 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXdQuO4T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A291257849;
	Mon,  1 Sep 2025 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730598; cv=none; b=nlm48f9BXh6XWxDStx3zmSP3Dj+Qaj2ErHptKBvm/xFcxZVmjiR3g8HMe0eQZWVoVLdEF4v2Ft8sEUXAH4qE5Qmu0x5El/l8wss3GPsYZqigehFx3KdkH0qYw2aNRXUic5W4+UORvKvWbpJiWYPadT0BES+jw0e2l2h5g6VNkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730598; c=relaxed/simple;
	bh=JV3RmCj1JMN6vIPs9w1LUVvRoHj1GcIh6KrLOIR/RlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC48KyguTpVE9nVVNZFHXwIoNDH8lkvgTB9j2sB/qT1hMbwOxalBY4kISceQgHT3nx/0t5ExKxfmRVjZ7kpWDdKmYUEQnTxnz/4dJG0mXihB//AdyA0pFPJpOP1mPOdEINWYB4xBaAEsxC+Nlhm7qTlMZfKgpmn2kTICK2yLLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXdQuO4T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756730596; x=1788266596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JV3RmCj1JMN6vIPs9w1LUVvRoHj1GcIh6KrLOIR/RlU=;
  b=jXdQuO4T89qdaspNpy0KKe3sSbeg28/wTlP8sjFuSCYbjrIvsBCpKKXE
   NZJ+DWtsMYQAmAjdvyJan2SrKRzf+u8dSQWXt+BEqwMW8SKHMgQtCiyuG
   j4PTbE/FL3P5PIIxFWCThtrXl0b27/vBU4GSoKRhPm4LhjnH+vkQfoaVJ
   lrPAxG7Su0MDM/v8D/Qa6PoQSpB4PnrIU3hZkAxP84vXPXJirm2Bm7DPR
   xCb797AxUoBVrBJUsI0yv8XAZEzAB5KJOJh2f63Kuvy9wupYpCVmBHC31
   kF0sxtWBr4DSonnTZtRq8KjCa5VI+ZYD8ozMqIk16CU6TofbZxwms4EYZ
   Q==;
X-CSE-ConnectionGUID: 3Vn31p95R1mtzhQ05BJgww==
X-CSE-MsgGUID: kPMLKY2ETaimIhBb9JmNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62821495"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62821495"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:43:16 -0700
X-CSE-ConnectionGUID: BuhrxOKbQ9+4gTuoB5MZsg==
X-CSE-MsgGUID: 6uN3xkOnSVOA2l5NeF2Alg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170868578"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:43:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ut3sL-0000000APj6-1CGF;
	Mon, 01 Sep 2025 15:43:09 +0300
Date: Mon, 1 Sep 2025 15:43:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Karel Balej <balejk@matfyz.cz>,
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Message-ID: <aLWU3AwC37jpV9W_@smile.fi.intel.com>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
 <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
 <DCGUXTSZ8B9G.2S2Q2JXYMBSRY@matfyz.cz>
 <5048048.31r3eYUQgx@radijator>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5048048.31r3eYUQgx@radijator>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 31, 2025 at 10:19:38PM +0200, Duje Mihanović wrote:
> On Sunday, 31 August 2025 21:24:54 Central European Summer Time Karel Balej wrote:
> > Duje Mihanović, 2025-08-31T12:33:05+02:00:

...

> > > +	iio->dev.of_node = dev->parent->of_node;
> > 
> > Didn't you mean to drop this since Jonathan pointed out that it's done
> > by the core?
> 
> Actually I have found that device tree consumers fail to get their IO
> channels without this line, so I left it.

because the passed device is not parent?

In any case this line is problematic. Use device_set_node() instead with the
proper dev_fwnode() parameter.

-- 
With Best Regards,
Andy Shevchenko



