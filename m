Return-Path: <linux-iio+bounces-25852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C704C2C9CD
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2125E4F3744
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712863321BF;
	Mon,  3 Nov 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4BzEEfE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AF3321A8;
	Mon,  3 Nov 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181497; cv=none; b=jN+uXezoqKFj0emLdBI4cs4983HfK7euacD/AvQ4InTIU8sQ8Oyyxm3SfS16PBxBgR6/ROQkm8y9rc9fMUw2xa1rKajvWedp/rzKgBNzkYB5NfHSEZPv1IdszgFx95bMsWC70gHgT5orc57N/10H5TJNDqJFyDVjilxE11vM/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181497; c=relaxed/simple;
	bh=G2KqnsuQ5Zzarl98yuoYLfJaqg+1gXkeK1KX3acp8Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNqGaecyuWec8wYIVvQbIlBXhDFgGu/z2lvjXgNH80gK0Phj2eWuVJ2jEKhToyGW3LDMO9eLQN2IqFP3B8W47hTTlNm5ZIue0jsa2IREGK6MLltWuA78pjLtcabQxBoWRa0LSEvKOwPw4Ng7u9rZJ+2p6CZxr6eRph7y7eEvhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4BzEEfE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762181495; x=1793717495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2KqnsuQ5Zzarl98yuoYLfJaqg+1gXkeK1KX3acp8Fk=;
  b=Q4BzEEfE9h3aaycBHaR0R49d3D8dHCVcUIZlrumblk6ib8dNaNhaReio
   tfDjRA0QvYBiPZ05AuEzJ1rrZ52uj39hGtAhdzw+XtwwFVkIoqvy4gK8D
   KGwNo8G3XRKQFOk6r1Fl+T/7rz0Wz5Qv10Bz96hYRks1v4yb5wJmkMjPc
   DHuIFsV6quza0Oh/FmJWsXdEApINmPAjpuFove0Au8nYbfoy/qjn38ijl
   s4yuYhOV0wXluB0F+ndKShLsN2khx0ZNEO1pIJ6b1Q+QaG/qWHM5dm3Pd
   PpdzJzsbhYM4ozjelj+Q78SS8JFsKgfTHx6jD68JMeCytX4iBImMNVJlZ
   A==;
X-CSE-ConnectionGUID: apaPngRJR1GI2Qlj4hzL+A==
X-CSE-MsgGUID: UyoBvm7TSruLKab26y9ruA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81666331"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="81666331"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:51:35 -0800
X-CSE-ConnectionGUID: UHG/pcslROie+eo1QdVyhA==
X-CSE-MsgGUID: sNHlAtf+QX6OTevRICShpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="187607026"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:51:31 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFvu1-00000005B8f-1G3Y;
	Mon, 03 Nov 2025 16:51:25 +0200
Date: Mon, 3 Nov 2025 16:51:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aQjBbBuZkARkGGan@smile.fi.intel.com>
References: <20251103141834.71677-1-herve.codina@bootlin.com>
 <20251103141834.71677-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103141834.71677-3-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 03:18:32PM +0100, Herve Codina (Schneider Electric) wrote:
> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ADC cores (ADC1
> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



