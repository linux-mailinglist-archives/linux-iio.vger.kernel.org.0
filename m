Return-Path: <linux-iio+bounces-20592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C137AD8C79
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3093B4407
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F751CFBC;
	Fri, 13 Jun 2025 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOWVlNK1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACA12B73;
	Fri, 13 Jun 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818944; cv=none; b=i80YgsjLM6uwg5XTDfsehFIrb40DNnMSlyk4I+JleUoiU+l0LifibQ+sNFFAKNqTb3bgEh6/O0jo+HeEDdPZzX0kK5rG+NVa5yho9VynyPAyOJuPa1EFnfDb+yEazSsyNsE2GLQv2G5aejEhM2halVEYwiksKYSf5b54XLSYeLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818944; c=relaxed/simple;
	bh=YEq3r8z9CPTt5vkquBPOsdtVyNqtsd8fCjZ9kOARXHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0PO7q2FKtnxtvhZ5Wk8ycQtmDZDj5v/m0DQzqM0a1b5HtEkkWEnlncMDRIc+PrfZ07xcK24Fbw6wwUURCT3r+05Y679Rzkdal6aFxMEfb5GH9klgu5fWHTDkVTqGCXIzH6LtRD4JgtA7W1rC0LglBfx/33G8Tol/s0mrvpKrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOWVlNK1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749818943; x=1781354943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YEq3r8z9CPTt5vkquBPOsdtVyNqtsd8fCjZ9kOARXHw=;
  b=dOWVlNK1efwrUGCvOs5/pJPWSORzT00BOhe+13b84Js2xKqwPBlVX6K6
   dcPYSBVdxbtMqbHxP6zFUZmUy5Au4Le0xPflUdySFERg/vzi4OawoHeaV
   GoSSTYaNX1OWoVp11vTKcUzpWqPHy0Fk5rvQGZAaU81bjW+QQdFSMOBKY
   qS+f+DAIpArAGMbKqxlMEXAupfkdk+f6FkJ7A9qOF2s2eFXcsfOex1I78
   fvwHdV07L4CL/3vdWuxka49zUb1X3kjmGVxXLhSi63+TqLpjVOJNwaoJh
   IIHhiYyfa1Sp+l7kmaYs6LSByJtQC7fETHpqDjtAzSkMvg0MEyGeTWA9l
   A==;
X-CSE-ConnectionGUID: QekG7zqPRfiVU9tmbrbpLg==
X-CSE-MsgGUID: PRuNhoT3QbGSAbU3r9eAUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63386439"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="63386439"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:49:02 -0700
X-CSE-ConnectionGUID: L8mRnVdgSiWXFWr30HX9ew==
X-CSE-MsgGUID: QEGtiL6UR0SjxOy0sLjvLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147722174"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:48:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uQ3q2-00000006FPO-1dnT;
	Fri, 13 Jun 2025 15:48:54 +0300
Date: Fri, 13 Jun 2025 15:48:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v11 00/11] iio: adc: ad7768-1: Add features,
 improvements, and fixes
Message-ID: <aEweNqhLsL_Hg_gl@smile.fi.intel.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749569957.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 08:49:34AM -0300, Jonathan Santos wrote:
> 
> This patch series introduces some new features, improvements,
> and fixes for the AD7768-1 ADC driver.
> 
> The goal is to support all key functionalities listed in the device
> datasheet, including filter mode selection, common mode voltage output
> configuration and GPIO support. Additionally, this includes fixes
> for SPI communication and for IIO interface, and also code improvements
> to enhance maintainability and readability.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(for all except DT patches)

The nit-picks can be addressed either in next version (if needed) or whilst
applying. Up to maintainers and you.

-- 
With Best Regards,
Andy Shevchenko



