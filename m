Return-Path: <linux-iio+bounces-27863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B69D33351
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 16:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30123057472
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E0336EE0;
	Fri, 16 Jan 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9StoE4y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F127146A;
	Fri, 16 Jan 2026 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577328; cv=none; b=URws/aNoaYwBZYzPuP2uSVCwaSIw7X7kMQ8aTHE45B609bHbGNcLQ8TbCZ8i2vALhvjdGz4cnrX0w/w/ywecuvA0HjWREbYaF2Dwl5CxFrfNbRbn0FgSavEs2HSp4MDHb8Ca/Wcm2lDzzuynxa2ba7bR7xhWxgQcK2ck0J7ktMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577328; c=relaxed/simple;
	bh=vecJKjAgtk9LRG+wn5qPyq+SGBuKDoB+drYl7G6aTYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLulWRZuJlja1OmPdAMwUFbLi08iLdnRCiTyEe5Ysl3vWOWSR1NafWwGVswPw4DDW5VaX7WARzz8Cv2wBorGd2dufg4x2cmceCmWldYB1QJg+mZwpLOwzqc1bOkTit5KF8H8XF22D6Te2ClevydSBFqL9kHr9b+TJ9NaX85pm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9StoE4y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768577326; x=1800113326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vecJKjAgtk9LRG+wn5qPyq+SGBuKDoB+drYl7G6aTYQ=;
  b=A9StoE4yVEWjbn4tu2dqzkjy/HIWiqg4DB3VGmoOAlqKRmiW5Om/pay4
   9GhpzMFs7Aj2VOJe5CRE0jvWx2DFB1BHZhZhwDl+UjY75Pb9yg1ahuvBq
   xJKMdkT0/MqLG0sBKY77TdQoKdIwbOIEuJfJWHujaO1DIeMwUWUtt1BkZ
   0IFxXquvcqAumnir+toREEvhwh4dxcklrjwI6YHXvPP1W5qGmId/OpzSz
   sYbM/bXvBwRs0pum5oJqLZ71IVCNg+32ye31V792dWHgqTAy18dqK68bh
   NibAMSaSh0F37xprcm3/U5YKCgmBtwBU+cYjKWz3OQtHdL2fiX0kgIPK6
   w==;
X-CSE-ConnectionGUID: W20zxn+cQ+2q6CFfr4MbkQ==
X-CSE-MsgGUID: bHhfu5f1SpaMDIK+nXq7Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69625319"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="69625319"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:28:46 -0800
X-CSE-ConnectionGUID: rzSpe6sIS8O8oJrA62xAcw==
X-CSE-MsgGUID: hdH5MpoMTkyvQGWg/q4rUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="205543946"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:28:42 -0800
Date: Fri, 16 Jan 2026 17:28:40 +0200
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
Subject: Re: [PATCH v4 7/7] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Message-ID: <aWpZKO1Jwi8n4NSh@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-7-dbb7d6782217@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-adf41513-iio-driver-v4-7-dbb7d6782217@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 16, 2026 at 02:32:26PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add ABI documentation file for PLL/DDS devices with frequency_resolution
> sysfs entry attribute used by ADF4350 and ADF41513

In this and previous patch the commit messages miss the last period in them.

-- 
With Best Regards,
Andy Shevchenko



