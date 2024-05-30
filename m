Return-Path: <linux-iio+bounces-5504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD668D4EAE
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1EA1C23304
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C717D8B3;
	Thu, 30 May 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUFj/aXl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D2186E38;
	Thu, 30 May 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081681; cv=none; b=KFQkXqGsCbh8RrOE1/6Tw/ckaASpRdkh+TC9Ot3oGitXvRrnn0Qgr3VmPlXUc7bJi5ZaDwR77bANDjBZXIqiA92V7Rhij7wMutSbYS7Q/73IrN/tHjyNKsGI7SlItysCpP9Lbp7wA3DBeJ3T0oaAC7nbjVdBChT0TjRHS5LF7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081681; c=relaxed/simple;
	bh=F2R6frOCJSZILqA+UDPyyU2RUYimdoTk7Ck5TLUgeXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QShp+5Yogk8KN32oDKuBCODOfkvkEDkKqjUdS/Tc5goRONAEty/3aQAOiqBjjJFNdzVE1hUiZ1n2U+D1SZezJtOZZECrGiEsLY0rNBJDSQnxYj95snDZHSZYTKACNwPyZzOAnYKhpq2wIJ5NvzrUej/BCq08snz3cQPeDFVo3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUFj/aXl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081680; x=1748617680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2R6frOCJSZILqA+UDPyyU2RUYimdoTk7Ck5TLUgeXo=;
  b=LUFj/aXl8eeBOIbWCUgeIal5KsrAGq9lU/l3g4B0MOAlvtyepZ39YMQv
   tlp/sFzuIRiXNcROfNxISg3o+gtMjQS7n8pyaB+vNrTkDDmgf4G65oaEY
   EOBsDetwHou+XSvEVQuGTgp1IQCsQOkxC01M+rGlpDBKw/nJUUfWKR8qV
   qD18KZh87NF+iSXp9501wonj7WupkNVAsWwD/8am31k9RwQYwRA7aYxF8
   HQ+hofPSaKR4V6vW2H6ykAcniWK5dcLmffZjVc65mjkHWDApZCTPtvkwV
   BWmuOVew/Se8GDa/Pa1fV4bcuIxAsdFZ8sVeMK4VRiuVQvAmbZv8wvomP
   w==;
X-CSE-ConnectionGUID: C2LZAiBbT2qVrHevMJA3jg==
X-CSE-MsgGUID: Eo55Fvh+QTmuE5wWfvxseA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13335879"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="13335879"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:07:59 -0700
X-CSE-ConnectionGUID: qWLMDDRuTKqwBRQMoSEYeg==
X-CSE-MsgGUID: j+6wilG8S8SizQ4oGFoSjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="40387828"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:07:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sChNh-0000000C70v-0182;
	Thu, 30 May 2024 18:07:53 +0300
Date: Thu, 30 May 2024 18:07:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: adc: add support for ad777x family
Message-ID: <ZliWSBihPdkkYoTg@smile.fi.intel.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
 <Zk3-qxCb0zfR440Q@smile.fi.intel.com>
 <SN6PR03MB432071701D6A19C3B4C0C33FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
 <ZldFpSQPAmAhbW2I@smile.fi.intel.com>
 <SN6PR03MB432024DCE5978841F016A71FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR03MB432024DCE5978841F016A71FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 29, 2024 at 03:45:58PM +0000, Nechita, Ramona wrote:
> >On Wed, May 29, 2024 at 03:01:06PM +0000, Nechita, Ramona wrote:

...

> >> >> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_LSB, lsb);
> >> >> +	if (ret)
> >> >> +		return ret;
> >> >> +	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_MSB, msb);
> >> >> +	if (ret)
> >> >> +		return ret;
> >> >
> >> >Can you use 16-bit writes?
> >> >Same Q to all similar LSB/MSB write groups.
> >> 
> >> I cannot do 16-bit writes due to how the spi functions on the chip and 
> >> because the registers for MSB/LSB are at different addresses.
> >
> >They are supposed to be on the different addresses.
> >You mean the distance between them > than stride?
> 
> I may be misunderstanding this, but the spi read/write expects
> HeaderBit+Addr+/-Data+CRC. Writing two consecutive registers would mean
> creating a buffer with this format for each address and sending all of them
> at once, correct? I feel like that would overcomplicate the code a bit, but I
> can do it if it seems appropriate.

You can add a new ad777x_spi_bulk_write() where you perform needed magic.

-- 
With Best Regards,
Andy Shevchenko



