Return-Path: <linux-iio+bounces-9079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9F96A1FD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 17:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56921F265DD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575BB18BB9F;
	Tue,  3 Sep 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+N5rgEL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306D18A94E;
	Tue,  3 Sep 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376620; cv=none; b=qpZvB+GeU7TEY7IKf5fylIVSII1lXYsA5cle4h0lptsSVUTMZmBOyrzopbMRaQubYOD+5hNYKVEJbuhKgVOYqO4IrJ5CuMjUCiEEAY0Rn/OPDFVRvMdtcelSb0eD0xJQeS5CJzM9gHcKb2KAEyh/KNC94J0np9eTblXZTV+B9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376620; c=relaxed/simple;
	bh=a2aJG7kNfc3M9GmIcbjyTQ4daTisOt3vcWyid0C0BYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agsNn6BSySRmr7TOdafM3OkPZlT61wc3w36hoSJg0Sa5Zvei6lKFKyoTnxgV1lJ5rrImO3u+ZJb6HH1WBU0RQwDADqaNBVcVEwooczqMBAsgONSBgFBe/PDYSw7082mI7HgcYpQypIBR0ytp5HG/JE2YcgZkcfGLYPyUXtDZzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+N5rgEL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725376619; x=1756912619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2aJG7kNfc3M9GmIcbjyTQ4daTisOt3vcWyid0C0BYI=;
  b=j+N5rgEL6grLWLEzCuZrxvPYJ1TklmffWCOJ6p9LFknOAlB33+Im7Z0H
   rUSGOpo7Y6VLOdHE0pHIsz11uxcu6VOoojVRmGWDesnscqdxqabb5gba2
   ZZzR+er4uXWomWsjyNdFSGiy8YImGA7A+1N3qJ7iQ2phn3ICfKtS9FYc+
   uEYFYV32g/gPU4/ePCrpcWMOpPQQrF9YryYrVc8JVJJ0La0aJDrLebe9K
   yv8HLH+mjunrWKRWqmHb1s1km6c7ZKvYyWJR04FLscWd2n8CHociYuqVl
   ihevNs8BK+YqUl3bC3CC8IQ7Wz7yZQ2sGwRBoHvj9bGUWuqtr2CZ0n9yl
   g==;
X-CSE-ConnectionGUID: XVnNrEJHRhGUEq6Nvsw1sQ==
X-CSE-MsgGUID: rzW5ieS+T6+viQDpqE8f9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34592070"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="34592070"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:16:58 -0700
X-CSE-ConnectionGUID: U2cA0KwhRxCQYYrzjUpXwQ==
X-CSE-MsgGUID: SxWbA5kQTuaOBa46KsPm/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64617527"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:16:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slVGy-00000004kYV-35dJ;
	Tue, 03 Sep 2024 18:16:48 +0300
Date: Tue, 3 Sep 2024 18:16:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <ZtcoYNAir5fJdeai@smile.fi.intel.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
 <20240724155517.12470-5-ramona.nechita@analog.com>
 <20240727164113.02a95b79@jic23-huawei>
 <SN6PR03MB432025ED9C0CB4CDD1CE243FF3932@SN6PR03MB4320.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR03MB432025ED9C0CB4CDD1CE243FF3932@SN6PR03MB4320.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 02:26:41PM +0000, Nechita, Ramona wrote:
> From: Jonathan Cameron <jic23@kernel.org> 
> Sent: Saturday, July 27, 2024 6:41 PM
> To: Nechita, Ramona <Ramona.Nechita@analog.com>

...

> >> +	for_each_set_bit(bit, indio_dev->active_scan_mask, AD7779_NUM_CHANNELS - 1)
> >> +		tmp[k++] = st->spidata_rx[bit];
> >
> >Update this to use Nuno's new macros for iterating over the scan mask.
> 
> Does this refer to iio_for_each_active_channel ? I checked and noticed that
> the patch containing this macro is not upstream yet, should I wait for it to
> be merged before sending out a new patch?

It's in the maintainer's tree, which your patch should be based on.
So I don't see any issues here. Do you?

-- 
With Best Regards,
Andy Shevchenko



