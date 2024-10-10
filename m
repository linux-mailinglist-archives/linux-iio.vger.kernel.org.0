Return-Path: <linux-iio+bounces-10413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65B999014
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111BCB214C5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41DF1E5738;
	Thu, 10 Oct 2024 18:25:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A661E501C;
	Thu, 10 Oct 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584710; cv=none; b=nJnmeYIcJv7r3YVQKl14AXoh761TFrxaCwUDiiySLdqS2+AR9kQffpbZl7jSyPIWvPs+XybhNVrk3GTmH6n7LN9MYtvB9gtQ31rfzZRRbq2cngR0oqB5qLriD4+07Fj9VqMHG1nNl2WAefOHZoURWpHQtxlGGq2u95ZMAci/AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584710; c=relaxed/simple;
	bh=Gb1OM3XNcHjhlrruKRGciwPXQbjPGmRZV9lTsWr/ndA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkPVW0VjQB2WIDkQIPRVKPrhfvKey7l2L/oTTHa0zIPm/LIyCH8WOPgSjsHi6dOh5jjuSIfWDRMexoVgs3jqplYE2MQBIc8Z5QHXloHu0jIY+ULfaSPXOKRkiprbFQVtrEce6DquQUHLBI6eH2IrRzOgVBGDxalx/m43z3E38co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Lr8ITAvcRuaAsxKZSip9HQ==
X-CSE-MsgGUID: drscvJzVRp+DubaH39V7Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="15589783"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="15589783"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:25:08 -0700
X-CSE-ConnectionGUID: cWumthqGSxO2q6eXH5c1DA==
X-CSE-MsgGUID: 7ZIywpEDTBmq7vS6rS0Z8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81270572"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:25:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1syxqP-00000001dPi-0OaD;
	Thu, 10 Oct 2024 21:25:01 +0300
Date: Thu, 10 Oct 2024 21:25:00 +0300
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
Message-ID: <Zwgb_Fq4dhVwzpf9@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-4-ramona.nechita@analog.com>
 <ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
 <DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
 <20241010184516.66826055@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010184516.66826055@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 06:45:16PM +0100, Jonathan Cameron wrote:
> On Thu, 10 Oct 2024 14:32:49 +0000
> "Nechita, Ramona" <Ramona.Nechita@analog.com> wrote:

...

> > >> +	/*
> > >> +	 * DMA (thus cache coherency maintenance) requires the
> > >> +	 * transfer buffers to live in their own cache lines.
> > >> +	 */
> > >> +	struct {
> > >> +		u32 chans[8];
> > >> +		s64 timestamp;  
> > >
> > >	aligned_s64 timestamp;
> > >
> > >while it makes no difference in this case, this makes code aligned inside the IIO subsystem.  
> > 
> > I might be missing something but I can't find the aligned_s64 data type, should I define it myself
> > in the driver?
> 
> Recent addition to the iio tree so it is in linux-next but not in mainline yet.
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=e4ca0e59c39442546866f3dd514a3a5956577daf
> It just missed last cycle.
> 
> > >> +	} data __aligned(IIO_DMA_MINALIGN);  
> > >
> > >Note, this is different alignment to the above. And isn't the buffer below should have it instead?
> 
> While I'm here:  No to this one.  The s64 alignment is about
> performance of CPU access + consistency across CPU architectures.
> This one (which happens to always be 8 or more) is about DMA safety.

Right, but shouldn't...

> > >> +	u32			spidata_tx[8];

> > >> +	u8			reg_rx_buf[3];
> > >> +	u8			reg_tx_buf[3];

...one of these also be cache aligned for DMA?

> > >> +	u8			reset_buf[8];

-- 
With Best Regards,
Andy Shevchenko



