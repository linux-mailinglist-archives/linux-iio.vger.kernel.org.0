Return-Path: <linux-iio+bounces-25395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFEFC02E87
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BD434F20B9
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510927815E;
	Thu, 23 Oct 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8kabk/Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC715E8B;
	Thu, 23 Oct 2025 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243909; cv=none; b=Nkjuk2kIt9Jgb1MZU4JmPR3zrhVgEVaR3TK+uxgWYZNvbpzKvFoCldLWU1IC/NOHsI5q9Ocy9ONaCfcGjQZCo7QRQiOOuSD3tJAoKpYKlokEsgpizoqxavySC0zstse2SVq03XFJKlDhD9ANWgs5RtUwzQVNKnMj70X6C0qAN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243909; c=relaxed/simple;
	bh=zwCmN86sqMbHXrITH7YOhA0fPI1EnrI6nXVZagQBh7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt+MWIeBsqlG1bUz5nRNyCpTTKwmLTZfzYTcA2FlYyphUBUGaK9YhnuarkW8ODFylOpr3eg9bSsGYSkwbapvlNgPZGSpzaDLnsbKXHKmBMMVAeXx9nxjN1Mltjvc4u1ERFRVmRRLeGmS+jANyeZSZII/zQJ5EgxQ5p4MWpV2ZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8kabk/Z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761243908; x=1792779908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zwCmN86sqMbHXrITH7YOhA0fPI1EnrI6nXVZagQBh7I=;
  b=Z8kabk/ZGD6/R7JpRbFPhyCXA0PdcAWNNDdXgwgcxV3zmXXqa0SAi54c
   jAxiVJaYmHSbx1kj7byGHbObV3Iu1BhMDBZzgmZOv4Llhue9olG+6F+ku
   /Q5X8rhG30JMzBsthRAKGZ7CTLB41tgfocmXy8zJRD5g0mj+DfDPh8TCi
   X2AstZmMkoC18PW+8sFuGhEUkmJNGTwNi7JLJthl5a1kVkd+nMmynTR8o
   wGPCr/fxDcGhBNnJAI43OP1NNaJ7C9FbCGJjz2icfnwVuJwfKOB0edX4o
   E08fgmId00TNC9ChtKAZjNATvt29zysZqMMzsrl5aZ0aqSmQT48A3vFl5
   g==;
X-CSE-ConnectionGUID: qNKq2PLNRVilgGcdqZar+w==
X-CSE-MsgGUID: nt0mLNHCRR+E7DQWHvbxXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74544223"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="74544223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:25:07 -0700
X-CSE-ConnectionGUID: rZGXvA+rTRisloNEidpLPA==
X-CSE-MsgGUID: 4eRJcodlREGrhOmUXQuDVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="214884102"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 11:25:04 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBzzg-000000020qc-1HGR;
	Thu, 23 Oct 2025 21:25:00 +0300
Date: Thu, 23 Oct 2025 21:25:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v6 3/5] i3c: master: svc: Add basic HDR mode support
Message-ID: <aPpy_FNh0DB_1x-w@smile.fi.intel.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-3-3afe49773107@nxp.com>
 <aPnngQdwEqHgPc7R@smile.fi.intel.com>
 <aPpIkqjeWsi7xAAn@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPpIkqjeWsi7xAAn@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 23, 2025 at 11:24:02AM -0400, Frank Li wrote:
> On Thu, Oct 23, 2025 at 11:29:53AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 14, 2025 at 12:40:02PM -0400, Frank Li wrote:

...

> > > +	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> > > +			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
> >
> > No error checks? Why is it okay?
> > Why is the first parameter 0 while it's not an _atomic() call?
> >
> > > +	udelay(1);
> >
> > No explanations given. Also is it really need to be atomic? If not, use
> > fsleep() and it will choose the best suitable API under the hood.
> 
> It is in atomic context. I will add comments.

Not only, the call that's used in the code from iopoll.h is wrong in such a
case. Haven't you tested this with debug atomic context?

-- 
With Best Regards,
Andy Shevchenko



