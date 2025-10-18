Return-Path: <linux-iio+bounces-25255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F44BED887
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6699F188AF01
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28C27F732;
	Sat, 18 Oct 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgCMvTtv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E925F973;
	Sat, 18 Oct 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814783; cv=none; b=gm8yDiYIqavqMgr7DfYQZ+lrd79karewgGBSRGotMs8rqJe710VtPAa/H9FVGjccdH5O/DtDLq7Y7bMymBUmclgocPKML9E9U6guHT4/RykJH888BKKqRcIPon93hOWEHbjqHvRKf81PfhAVmIzdPuKQEITlMNxLZJramayEZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814783; c=relaxed/simple;
	bh=yO1VZBeYGqh+ktpk0ausSXki7r/iZv/xg2OTt1f7N7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuJbbwJbf7xuVbBj6esqEWfxCVrdNfgU8vjS8Ilsae7bkAAFhvZ/L9Pr4A/yMfh0ww/KYTESRNbwAQhQ3RkhwkqfnKHdMw7ywAv2pQaxP3TWwN8iCH8+yJyQojU9cYekrUatdcmcuA+olYOLZ2V98L6QnYpqcoruMaOXI/p9um8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgCMvTtv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760814781; x=1792350781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yO1VZBeYGqh+ktpk0ausSXki7r/iZv/xg2OTt1f7N7A=;
  b=NgCMvTtvjrEHvVyVqBKWfpGHSaMo66RlcOtSLucNGIj7mP5GgHNwuobU
   Q65HPnu0tZeqAQjDxuyka0JmbTujOYh4j0CJgNTBdXza0xAnrbEVnm+WI
   bqtHc3CNym1WPcfG+9h9r3HZSP+Uzt6fMLg+J0AOYlGhJVgU1ZMlpiFGE
   wMYuk0HoA8qmHtpnMh+V7HmatHgCP9DO7Mc8uQ0/vmaNkmGzB5BU7yO4W
   QjP+uHGhHnxpHkbbYutLRpXv7PRdnpTbVOeAD4SNjKR2GyH6GvDpID6cp
   KzA+BFnkFwh21N07yJ4o5+CSkb8Rb1gm+uCTzWHzNXdykCig40UvFee5b
   A==;
X-CSE-ConnectionGUID: d7qzkfAjTaqmUvxWkkLH/A==
X-CSE-MsgGUID: eFoKicdcQuym+2cr5QyYMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65616194"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="65616194"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:12:58 -0700
X-CSE-ConnectionGUID: LysKdMlWQaqV0EAfAFX4RQ==
X-CSE-MsgGUID: paAcxxzJRnCbHOe9BkCKOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183007278"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:12:52 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vACMD-00000000xKO-0O5g;
	Sat, 18 Oct 2025 22:12:49 +0300
Date: Sat, 18 Oct 2025 22:12:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org,
	AngeloGioacchino Del Regno <angleogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 1/8] spmi: Print error status with %pe format
Message-ID: <aPPmsBHnmKQ1sa3O@ashevche-desk.local>
References: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
 <20251016104402.338246-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016104402.338246-2-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 16, 2025 at 12:43:55PM +0200, AngeloGioacchino Del Regno wrote:
> Instead of printing just a number, use the %pe format for error
> status, increasing readability of error prints.

...

>  	err = device_add(&sdev->dev);
>  	if (err < 0) {
> -		dev_err(&sdev->dev, "Can't add %s, status %d\n",
> -			dev_name(&sdev->dev), err);
> +		dev_err(&sdev->dev, "Can't add %s, status %pe\n",
> +			dev_name(&sdev->dev), ERR_PTR(err));

LOL, I only now noticed that the parameter to dev_err() and dev_name() is the
same. For christ's sake, why do we need dev_name()?

>  		goto err_device_add;
>  	}

-- 
With Best Regards,
Andy Shevchenko



