Return-Path: <linux-iio+bounces-27736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 788CED1DA52
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FB953007C29
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0B1389DF6;
	Wed, 14 Jan 2026 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdZMar8h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E3387575;
	Wed, 14 Jan 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383760; cv=none; b=Tx2h1lLPh6GLoDLe4kZ3S+LWjWNK9lD4prbxvrMTvSiqfuhj6pBTPYPCwWRzGhucwxM5CMBDxevD2zfKJs98QOytiJajr/0h81BpL+RAbLoWZBsvcyQCM179kdegJFmw6n2I+GS8/2RLS5iZXWS79tZR2hqTpaO7Ae2U8yEQaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383760; c=relaxed/simple;
	bh=MAXJVCpBtOrZVOvzDnY3H5JvAag0UgPrscTnLJ7u8yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIa+NazbL2+jSVMbJz+mkTaxqWLC2EJTK+eefbF00D17CqnHRPll91teFG2hPpxOxqhEB7apQ9g3+xy98/BnH2cQNE47mbZQWE8qgudh/i4peQpNn+F2ar7J+7JKe3jNy1mpfPMNdlVo/VJEK4R5ALxy05EfL2Noithw+LH53xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdZMar8h; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768383758; x=1799919758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MAXJVCpBtOrZVOvzDnY3H5JvAag0UgPrscTnLJ7u8yk=;
  b=QdZMar8hSLxBf3CMnVgeNwwmdg85pdwe37VW3yeAGfyJAJ+GNDuq7mbI
   N7ErM3WCori6HpJBhujyfiwBz8Eu+bTXMju11omzDGKcX+JJYyszL7CEr
   PpPKDA1L8i09U17U5CW+obbti9NIS79DsmDeY/FXDzQu3ODXCYVDJG4gq
   5162KpmqMSoQ0MU36VxCWic+J9JdRkTarQQETFPcZzssuPGDyS0f6Gw9Y
   HQ2eGpnDzy0hpOP9OpPQlctiDfdLVtReOaiI1x3iGSlwPG069weCt7Fb/
   IQmp8o4yBNSOeaqS2rqoH7PA0PT1echDd0YATgQtYEm/aNoAuU5FBY8Ix
   g==;
X-CSE-ConnectionGUID: NCrt6gNZTdiM2wKr+3UMPQ==
X-CSE-MsgGUID: 3CdrlrGAQiiGwITtj6sDaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87094042"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="87094042"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:42:27 -0800
X-CSE-ConnectionGUID: ZQxiu0mMRRurcnuwza5aGA==
X-CSE-MsgGUID: /xvIp0n/QjW4Ffw80xNq+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="203850428"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:42:20 -0800
Date: Wed, 14 Jan 2026 11:42:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
	sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v7 05/10] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aWdk-RP-59cJeCBo@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
 <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
 <aWdbPze-f_2_5EbL@smile.fi.intel.com>
 <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
 <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
 <647b4acc-3310-4329-ac7a-77e86bab74a3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647b4acc-3310-4329-ac7a-77e86bab74a3@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 10:09:45AM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/01/26 10:07, Andy Shevchenko ha scritto:
> > On Wed, Jan 14, 2026 at 10:03:57AM +0100, AngeloGioacchino Del Regno wrote:
> > > Il 14/01/26 10:00, Andy Shevchenko ha scritto:
> > > > On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
> > > > > Il 14/01/26 09:56, Andy Shevchenko ha scritto:
> > > > > > On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:

...

> > > > > > > +	struct regmap_config sdam_regmap_config = {
> > > > > > > +		.reg_bits = 16,
> > > > > > > +		.val_bits = 8,
> > > > > > 
> > > > > > > +		.max_register = 0x100,
> > > > > > 
> > > > > > Are you sure? This might be a bad naming, but here max == the last accessible.
> > > > > > I bet it has to be 0xff (but since the address is 16-bit it might be actually
> > > > > > 257 registers, but sounds very weird).
> > > > > 
> > > > > Yes, I'm sure.
> > > > 
> > > > So, what is resided on address 0x100 ?
> > > 
> > > I don't remember, this is research from around 5 months ago, when I've sent
> > > the v1 of this.
> > > 
> > > If you really want though, I can incorrectly set max_register to 0xff.
> > 
> > Why incorrectly? Can you dig into the datasheet and check, please? We don't
> > know what is the 0x100 address means.
> 
> I don't have any datasheets for Qualcomm IPs.

Hmm... Can we have somebody from QC to check on this?
Perhaps Dmitry?

> > > > > > > +		.fast_io = true,
> > > > > > > +	};

-- 
With Best Regards,
Andy Shevchenko



