Return-Path: <linux-iio+bounces-10619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D699299E526
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381F6B24CD7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D861E765B;
	Tue, 15 Oct 2024 11:08:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDD1E377E;
	Tue, 15 Oct 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990538; cv=none; b=vBjWHi7swnPgrGQO06MwR7Pb35zAGed8DPEM9BBQMtgs1Rzr6EPwgCblSyCHhyJO/RDbwWb4cmtDtiJszeNZOVS0Al06fvq+YsSrgLgPKXKkvUG2iB4LFV7eBGvCLZU6kzzBNuLO8AMMlAoWioXtg+fgSxedajt2o65QW7xl8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990538; c=relaxed/simple;
	bh=7vjGjQHfBMbftYavyzTIGaLgrxdYcK7KHDnpT08ZtaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsPwlTNJrfK6s6UFwZxjUvZBj/jH7bQ+fgO9QRTE7s9tMwQJBnKIlS+zD/m8vXBzEm0RR/7kDbyq6KdETRVyL4S8uyAaMNVT08LEMtYm2eBGYNg+coz8JcswoeLjL+A68JHRaxDh8tQRUUN/1jzjgSSoe5ChovIMolgcTRIxWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: oNnjvyTlQJS726R6/G4jfQ==
X-CSE-MsgGUID: BqDuvhe7RMWh3rr1LViSLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32295900"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="32295900"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:08:56 -0700
X-CSE-ConnectionGUID: A4XlGWDvSqSs2/hGER1uWQ==
X-CSE-MsgGUID: DF/+bTsNTu2B2M/K1ho2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82516728"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:08:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t0fQ1-00000003FDA-0Jg3;
	Tue, 15 Oct 2024 14:08:49 +0300
Date: Tue, 15 Oct 2024 14:08:48 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Nechita, Ramona" <Ramona.Nechita@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <Zw5NQM6Z9ATOx6SX@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-4-ramona.nechita@analog.com>
 <ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
 <DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
 <20241010184516.66826055@jic23-huawei>
 <Zwgb_Fq4dhVwzpf9@smile.fi.intel.com>
 <20241012114202.425f1b74@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012114202.425f1b74@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 12, 2024 at 11:42:02AM +0100, Jonathan Cameron wrote:
> On Thu, 10 Oct 2024 21:25:00 +0300
> Andy Shevchenko <andy@kernel.org> wrote:
> > On Thu, Oct 10, 2024 at 06:45:16PM +0100, Jonathan Cameron wrote:
> > > On Thu, 10 Oct 2024 14:32:49 +0000
> > > "Nechita, Ramona" <Ramona.Nechita@analog.com> wrote:  

...

> > > > >> +	/*
> > > > >> +	 * DMA (thus cache coherency maintenance) requires the
> > > > >> +	 * transfer buffers to live in their own cache lines.
> > > > >> +	 */
> > > > >> +	struct {
> > > > >> +		u32 chans[8];
> > > > >> +		s64 timestamp;    
> > > > >
> > > > >	aligned_s64 timestamp;
> > > > >
> > > > >while it makes no difference in this case, this makes code aligned inside the IIO subsystem.    
> > > > 
> > > > I might be missing something but I can't find the aligned_s64 data type, should I define it myself
> > > > in the driver?  
> > > 
> > > Recent addition to the iio tree so it is in linux-next but not in mainline yet.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=e4ca0e59c39442546866f3dd514a3a5956577daf
> > > It just missed last cycle.
> > >   
> > > > >> +	} data __aligned(IIO_DMA_MINALIGN);    
> > > > >
> > > > >Note, this is different alignment to the above. And isn't the buffer below should have it instead?  
> > > 
> > > While I'm here:  No to this one.  The s64 alignment is about
> > > performance of CPU access + consistency across CPU architectures.
> > > This one (which happens to always be 8 or more) is about DMA safety.  
> > 
> > Right, but shouldn't...
> > 
> > > > >> +	u32			spidata_tx[8];  
> > 
> > > > >> +	u8			reg_rx_buf[3];
> > > > >> +	u8			reg_tx_buf[3];  
> > 
> > ...one of these also be cache aligned for DMA?
> No need as long as driver doesn't do anything bad like
> write to these whilst another dma transaction is in flight.
> (I haven't checked though, but typical drivers don't)
> All you have to do is ensure that any DMA buffer doesn't share
> a cacheline with an unrelated bit of data (i.e. a separate allocation or some
> state tracking etc). It is fine for multiple DMA buffers  (say rx and tx)
> to be in the same cacheline.  Any DMA device that is stupid enough
> to stomp it itself is broken (and would be fairly hard to build!). Such
> a device would need to be worked around in the controller driver.
> 
> They are allowed to write back stale data, but not garbage data to unrelated
> parts of the cacheline.  I.e. a tx buffer that was changed whilst
> the SPI transaction was going on, might be overwritten with the old value
> when the SPI controller DMAs back an updated version of the cacheline
> containing the rx data + a cached copy of the early tx data.
> The risk we are defending against with this alignment isn't this, it's
> unrelated (and typically not protected by lock) fields in the structure
> being overwritten with stale data.  The really nasty one being when
> the allocator gives the next bit of the cacheline to another allocation.
> (avoided here because the structure is sized as a multiple of the maximum
>  alignment).
> 
> Now, the code that bounces unaligned dma buffers on arm64 will probably
> bounce these because it can't tell they are safe :( That's not incorrect
> it's just less than optimal.

Thanks for the really good elaboration! I will try hard to not forget it.

> > > > >> +	u8			reset_buf[8];  

-- 
With Best Regards,
Andy Shevchenko



