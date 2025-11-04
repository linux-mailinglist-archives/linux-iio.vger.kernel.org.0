Return-Path: <linux-iio+bounces-25898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F8C329D8
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 19:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5BF94E4C04
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA605335097;
	Tue,  4 Nov 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDyO7470"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97021CC56;
	Tue,  4 Nov 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280667; cv=none; b=e8lrunjHOmnDWFoggWzkrOvJCbs8jN4ApdLLQ5RH9uAvEQUoJmyoOSbEKhdyGwh1yN0jVZVimCk/eWgCkNoDydIMuvgGKtZJG5mmXInHHUPq6sODilZ1KN7FXY3QabrMJnjN5qBsaSP/+Q6D/bG3CdFFncOb1zJAvZP7PuLJY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280667; c=relaxed/simple;
	bh=S8M0n4HGCHbm4fPzIzmU2dNLRWtrLtsQWOHy/RiPZws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHFXPqcazxKrlHtdn62ItrmXD5PP4/Z5CqtiNoMdEuK9s4csexRYAjzPz9QW0fd8qb2A5qrUSATYDZSB+y1XZRaJLcksNm6rgfdDEzH4V44lcu0GG7k58YQ0EWqwBOomvX3jFTP5kId8JLX2AUTUJjw/HyTqtNY9z76z6H2Qwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDyO7470; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280666; x=1793816666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=S8M0n4HGCHbm4fPzIzmU2dNLRWtrLtsQWOHy/RiPZws=;
  b=MDyO74704GhVxLBvgmqO5uQI5LB849mn8FtubDu3CbtJdMCbTCfk3U5Y
   7w2taZYHJXEiZKVzY6bPm6SSpmQXLka0JWbU8DGMQLECuRhO8fAvx3xpg
   P8nUyyvaeOXLySf6gOveoEBcxygsnythDoY3zVnbCoiJ7FXA1jkq+5p/n
   3Bdj99OMEhZeXqS+zaDPgB12vRf8HrZGueAFN8O4v8MlDC9J07HC0niAR
   IXTP/XSS1cAs9Q7p8hVkIs3zyXbMjTT91nHg8/gsIlrLhFu6Hk382Tmmr
   UALdSaxAWvIpLbogySrPIx8z8txmAb8C6KG4XV+HCIkxx+H63RjWjxC1n
   Q==;
X-CSE-ConnectionGUID: zKPZ7fujQqeG2J6Kkr0lJw==
X-CSE-MsgGUID: 1MMZqZZhSRuNWiIq5B6LMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="74678044"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="74678044"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:24:26 -0800
X-CSE-ConnectionGUID: u/UdtA0uTQqLSdlYaroy5w==
X-CSE-MsgGUID: gLat3Ar9S+WhpE96CH7KCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="192316412"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:24:22 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGLhc-00000005Xcg-0cyN;
	Tue, 04 Nov 2025 20:24:20 +0200
Date: Tue, 4 Nov 2025 20:24:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 10/12] iio: dac: ad5446: Refactor header inclusion
Message-ID: <aQpE0_-YVeHmfL2v@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-10-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-dev-add-ad5542-v4-10-6fe35458bf8c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:35:15PM +0000, Nuno Sá via B4 Relay wrote:
> 
> Make sure include files are given in alphabetical order and that we include
> the ones that were missing and remove the ones we don't really use.

...

> +#include <linux/export.h>
>  #include <linux/iio/iio.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>

Most likely the types.h is missing and maybe more...

-- 
With Best Regards,
Andy Shevchenko



