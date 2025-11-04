Return-Path: <linux-iio+bounces-25891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5AEC32490
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 18:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78F818C4897
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44FF337BB5;
	Tue,  4 Nov 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="be5sMVm5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6E2E8B9B;
	Tue,  4 Nov 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276249; cv=none; b=QiQWj+yNs3Gp2w73D4Na6Qm6apKLTbHP/osef+dMfBB5LXdFpL5GqhbcLliINmCE3EQCPawZgDWI4DYtiPZov4eqvM1msBga9iQFqVMulUSxuy+5v7n3N0vejX6oTBYs/f7KTQlVugyLWl7nzyMEDuBRFy5v+Z5FKQBFduDLy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276249; c=relaxed/simple;
	bh=Ih/4kOeLwIWUHbtaQb0t9ZD0GHP7xl8w3u2PEv/ZXP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az55EDUZ6HbuKxmat9mLhv26px0Tv39qwWMXgr91l37FknyTSJqneVPYoZAym24FfiGG7NZwIeqaqNCGswAOssN1ouoYN3OE9DuduTb9WiJ913dY9QdvL5cSis8wLDxzLl5V8fVLz+3TtW/rdacqrs8ugEE4rghD1Jr5J84IZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=be5sMVm5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762276248; x=1793812248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ih/4kOeLwIWUHbtaQb0t9ZD0GHP7xl8w3u2PEv/ZXP0=;
  b=be5sMVm5wd6hia2Vm4N0rCGXESu9aI2Rrz1fdOueoI+E2RsWJFwMSDfe
   zwQFXGmAgD+DXS+8lbIa9l8zphUQSTV3dAinZwkt83y4JMcEUAi95NtsA
   xLcpzFv19hVSzg1Yo6AAscwSy69ihb5NucQJ66afWBy45ROFBdVMlxcEV
   8gCvL0/xpTStMAjmO+bzczMinpCagwll9RMLE7VyIwslcZxoLM4XVL1/4
   XcdglNNkLE/552ceRS+8kDqDvzkZ7uFpYRnKUmih/e4TIJ5b625KV2QJe
   7Jl2hGaw6QHzR6SonBp3Oas0v1MkwkaXRF23+hP49fw/pQnMQ9CU0GGPx
   w==;
X-CSE-ConnectionGUID: WVFS6je9R7iz8xtwV1gPTQ==
X-CSE-MsgGUID: 7fKbHIPGQj2r0NFlZqt79w==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81784376"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="81784376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:10:48 -0800
X-CSE-ConnectionGUID: BcrK5iu2T+OgtiSQLCsAVw==
X-CSE-MsgGUID: e/Iw6LthSb6Ej5sfiQTPtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191565607"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:10:44 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGKYM-00000005WTG-0qdp;
	Tue, 04 Nov 2025 19:10:42 +0200
Date: Tue, 4 Nov 2025 19:10:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 02/12] iio: dac: ad5446: Use DMA safe buffer for
 transfers
Message-ID: <aQozkdWtQxv15Umd@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-2-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-dev-add-ad5542-v4-2-6fe35458bf8c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:35:07PM +0000, Nuno Sá via B4 Relay wrote:
> 
> Make sure to use DMA safe buffer. While for i2c we could be fine without
> them, we need it for spi anyways.
> 
> As we now have DMA safe buffers, use i2c_master_send_dmasafe().

...

> -	put_unaligned_be24(val, &data[0]);
> +	put_unaligned_be24(val, &st->d24[0]);

Now this &...[0] are redundant as you defined (by name) that the variable is to
be used as 24-bit one, i.o.w. as a whole.

	put_unaligned_be24(val, st->d24);

-- 
With Best Regards,
Andy Shevchenko



