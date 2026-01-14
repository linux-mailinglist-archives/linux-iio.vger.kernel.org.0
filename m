Return-Path: <linux-iio+bounces-27757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C25D1DE5E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3390B3022F08
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4AD38F23D;
	Wed, 14 Jan 2026 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnO5CjoR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107C38E12E;
	Wed, 14 Jan 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385365; cv=none; b=E/GBbPpK+CF9xexSTRsSoQX27Dw/w/rnV7Dn8+ewU9hbfzoLD2dloK/bsY3oG5l2O7R5CwnEC3zglCB03ghTRQugf+O4MtJ4r0/x14Xd0KQDA8PivzisSQ7mFrUBYdo1Zr5+/mtjjoGs7geIcqEYnDW15TZWTfP2tBH5Qt6lKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385365; c=relaxed/simple;
	bh=mVfiznKpM9yXiJNBoD3mVJIRyBtj3lhbh1JGsuuuN9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOIgQzz9LCr9YtmIPNuC98q5PPGqpXUBJw625edFl3e1ac4Vmk6nI9iU0bKMNPCWIbvvVMwp5Q6A0qB+6rmke314zVI837Hsh0su9uaKzQzkvZ1ZsbucqUzv9dP1jmJVV6NZgcHItlyiiqX/ZGH6TNwMotas9HXtbRIbZuB1oVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnO5CjoR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385364; x=1799921364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mVfiznKpM9yXiJNBoD3mVJIRyBtj3lhbh1JGsuuuN9g=;
  b=DnO5CjoR9d+yp25a+zms9j7s9lZx3NPeDx1T4jtlWV/OlYMUkskArozU
   uphAuS7qfrrOp4onyLI2KHojEJlYQ6DrBJ4qK1nriYrGNcOLq5XwQ1T/7
   o8onKYGxRvmgJqL+60IPBdEIKuTID9z+XqE+PgNTh4X0CHBhNsuBZzEsN
   wrmzyMZTr0qP0vfwbhprRRPVgjusA+q3RMigEZautLWtdNT7+xMNAJgaz
   M5mG5Vqy1Bk78nxBVV2hVgowC9dYazg5AQgUnq2aY/riQCBBhm0GwPRTu
   qWDFE3bPXtMeIMkcCGqdX0RCORH6L/R3A0kFkdUf2dt6/8TsBlyLMKmEU
   Q==;
X-CSE-ConnectionGUID: QzidEKrCQqywFoEvvMIDaQ==
X-CSE-MsgGUID: hHxC7f/QT9qE4H8kD+6Z6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="79977251"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="79977251"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:09:23 -0800
X-CSE-ConnectionGUID: nCgo7y7nS+SB6ivhyZ/2wA==
X-CSE-MsgGUID: 9QmYMU7TQKK9zutJt+nHog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209484837"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:09:17 -0800
Date: Wed, 14 Jan 2026 12:09:15 +0200
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
Message-ID: <aWdrS7poHyhTzyfN@smile.fi.intel.com>
References: <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
 <aWdbPze-f_2_5EbL@smile.fi.intel.com>
 <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
 <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
 <647b4acc-3310-4329-ac7a-77e86bab74a3@collabora.com>
 <aWdk-RP-59cJeCBo@smile.fi.intel.com>
 <ae46b504-58d3-4042-be05-f31e9e01091b@oss.qualcomm.com>
 <aWdn_j7SOKq97vpY@smile.fi.intel.com>
 <dd877ea8-b634-4cc9-8280-08663f82776d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd877ea8-b634-4cc9-8280-08663f82776d@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 11:04:30AM +0100, Konrad Dybcio wrote:
> On 1/14/26 10:55 AM, Andy Shevchenko wrote:
> > On Wed, Jan 14, 2026 at 10:47:20AM +0100, Konrad Dybcio wrote:
> >> On 1/14/26 10:42 AM, Andy Shevchenko wrote:
> >>> On Wed, Jan 14, 2026 at 10:09:45AM +0100, AngeloGioacchino Del Regno wrote:
> >>>> Il 14/01/26 10:07, Andy Shevchenko ha scritto:
> >>>>> On Wed, Jan 14, 2026 at 10:03:57AM +0100, AngeloGioacchino Del Regno wrote:
> >>>>>> Il 14/01/26 10:00, Andy Shevchenko ha scritto:
> >>>>>>> On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
> >>>>>>>> Il 14/01/26 09:56, Andy Shevchenko ha scritto:
> >>>>>>>>> On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:

...

> >>>>>>>>>> +	struct regmap_config sdam_regmap_config = {
> >>>>>>>>>> +		.reg_bits = 16,
> >>>>>>>>>> +		.val_bits = 8,
> >>>>>>>>>
> >>>>>>>>>> +		.max_register = 0x100,
> >>>>>>>>>
> >>>>>>>>> Are you sure? This might be a bad naming, but here max == the last accessible.
> >>>>>>>>> I bet it has to be 0xff (but since the address is 16-bit it might be actually
> >>>>>>>>> 257 registers, but sounds very weird).
> >>>>>>>>
> >>>>>>>> Yes, I'm sure.
> >>>>>>>
> >>>>>>> So, what is resided on address 0x100 ?
> >>>>>>
> >>>>>> I don't remember, this is research from around 5 months ago, when I've sent
> >>>>>> the v1 of this.
> >>>>>>
> >>>>>> If you really want though, I can incorrectly set max_register to 0xff.
> >>>>>
> >>>>> Why incorrectly? Can you dig into the datasheet and check, please? We don't
> >>>>> know what is the 0x100 address means.
> >>>>
> >>>> I don't have any datasheets for Qualcomm IPs.
> >>>
> >>> Hmm... Can we have somebody from QC to check on this?
> >>> Perhaps Dmitry?
> >>
> >> 0xe6 is the last usable register today
> > 
> > Thanks for checking!
> > 
> >> But I wouldn't mind either 0xff or 0x100 because I don't want
> >> anyone to pull their hair out if a regmap access is dropped some day..
> > 
> > There is actually about the exact window size where registers are belong to the
> > same entity (subdevice). As in the HW world most of the things are stuck with
> > power-of-two numbers, and taking into account the naming of the field, I do not
> > believe one provides a 257 (256 + 1 = 2⁸ + 1) register _windows_ ("s" is also
> > important here, as it points out to the pattern) for the subdevices. I bet the
> > 0xff, i.e. 256, is the *correct* window from the HW perspective.
> 
> Right, [0x100n, 0x100n + 0xff] inclusive is the reserved register window
> for all Qualcomm PMIC peripherals, so I guess 0xff is the correct choice
> here

Thanks for the clarification, v8 addresses that, so seems to me good to go.

> If a peripheral is more complex, it's split into a couple of these
> same-sized blocks

Right.

-- 
With Best Regards,
Andy Shevchenko



