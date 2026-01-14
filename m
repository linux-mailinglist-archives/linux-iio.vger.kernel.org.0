Return-Path: <linux-iio+bounces-27740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF035D1DBCB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5804A3025114
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17893806C3;
	Wed, 14 Jan 2026 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ay9pnqSD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AC34F46C;
	Wed, 14 Jan 2026 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384520; cv=none; b=IZTsWP+xSsZcF3N8NPDt35XjJQ2SonpTJZ1YM3mX1GQKcEp1fQFSj9/snXHCfS2qYaS+0KBYePXMyXVm752AbLnKd/fu/pWBGKRZH3nyE+qS0WocuV8zgtaw9CwuzdYGwsxcPmHEEUzn+2WF2GvRGsUgRFeZMo9krkLBxOp00vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384520; c=relaxed/simple;
	bh=j1XcnslA3MmTMPnCgBkjQFe0gIruJbeqNyM3JJqammU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuVOioX/1idAD+Ihgz14EZZr5qHW49LQJ8bFXCKfyViAtbowGXymM0GWEXWjk79ynZjI7q1ml1EUzEpPN5LK504UXIO3Dlwivn2pAeBMldKR2AV1OwDke5BThwanZrO5n0GOAo55H1texZAWO9DUKjnz67/R4hsMRnVH4Qcm5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ay9pnqSD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768384519; x=1799920519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j1XcnslA3MmTMPnCgBkjQFe0gIruJbeqNyM3JJqammU=;
  b=Ay9pnqSD7vpVAD9CBq6zGz0B/YWwisuNOlNGqFLVkiARloBRwMjUQo61
   2UhsypNzJu0sfKkLgmmI4zuuPf4lJWbDDuDHjCY2KEPEa7vIeo+6lctlb
   zs0nPOp4P2aYejBUkPMaplMvSbiV8359WMOSSnA8eDEN+M7Gejp16pLQz
   NTn34Dn+A0l/j4F5CR4erDeaajvARWGkc3cNmB+nTbDJY/lRp+mcVtQTq
   0lef2lZGicAEF4LS9Bii/97Dw3URxsvN/ypx8pCk2acPgWEPJHpRLR3XW
   nutggk3lMgkX6GepWZU2Kldx8kf7OU+i9QvgSugfsLue8S/f0balEim37
   A==;
X-CSE-ConnectionGUID: wFFthoyPSTWHmxrvHdt2Hw==
X-CSE-MsgGUID: sMeIhWO6QGCDAGK2/Mp88w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68887287"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68887287"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:55:18 -0800
X-CSE-ConnectionGUID: epqCc/UIRPC/tRMI6XYhsA==
X-CSE-MsgGUID: GEAk1xrtRTuH3pbsAc6PgQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:55:12 -0800
Date: Wed, 14 Jan 2026 11:55:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
	sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v7 05/10] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aWdn_j7SOKq97vpY@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
 <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
 <aWdbPze-f_2_5EbL@smile.fi.intel.com>
 <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
 <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
 <647b4acc-3310-4329-ac7a-77e86bab74a3@collabora.com>
 <aWdk-RP-59cJeCBo@smile.fi.intel.com>
 <ae46b504-58d3-4042-be05-f31e9e01091b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae46b504-58d3-4042-be05-f31e9e01091b@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 10:47:20AM +0100, Konrad Dybcio wrote:
> On 1/14/26 10:42 AM, Andy Shevchenko wrote:
> > On Wed, Jan 14, 2026 at 10:09:45AM +0100, AngeloGioacchino Del Regno wrote:
> >> Il 14/01/26 10:07, Andy Shevchenko ha scritto:
> >>> On Wed, Jan 14, 2026 at 10:03:57AM +0100, AngeloGioacchino Del Regno wrote:
> >>>> Il 14/01/26 10:00, Andy Shevchenko ha scritto:
> >>>>> On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
> >>>>>> Il 14/01/26 09:56, Andy Shevchenko ha scritto:
> >>>>>>> On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:

...

> >>>>>>>> +	struct regmap_config sdam_regmap_config = {
> >>>>>>>> +		.reg_bits = 16,
> >>>>>>>> +		.val_bits = 8,
> >>>>>>>
> >>>>>>>> +		.max_register = 0x100,
> >>>>>>>
> >>>>>>> Are you sure? This might be a bad naming, but here max == the last accessible.
> >>>>>>> I bet it has to be 0xff (but since the address is 16-bit it might be actually
> >>>>>>> 257 registers, but sounds very weird).
> >>>>>>
> >>>>>> Yes, I'm sure.
> >>>>>
> >>>>> So, what is resided on address 0x100 ?
> >>>>
> >>>> I don't remember, this is research from around 5 months ago, when I've sent
> >>>> the v1 of this.
> >>>>
> >>>> If you really want though, I can incorrectly set max_register to 0xff.
> >>>
> >>> Why incorrectly? Can you dig into the datasheet and check, please? We don't
> >>> know what is the 0x100 address means.
> >>
> >> I don't have any datasheets for Qualcomm IPs.
> > 
> > Hmm... Can we have somebody from QC to check on this?
> > Perhaps Dmitry?
> 
> 0xe6 is the last usable register today

Thanks for checking!

> But I wouldn't mind either 0xff or 0x100 because I don't want
> anyone to pull their hair out if a regmap access is dropped some day..

There is actually about the exact window size where registers are belong to the
same entity (subdevice). As in the HW world most of the things are stuck with
power-of-two numbers, and taking into account the naming of the field, I do not
believe one provides a 257 (256 + 1 = 2⁸ + 1) register _windows_ ("s" is also
important here, as it points out to the pattern) for the subdevices. I bet the
0xff, i.e. 256, is the *correct* window from the HW perspective.

-- 
With Best Regards,
Andy Shevchenko



