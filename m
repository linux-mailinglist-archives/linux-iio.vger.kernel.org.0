Return-Path: <linux-iio+bounces-25817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4D0C2A764
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 09:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910973B35C1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C7F2C3266;
	Mon,  3 Nov 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtQmbLgK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF122C325B;
	Mon,  3 Nov 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156515; cv=none; b=B24b9b/6/qK0pXmx+J0cXnnFp17iBBGFwZqDA3PPOmBBdws2jYdgwLyMo1wQ6oNYMy1zaKqkuDGIDx2tpbcfNGJf7nwnS9i8NHqcUXN6ezu/zer7/25swHIZQ+bvYuJJS7o979YOIHKOV+K1oDmqNFD9bqiqkNUB56fAVQrOF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156515; c=relaxed/simple;
	bh=mvmcQpTdyBJXNSOpW128P7Ddr42SK2Tloipxj7KJbCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5c5O/aGX+LlvsCp6Aa8mT8Xw8iFriigWj4wgo5hn7kFseQnjcxNLeOVUeT9ME0IJ0l3bLczoJPWKNFAVfGVUYQRyGuEh7QOWutJQ/AVYZ/fWWHDQK61U0jg8fUUZHFWxWnOflmBE9SuIP4t7QT8EukiYdFHbz8i+X+QR61DZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtQmbLgK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762156514; x=1793692514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvmcQpTdyBJXNSOpW128P7Ddr42SK2Tloipxj7KJbCo=;
  b=TtQmbLgKFVbVBbXyp3Tq3NwfuFWePhPw7Z8CxRajcC796JbJXpF8D/aJ
   0ZJlzRn39xGEuBdMcyUBR6aO2XKo9pG3z2WX9j70md1yBpGrlx4rI2tBM
   ETx2C5LIrjeBvplRNfXcfUGPYNdDiA3s4HdT4ruCEBSr2rSXvQvuYnj3d
   3izwLWMPQp//9x0RF2D/j2NQPYxqya0H6xWn13Tv/wzp1301TzB5SVGu/
   s6rSCZA+G/3ifhoAK065836G5g5X2JOB/3+cBvIaF0yBlivbBm6MRCGIM
   YHH6hHqGvJaEjf6iGHqxzFHEz7196f1YPBUoWKl59EFmYgRwcdEdOtkY5
   A==;
X-CSE-ConnectionGUID: IsAbFhenQIuX60rtPpIoKQ==
X-CSE-MsgGUID: 8rz0YDOkQ2m6xfRMvUaFRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="68087003"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="68087003"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:55:11 -0800
X-CSE-ConnectionGUID: 9X1JRKWbRbGr6fM9AhljwQ==
X-CSE-MsgGUID: jYMZcKarQD68ZAbXZMggpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186675307"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:55:08 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFpP6-0000000556O-0MY2;
	Mon, 03 Nov 2025 09:55:04 +0200
Date: Mon, 3 Nov 2025 09:55:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi270: fix dev_err_probe error msg
Message-ID: <aQhf15IWlTMfETpf@smile.fi.intel.com>
References: <20251102223539.11837-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102223539.11837-1-rodrigo.gobbi.7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 02, 2025 at 07:30:18PM -0300, Rodrigo Gobbi wrote:
> The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
> during probe, if devm_regmap_init() fails, it should print the "spi"
> term rather "i2c".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



