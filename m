Return-Path: <linux-iio+bounces-25569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3801C1403B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CB2B4F31C2
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68024304BC1;
	Tue, 28 Oct 2025 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORChShF6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835F3043C9;
	Tue, 28 Oct 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646332; cv=none; b=ujYVHfiWLKnj/RzzPPOaWpdJ8z7c4B5JpIKKxCdxlM7ZK/x86OIBdeGopbqhTqgSitShGnpJCW4qjtA1uzg3vgqRwa5wHQx/s0Lb1ykE6/U5rSHkwtjds0Fv3t1iy62ke28VyMXI5MgMKAMQdigsyraw1M8sONiFQ9HGBrY4rdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646332; c=relaxed/simple;
	bh=qKfDPYKzNacwmxBtqb1BnFHfk3maEUR9yyz8dofhY9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYRa+PePkoHGYqIZqQYIQ58vIKNSIuQFE0iKYApZGc3vkvwuu/Q3XVZ873rQYOfuuQeh+ZaKfD1rR/WGbaZdjJDRS0MrRxh4uEb73AHTImLReHpADyocff588puRSIeZgIUu3OX6HlEQVygwSgJ/Hr5bkTduAn+ERDfPxA50f4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORChShF6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761646331; x=1793182331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qKfDPYKzNacwmxBtqb1BnFHfk3maEUR9yyz8dofhY9U=;
  b=ORChShF6jUdvfetSLeSmGfKHAgXA0MAaFsuH46odJcra0SyjZ7BCjza1
   tSkVIVvNytYsLlmTvGV7Bc4+AVlAF2nNtpEjf+l9259A7FhV3VlV0OrK+
   g7/VmV50hM+0ZDISHZH495R3NVuWKvJpwXeCMNf6a8qCHQkg3CVlJl9qX
   PDVHZDjWVOKJ5x4cndcfzFAIqp3jTtSiadHQwscnbktzaoIuE+rIOl84w
   6sNlSNLqXwQZP4MebRFmctUuZj6y4E2Jt7CnsIt6EFaYp34XbAjgCsIn0
   tKxX/qxDaB+NXunL9h3Y28Tqh2nD+0iiMY1Ld19RqheIL8EabsYgzo5TW
   g==;
X-CSE-ConnectionGUID: Y4d65xLySe+Gvrx+2esKRw==
X-CSE-MsgGUID: e1PL4l1PRWW3sFqLLLGMuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81163409"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81163409"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:12:10 -0700
X-CSE-ConnectionGUID: T/6yMEsdRx20wwgjIuDH8g==
X-CSE-MsgGUID: VaCTgpPuR6OiLKW57/cTkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="190500255"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:12:07 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDggP-00000003HJf-0hWV;
	Tue, 28 Oct 2025 12:12:05 +0200
Date: Tue, 28 Oct 2025 12:12:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: nuno.sa@analog.com, olivier.moysan@foss.st.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] iio: backend: fix kernel-doc to avoid warnings and
 ensure consistency
Message-ID: <aQCW9LqtwA7WE-DI@smile.fi.intel.com>
References: <20251028093326.1087660-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028093326.1087660-1-kriish.sharma2006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 09:33:26AM +0000, Kriish Sharma wrote:
> Fix multiple kernel-doc warnings and make the documentation style
> consistent in drivers/iio/industrialio-backend.c.
> 
> Changes include:
>  - Add missing @chan parameter description in
>    iio_backend_oversampling_ratio_set().
>  - Add missing RETURNS section in iio_backend_get_priv().
>  - Replace Return: with “RETURNS:” across the file for consistency.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



