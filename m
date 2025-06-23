Return-Path: <linux-iio+bounces-20891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34095AE3694
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 09:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C674816F402
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770F31F3FE8;
	Mon, 23 Jun 2025 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gidknS1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6E1F181F;
	Mon, 23 Jun 2025 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663181; cv=none; b=nG9RspKnTIif3HbGteaJ+O9wVZ+vLbk7rOgRzZ7D9U8FM/FW2n85j/nhhVu9qe/kJnzhd4f3q9nFzdGKrZLpEAXMb5lOlGOAW7hr9z1cMfazfTT7XwSyTwWuI210ixbgJwsqaJl3yUCHFLpLUq/A7o5ljPeC+g66/Jsx/XcPph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663181; c=relaxed/simple;
	bh=uMS6SxvwbTk6+f+beP1zqXrTKD6JiMADLyM/BP+h2xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqR7CUbwF7ncswbUgA6W06xTGla04qowWoj32K/F3Y//m7xNJ+75hbuVqm1KR6AyzdR9NU8yzhb6y2NDywPzRm6V0H1wpXlq3x7qZ5oQCjXxpXqb7PEsW+mOVlCBc48uAktUbGv8zHox2meUQPVjryoDA1RXR+9LJc/rwvA6klA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gidknS1Z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750663180; x=1782199180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMS6SxvwbTk6+f+beP1zqXrTKD6JiMADLyM/BP+h2xM=;
  b=gidknS1ZvMBuzT/R1GQr89lUIfBqfaDrS/Nc2r34KAUzfIJEZQ6vR6b9
   qBeDXrYRi13Pg5jZU6Qkrm5hIoSMQIbol14UeEG+ugJqSMAPx9ysJEPXW
   EyTik2XTn/uswLGVKy4j50g6PUdAzJyPiRdhfi1r/Da2DVs6tca5n5KJY
   y3TPThnuDU/gkVlsLF8EJ3whubnvTzawAPefveQa5R7eqPj97NcqUDHgC
   CCQjG0zcrjuMsaMpTx9E08qlJGA0yiKkuVD9Xeydpk9mnAWAjWrwJqCM1
   mGjQjPkGcW7cvX5f6LXXQFpL9eNkP6CZ3Bm9AGRpJgi+5Too84BJ92dTR
   g==;
X-CSE-ConnectionGUID: Mr2J0DASQ7KghQIUPMrcsA==
X-CSE-MsgGUID: xjulBmOKSq63f+LfdGtYEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52787883"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52787883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 00:19:35 -0700
X-CSE-ConnectionGUID: pN8HTRYxTIWnyaLlsaGdRA==
X-CSE-MsgGUID: ckLOpPKRRK+VAXlpoHZV6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="182561505"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 00:19:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTbSh-000000095qe-2GUI;
	Mon, 23 Jun 2025 10:19:27 +0300
Date: Mon, 23 Jun 2025 10:19:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marek Vasut <marek.vasut+bmc150@mailbox.org>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
Message-ID: <aFj__w2rf4UEJvhY@smile.fi.intel.com>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <aEw_DcqpCpcsBGd0@smile.fi.intel.com>
 <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
 <aE_aL5dGKZeKBu50@smile.fi.intel.com>
 <db14331e-193a-4915-990e-7657b5ca0c5b@mailbox.org>
 <CAHp75VcZ6-WFyyERg7YVXNj3-uggwyNf2fF4mnbhiUZ6xNwYvg@mail.gmail.com>
 <3e7daf0d-6472-4e53-86eb-e5c5c1fd3640@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7daf0d-6472-4e53-86eb-e5c5c1fd3640@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 21, 2025 at 07:33:41PM +0200, Marek Vasut wrote:
> On 6/16/25 1:09 PM, Andy Shevchenko wrote:

> > > > You can try to monitor the /sys/kernel/debug/pinctrl/*/pins files for any
> > > > changes that might happen on the sensor events. It might (help to) reveal
> > > > the IRQ line.
> > > Sooo ... if the IRQ line is not described in ACPI, it could still be
> > > connected ? Hum, I'll try to shake the laptop next time I power it up.
> > 
> > Yes, it's possible, unfortunately due to the closed / per-product
> > nature of the Windows drivers.
> 
> This is the only pins I got out of this, and there doesn't seem to be
> anything changing if I shake the machine:

Yeah, it's kinda hard to catch in case it's an edge triggered interrupt.
But for level shouldn't be that hard and it seems there is no luck so
far. :-(

That said, the best workaround now is what Hans suggested.

-- 
With Best Regards,
Andy Shevchenko



