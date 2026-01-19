Return-Path: <linux-iio+bounces-27999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB95D3B610
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C767B300A3F2
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ACA38E5C1;
	Mon, 19 Jan 2026 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mixLJPBF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4232B9AE;
	Mon, 19 Jan 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848279; cv=none; b=HAyr0o0H9YvUa533Nsn+UHbIjwL1WyQWBYRY3BOkJojkC3sdyqiXSo6NS5Bf0U5ZWnn2X+D2PelOBkMlvXKaG3vy3kNB3uf3Nhm3mRLHoXWa+0MIs0cUjHull/zym0iYFs8VwlEn0lYqpRxJDxAHGIxS4PiMchO+tTzuGRwPlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848279; c=relaxed/simple;
	bh=Y1j8XMouMqN4N5IRw1WeSKPHm6WunhmsOE18oYmrnvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIdk8TSqrWDW2BwHa/vNg0x41bGLAVEd1L+Pcpi2vdJsuxqYGzGrUuaolIVs6BJCeYvuWbHYAxsNScVlv/zYe+gVTh7Au1X5+E3mvgPugvDft8olTPG44olyIohDA8IDKWJCMls3u2a8AOBXEaOatR+MQh9/lw3Pd62hfO0/4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mixLJPBF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768848277; x=1800384277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y1j8XMouMqN4N5IRw1WeSKPHm6WunhmsOE18oYmrnvI=;
  b=mixLJPBFvkntBiG+uj4lS/vjkoVy4LXXRx9ap+Svc4AFs4DPGSgTOgiD
   Q7fNMPXPHCLDMUqgtwiIvfDL8/3zkBHSoQRigwpoHu1KvfUNCo3UH5AkK
   Nh386gCLSMzycHS+9aqYHrBO9gAgpWgkMuTDJkLWpq78blvuYKIWyOpAY
   pFXxiNicFflyas/mJdoO42oTpljdybbZyEQt9522xEMU7xXAuxe1sfYLX
   X2uA1l2J6569oBfN0leAd0BVyCpHLxOZkB8FTvgNtwLIrUP/N8wSsThXy
   QtK87O4XeAPGgHsBYSBE2P6mmddJ1XOgC8vS4JMGe6hTm8qbdRAp9N2yv
   Q==;
X-CSE-ConnectionGUID: Tr7Ix2VOQzmEB3NHlbc7xQ==
X-CSE-MsgGUID: l2PSuPP5T665GyEBY3g1wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="87478302"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="87478302"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:44:37 -0800
X-CSE-ConnectionGUID: 6mjhy8T0QCGvklC1i8Rebg==
X-CSE-MsgGUID: qrbKQFVzS2ym8frLmarsvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="206281320"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:44:33 -0800
Date: Mon, 19 Jan 2026 20:44:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: petr.hodina@protonmail.com
Cc: Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: proximity: vl53l0x-i2c: Use raw I2C access and
 read full device ID
Message-ID: <aW57j-zfhKGp1VTm@smile.fi.intel.com>
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
 <20260119-vl53l0x-v1-4-cf71715a1353@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-vl53l0x-v1-4-cf71715a1353@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 06:19:58PM +0100, Petr Hodina via B4 Relay wrote:

> Replace SMBus byte reads with raw I2C transfers when reading the device
> identification registers.
> 
> The VL53L0X exposes its model and revision as 16-bit registers, which are
> more accurately accessed using standard I2C send/receive operations.
> This also avoids depending on SMBus byte data support, which is not
> guaranteed on all I2C adapters.
> 
> Read and log both model and revision IDs, and validate the model ID
> during probe to ensure the expected device is present.

...

>  };
>  
> +

Stray blank line addition.

> +static int vl53l0x_read_word(struct i2c_client *client, u8 reg, u16 *val)
> +{
> +	int ret;
> +	u8 buf[2];

Here and everywhere else, please, keep the reversed xmas tree ordering.

> +	ret = i2c_master_send(client, &reg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	ret = i2c_master_recv(client, buf, 2);

sizeof(buf)

> +	if (ret < 0)
> +		return ret;
> +	if (ret != 2)

Ditto.

> +		return -EIO;
> +
> +	*val = (buf[0] << 8) | buf[1];

Actually define

	__be16 buf;

and use

	*val = be16_to_cpu(buf);

> +	return 0;
> +}

...

>  static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> +	u16 model, rev;
>  

Use reversed xmas tree ordering.

-- 
With Best Regards,
Andy Shevchenko



