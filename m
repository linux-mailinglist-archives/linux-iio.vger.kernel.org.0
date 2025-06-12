Return-Path: <linux-iio+bounces-20549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55578AD70F1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F9D178639
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E9239E99;
	Thu, 12 Jun 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExZ4gQZY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24944222574;
	Thu, 12 Jun 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733133; cv=none; b=pDh2o4J106XMEoGlNNFhCYUUohzIXB7PyBR8FlEpg/ev1OC4dAXMk54Tr4lMo/nJNRnhrqcOvFRpn4NcIHd+e8Quqr4u10euouTcfdiimoQDcpPNo/AYqVnXZlDUo/CqgdpIdt1oHtXyio08y7iIFmv8bXJeqp3agJm6pyEAhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733133; c=relaxed/simple;
	bh=tvOzRak3NxCCxuZb5njChHp5ISdPJBKppqhdKhqj1VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAa/0KkyuyOlOaV2BcLk4FYTo4FaefPJaYHOd9RQlJtJRMvu1LTmy5nxjv2mdd1Ik8A0nz7nDDZb8aANN06WcU1zXBdUDimexl8maS9/ut/J9tTA+KqCs51KNpW7jLdJEZTQUl8NZahlkodogSgRjskp1yS/oMdB4ygnD2JMIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExZ4gQZY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749733132; x=1781269132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tvOzRak3NxCCxuZb5njChHp5ISdPJBKppqhdKhqj1VU=;
  b=ExZ4gQZY8P4ML6oyhN/qBnY+6iY0pzNlH7fJNz+EkMCvpRx8c5A/vMaz
   YWYiTNy3iZzx94eaVSCriMgqJ2hXZyUpelYGXhttQjWPwk3Qr7B7OMJsj
   UMwrQuOTuBhQCmI1E3TijFEx75xSw+NzZEAEFF5XKrQHPC2rdaCMolAsv
   gtbQsM2D0z23z8KPLKg+7j6nybG2T4iNDsuHDahMdK1tMv6SyjE4Wj0zS
   TBRKZX0OifofqZDHpDenVadfMTlbgj68Qc8K0S+kzG7YpBO4bPgXDyxR5
   lvE9xLvBNxAdI0huPHGZN3gvOotCO7elTA0SMuNWPJjN2x802w6mCV/bg
   Q==;
X-CSE-ConnectionGUID: yO2kZRx+Q9i56P9TPa8ppw==
X-CSE-MsgGUID: +DhAPsT0QNGRY6EofgOlVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="39520803"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="39520803"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:58:51 -0700
X-CSE-ConnectionGUID: 7OK3mPA2Qp+MTbkNTSUUfg==
X-CSE-MsgGUID: tChaeAagQs+87ZSieaSjHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="148065020"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:58:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPhW1-00000005xEZ-1QiU;
	Thu, 12 Jun 2025 15:58:45 +0300
Date: Thu, 12 Jun 2025 15:58:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: surajsonawane0215@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: Add IIO_DENSITY channel type
Message-ID: <aErPBUnBWsCewA1i@smile.fi.intel.com>
References: <20250612100758.13241-1-surajsonawane0215@gmail.com>
 <20250612100758.13241-2-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612100758.13241-2-surajsonawane0215@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 03:37:44PM +0530, surajsonawane0215@gmail.com wrote:
> From: Suraj Sonawane <surajsonawane0215@gmail.com>
> 
> Add IIO_DENSITY channel type for particulate matter sensors,
> with base units of grams per cubic meter (g/m³). This is needed
> for optical dust sensors like the Sharp GP2Y1010AU0F that measure
> airborne particle concentration rather than raw voltage.

...

> +What:		/sys/bus/iio/devices/iio:deviceX/in_density_raw
> +KernelVersion:	6.15

If it was missed in the past, add Fixes tag, otherwise this boat already
sailed, the v6.17 is the nearest one.

> +Contact:	linux-iio@vger.kernel.org

-- 
With Best Regards,
Andy Shevchenko



