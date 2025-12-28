Return-Path: <linux-iio+bounces-27402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD31CE5373
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C89A300508C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BA1E0E14;
	Sun, 28 Dec 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MP2CLw/5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE413A3ED;
	Sun, 28 Dec 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942336; cv=none; b=BqskUY6tJp4drqZWSzCXghAhNaoCbknyiLtsJeHmqY75Mf3dNbAIywYvSmhVCcBLq4mqjkVyLxJylCEqj6sZtKBwD2XPsjA8VEBXcRGxuCcy8Ludd67hpr5xjmI5qYXZTr9BgDsg26fpxZa2voRl36rTiCVCxREwOqVKK4Gm82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942336; c=relaxed/simple;
	bh=uSsQIz1OGRhV62noj5RTIXudfw9LxSYl7qmhYqRlhNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VorhZpcw6BD/lgyupR/MvczxGocngh5Z31OxSHSUL9d/yJsG1ab8K2sFac9vT3Njz8/y55pfYuKPe0NSO+SzFWXz89PtlYr9e2nXlH4/ZZuwjju1gQRDNmN6whA7N9gyLvknv4u1bHvQtLZsT7ZlE96A1h4iYOvWHzhoFIjHomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MP2CLw/5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766942334; x=1798478334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSsQIz1OGRhV62noj5RTIXudfw9LxSYl7qmhYqRlhNU=;
  b=MP2CLw/5chQ3sg+TX39VpAea3q4M2spsaarjZkq5RtvAtkUoZMpfkm2V
   cliOEOb7EyZWiR3riWO8xJoqAuKWlE3QPRFKIV1Z+eqxfFsL+jGJ7itr8
   Z3ZMAWZck7Rqt8+Bm9JhiRPigZsgv2l25d4v6TorbwTH8vxnEKUrYwSlk
   g1olzlAuFp5gzwuDvgau1icaXaWrY5E54ZostfsY2Kmq8L5c0MA1ABtOF
   jZhPtZi0KVw+79qwjsW8KFt52fwkigXs4fZWPWFi28AVksVj08CmXBsLk
   LdZdzvcHey/mfHovJU/WCMFs7cB2dWayia4B/S5fXUaLIcNAumKrJuabG
   Q==;
X-CSE-ConnectionGUID: 4IeW8qDKTt6lkpt69mBNTg==
X-CSE-MsgGUID: TY7ARchhRuW8io06hSEf6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="94050240"
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="94050240"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:18:54 -0800
X-CSE-ConnectionGUID: cJQ6PGrFRG+RAG4QQL6Dtg==
X-CSE-MsgGUID: AjwdGj8DS8+yyQvoKneU5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,183,1763452800"; 
   d="scan'208";a="200648464"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 09:18:52 -0800
Date: Sun, 28 Dec 2025 19:18:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID for
 LSM6DS3TR-C
Message-ID: <aVFmec8JA6ZX18il@smile.fi.intel.com>
References: <20251223025351.3099978-2-samuel@dionne-riel.com>
 <20251223025351.3099978-3-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223025351.3099978-3-samuel@dionne-riel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 22, 2025 at 09:53:50PM -0500, Samuel Dionne-Riel wrote:
> Same device (LSM6DS3TR-C), different integration with the firmware.
> 
> The integration differs in that the firmware provides the SLA0 and SLG0
> mounting matrices. They are assumed to be Accelerometer and Gyroscope.
> 
> Observations were made against the Windows driver, version
> `12/06/2023,1.0.4.3`. This driver supports both identifiers, but expose
> the device in different ways.

...

>  static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
>  	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
> +	{ "SMOCF05", ST_LSM6DS3TRC_ID, },

The trailing inner comma is redundant. Perhaps it would be nice to have
a cleanup patch to remove existing one.

>  	{ }
>  };

-- 
With Best Regards,
Andy Shevchenko



