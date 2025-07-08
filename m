Return-Path: <linux-iio+bounces-21443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CA0AFC8F9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C061188BBC8
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041212DA758;
	Tue,  8 Jul 2025 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwZ/5rka"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1552D8397;
	Tue,  8 Jul 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971985; cv=none; b=e7GnzzwI2wy1CGo4bjrM13B5qTBNpcW+vqQ3CWyqa/BXfkqBc/Dmf429wHDJpLN2mRKCuzWoj6VJZxlz9jFGUrRC/NIPm0O+lf06P/U0MG5+gPHRxpSmBngOO/u41buEo7NmaBu9GJQpknmkxVxmYHOLp43Xbb+bDni6zne41zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971985; c=relaxed/simple;
	bh=O+3HEWQa9m+oJ5zzQvZwOjr1f4UKgVaCi0+vnwA0Qf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwORxRwB87iNr7o3bRoTCT73fXYOSomI+kJr0MI7yp5ykoFPBC3hjLWIdUgXEN5M3+9eVE78MmI0gWMPkcGnpVc/tnbYwGZQUDNtleqOmqMFmWgSgUGybMFsK+61FhoUIrUeiiaf2QKB9dh0DYsgCcYMuCNdmsKdsEScy/HuoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwZ/5rka; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751971984; x=1783507984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O+3HEWQa9m+oJ5zzQvZwOjr1f4UKgVaCi0+vnwA0Qf0=;
  b=FwZ/5rkaJRN6qGhZqVzobX4N6dXuyIoQ34O/KuCsGAbiOPFFimjKY5tX
   i1uND+lz3a6Zvl453h6I8P/O9HfRHqZ5L+1xu8//oTQZQoPLXJ/g4w+xF
   +c5qtyEywhovVxV1ard/0bi4riXPdVc/b1vFuRISA85v61Tt/TOU6aVU3
   5t19FjbX7c1FkjpDX8AVt1xuA+IVMpPlMJXf0lr78FiGkQoIaKeYzRW6G
   NF+GSTEDrcl+Ng7maKP5ZAXkKHeDJz7SugnhIftAJ0cmW8D5CMUn6hkmE
   2oUj3a8QoKOWQLYZEEowVQW3Fryin9K+SpsMp4BVXvwCCILFYs/QgSta9
   Q==;
X-CSE-ConnectionGUID: /V+/YtlJStWKhOggov6RZQ==
X-CSE-MsgGUID: MKBmul4fSQGb+jN9lKKhLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65558075"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="65558075"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:53:03 -0700
X-CSE-ConnectionGUID: C9rRNF7FRmWDZ78R4vbJGA==
X-CSE-MsgGUID: 9husKVlrTXy4SJLvTtJwwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="156211127"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.230])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:53:01 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B20131208E5;
	Tue,  8 Jul 2025 13:52:58 +0300 (EEST)
Date: Tue, 8 Jul 2025 10:52:58 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Crt Mori <cmo@melexis.com>, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/80] iio: temperature: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aGz4ikEwFAstpIvG@kekkonen.localdomain>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075428.3219924-1-sakari.ailus@linux.intel.com>
 <CAKv63utwwwQVMrAZAGy9rkk5fFPncQ=TzggZf6K0s-+GB-oi6g@mail.gmail.com>
 <20250706112502.72441d9e@jic23-huawei>
 <20250706112631.33bd5a4d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706112631.33bd5a4d@jic23-huawei>

Hi Jonathan,

On Sun, Jul 06, 2025 at 11:26:31AM +0100, Jonathan Cameron wrote:
> On Sun, 6 Jul 2025 11:25:02 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 4 Jul 2025 18:00:02 +0200
> > Crt Mori <cmo@melexis.com> wrote:
> > 
> > > If that is the case then:
> > > Acked-by: Crt Mori<cmo@melexis.com>
> > > 
> > > 
> > > 
> > > On Fri, 4 Jul 2025 at 09:54, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:  
> > > >
> > > > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > > > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > > > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > > > pm_runtime_mark_last_busy().
> > > >
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>  
> > No {} issues in here so applied to the testing branch of iio.git.
> > I'll push it out as togreg later in the week at which point linux-next
> > will see it.
> > 
> Actually - change of plan.  I'll wait on your set with the others fixed
> up as I don't want to pull in the pm-runtime change if I'm only going
> to have a few of these ready by the end of the cycle. I don't mind merging
> that with the whole lot if they are ready though.

Thanks for the review. I'll send v2 of the iio-related patches soonish.

-- 
Kind regards,

Sakari Ailus

