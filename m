Return-Path: <linux-iio+bounces-26148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE49C480DA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 17:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19991885680
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79596325720;
	Mon, 10 Nov 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDtuIYwE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83797305066;
	Mon, 10 Nov 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792703; cv=none; b=NpCS2oBUGM/XHPdxgYqYUzwdOUZaMF1RopzGgds0itq6ID0vZ6rJSFhYckUf0B9z+ET31UN+4kjw32Q/ct1kYU1Kwp9unFkKIqVw5xh+FMJw1L890L98EQz8R719GmS8IPNF/pf7tVnu1CZ17p5yvBxNSV9FZOt28nb3FKvYfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792703; c=relaxed/simple;
	bh=fLzd+VRzKDe+3L+miM0mvnpuDsl++gErPafaJMrhHLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsqE7eryg5zp1T2+8EBICQBbaLPH/1QU5VR25jf5bOr59wUT/zeGl/QOTY8ziO0oXhazr0khKYkYaGEXQS9bRt0ireNNvP/ylBf3KO/WAucDTxScOcrcVdl/R0GdpWOj3lv9Wtj/Dk5Us+KniHHiy39/4zNl9P8O9EHH0djxkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDtuIYwE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762792701; x=1794328701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fLzd+VRzKDe+3L+miM0mvnpuDsl++gErPafaJMrhHLs=;
  b=UDtuIYwEcifr2twarGZYdwjXXgdpQSe7fg4PiSJ1AukfXEOyJGHpY98+
   k3Oljzk6cj94X6ohwKSZr93e/EXPh9C9ndo1cxEMnoIHsXT1hj8qrAv4u
   Qwex6ecka3TZvMq09qdRpj+6kLFwFkPTbxh/9S3DRalrrnS6SpMnzW6GL
   GTQp9oKxdlzDiE0mLAzg+63Lp6mG3ufntenQXUqDke/5R3M7/gGNrAqLP
   smbd5yGJBj8X1Q8gtsEZFMWfwrZwa/5BfsjRxm6WtWjb4t9geR/HIwGtt
   mv0+MaOiCMZCpqeW6wdjnJnlxlFIcFdQ1Rc5FAOl4Gg9uGnskwSUOWMMM
   A==;
X-CSE-ConnectionGUID: BotMA2rGTISWukGZuWf0Pg==
X-CSE-MsgGUID: IkNlKB+cTVOLschNw71gHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65002515"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="65002515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:38:21 -0800
X-CSE-ConnectionGUID: 72YtJHcySWevO5D6mmsIlg==
X-CSE-MsgGUID: idgDsCzOSomtSbUEqOFZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188669479"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:38:18 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIUuF-00000007W0X-1St9;
	Mon, 10 Nov 2025 18:38:15 +0200
Date: Mon, 10 Nov 2025 18:38:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] ADF41513/ADF41510 PLL frequency synthesizers
Message-ID: <aRIU94elwpjiUDMc@smile.fi.intel.com>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 03:44:43PM +0000, Rodrigo Alencar via B4 Relay wrote:
> This patch series adds support for the Analog Devices ADF41513 and ADF41510
> ultralow noise PLL frequency synthesizers. These devices are designed for
> implementing local oscillators (LOs) in high-frequency applications.
> 
> The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
> operates from 1 GHz to 10 GHz. Both devices feature exceptional phase noise
> performance and flexible frequency synthesis capabilities.
> 
> Key features supported by this driver:
> - Integer-N and fractional-N operation modes
> - Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-N)
> - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> - Programmable charge pump currents with 16x range
> - Digital lock detect functionality
> - Phase resync capability for consistent output phase
> - Clock framework integration for system clock generation
> 
> The series includes:
> 1. Core driver implementation with full register programming support
> 2. Device tree bindings documentation
> 3. IIO subsystem documentation with usage examples
> 
> The driver integrates with both the IIO subsystem (for direct hardware control)
> and the Linux clock framework (for use as a system clock source), providing
> flexibility for different use cases.

When cover letter is better than the commit message :-)

-- 
With Best Regards,
Andy Shevchenko



