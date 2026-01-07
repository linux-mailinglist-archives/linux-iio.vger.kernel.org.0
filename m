Return-Path: <linux-iio+bounces-27527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01862CFE94D
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 16:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C1430123CC
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5C392B6E;
	Wed,  7 Jan 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FloTs901"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80999392B77;
	Wed,  7 Jan 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799759; cv=none; b=rGBGsGBfTkvh0rR3ipKoFJb5xqyImJWmG4utU8JgccJHmDqv55LYem8bkS/P8SPEOATKZiu8fQwOEDeQCemutbSF4ASG5z+atfI1mNG/gIuEkq95owyqwn3g2Yknp9SciEWda04vWWusI5SxJ2UzYMTHlNF0nJucG8sbWm4Ppmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799759; c=relaxed/simple;
	bh=26LnPSlE6H/04Cg86Bu4iGZobd8GHkU0wUulnfXq4I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTqs7//uLStT6lFb798iwHZWoxvYODIDicyrVMVDk/9LBob7fhyoIc+MRmOaZq7fvmDiyMyJfRM2FP7LvjW7exGsfHKblMEib4zBd22C+VMGPw1qW9hwUm/AgHm6ufjZ2hO9Q0g5+P+8DetDejt1Y+71wY1ga+Q1XdcVVQft+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FloTs901; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767799757; x=1799335757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=26LnPSlE6H/04Cg86Bu4iGZobd8GHkU0wUulnfXq4I0=;
  b=FloTs901DsDQX2ymoQEEoP3v/NTb783EwX0kerT4F2fvqZvSz/CiqiSe
   6LCZX/n0tUv6r2do00wxFWEW7es8jpYFR6f0JOYNqty2zYuTv4Yu3p4D0
   ulweETYOpJI6CeqvbGaW4rY0ju2lr4uXcz/bZiZj4gnZ8RA+nATra4sK3
   CIDyOImzqkJHxxg/5m5MIxAFIDgg6nVmo07551u3BHAN/h0QkpDndjLS6
   HM0qwHOqaxG9j0vOCtDG5MA46KSTLyrP6IdU6JK+nrkJR+Wt7cB3wKVaE
   AeBYPDaPjl6/VZ6KQEWkKIqg9xKcsINpB5Pslfq2xWfNWVc0sqxyMBoZr
   w==;
X-CSE-ConnectionGUID: ACyerL/MTj6U7GOli8wVVQ==
X-CSE-MsgGUID: ptVVyOwlT3Sln2E23bhPdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79892361"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="79892361"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 07:29:14 -0800
X-CSE-ConnectionGUID: xJSR9bTRR/CpYzwHr0MkNQ==
X-CSE-MsgGUID: egdtjVn5QgSoFGK9K97hcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="233666237"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 07:29:12 -0800
Date: Wed, 7 Jan 2026 17:29:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, mazziesaccount@gmail.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7476: Remove duplicate include
Message-ID: <aV57xb7nsUT-klRm@smile.fi.intel.com>
References: <20260107082920.2151042-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107082920.2151042-1-nichen@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 07, 2026 at 04:29:20PM +0800, Chen Ni wrote:
> Remove duplicate inclusion of linux/bitops.h.

...

> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c

>  #include <linux/gpio/consumer.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> -#include <linux/bitops.h>
>  #include <linux/delay.h>

Can you actually sort the headers alphabetically so this will be visible change
(in terms of the context)?

-- 
With Best Regards,
Andy Shevchenko



