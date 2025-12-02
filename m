Return-Path: <linux-iio+bounces-26633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4A6C9BD8C
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460363A6C20
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7081F1534;
	Tue,  2 Dec 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbKAiqGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC12AE70;
	Tue,  2 Dec 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686917; cv=none; b=Uj3s4LodMczHaQVFFOrqyMZQfcdaCdYvipW+FXuwI484e5IwluPKjeWKSlDI5koDC9giXcDEh3IE+7az7mqobZKn7l+4hn9F9o+oavq6C8xPFOpVy4swu8Fe8yVSm/3A5XbCQRW/9tUmyV8jCVRaJz8VBID7NWxV/ZaRX6ESrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686917; c=relaxed/simple;
	bh=WUZxo2Se3vRA0b/qJo/SNY+nUnfU5nNrdHEmjaQYlmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfLDOnORhXuLsFhU/cPuTOPRWi3tUfZiivZxT3oQxOXoa1+REbv3bdR5e8bPIprCSXchR1kSIMULTeE57aQKNR6d21PS731vXGyadTIH91cM+ldm4/lEevtQBNIibbA1YKQFe0sChzdI3c3rFnp1NoK7bslXwDPH9kNNKbboQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbKAiqGt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764686916; x=1796222916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WUZxo2Se3vRA0b/qJo/SNY+nUnfU5nNrdHEmjaQYlmk=;
  b=FbKAiqGtiMmzFJrXHoqTrTx32BBF+liqNmyiE0T3sGLKJ3C2E8N7ZqbE
   xV0iqhO14fLolNObjEJK3XbWNIYm5qe1DoE2HXk6anRG14lyjnpNL18t3
   9hDald4kPejnTP5AJwLV0HPkNod/d7e6Y5AAld+akt6hH5TRMunsDmhJ4
   ExAMf/V/zRdYGP7BNyK8mV8Khdh5hTE1wEE3AEe0b8NEQL0w0+Fxnh97p
   d+3BOcZvqd3/3fB9Hdq7xxz6F2dpij73FWI5TZQeOyhjpGIUASyXZTc+O
   WLGNPJx6gpRn6PH/8Fdi/qYPcDKFXhk6y7XZrqWoMq2SDH4SbYfqk87om
   g==;
X-CSE-ConnectionGUID: knifRdwQRQyr4W+IRX9DsQ==
X-CSE-MsgGUID: Pla4JnrXQqS/P9/qV8EUXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66610633"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="66610633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:48:35 -0800
X-CSE-ConnectionGUID: Zy6wXhejSACOoO0Gk5mviA==
X-CSE-MsgGUID: ml6C7QoYSzuETohjXSNP7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194487559"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:48:32 -0800
Date: Tue, 2 Dec 2025 16:48:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/7] spi: add multi_lane_mode field to struct
 spi_transfer
Message-ID: <aS78PF1FiDPWxrLz@smile.fi.intel.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-3-34e05791de83@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-3-34e05791de83@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 08:20:41PM -0600, David Lechner wrote:
> Add a new multi_lane_mode field to struct spi_transfer to allow
> peripherals that support multiple SPI lanes to be used with a single
> SPI controller.
> 
> This requires both the peripheral and the controller to have multiple
> serializers connected to separate data lanes. It could also be used with
> a single controller and multiple peripherals that are functioning as a
> single logical device (similar to parallel memories).
> 
> The possible values for this field have the following semantics:

I believe it's too much for a commit message and will be hidden deeply
for the (potential) user. Can we rather create or update the respective
documentation file?

>   * @rx_nbits: number of bits used for reading. If 0 the default
>   *      (SPI_NBITS_SINGLE) is used.
> + * @multi_lane_mode: How to serialize data on multiple lanes. One of the
> + *      SPI_MULTI_LANE_MODE_* values.
>   * @len: size of rx and tx buffers (in bytes)
>   * @speed_hz: Select a speed other than the device default for this
>   *      transfer. If 0 the default (from @spi_device) is used.
> @@ -1112,6 +1114,10 @@ struct spi_transfer {
>  	unsigned	cs_change:1;
>  	unsigned	tx_nbits:4;
>  	unsigned	rx_nbits:4;
> +	unsigned	multi_lane_mode: 2;
> +#define SPI_MULTI_LANE_MODE_SINGLE	0 /* only use single lane */
> +#define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
> +#define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
>  	unsigned	timestamped:1;
>  	bool		dtr_mode;
>  #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */

Seems to me that this also fell apart, as this define sounds like a part of
*x_bits above and your patch makes it even diverse further. Can we keep grouped
members to be in a group?

-- 
With Best Regards,
Andy Shevchenko



