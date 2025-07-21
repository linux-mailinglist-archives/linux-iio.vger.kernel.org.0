Return-Path: <linux-iio+bounces-21794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D6B0BE18
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425B61891856
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B7283145;
	Mon, 21 Jul 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMss2JQT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255F222590;
	Mon, 21 Jul 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084334; cv=none; b=OaeVjoNrJgX+CP3D0usZ8ev8fHIJTB8Q0o4Nue20FNRZl9jzcyAp3Hz5QtF7rTlDWRicclsyiB7CDXc8hGyjcm54Z9Lr3yxLNse+BoyXZ0PCIKe+Q9ND7iZZDt75tMG0e6JH1mEBJ/QNOQ7pqqTyijB1LV5ezNY/D7GJH0rseGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084334; c=relaxed/simple;
	bh=S81qr9hFOduDkWryR/8Zook9qEaCBaFDKK8h/sGo2HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMBj8axarmBFXiBkzR5wPg1NZ+NE5JoyYtF2WWgH7ajcImhAohXEKfvn2A6e+/bMgr9ADoNcw0z2ldUruYHJBx8ntIhTzbvvuNiAK29tgpqXHSuDPh2EUzYt1Of0NnCNV8bCMEBmPoEjoW6iIqdM1VoCg1F2iYKQ8V+UHrA8TX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMss2JQT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753084333; x=1784620333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S81qr9hFOduDkWryR/8Zook9qEaCBaFDKK8h/sGo2HY=;
  b=VMss2JQTMY5hbXmJlSbFyXVdGLQnBmvOjFzQgzlmnn5D72TrB92WQfc3
   crZzT8b8HvqbpZs+X2P5pAKJ/2w0p21cXaala9BRdC/7/Qqu6K6ZS5vAo
   REDevpLgS4KWtFe6kCMbgvFoM/p2dio3TNEK4PYlVRFuYlpWlGQa8fC6h
   japYvjh9hT81M3zBX5/PQm4tKWz6maiS+Y0RHZGLYTbqQbGIU+9DN6jwq
   9kQA3y5nVE13qPYHfpCgMtv8V701uUAfCfQ1aYq+PffuVEYoo90gvq1qD
   cZv2oz2l+sK8Wgzp0h1t3eTZTWrDS9xwVG44l+6s1Gp37JxVr2Rchxhf5
   w==;
X-CSE-ConnectionGUID: 1p3K8cpmSvGxJB/HMUmDfw==
X-CSE-MsgGUID: ImGINN3LSHOOkCrk8WqzUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55249411"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55249411"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:52:12 -0700
X-CSE-ConnectionGUID: o0q7XRb0RPitcVimaam3ZA==
X-CSE-MsgGUID: khK44DSEQ5igeY5q8Fawhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="182474746"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 00:52:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udlJb-0000000HHid-2Qi4;
	Mon, 21 Jul 2025 10:52:03 +0300
Date: Mon, 21 Jul 2025 10:52:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: ">" <sanjaysuthar661996@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, ribalda@kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	neil.armstrong@linaro.org, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Subject: Re:
Message-ID: <aH3xo8PeReb0s-QD@smile.fi.intel.com>
References: <CADU64hCr7mshqfBRE2Wp8zf4BHBdJoLLH=VJt2MrHeR+zHOV4w@mail.gmail.com>
 <20250720182627.39384-1-sanjaysuthar661996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720182627.39384-1-sanjaysuthar661996@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 20, 2025 at 11:56:27PM +0530, > wrote:
> Changes in v2:
> - Fixed commit message grammar
> - Fixed subject line style as per DT convention
> - Added missing reviewers/maintainers in CC
> 
> From 5c00524cbb47e30ee04223fe9502af2eb003ddf1 Mon Sep 17 00:00:00 2001
> From: sanjay suthar <sanjaysuthar661996@gmail.com>
> Date: Sun, 20 Jul 2025 01:11:00 +0530
> Subject: [PATCH v2] dt-bindings: cleanup: fix duplicated 'is is' in YAML docs
> 
> Fix minor grammatical issues by removing duplicated "is" in two devicetree
> binding documents:
> 
> - net/amlogic,meson-dwmac.yaml
> - iio/dac/ti,dac7612.yaml

This mail is b0rken.

-- 
With Best Regards,
Andy Shevchenko



