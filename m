Return-Path: <linux-iio+bounces-18762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9C2A9E9FD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB18F3BFFE5
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82785189906;
	Mon, 28 Apr 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AenzC1EC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1E186284;
	Mon, 28 Apr 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826418; cv=none; b=mrdSGYJBvW2y36o+rxAZT0gb31yAC/sONUnzI7au26Lf4sXw2ohyS3V8VwGApZsCMCzs3UhQ4dm/U/IFAu06Y6dWb+ibvBr1huD0qAAROwFa4II84DMkUXXgRyV87DCP0/1NMs2/Yj47732zDCMRbeWL35AI/nf2LyWXPk9cmD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826418; c=relaxed/simple;
	bh=xqPZ0ud1jzDnIp4aqLWSWg15vgjoZ4+mQGetNtasPXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD7NmzQHmoeCnmF/ERhVxz5SIj2rlIaV2nUVekeDzmT7UjY5n88/DlrcNdi5dxf8mGIXdxb1PJ1BGgTCFHGuiV3GH4Xw0RRyMQUHTH8RD4Mti+FN6xV3ZznZo18WLtTUzn+lpuTJb4UiZp+VUnTKjwafDtetFt35dZNeIIHAItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AenzC1EC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745826417; x=1777362417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xqPZ0ud1jzDnIp4aqLWSWg15vgjoZ4+mQGetNtasPXk=;
  b=AenzC1ECm22B+N0QWGretDTAoTNPSjhW6MHq8tP7BNAy4niWoD35gGC2
   K8EDgvgAiz5kcIhNNMoEvwdSUkUEyIvnghffPXgotrf6F0d0gxU5TOtCa
   vGDp2xGdCZL+eRP5YTBGjpqEcl0yTATUMIIDLWAME00AonaVVUch6B4WH
   Fd50AzOJQUY3RhPl3IDyBuzA1Oh+ROtE/7X0HG2JAu/VXc4FlpnomrN1f
   5siejyrjaUs/FSmPwbMdIzOmWG87anBFNs/Y62kMyj5rwMuAxwyfLRPCD
   bo+WVmrGKgRPix8ATBUK8V6bQ/GTH31LCplQsTq6/ig9YF81P6K9TAvQO
   A==;
X-CSE-ConnectionGUID: cHEhq7G0QI2C4VIeP//iKw==
X-CSE-MsgGUID: lC9b2/Y8QbeH481oVmvXuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="46637702"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="46637702"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:46:55 -0700
X-CSE-ConnectionGUID: +wS270m4TK+ee61BCBE0PQ==
X-CSE-MsgGUID: 5+e9c8b5T2aEhHLCR8Qh9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133412770"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:46:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u9JCT-000000011LT-1EbO;
	Mon, 28 Apr 2025 10:46:49 +0300
Date: Mon, 28 Apr 2025 10:46:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org,
	Lukas Rauber <lukas.rauber@janitza.de>
Subject: Re: [PATCH v2 3/3] iio: adc: mcp3911: add reset management
Message-ID: <aA8yab0GA2wYRckx@smile.fi.intel.com>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
 <20250428-mcp3911-fixes-v2-3-406e39330c3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mcp3911-fixes-v2-3-406e39330c3d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 08:54:13AM +0200, Marcus Folkesson wrote:
> Add support for optional HW reset.
> If specified, a reset will be asserted during driver probe.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



