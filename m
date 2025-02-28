Return-Path: <linux-iio+bounces-16186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A21E5A498EF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 13:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB116A2C2
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35226B098;
	Fri, 28 Feb 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EacrAzqy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542326AA8D;
	Fri, 28 Feb 2025 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744807; cv=none; b=BebqIy2nLqWmcOajT3v5bqoE/g+mv0UYf5XP+cil73HbOAbmGoXb8R4OpVwpb/0WbUayj+xkCaIxDUYNb1yYlc3hmxijsOigrw6jbQbM0nVZOETUew5543UouziBXoEkvHqC3H8yYfxxcu5SeyrGuU9BjbupvSXIbzSywYPmC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744807; c=relaxed/simple;
	bh=MZOh/BEyXhy9QpLpvX6QrFoMONASFhvLsh4Crc2wUMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSxVMzuqjcOA3hE50jrsqgS848w3KWNYhPNi2X02JqR+Dr/amaKArUse67YDN+zjmSGQ8K0BE0hodWX4ALocUK0sYTLlkCpUTtI/S0KyDH4ZgxveiId9oGB17apO6ZTTRcG/Kh8r74QuUMWiVarT3g7fQHSj5WOFf2Z4TbnEwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EacrAzqy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740744806; x=1772280806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MZOh/BEyXhy9QpLpvX6QrFoMONASFhvLsh4Crc2wUMI=;
  b=EacrAzqyraXidtPPihAqwy/tyiwMJByDebCmT2q3eiPULWT8Pm3y+G+r
   5upyjCDIKoavo3w5AoFLSrIEPrR6JD5tW0wkNTXkyxgyf+7VcmTCFjhlh
   ZsrbAwIB4s2fsClzhkThdnxxchLBbEksDInwRLnJks12k5m8q9Oa7QkR8
   axMj9zN0OenNyvwEfFa6KSwhJeG5KpDgGVY0PVwfGNHuV0Ur4FFeB++XG
   KsIkOTz9VEH2k1ESleJEN8lIPJ0h7rJ6k52dx7gkQLNQHO8od+SUQb6uC
   JA3ctjy1HaHrSBdQa6pFHwwGN0RCjqHAKCTtFsCwvB94dubxU0Pz2NnjO
   g==;
X-CSE-ConnectionGUID: ZiVBuRKaRu+1ttoE8C5ZNA==
X-CSE-MsgGUID: dIDzWzTeSaO14u/B4ide6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45321182"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="45321182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:13:24 -0800
X-CSE-ConnectionGUID: CEXLI9B3TsyP1BSLtGZLjA==
X-CSE-MsgGUID: MHTcmSvjQFOs2h7RfXYlTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117357535"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:13:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzF1-0000000FwL9-1YGd;
	Fri, 28 Feb 2025 14:13:19 +0200
Date: Fri, 28 Feb 2025 14:13:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux pin control <linux-gpio@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] ib-devres-iio-input-pinctrl-v6.15
Message-ID: <Z8GoX6GxvdEEU_n5@smile.fi.intel.com>
References: <Z7xGpz3Q4Zj6YHx7@black.fi.intel.com>
 <CACRpkda19xw3YSO3wL4FaDVHz4KV5Vrp4vR7PSHn3yLqK20PGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda19xw3YSO3wL4FaDVHz4KV5Vrp4vR7PSHn3yLqK20PGw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 12:20:18AM +0100, Linus Walleij wrote:
> On Mon, Feb 24, 2025 at 11:15 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Here is an immutable tag of the "Split devres APIs to device/devres.h and
> > introduce devm_kmemdup_array()" series [1], please pull if needed.
> 
> Will the pinctrl changes come in from some other tree if I don't do
> anything?
> 
> Then I prefer to just chill :D

This will come inside Intel pin control PR as usual, you don't need to do
anything special.

-- 
With Best Regards,
Andy Shevchenko



