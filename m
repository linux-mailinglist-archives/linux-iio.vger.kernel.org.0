Return-Path: <linux-iio+bounces-23224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D6DB340FD
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477847B348C
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E3274FF5;
	Mon, 25 Aug 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hauW5Nnr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515313AA2D;
	Mon, 25 Aug 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129337; cv=none; b=k7Zmt7WjuF8XOWi8Us9wYA8NdahNdl+UJ1XAiA7rSfhf2SXyuuz7yAbVWUCFcFB1zykp1NJkhtyvka+h6mlXF/0HMxhEtuFe84g5jiGXYF6Nb3SF0UUrsaJeA7T2XSVm3iTxa1NQoMr39Kc4Kvc9v0CEpLk4i/Jka1PW8xAKMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129337; c=relaxed/simple;
	bh=uVUCN940FDeyxi4N4kgxLfIMJbx7JS2sssBs6B6WEtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2D3wc+1q5Fz+ErmlK68EYLrmFyL47BNCvy6xJ+JNPswkEricG2L6rJC0w/dlJP293GQvCi7CE2lDYcBoW12cE3DjmDyQDtSseyF1PDHV+5OapkrA/TuXRaejXOipxv625jKVZ1fQ4kaCFuzzT4JpxB3l5O29cWLiM57qJsRUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hauW5Nnr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756129336; x=1787665336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uVUCN940FDeyxi4N4kgxLfIMJbx7JS2sssBs6B6WEtg=;
  b=hauW5NnrQ8uhodD/Hp2JPNQ+0NcWrIVl2i9BxEVEODFq7i0w6sQxTaUW
   RisXqragHtaC/5eMwciShZ5B1Cm7Mypgw8CL7+A7f9Nfc8Yke878aY817
   Mw6yivH+7K9zNDLySOBOFeBfhR6jCUg8mE5kZVgiSfZhg1RkhotDOr4Fl
   yP24HBbJlGKzs5qpjqLQq+YX0VJu76tKGOWbJN2uugG/qI9LDQY/NxSSl
   yvA9QZMSxF+q32qDjV8BS1J1+Cb2Z7S5CVEnY2Y7wHb2yaBoicnJcVXaE
   YwMVICqdO5L0WCOzU1HCVjoMS4If9xIf1HsUtoZDhuumqyOuqC1DBPAsz
   Q==;
X-CSE-ConnectionGUID: BwaRWRX3SQ2trUqNPEM5uw==
X-CSE-MsgGUID: ASXGBWK8TD+Tms5nLOP+Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68933112"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="68933112"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:42:15 -0700
X-CSE-ConnectionGUID: Sp+nYHJjRJG2H0gT4buH0g==
X-CSE-MsgGUID: eaDLz+waRUOXh8ieqSkS3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="206458136"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:42:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uqXSa-00000008WOu-3RXw;
	Mon, 25 Aug 2025 16:42:08 +0300
Date: Mon, 25 Aug 2025 16:42:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Message-ID: <aKxoMKf7bpbEFCy8@smile.fi.intel.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
 <20250825105121.19848-2-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825105121.19848-2-Ioana.Risteiu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 25, 2025 at 01:51:16PM +0300, Ioana Risteiu wrote:
> Assign num_lanes_set in the adi_axi_adc_ops to axi_adc_num_lanes_set()
> to support setting number of lanes used by AXI ADC. This operation is
> included in the generic structure because the number of lanes is a
> configurable parameter of the generic AXI ADC IP core, not specific to
> a device.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

(Hmm... weren't there tags in previous version(s) for this patch?)

-- 
With Best Regards,
Andy Shevchenko



