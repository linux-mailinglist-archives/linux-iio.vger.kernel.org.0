Return-Path: <linux-iio+bounces-27702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF177D1D3DD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E5273087788
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AD37F8C6;
	Wed, 14 Jan 2026 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUECs5q0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714437C102;
	Wed, 14 Jan 2026 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380397; cv=none; b=nIFzbX7rO515CaHBhYoW9BH+Ov6OxNDjEurtf7e0d0unxKZ5OWN8klUubPdWeKd0HqWnTu7+TUyfByFlkyyQ23TU/oMGrMsLSmBTgDPPu+2jqOXES41nS7PZ4LzlMP7OMPUqo+GC74Ttjlss+gO96XBcPtfunp58HTfyD5yUaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380397; c=relaxed/simple;
	bh=0QdZ6wkztJki3d9zwW4Ck8xjQesrvonP+NIaGX6jeIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjahieHT24MyZgSxWXsRxVAAPLbd5pyW+kfqsnLuqzBlMtOGleKkf0dhpL7nP+uQNrhjMtCS+AZWetBpshetDRSi5ksRrgEklFyVkTMTxayGDNSXX4CyUXner/3l8SCGLh1JjPv/3xmhacn9IBJbcdryB+b0i6BlsLR9siP+7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUECs5q0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768380394; x=1799916394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0QdZ6wkztJki3d9zwW4Ck8xjQesrvonP+NIaGX6jeIU=;
  b=OUECs5q0Vb9VUrFolxrittUGvumEDsBo+TQ+448ZXnotB1FBre6Yu0Um
   LMg8NFfCoioiXFB4Ar3UaFAxI1MVwwCk3xxAX7S+zgYpeO97R2AV4DQOv
   fohPRRM+UY+QZlbVWwJ2o5DS099RzbZs51JV3ELZS74lRbiCPhc9uPej1
   hVufjKzdBcN7eJ6etmBPO95QpthY7fEu1BZNjeLo0e3s3FovT5rzPpEMr
   3BDfwgq81Sjg7G3jhNQREcSVigmhEGsMdqhzw5eHD9omFaV+3zJTteEvK
   5NImK65lPzR4ne8rAOEPtXt8+SqpjILBeREbryeZxVc3QDVO6HkjPNP5q
   Q==;
X-CSE-ConnectionGUID: da1PxSpJRBib7UI+G3ZLVw==
X-CSE-MsgGUID: +3amV2FnQ8KzavN4z0kYZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="95150417"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="95150417"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:46:31 -0800
X-CSE-ConnectionGUID: XPYsRDaDSBSfvl1XJ/VIcg==
X-CSE-MsgGUID: ptXgIPWTR2u0wybTazACLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209464491"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:46:26 -0800
Date: Wed, 14 Jan 2026 10:46:24 +0200
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
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v7 02/10] spmi: Remove redundant dev_name() print in
 spmi_device_add()
Message-ID: <aWdX4OiZSsXIqEH8@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114083957.9945-3-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:39:49AM +0100, AngeloGioacchino Del Regno wrote:
> Function spmi_device_add() uses dev_{dbg,err}() for respectively
> debug and error prints, and passes the same device pointer as both
> the dev_{dbg,err}() parameters and to a dev_name() that is part of
> the actual message.
> This means that the device name gets printed twice!
> 
> Remove the redundant dev_name() from the messages.

This should be the first patch in the series, then in the second you will have
less churn.

-- 
With Best Regards,
Andy Shevchenko



