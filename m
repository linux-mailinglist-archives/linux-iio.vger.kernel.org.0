Return-Path: <linux-iio+bounces-26491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4EEC8B662
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 19:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1993B5C8C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E130EF9F;
	Wed, 26 Nov 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U04PZgKX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD5279DAB;
	Wed, 26 Nov 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180826; cv=none; b=r/e0KC6/fIRFc3/MetWQR4BJzSjYsrHOB8I7hXmjyPbUCDRjiiVEPfOlQwKAhYqrSk/hd38BZKbb64yKxYn7OoJa/2+HB9xGbuiKp28ynCFkpKgvWCD5oduHSe13SwxjQrMQF7txYwxBfIC7gzEgf8HsIDqX8Sn4KBp2hEH8980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180826; c=relaxed/simple;
	bh=Srsnd+nO7RHYhuP7VbP6PX+HPNCeRP4K8crUtPh370E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmJhmOL8RC8vr7unn0Lf+1Pxi3sNjDhQwa9lQfUc3PXDHJKYRdEeEX+2Jju0Lto1mRbLy+08cvvNAmFBtZZnbEqcSn68AxH9id7DVdXx2oH+z3zBKF8bsXS1aCox+RE8ShpFO1PyFeccuiFQNOUlZTcjlbx7Sn7tStAVeFjYph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U04PZgKX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764180822; x=1795716822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Srsnd+nO7RHYhuP7VbP6PX+HPNCeRP4K8crUtPh370E=;
  b=U04PZgKXec8Roe8aDUPuJV8R56XEr//VJ2Y/PZNO9kEl6xSoMjPZWuuy
   4826ZDe+ed4zxmdy8wN1i1LQeoFCL7gLJlwkAqVDF6FBftYgBjTO7zlCL
   bGb7RW6i6c4tXhKSbKwtRo5wZ6OGzST26N5ihz1mP3b8Av5/3Phu8HjSp
   tOcH5v287821FAkHeNJBlZWk9u7Wj1RaL+3SG0K7ZMayMCZfxm7uDGubP
   wlzvAIWjXPRa4CCzUDXlzAPaPVFy1fo1qJjgSCtpC0jfj9ZGinHCmlWEu
   1wod25oJUiERFOHLs9bQ0O4bY4fyhlQbw9bgqrDbNX4Cf8dSODFUk1lAu
   g==;
X-CSE-ConnectionGUID: 9KcbhDwpQbOx3FgkV3L6QQ==
X-CSE-MsgGUID: dd04mSa7SbKWWR3ZDQ5x8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="65932472"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="65932472"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 10:13:40 -0800
X-CSE-ConnectionGUID: gJL7+COvS/yo4aIzSwlsqA==
X-CSE-MsgGUID: CeGErtHQQs6MQZ0MPMr5WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="192263733"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 10:13:36 -0800
Date: Wed, 26 Nov 2025 20:13:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl380: fix check for unavailable "INT1"
 interrupt
Message-ID: <aSdDT4upO9shVq0S@smile.fi.intel.com>
References: <20251126144624.24512-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126144624.24512-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 26, 2025 at 03:46:24PM +0100, Francesco Lavra wrote:
> fwnode_irq_get_byname() returns a negative value on failure.

...

>  		st->irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> -		if (st->irq > 0)
> +		if (st->irq < 0)
>  			return dev_err_probe(st->dev, -ENODEV,

Please, also fix this.

>  					     "no interrupt name specified");

Otherwise a good catch!

-- 
With Best Regards,
Andy Shevchenko



