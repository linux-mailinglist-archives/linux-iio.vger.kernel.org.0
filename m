Return-Path: <linux-iio+bounces-25752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2236C25472
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 14:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 948BA4E0734
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245902153D4;
	Fri, 31 Oct 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JddK3u3m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43D1F5437
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917800; cv=none; b=OeSqmQNlGynr1w3nBen0k0hcm/8efQvzLLFrk+LXuEerKsLL1pTcuHTJH8R7S965X7COqx6bswsHqqD3Aae8En2S5UnRNHkwLJ6aThuufOi01sU106iykuGK0rtSnl2HeZDeQr3QFz1DvILDjiE345zaLO+5WVK8et+BPA53kWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917800; c=relaxed/simple;
	bh=MFPnZ+xY9hGIvZmK4Gp/1HY1F4zNctl9FqFr1zMDBAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkRu0uX9b1m4Q81sVhew+iYNa13/p5k6gylF0owoWlqaCpo8fS+Rm3nELO8aJgMzOTx95Fuxu9dOqgD2VZHOpU6x5NhrnMVLWOZbwahqrWPLabxWnv+F11Op1bEnwF3RK+uwuVbvUUNCt4K0IfykLY9mWdpFZW7H+8R+ME+9lZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JddK3u3m; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761917799; x=1793453799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MFPnZ+xY9hGIvZmK4Gp/1HY1F4zNctl9FqFr1zMDBAw=;
  b=JddK3u3mX3HD4coH+nDZqj2uc9fq97I6ux0C8oOzZ9y2jQ43Jb3Y9VDA
   +ZR2i1DUS+x2jGkBZzPRVAVUT/JiqSxPVGwy+uvpi/SsAy+9eJn5FwvMP
   BNlwbOrN/6osbBLqcjFHpbh/erJSHfZ1orGedNzfa87i5qrO+jnlzYwE1
   3zKKma6oaxvYNgJT5GGh16sF33CxFTizqr1Juo6rQBJPqg8eK5bA9DfBF
   +oWreqnpLjkxFRnIaoMvYYqy4IZmuYu6P8Qy/RK/yYDQ3tmk6YIpRgfvQ
   /MX83g8V7A1X+tlMe0URM9fjg5xnG4Jauz/xTRG/XvRKUTTVd1KxdTbJn
   w==;
X-CSE-ConnectionGUID: InpywsZTT76FS8vvSXXsZg==
X-CSE-MsgGUID: ar3BonQkRzaf9+jSQQF0qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="66691387"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="66691387"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:36:39 -0700
X-CSE-ConnectionGUID: HgzjcuqgRTm3OQo3dQVfZg==
X-CSE-MsgGUID: TdTGSdjHRy+4VsUCdE3lBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190321225"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:36:37 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEpIv-00000004HPn-0CdB;
	Fri, 31 Oct 2025 15:36:33 +0200
Date: Fri, 31 Oct 2025 15:36:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 02/10] iio: dac: ad5446: Use DMA safe buffer for
 transfers
Message-ID: <aQS7YIxYH2suDmoS@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-2-d3541036c0e6@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031-dev-add-ad5542-v3-2-d3541036c0e6@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 12:31:23PM +0000, Nuno Sá via B4 Relay wrote:
> 
> Make sure to use DMA safe buffer. While for i2c we could be fine without
> them, we need it for spi anyways.
> 
> As we now have DMA safe buffers, use i2c_master_send_dmasafe().

...

> +	union {
> +		__be16 d16;
> +		u8 d24[3];

Why not __be32 d24; ? Yes, it will require explicit size to be provided, but at
least it will look consistent with the above. OR u8 d16[2]; ? But then it becomes
simply a u8 buf[3] __aligned...;

> +	} __aligned(IIO_DMA_MINALIGN);
>  };

...

>  static int ad5660_write(struct ad5446_state *st, unsigned val)
>  {
>  	struct spi_device *spi = to_spi_device(st->dev);
> -	uint8_t data[3];
>  
> -	put_unaligned_be24(val, &data[0]);
> +	put_unaligned_be24(val, &st->d24[0]);
>  
> -	return spi_write(spi, data, sizeof(data));
> +	return spi_write(spi, st->d24, sizeof(st->d24));
>  }

...

>  static int ad5622_write(struct ad5446_state *st, unsigned val)
>  {
>  	struct i2c_client *client = to_i2c_client(st->dev);
> -	__be16 data = cpu_to_be16(val);
> +	st->d16 = cpu_to_be16(val);

Not really, we don't mix code with definitions (with only few exceptions,
mostly related to cleanup.h).

>  	int ret;
>  
> -	ret = i2c_master_send(client, (char *)&data, sizeof(data));
> +	ret = i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->d16));

This will add a quite an overhead to the transfer (not that I²C is super fast,
but rather the processor is going to do _a lot_ of additional work here instead
of doing something more useful.

>  	if (ret < 0)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko



