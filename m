Return-Path: <linux-iio+bounces-20231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21177ACE997
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 08:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7768D188DEC7
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 06:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACA1C862B;
	Thu,  5 Jun 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoasEWsE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D786337;
	Thu,  5 Jun 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103471; cv=none; b=eNbcH9L5b48+Hbi0cAydIJmfDXzJ+Di2Upk7344U7RSNsTMrX7QCGHJy2XwRNl/GGRmOzqPPFyY+RnN7adUVs6AuOhzaNyGBXDe6dzmm1m3ujRuqS0dVQ2mnMqSUwxJJVW+vS8i5l/SoY6Sk4GQ7jClLf+W7lJ7JtSHYTeGLC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103471; c=relaxed/simple;
	bh=RZxpLfhIRq9MDyCn7PC1IqQd3NaFFgnnFlYQvCjgl1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGiGeQAMhy7dZnEjwzXPrGkpOqSvqPxVMNP7fVU6vH7Q73Mi+FlMbsSkkXY8/Ym4iZHLwbxAAf4DnoOX8HOg7TodZluh1Ns37DElQYmSbkSNkJwzhKEMbeB8Zr08pcEFrHyGFnaIjqL5h+t1I/Eb3Z4+oWMe32lkazNcRfQnt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoasEWsE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749103470; x=1780639470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RZxpLfhIRq9MDyCn7PC1IqQd3NaFFgnnFlYQvCjgl1g=;
  b=XoasEWsEb0PwgqCZz+cHCMZkdZRemmNqIPlDJL1G8HUbd1u24JFht+WO
   EzYTVRbNCmlO+o+RKrSiuvBnI7LQHMwzAGyqo/KF3yvbVPYUuC4Rnoj0d
   lGx6OHFSQgP5fHUk19ayQMmsmtNJ+gxu+1IFzIlvAADj1DIx/hXtzMIcG
   PpvdvFxoP3/nhdrV6clAz3mzie9QW/lX3zuqKpS2c3PTDRDIR9mjAqOxW
   S4vwkuFF4Ik1d1pR41/M9aR6+tzbTtZJ3psrA2Rtxgsph+ESc390LmFeC
   nuxG4JeACksJ3l81/7SNIzmbaer6t6BFIps8gCjttu0HHhn6jomuQTzVy
   g==;
X-CSE-ConnectionGUID: VR2OW/oCQ+uk1ZOrb0d1Ow==
X-CSE-MsgGUID: UXWvV5SIQ4KkDq7TVDItKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="38837851"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="38837851"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:04:29 -0700
X-CSE-ConnectionGUID: utlLf4pZQPODm/+M2F+6mA==
X-CSE-MsgGUID: aKLhIUSCTNmCCS/ak7G/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="145905398"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:04:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uN3iA-00000003mBg-218f;
	Thu, 05 Jun 2025 09:04:22 +0300
Date: Thu, 5 Jun 2025 09:04:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v10 07/12] iio: adc: ad7768-1: Add GPIO controller support
Message-ID: <aEEzZjfLVUW1kyC9@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
 <eb48ea5f11503729b15a36ef00c89de3dd37bcc3.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb48ea5f11503729b15a36ef00c89de3dd37bcc3.1749063024.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 04, 2025 at 04:36:43PM -0300, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The AD7768-1 has the ability to control other local hardware (such as gain
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
> 
> Add direct mode conditional locks in the gpio callbacks to prevent register

GPIO

> access when the device is in buffered mode.
> 
> This change exports the AD7768-1's four gpios and makes them accessible

GPIOs

> at an upper layer.

...

I haven't seen in the commit message nor in the comments why GPIO regmap can't
be used. (No need to resend, just reply here, but keep in mind in case of a new
version of the series.)

-- 
With Best Regards,
Andy Shevchenko



