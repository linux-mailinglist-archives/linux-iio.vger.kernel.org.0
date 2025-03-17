Return-Path: <linux-iio+bounces-16985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2D1A6578F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5D93A966B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41518C03F;
	Mon, 17 Mar 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bl2FPEv1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014741E52D;
	Mon, 17 Mar 2025 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227511; cv=none; b=AICEsbnWRh8281Ug18rS2rx2j+OT457zp/GmBiEewLpnmC2SRcSjMxzI9NdNewqarphrMPk4hr3uxoNimBJlka72iKNUN5XS9yl/YNkB2DhStE6upPlWLpMmQCAdG4jyxDm11YxBoGqW9GO/rz5clCcmwIw60WBMevpq3BS+OxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227511; c=relaxed/simple;
	bh=A5B/PhJUtLxRi+P6FMPnXSx2/wJ6ZVPzqvrCVBB9aq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLXV1VetiQbGN6gSnoCbY4a7lR2YjHcPIUARS2Az8NUWKrmeGGg12ozB+J1gyqO1XZlK7oCM0ab04s35w6OdWvIUW2YalzijgflPSC8JW+kEOkjaVNUr+NDK56OoR/t5ePepu9OAVF90UWiLhCB+DVCiAWIkNJRO5WIWVP6J0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bl2FPEv1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742227510; x=1773763510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A5B/PhJUtLxRi+P6FMPnXSx2/wJ6ZVPzqvrCVBB9aq0=;
  b=bl2FPEv1YvGZcH4CxaF89HlLgnUkaJvUHJJKWH85q7TyKdYmHOJy6/dY
   V5R/vZwJ/Bs/X0iAYwWTFCAA/qhCeS9duMQY4TmqBBEYxId2KN9p/8sz0
   eSD5dUzZnBfqAprkPtcxLJGsVum4VTfagSBot54PWxY1qqeHgHEi6zAk3
   H1LfgL3NukxX3p35HeAtfAKo5bBNqEtPHyq9Q0ROfw6dJN6M/RLIawZNV
   3KJHoX10+HNGP6ST7ftitT/1q6RiQs4wWebitmcVJWeEZyYXu0Z/DT7D9
   6LG1n3bB+lLS23pbFJJyn+zQ6UKHHTSYIKiptxBbcfuQLrgHcBY1JvcEt
   g==;
X-CSE-ConnectionGUID: QUMTo5zCQnund+AbHYWiEA==
X-CSE-MsgGUID: gL6aZ/O8StuTsXhuEgrtbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43240919"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43240919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:02:48 -0700
X-CSE-ConnectionGUID: DSYoy4p4QZKjzbx9XHcphQ==
X-CSE-MsgGUID: Sc9g6W+HQtmggN+zymuG9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122470611"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:02:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuCvH-00000003Lxf-2miG;
	Mon, 17 Mar 2025 18:02:39 +0200
Date: Mon, 17 Mar 2025 18:02:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <Z9hHnzuvFBd4FRPB@smile.fi.intel.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <69b627227e675d94c27f42783d7cf9ada93f730b.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b627227e675d94c27f42783d7cf9ada93f730b.1742225817.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 05:51:02PM +0200, Matti Vaittinen wrote:
> The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
> help drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg"
> -properties to channel identification numbers, used in the struct
> iio_chan_spec. Furthermore, the helper can optionally check the found
> channel IDs are smaller than given maximum. This is useful for callers
> which later use the IDs for example for indexing a channel data array.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> otherwise. Also, same grep shows all the .dts seem to have channel IDs
> between 0..num of channels.
> 
> Use the new helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



