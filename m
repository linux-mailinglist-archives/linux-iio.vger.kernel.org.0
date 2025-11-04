Return-Path: <linux-iio+bounces-25892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC310C324A8
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 18:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D181618C5E14
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93467338F54;
	Tue,  4 Nov 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia92zLjl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053526CE17;
	Tue,  4 Nov 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276359; cv=none; b=ecu7Ru4uWEpIaroIFgYV728x7c/whCerZarvBjSCgp4HEYyTZ/PDkhcBUBCoE3VDgZdiWn1smA/o5AWaanBBU7mCMaRJldKLPFT39hRsRAsM1pW+u6X13+IM2Ay5mSNvazAUufsVXAyw6EkfEsR/lEnrnF5n/W1k2UiD1tEJ3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276359; c=relaxed/simple;
	bh=Ckrti+RCAeXUKxiYq8ayvPhDwSUuAEroGnz/I3Go4RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBynKHt4VPA+ZFoqf7hKFnA24/lMR7lLeALIsg977c5TF2Af9aIU61Vh+16DiGNPLiiakKvI5m4qkN6ybzAUTvLE03yTotNYI+TmRRYbSminfsUredLvmEtGKLgqEKHOrNrYjUDDmRI2zyx2zwKj5rbqdhadq+OLcCaQsvRW/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia92zLjl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762276356; x=1793812356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ckrti+RCAeXUKxiYq8ayvPhDwSUuAEroGnz/I3Go4RM=;
  b=Ia92zLjld0f3FkCtnanN3GeZwsay5wHC3/lIywuicLQwrzOfsm9G9Dxt
   rwH72JhuTLxeWH+vvGfLdDYAluPu+KTLZIMCnBWlq0HBZ3JYaAIdEqaV2
   h1rhQk7tchlO7Wb0a8vPOrwzhQU63HvFoF8NLOqhJLdSKKGC7Pe56oS58
   fAMSmmnnddZHwdAsApQgNzhzWTkxgWA6PjqD8uwgzvYPUccwZG3gVTyMS
   QpJUHYlJJTaC0/LG5rE/ixH30cDxV8+n7mipN7hFj+X9aKdLsSIdwO1j+
   rEOE4a6bo0VjC3JTRtp4ojQ/5s+A3TpstXZ0UNJqE9CHRgbEaD1o77fvG
   A==;
X-CSE-ConnectionGUID: IhD/Qp5FTXCkeVWyhpfcMw==
X-CSE-MsgGUID: q/KrOAl1T9yD56qQTfbbBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64304275"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64304275"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:12:36 -0800
X-CSE-ConnectionGUID: nAZqOBSYRZiRU2Ip+4LmEg==
X-CSE-MsgGUID: leyWjSHYRTacEPePbFiEtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191513692"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:12:35 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGKa8-00000005WVj-1QWp;
	Tue, 04 Nov 2025 19:12:32 +0200
Date: Tue, 4 Nov 2025 19:12:32 +0200
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
Subject: Re: [PATCH v4 03/12] iio: dac: ad5446: Drop duplicated spi_id entry
Message-ID: <aQo0AKjQUNN9FCDR@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-3-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-dev-add-ad5542-v4-3-6fe35458bf8c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:35:08PM +0000, Nuno Sá via B4 Relay wrote:
> 
> AD5600 and AD5541A are compatible so there's no need to have a dedicated
> entry for ID_AD5600.

Suggested-by?
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



