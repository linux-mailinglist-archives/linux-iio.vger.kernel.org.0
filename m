Return-Path: <linux-iio+bounces-25592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2098C15447
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A1025025D2
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CFF3314CB;
	Tue, 28 Oct 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAF0aCPS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659832ABCD;
	Tue, 28 Oct 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663243; cv=none; b=TTgbe2uq9JmGuOmk5fk+CXoqnvk2GXj0YV0PJdesGU5FnuCkeM8pn110MAZOiQKY+owF6a04Ty/fSogwIUo2J113tx36eUYXtLVv1HIG2sp1kuJ9WdS2XMwyGJdttzdeK/h1N8FR2+UL97whoWU3eEQrLsnfi8Vs1+YasUbhF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663243; c=relaxed/simple;
	bh=mi5dp4FJzNlz74atslUNZlo0HuAOGR5OEssnOLjHZXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0dZDfN6bZWduLkRlkJnTfV1sTOM4GkVdVpfogCvIKVuOIH+zYtnU2T4XW/5phfqk424U9y3+vBusXLmylt4E0Aa/hmDnK3/wrGDKhDts/8O6F97+6gqIJ74vwGga5InaT3aWyE6qBjbPxb8XDRVTbBlgG1E3uj5FUwi3FKcbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAF0aCPS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761663242; x=1793199242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mi5dp4FJzNlz74atslUNZlo0HuAOGR5OEssnOLjHZXw=;
  b=DAF0aCPSKMtFRh/1gv/nY99A6mycEjqc6R7Cg4GUdh4WxVaZOn7H7Wci
   j9ErMqcXR/Cd/4SlVx4wbHuWnY0ExiP+sjIPEd5XVx2SKJhA4rqQHeE1t
   B35RQIDfA9ozuyDCWs5zxLxHZa3wUgnp9c/lJLTdMD04jLO1bNw//nyRy
   7bH2zlxXrbTUuzjS7krM3wfmZTV8Uvh6ZkPcW4XLgwTi7W5U0BY64bdbV
   0hb1WsgRFgKJ7JWcrLNiUZbBHOi9ox3qvRax6PNFQ3d7Q/mJJZsBxtKwn
   pMGnx6SsQn0obwHrTbJ7Nm5ScJQFJuRE82GhE251DTPt+2TeIgl/Dzu0l
   g==;
X-CSE-ConnectionGUID: CTWVpU5YQJ6H/qjsTWUjxQ==
X-CSE-MsgGUID: n5jpTfzYQdyaHo0Of1n3nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67629264"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="67629264"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:53:54 -0700
X-CSE-ConnectionGUID: rgJB7n3+SFOXyrXLC2uGKw==
X-CSE-MsgGUID: qaBRj9teRIeLIp8szEYJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="186114724"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:53:50 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDl51-00000003LN6-1Dhh;
	Tue, 28 Oct 2025 16:53:47 +0200
Date: Tue, 28 Oct 2025 16:53:47 +0200
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
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v8 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQDY-9CEOlA74A-N@smile.fi.intel.com>
References: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
 <20251028-i3c_ddr-v8-6-795ded2db8c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-i3c_ddr-v8-6-795ded2db8c2@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 10:49:02AM -0400, Frank Li wrote:
> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.

Seems you missed my comments against v7
https://lore.kernel.org/linux-iio/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com/T/#m377b66850dc0205c3b8723d09c647b545b029fbd


-- 
With Best Regards,
Andy Shevchenko



