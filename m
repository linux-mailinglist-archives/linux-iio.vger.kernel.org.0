Return-Path: <linux-iio+bounces-10441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C399A0A3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B872B24A1E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960320FAB6;
	Fri, 11 Oct 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkCd0aSJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0720B1FF;
	Fri, 11 Oct 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640866; cv=none; b=fntp/Uu8LHSc7Q8OJzRY/4yNhgD3b46i8pwJKO2Efn43rbcnXTe6Odlee6nULlphM5/YMp9sUgwqbwJmW3SDcJiGjZP1eUlIW2bVEuH1z/YP7CFDzCyKkvliPqJ7I59WZEL2rgxJy6pZthpIap70lhyqP2d0UeH9KMPXoEi/NOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640866; c=relaxed/simple;
	bh=TTBYiyfuJWI3xeO/62MgI2m+N/DKFEa9HxhkW4aqcOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkTRTzqLfxyqOf8G+qNPVVVrqgx05JCLY57UFPg1e+veM5Wnrr/i2TOJx8hKrfzB8SvKxkDPmuPEXGfuxy0pLYxZSdm0uTpoAywtKXt/Z4QoEDeG3MrPAt/17mo/Yx16vj3myT1/9bBczGB4TxilvBjuQvEtRPVhrGwmR/yt3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkCd0aSJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728640862; x=1760176862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TTBYiyfuJWI3xeO/62MgI2m+N/DKFEa9HxhkW4aqcOQ=;
  b=VkCd0aSJ4/jNAhoqHMMFP9bBx4EoIcXZb2HQGDBZs6S3EvVP/dNDNG16
   GMXa6PCzEpSryKaR0SPS729FDQmZUhK2OOt3eD9FMDCjBIGT9LH+tY9TG
   Io6BMTD9AjrA9iEJ5kHpLKGPDGgZF5pEsAzg4XxanrXzHv/H6X8da6T6m
   f9PE4vCrfTYjNOhxKBVkjNnvXKIOHlf+ZCrgq1A5WO9IC0yCNWxoXraqx
   irYPREvIr/PvummdRCsg1iEkfcf6Xdk13Hu2V54yc9BR2VJG3fvJak5YG
   fbI5tGF7LAl4fubsT8NuyqJOnAjj6sediahVwA/4H0YJwZNPvz6qa2dV0
   g==;
X-CSE-ConnectionGUID: a2tiO/LgSIOV7jZ70Rkrqw==
X-CSE-MsgGUID: f2yYU0ReRgaPka46FVufrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31736825"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31736825"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:01:01 -0700
X-CSE-ConnectionGUID: lIJGebpqRD6OJjoWzMWkIg==
X-CSE-MsgGUID: RP5StCEJSpqD/T30dveTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77069186"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:00:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCS8-00000001qoi-0eOY;
	Fri, 11 Oct 2024 13:00:56 +0300
Date: Fri, 11 Oct 2024 13:00:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] iio: chemical: bme680: fix startup time
Message-ID: <Zwj3V1oaTO6je-w9@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:20PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> According to datasheet's Section 1.1, Table 1, the startup time for the
> device is 2ms and not 5ms.

Fixes tag?

-- 
With Best Regards,
Andy Shevchenko



