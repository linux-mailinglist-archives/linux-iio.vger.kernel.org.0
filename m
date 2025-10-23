Return-Path: <linux-iio+bounces-25363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E1BFFE89
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB563A299C
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54762F619F;
	Thu, 23 Oct 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4nDh4zT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE62F39C3;
	Thu, 23 Oct 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208006; cv=none; b=HxxE0A2UErv1co139FKV9zjBnz3ZNNglrK2Nh8Aw/UASkDb35NPmmkW5jPnOHov5ogud1/YXOATH531T1IRC4NQDD0ETqGEvLTRQp8iuix+9OY/45Q4ZO8ZJ8gHuk6GN8OAebFdqOWSZ2kJ6SEIVSmQiDqOwWe5QeFMb6q4nLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208006; c=relaxed/simple;
	bh=hIgKZLpwh9ypnh/7PbIPkTvyj83dO52fKwwzYQwLGK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/TujRoM3gxssc1pq4sY+yWM0OqjPlTR+jdvNhJM/fddF9BoHs12b9+BgPOi6t7P3VI/ew4ZyppCNup9YTS8GbJAYaUOEsqiVoA/KGjnMaJyI/9aFcwTH1dTjwmcZyS7lXfT6IiAUe5cxUMAc2zw4MAcVPAwtj4Ugi8Dx5B1UvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4nDh4zT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761208005; x=1792744005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hIgKZLpwh9ypnh/7PbIPkTvyj83dO52fKwwzYQwLGK4=;
  b=h4nDh4zTnrHukgjdRYmcTTEoJiX6RyTQ8IliVgeDQk+TrgucgO4Isk6a
   EDbizDpO8K4KU9+O+GfMOn30uhP74Jw0m/Xwnay53B+pGzQ5/Y37i/fyO
   WJx5XZex39ST87J6fyxgYAkQ9+ISc1jOzpyB7KQLk1biDNoNDgTBODdHc
   Duu5cqJxScx5oRrvME8GiED0eiyjCHmrDE83P/fbAfHcTcCIDOowQzspp
   XKMVVR1m/Dmst5DVAHOllvp8vT9CkZbvRLJ/BUHnOGk6p64bBab7jrYmy
   eJxGzhI6qyEw41QW2NfP3DamfNEsa3t19vYl5E/bptYSAVG7SeDK9pg+j
   g==;
X-CSE-ConnectionGUID: wLbOXc4fSbifuxChAvGDOw==
X-CSE-MsgGUID: Zx+90B+QS8GulZug7p/jCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67016421"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="67016421"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:26:44 -0700
X-CSE-ConnectionGUID: uyTyVUMQSvK5tiZL0uQvlw==
X-CSE-MsgGUID: WxnY47zNRrmucoia1M0YvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="188495374"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:26:40 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBqeb-00000001tZK-466A;
	Thu, 23 Oct 2025 11:26:37 +0300
Date: Thu, 23 Oct 2025 11:26:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/5] i3c: master: svc: Replace bool rnw with union for
 HDR support
Message-ID: <aPnmvepToKtZnAI-@smile.fi.intel.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-2-3afe49773107@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-i3c_ddr-v6-2-3afe49773107@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 14, 2025 at 12:40:01PM -0400, Frank Li wrote:
> Replace the bool rnw field with a union in preparation for adding HDR
> support. HDR uses a cmd field instead of the rnw bit to indicate read or
> write direction.
> 
> Add helper function svc_cmd_is_read() to check transfer direction.
> 
> Add a local variable 'rnw' in svc_i3c_master_priv_xfers() to avoid
> repeatedly accessing xfers[i].rnw.
> 
> No functional change.

...

>  struct svc_i3c_cmd {
>  	u8 addr;
> -	bool rnw;
> +	union {
> +		bool rnw;
> +		u8 cmd;
> +		u32 rnw_cmd;
> +	};

Same Q, what is the selector?

>  	u8 *in;
>  	const void *out;
>  	unsigned int len;

>  }

> +static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
> +{
> +	return rnw_cmd;
> +}

Useless?

-- 
With Best Regards,
Andy Shevchenko



