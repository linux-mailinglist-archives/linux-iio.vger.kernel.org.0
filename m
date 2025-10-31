Return-Path: <linux-iio+bounces-25760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8BC25C97
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE5C188D2A7
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE951EE019;
	Fri, 31 Oct 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ztb6NN8D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22931DC198
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923262; cv=none; b=lMygRJ97X3NRBP84jJBCW5I1JgYiyBEZKPQEYvsfl9aVV43694Agf9qCHBZK/lOUkCrX0PIxD5fQzEue97wsJ1kBUEtyo8K2TLCGaRcR16ZtyRog3VIq/AnUGvfTd19LVLzcL7HuxOi0OjrXhMPotJ7s/EfUe8Y6gJ//12v6z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923262; c=relaxed/simple;
	bh=PbvsIHP2yoN2ylbMzJL4WS6oUFqXg+YzCduhccCTFdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VasEzUvUc15HvDOGu9OrttM3K2kMGgUJ9uUtEITpashx5CEMd6LoFsT+30ObqK7hAf6pSEhA1DmUko8Bz/W6EI6aMN3qEeFJBjm8QbGgBKDjTM4tgqc1qSG4cA5BukKUdFt9bpcw99AStC2Wyzccccu+b++5Ht3P+YQWwIHAuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ztb6NN8D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761923261; x=1793459261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PbvsIHP2yoN2ylbMzJL4WS6oUFqXg+YzCduhccCTFdY=;
  b=Ztb6NN8DI65Bab7LRDhryN5ViC1LTwUNV+cjwPYUlkluEFT9tFZj2X7+
   8g+XmgnrP4E2SK0ESTEOzFE9FGpi6JdPOKuoykpEUrL8xfJJ7X/SMLQkw
   48Y1TKLmFbbRovolMDnEq/nQhVFi3gHXr2Xp7N0gOW/U9VzPk9EdnvbwI
   qaoRA5/PK6soLoczOBClI/7JbPZNrRQtUOsOvK0cfokDrPjxk9bJoX+be
   +AzGniekBYhzQHzbCW92JpILuF0qlN3e3Rw5Gw0Se6CaGZAChy13uTLe8
   6Ab7dZi3P7dKHey6RmSN2DFX9hOcKBmkQ7wR0DF6OfXYeaAZwTg92m8tc
   w==;
X-CSE-ConnectionGUID: ZxOLwAqBTzmB4smeynqu7w==
X-CSE-MsgGUID: 3HriJn9MTUq+BpGnUz5Ohw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74377678"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="74377678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:07:40 -0700
X-CSE-ConnectionGUID: gXIo+etQTXqvrVou4ZwQrQ==
X-CSE-MsgGUID: FdM1I+DsSymMHz3rWyN3sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="191402274"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:07:39 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEqj0-00000004IvH-0WC6;
	Fri, 31 Oct 2025 17:07:34 +0200
Date: Fri, 31 Oct 2025 17:07:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 02/10] iio: dac: ad5446: Use DMA safe buffer for
 transfers
Message-ID: <aQTQtUUQpWY_L5q1@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-2-d3541036c0e6@analog.com>
 <aQS7YIxYH2suDmoS@smile.fi.intel.com>
 <83da9af88f23bc87c558e220d7d1a32a0d91403d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83da9af88f23bc87c558e220d7d1a32a0d91403d.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 03:00:07PM +0000, Nuno Sá wrote:
> On Fri, 2025-10-31 at 15:36 +0200, Andy Shevchenko wrote:
> > On Fri, Oct 31, 2025 at 12:31:23PM +0000, Nuno Sá via B4 Relay wrote:

...

> > > +	union {
> > > +		__be16 d16;
> > > +		u8 d24[3];
> > 
> > Why not __be32 d24; ? Yes, it will require explicit size to be provided, but at
> > least it will look consistent with the above. OR u8 d16[2]; ? But then it becomes
> > simply a u8 buf[3] __aligned...;
> 
> Because I'm just keeping put_unaligned_be24() as before. In fact I'm just keeping the
> same type. Sure we could do __be32 and the cpu_to_be32() with a proper shift but 
> I'm already doing way too much than I signed up for when sending v1 :)

I think no shift would be needed.

> > > +	} __aligned(IIO_DMA_MINALIGN);
> > >  };

...

> > > -	ret = i2c_master_send(client, (char *)&data, sizeof(data));
> > > +	ret = i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->d16));
> > 
> > This will add a quite an overhead to the transfer (not that I²C is super fast,
> > but rather the processor is going to do _a lot_ of additional work here instead
> > of doing something more useful.
> 
> No really. This exactly to tell the i2c to not do any bounce buffer if the adapter
> calls i2c_get_dma_safe_msg_buf(). So I would say, it's actually faster.

I might have forgotten the implementation of that, but does it hold for the
controllers (or cases) that never supported DMA?

-- 
With Best Regards,
Andy Shevchenko



