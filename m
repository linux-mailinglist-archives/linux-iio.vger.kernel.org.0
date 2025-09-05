Return-Path: <linux-iio+bounces-23789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074BB45E85
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC267481E20
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECB9309F1E;
	Fri,  5 Sep 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0DVrRFb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3530217F;
	Fri,  5 Sep 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090719; cv=none; b=M+Kpuiltmq5tIaKTJ2oCUFXFCZadiy30PxIR4glkvqHSUT/E+kxaO3+6wnkhfdXMo5pKQZ40M7kSWtTzeQgthX0n788i3uZU6OW50dP+eGsldOCRj7P7lTDvAYhHU8ax5CblQDR1HmnXqworz8nuM7KxkhL4lyDUJsLOed+DlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090719; c=relaxed/simple;
	bh=J//GOtdAcyhFVkDXVSjfGjySdeaeurbPwX3waIGxCZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgcWVx5/X1RvW4Z3/fCtG0RrDr7Btc1OxJbGcyZ9ou+v8cWoZOFcadgL6PTYEDI4VraZWfIXEpXikp44jx0UQZILRFAXUcTZHB2MIjDBaIZI/yRLBltdNOI4YltEpW5oqH9vjPxOPU7NLvok/YiFYtI8iI+LOujBgawn1cyeDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0DVrRFb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757090718; x=1788626718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J//GOtdAcyhFVkDXVSjfGjySdeaeurbPwX3waIGxCZU=;
  b=N0DVrRFbB76Rgzlg1cME4MFzqxX1VHi1GEZ6VPywfLPO2/4LHHAKWEuP
   wp2DgzCv/rsfaKwaoYQuCZtkNMtj/e2YlqZioPLVVnSbixAXAjcbkbBdO
   J9C2t4yorP73qQTbO97gLUA8s4EzsX/pQ1DLXZFtw9NHpuxjoj3xKh9+7
   JNCLvPS2dC/JKhxZVXtm85YoX6XLgNPaKi26VXNllreUrGPyo3jIZhojr
   HIPUbEVO4HBhnaIB/Mz1WKfCkk2DRpaDHdXfMzy7fNuOchkzvv+T/7C5d
   K9OvEb51dftiVBH4qb0DcwqqxE/R8FBfuxP4Y9K8D5fbTmbdzXQFBWPoO
   A==;
X-CSE-ConnectionGUID: QVeDpXTpSbqAg3dN9xpt1Q==
X-CSE-MsgGUID: 3hT9NTAVRAGH/sFjiwLD+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70149625"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70149625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:45:17 -0700
X-CSE-ConnectionGUID: kKMV4G6YTxGOe8O6Lfq8xg==
X-CSE-MsgGUID: wFGoXi64QU2fZAzvE6Garw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="203134496"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:45:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uuZYl-0000000BfbA-2Kpi;
	Fri, 05 Sep 2025 19:45:11 +0300
Date: Fri, 5 Sep 2025 19:45:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
Subject: Re: [PATCH v3 3/4] math.h: Add 64-bit fractional numbers types
Message-ID: <aLsTlwvQd1Jgnlht@smile.fi.intel.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <f9ebbb830fab46201dacbffa4cbe223782f0acf3.1757001160.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ebbb830fab46201dacbffa4cbe223782f0acf3.1757001160.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 05, 2025 at 06:49:32AM -0300, Jonathan Santos wrote:
> Extend fractional numbers types to include __u64 and __s64 data types.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



