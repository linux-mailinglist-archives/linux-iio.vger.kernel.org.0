Return-Path: <linux-iio+bounces-22318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F72B1BBAC
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 23:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6473189039B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F52231836;
	Tue,  5 Aug 2025 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esXuty+w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC992066CF;
	Tue,  5 Aug 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428584; cv=none; b=nmvx1IgOE21o11lw/fiqJZTjKyWWkawpesULiZxhHR0Rg28MepBKe5XBC91EVS4td7FOZ1s7I3wgXKPE0I7IHjB06QuChj3U9nPpXU9npB/toOGjlayWx7H6yYhTYMgVqsxCDTD+OpgU2e6u4OSCddvutXcwEm0crcN+o94aJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428584; c=relaxed/simple;
	bh=u/948oDQQIOodQ3QXjRgv6XTHw62TrPExIfVZivcLY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmwo9NDgYRYT0IW1EYSGFZ2v0bkeEdCxPQo0QI1yQ2gA7KrVUZdXEG0fTnFDRaPEVjfE61JB7PqY+IDjIR2KvMwulyTLwOQnC31tNYyQPkw/59K7neBXTPjNOD+rlt5rmKDD29sTCDXBW3KdoT6wFFWTEbKVYhQlwianB7C0bA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esXuty+w; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754428583; x=1785964583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/948oDQQIOodQ3QXjRgv6XTHw62TrPExIfVZivcLY8=;
  b=esXuty+wEthDHXQbMlkX0QtMDUu92GPfW4qrQCXVrO3BhUo75MbTYRic
   PntQgEiBrwFSqZ1gGeLVJFRJ5of5Xbx78QGLMuumrMc3dAMk0vy0IDeE4
   EUnzTbnLAVQvDtUYeJ7AJiwSZ1c134NXaK3ZioZSOpHK62miRrHzNP3Ox
   zGaClY+ItqMQwav1cKqwMAsiPsEOjIMcKksiafKgQbpPKQ3AS3Qx2tezT
   McTRbgrB1Y7PA/a0Ce+mG4cLCXeW0xRrIyClcS+Indm2P+8MoE2oRiNIp
   XRf9jvVjJo2BSklKZFw5lxcaQxqtREJbGo8uxE1bmRFq+K6ChemO2UaC7
   w==;
X-CSE-ConnectionGUID: fpvfyAmUTIWruoAKJqetGA==
X-CSE-MsgGUID: lrFAk7yVT2+1iuh5a5G7Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="67811400"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67811400"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:16:22 -0700
X-CSE-ConnectionGUID: 0Od6XwJDQBC/j5qDmek8lg==
X-CSE-MsgGUID: 6uh4nKtqTn2SpXFR6N6+YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164502641"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:16:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujP15-00000003r3M-0aFZ;
	Wed, 06 Aug 2025 00:16:15 +0300
Date: Wed, 6 Aug 2025 00:16:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, gshahrouzi@gmail.com,
	hridesh699@gmail.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: ad5933: Fix implicit fall-through in
 switch()
Message-ID: <aJJ0npFx1mwJ-MoV@smile.fi.intel.com>
References: <aIdKAJVnskdAVUMi@bhairav-test.ee.iitb.ac.in>
 <2025072835-singer-penny-a421@gregkh>
 <aIeDDsRurrgXqRQn@bhairav-test.ee.iitb.ac.in>
 <2025072808-evict-snorkel-8998@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072808-evict-snorkel-8998@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 28, 2025 at 04:23:49PM +0200, Greg KH wrote:
> On Mon, Jul 28, 2025 at 07:32:54PM +0530, Akhilesh Patil wrote:
> > On Mon, Jul 28, 2025 at 12:39:21PM +0200, Greg KH wrote:
> > > On Mon, Jul 28, 2025 at 03:29:28PM +0530, Akhilesh Patil wrote:

...

> > > > +	default:
> > > > +		return -EINVAL;
> > > 
> > > What tool is requiring this to be added?  It's totally redundant and
> > > needs to have the tool fixed instead.
> > 
> > This patch is not inspired by any tool as such.
> > I observed this code pattern while manually reading the staging area iio
> > code. From my eyes, there is implicit intention to return from switch block if
> > no match is found which can be improved in readibility by explicit
> > default block returning error.
> > I agree this is redundant and will not have any functional impact.
> > However, imo - this can help support kernel wide efforts to
> > clarify switch() blocks.
> > 
> > The motivation for this patch is from a035d552 which talks about
> > eleminating ambiguity by clearly defining swich() case blocks.
> 
> Yes, but the code right after this does the "default return", so that is
> now dead code.

Hmm... If I read the code correctly it is either already was a dead code before
that patch, or it's still accessible via goto label.

> I'd recommend the "pattern" that the current code is in, it's simpler.

The pattern to return from all switch cases, including default is commonly used
in IIO drivers.

-- 
With Best Regards,
Andy Shevchenko



