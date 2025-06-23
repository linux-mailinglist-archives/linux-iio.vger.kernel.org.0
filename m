Return-Path: <linux-iio+bounces-20890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F30AE367B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 09:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3728188FCAB
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8921F09A3;
	Mon, 23 Jun 2025 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/5Dp29A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B821EB1AA;
	Mon, 23 Jun 2025 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750662430; cv=none; b=SXRcV/SoH1A1Swzibfis6c8MhZBph5fKoXKCs2nE3BcF0IOakcF9X13p0rWygwKkbZnH8PwprcD6hAag/UmniZceeDZ3csXIk5ObY1Iu0A1VLbh0BKqyQ62vXm7jgQyEDR5qLfZSpZiR3UE+Wmsh+0Rt4KqDw9YqjLiWLanU+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750662430; c=relaxed/simple;
	bh=IkXT4iOgvOdUBe8c3ENndU7xzyoDcLDg7zbanLSFZ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+dFKxROWcoFMutf4gsqQl9YUL9w1w79g2ZlIK4UBUPcZ1dyz+3EBJMOF74Kx9BcSkEGK+DobTf4lINI2KJtnzxaeMuOpLcIfYzLGkDZVaoBF/tencSWQs39EGnnxQN9LN2xiiWOJcqphGFyS5tawbYyN9IXnUxpl6TDhJsfDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/5Dp29A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750662428; x=1782198428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IkXT4iOgvOdUBe8c3ENndU7xzyoDcLDg7zbanLSFZ0k=;
  b=i/5Dp29Arb1iw05sRe+VQ915tN7NT2Or5ToMKyLZiFKzByCAFU//CTZA
   7yPDe+8qaUgCB88l/aap0Mbfmd1NEs3pqm0ES2NQqYTmFAN7UvvnCu5wH
   ehl1KcpTl+hYR/bU4NdMm2OUQNyzVIqHipCHDWratrUwyr7lDgZPyJL1w
   uBhJmGZeRaL9D5FYsHRHHfvG/bkzAvkXlooKt1AW/rl/Zd3sbKnb8xjGr
   E86pj1JyRrU7hovxMccugTepUzgI/2hHq0Ezk3XYSk+pZXtVVVOnnPFoQ
   f54jBL2bme1fXGDibS7r18qk7MNUk2vINE0WrS9TEr0MLZCNvcBQG1b0Y
   A==;
X-CSE-ConnectionGUID: cfmtqPWfRnS9NwCfKknSPw==
X-CSE-MsgGUID: Y+V1+TnlR0Se08bbD4RIxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="51972913"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="51972913"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 00:07:07 -0700
X-CSE-ConnectionGUID: ipTrBwf7TY+jc+MOxcVAlw==
X-CSE-MsgGUID: h9N5OeopRmOr9qfE6d54Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="150929928"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 00:07:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTbGf-000000095fj-0kny;
	Mon, 23 Jun 2025 10:07:01 +0300
Date: Mon, 23 Jun 2025 10:07:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: liquancin.mereenamathai@in.bosch.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, vassilisamir@gmail.com, marcelo.schmitt1@gmail.com,
	javier.carrasco.cruz@gmail.com, Xu.Zhang@cn.bosch.com,
	Maoting.Bian@cn.bosch.com
Subject: Re: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and
 support
Message-ID: <aFj9FGSpJyZjL_bj@smile.fi.intel.com>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 20, 2025 at 10:24:53AM +0530, liquancin.mereenamathai@in.bosch.com wrote:
> From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> 
> This patch series adds support for the Bosch BMP390 pressure sensor to the
> Linux IIO subsystem. It includes the main driver implementation as well as
> the necessary device tree bindings for integration on supported platforms.
> 
> Patch 1 adds the IIO driver for the BMP390 pressure sensor.
> Patch 2 introduces the device tree bindings documentation.

>  16 files changed, 7296 insertions(+)

You are kidding me.
Please, take your time to start with something really basic.
Also, can you explain how this driver is not duplicate of the
(any of the) existing ones in IIO?


-- 
With Best Regards,
Andy Shevchenko



