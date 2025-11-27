Return-Path: <linux-iio+bounces-26525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFCC8FF46
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 19:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24CFA4E34FC
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 18:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DF301007;
	Thu, 27 Nov 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KisMf1vu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258879C8;
	Thu, 27 Nov 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764269715; cv=none; b=sc5Do5MaGEDkG83GJLtZTzh1x+/CCzosHK1lv4yYM6K0egJwTs6iMdg+mb5eTLICgGYDIvAcfjAYPra19rfprqQZVMnSbAgx4FBkdJniCquv3r8DAJGWO4c6qF/cqHoLoPbz+Q5gMf+Tg+89ThruZDVoVff2muG0TrRbTwcq8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764269715; c=relaxed/simple;
	bh=9OGJoKTTeNxpXd4hc6X0kluLEJb7Wr89HVeKcgy60A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4dPqvuK15d+3Y/lan6xkV23Jrpps922Ba1JWPn8malNOViZ7koC5oevobCeZWUMpgl1oeyrclXRInbau7TTK0jpbJ9VP+PGy2qSkmF0S7NWBvGbljdy+QZMqK55vqYKyNu/Ej7ixhvGoKaeexGeYbjATK2zdQDasqpD8ODhALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KisMf1vu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764269714; x=1795805714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9OGJoKTTeNxpXd4hc6X0kluLEJb7Wr89HVeKcgy60A0=;
  b=KisMf1vu5yWDxl3sKOZiy4n948PZURq7GVrdpwxfw1ubml2PKKxBOVUv
   YUS8stGmX74xehqtnhD86WfNgE165thsiN59fOb8Ql7HLTyz+pXT58z5p
   ZJrGMvZi4EnAi/rzQOP5oynzfzyzkRnBzOtQvjgKwIE5KStlYtqWCk9y7
   W2dqiPQT9EalSSF5Uf63osIb8kpUH7sHxgmbz85KGUO5RGHGEW0rUpRUx
   X0F2GO1tt94dlPm1CwK2d/2Asmscsr4bUe4nvlx1lU6tr83aSZkbv3uJM
   GfHUcSt4JqJAy0DXvRdoBBXCXj7LToxzLdGWqwRNIIC3uWOeLssoe94mg
   A==;
X-CSE-ConnectionGUID: 2P4BxRLQQz6RQ6c2cGvZ6Q==
X-CSE-MsgGUID: JLEBgqDMRnmCawtgE8Z2dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="77005533"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="77005533"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:55:13 -0800
X-CSE-ConnectionGUID: zo+cvfkTRcKAgq9F5Plxnw==
X-CSE-MsgGUID: 3AiLodaiQaqJirxYhFXt5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193092258"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 10:55:09 -0800
Date: Thu, 27 Nov 2025 20:55:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rudraksha Gupta <guptarud@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio: accel: Prevent NULL pointer dereference in
 interrupt setup
Message-ID: <aSieijZt117wOh-6@smile.fi.intel.com>
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
 <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
 <d3318386-2646-4f1c-ab4b-6ae3bc71e9bb@oss.qualcomm.com>
 <aSWPnRBRdPS8vnir@smile.fi.intel.com>
 <61e860e7-fc3b-49ad-bf6a-9745f205d52b@gmail.com>
 <c627fc05-6980-44bd-bdde-4750b3bafe2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c627fc05-6980-44bd-bdde-4750b3bafe2d@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 07:38:45PM +0100, Konrad Dybcio wrote:
> On 11/25/25 10:23 PM, Rudraksha Gupta wrote:

[...]

> We won't be taking any non-urgent patches until rc1 drops (~3 weeks)
> so if the IIO folks decide to pick it up in meantime, just send it as
> one

AFAIK IIO is closed as well till v6.19-rc1.
The patch can be taken to a deferred queue though,
but in the result it will wait for a new cycle.

-- 
With Best Regards,
Andy Shevchenko



