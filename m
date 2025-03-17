Return-Path: <linux-iio+bounces-16984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB9A6575A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591D117C91F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE117A5A4;
	Mon, 17 Mar 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JykFVUJr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E07C8EB;
	Mon, 17 Mar 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227286; cv=none; b=Tq9IPblCiaszJNDO1ZGSWcI9+CWnM3wYSWVAZ8Ad2bzHink+n1nEQ7U/7GGCZO0l0KKv3C6HaHNcimRM3Kgz3yw3RXI4M1umTI+fthhfQlJMiugt8WBB7U7/CWNcF93MdsJsP2OW9TfLfPVnnlTFBGb2QJu67ntEsL4qbT1wQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227286; c=relaxed/simple;
	bh=rJe8kVKyH077ow1Mw00nxnv3bgj5DDeZ/UYwSoiFKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0Rqj1m6UzvwSLH1hy0vvedU3MoA9ofyD03ffaGNGI7ODkeXzjp0ep1231gwpmSay/omNn+1TBiq7y27jGa3g778rsBUEqCIb3he9/feBOBnvSDpeD6ACmQvhD4/czMZHQhWJ8tiPh1MdXcr/lE6n32O+kuFLD2ALayyFFNlxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JykFVUJr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742227284; x=1773763284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rJe8kVKyH077ow1Mw00nxnv3bgj5DDeZ/UYwSoiFKZk=;
  b=JykFVUJrMSpbfI8tF3irXoqPIkZXcom1JfsSsPIXxzmMuNP/6+hrmmT+
   06gWCJittSCMdIPAZbxXAB1UcxbHRvcgOhWMPmJzR6KjJ55IO0U27yIVi
   Npfd/QLoLEPaktGobeAhlV4RjCGyCfpoz49MjYJtrLQ4ZAWmDE3sS1eIE
   /AvLUsvoQB1IAC6B5ZadKhv60XFA1PbkIBF0o35Wm/nx8RoDE0G4lfORa
   QlwWSuEq7Z/WlbRwSdgLpvzfSsglEziMztJOojhQK/IocUaGQSWikiadc
   uBw6oERafxEDemIJ4Gtpi8caByorQQQ4yzCuRyB8OjFHIRiwDdzSLJoxY
   g==;
X-CSE-ConnectionGUID: pXeAeHBHTY6rITBzQ4bXzA==
X-CSE-MsgGUID: Qgoo6TGqQy+V5+ImbOAZDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54703329"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="54703329"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:01:14 -0700
X-CSE-ConnectionGUID: 63yQND79Scmjk8NuLdValg==
X-CSE-MsgGUID: DHM8kifPQZSKZYZM2QSPpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122479989"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:01:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuCtk-00000003Lvv-0VD0;
	Mon, 17 Mar 2025 18:01:04 +0200
Date: Mon, 17 Mar 2025 18:01:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v8 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <Z9hHP3vdCm0WFoyH@smile.fi.intel.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <e556f152a9cff2ff61e7b7a4b42feffb400cb1f9.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e556f152a9cff2ff61e7b7a4b42feffb400cb1f9.1742225817.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 05:50:49PM +0200, Matti Vaittinen wrote:
> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.
> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.

LGTM now, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



