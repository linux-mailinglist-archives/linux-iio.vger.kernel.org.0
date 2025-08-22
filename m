Return-Path: <linux-iio+bounces-23138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F5B313AD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56EE5BA0457
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57E2F530A;
	Fri, 22 Aug 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EL/2jZf1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F462EE60B;
	Fri, 22 Aug 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855575; cv=none; b=gptZ49dqg71B04K7gRwyxwXZ71mmexI29ZVBbzhwcJ5XaW6YXtCSpKtFq0Gbl9HDw5EGhJuZZjVenvS1O153KwXY8pyFW++ZUMMtZh37f7tK2LF6jHxGN9NKrMZCjgfDPz2bWNPx4cs7JpgULdoGkkFW89LfnedTffJJuHGZpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855575; c=relaxed/simple;
	bh=7TUjIdFSpxdPwhWS7KavRP+nexN6+krDK0zXKT3Z4nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZFap6Ib4g1CrCqpvfcpT9atBaLbOTJIFSCXxNuO71wc67Pak5xlWNrruKV81K6u4BCU2SQhv8BagmheVpNQrNjycWivtUts1KHpwZAqFiUXENCPv5F/wD3uSTaA3raz5uIqyoYeNDQT1Liou0ytDFCyXppPo29PbK0LkpjqyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EL/2jZf1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755855569; x=1787391569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TUjIdFSpxdPwhWS7KavRP+nexN6+krDK0zXKT3Z4nI=;
  b=EL/2jZf1G02VLbxeyigwW40DBROzamQU+/7jjve8gU8H9lNKTJ8Bc4hn
   OTcMTnY9HR6C+XewwMQVLkc4K/e+SMX3Y0l1C+EBdPmX3EAAsGISQe2tO
   TG5kxN7vSIoc75aIHGA3WjwAt1K0WsEAghxdSCAoJER9XSSroA1M7+7Ix
   2LYm1nbCR6sii2NwdPZmM2ppOrepmB/urTggKwCJJ/oZRNhVXUmARpMwn
   MOjj32nr4OxTGz1wJoAfo/S7zbbyj4XBq8kOWY0bdIA/6G2OW/OBu6zec
   ihPz6sa96WusdfLCNolfUTto7TQZQaqWwarNOJMctVM/0XvqxUmFeaboV
   Q==;
X-CSE-ConnectionGUID: RKGUoP7SRliwfszzu9L+UQ==
X-CSE-MsgGUID: 96BbsFwlTSO/NFzIGUJWSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69260143"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69260143"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:39:26 -0700
X-CSE-ConnectionGUID: f9G7SEp4RL+f9OQZP3DIVg==
X-CSE-MsgGUID: a3E0ehOpQtuXsOFDu60/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168177411"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:39:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1upOEu-00000007Tma-2yFG;
	Fri, 22 Aug 2025 12:39:16 +0300
Date: Fri, 22 Aug 2025 12:39:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Haibo Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andreas Klinger <ak@it-klinger.de>, Crt Mori <cmo@melexis.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 01/10] iio: accel: Drop unnecessary -ENOMEM messages
Message-ID: <aKg6xF4w2ugRqDMt@smile.fi.intel.com>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
 <20250822-enomam_logs-v1-1-db87f2974552@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-enomam_logs-v1-1-db87f2974552@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 22, 2025 at 09:19:49AM +0530, Dixit Parmar wrote:
> The drivers do not require their own error messages for error
> -ENOMEM, memory allocation failures. So remove the dev_err
> messages from the probe().

Misplaced (), should be like
"...So remove the dev_err() messages from the probe."

Same applies to all of the affected commit messages in the series.

-- 
With Best Regards,
Andy Shevchenko



