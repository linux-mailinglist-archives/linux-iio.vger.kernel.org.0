Return-Path: <linux-iio+bounces-27709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44735D1D4F5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEFFB30428EE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CE37F8CB;
	Wed, 14 Jan 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuVQm8pq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930973803D6;
	Wed, 14 Jan 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381082; cv=none; b=bw4pbi2aRA7r4TtCWmEh6wqQDl5BbvKO9cdumWRLTjv4/hLEiR0KeTY+/9mqfu9QszeY8qUiHrn2Ub96ZSH1VCKQU0/ZgHWlKwul88FXUPWDNG34UXcosfLvBEzhG7LDQ1X442WTiPDibFs+zApvrGQTJXk2mjmXreIwQ4kMvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381082; c=relaxed/simple;
	bh=092LXwRtl3E3+JMBPc+hQPk7+1GDnDFvIMA9uYo3EgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MioOj43W4bjMJ4ViVA04DKiKyz3D3u8cxsoNel8eUH4U47lxdV2LEjTelvWd9tnM1dZ1xC2Joa8mfIu7a78RZeNm53KIaziYXseWzxaVz6+0ipu/dj+tkQ9nUjmcbqe+OvH+C7BKECf5kG5vIz7K5yxlmn5WaAvTo6M21B7T6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuVQm8pq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381079; x=1799917079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=092LXwRtl3E3+JMBPc+hQPk7+1GDnDFvIMA9uYo3EgI=;
  b=QuVQm8pqW2HnME4HNtP7MyQdI4KQmuOcd0hGaI16jaVnlSl3uvvOR7T2
   4jM2BO+kvGPEUoenoN2JQbNH9bzpsPlBSHCJFflL0Nfyq/AY3K+ibtv9a
   MplZMuYmz4Yz3clZw7RWUiGytRCjNKe3btf+6vB5pl09WsS9N5lajnqJC
   uki52hXtF0xx7q0rfrkEf2OJDOu3GecEzPf1/WaViO3B39PWCqd5fbhqX
   Vdwg4MCucRQ5RccRUoGxK40RXOEYka4CqjMsmZPW7a7PrHH2BMqdhwSl0
   NI8mdd5yOxzbBuFRtT3sOdHzCXD1g8nOasWNRe615DlXLfyqG5LFLAwBE
   w==;
X-CSE-ConnectionGUID: y4qaBdONSMWvvbXHXerLjg==
X-CSE-MsgGUID: R8WU+mW5TIyBPNwWFmlFkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68882800"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68882800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:57:55 -0800
X-CSE-ConnectionGUID: 7YkKbVRHRcKhwYylcXtH/Q==
X-CSE-MsgGUID: BIuXDWFRSvWAcOZPm03Njg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="205045288"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:57:48 -0800
Date: Wed, 14 Jan 2026 10:57:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
	sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v7 06/10] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aWdailGSr_RmJrP2@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114083957.9945-7-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:39:53AM +0100, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrates a Power On device supporting pwrkey
> and resin along with the Android reboot reason action identifier.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for PON
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

Same comments as per previous patch.


-- 
With Best Regards,
Andy Shevchenko



