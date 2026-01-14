Return-Path: <linux-iio+bounces-27704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED662D1D404
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97E7C3007F2E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3335E531;
	Wed, 14 Jan 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfCP6TXN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00A37BE85;
	Wed, 14 Jan 2026 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380692; cv=none; b=CZRXwbPqUrCQLRwpsPzvJ0f3fWrVXJSj7PzsJdBWl55GAtchbU6CcJJGiI1Vgon/GdVcq6W/Ve822I5hel0rZn0ZnZHjyTdFUh+uzwAe+PkJH1wK8za6nXmX6ifnLF2edcf5CLi0MY2NAO94hAvMt0Jx7HWV6FJhbmRDwN/Qv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380692; c=relaxed/simple;
	bh=dgAZttYLRaCe9m5TzCKJ6+TFt2wSCjRKjFsbXPtQkvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbk4alvS+wOkHrwOljBO0YFCSQL8bgP/7I1ATiMBkysFrNf8oKFAfnNVsA60SBNHBlsZv5V+s3b1FZs1i6XifCgKXJGGoGRZ1yQuRA8BB7vvYOCkzxvMmHIw5tumZynpb9ILEm5RmACvgG1vug2Px+nx4QVig1KVxAV2i30lMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfCP6TXN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768380688; x=1799916688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dgAZttYLRaCe9m5TzCKJ6+TFt2wSCjRKjFsbXPtQkvI=;
  b=WfCP6TXNOWALkwSHysplicCCwqqPH72y5yOYtzh3JiPyfa6xhj9AMVtW
   vZ2lIOnYwqHjT9YsboB+U00OSh02aApQ18X1pSjUA2V4+kp9u6vRwcVf9
   Dgf7SGm6/0UBvY7wDwtk4x22s0T46b7wpL76BUDiimnRxGYucH7I46uZH
   2Gkq81RJ03LBeE0edYtam9HVf1UnYhGQIidSZ4XkD4hvTRCL5Wvirj1oK
   5HbnFd0e07DT/KNCX3KXzo3Gswi3uXvrP2x3hvAUDnlh88aLndxNC2H6H
   kPhkjluj02dSbDGBKZT3Cs8UJi+Zkmxt33OI3mDT1bBkvKuG44tnCRv+x
   A==;
X-CSE-ConnectionGUID: 9a68fWfAQuOLPi9xF2558Q==
X-CSE-MsgGUID: UThUJun0TtebpZ1uUZaVGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="95150901"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="95150901"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:51:23 -0800
X-CSE-ConnectionGUID: w5KBXLSkT5GwlKETmfz/1g==
X-CSE-MsgGUID: 20YHxAaLTi6mkDSnYbmoqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209465922"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:51:17 -0800
Date: Wed, 14 Jan 2026 10:51:15 +0200
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
	linux-pm@vger.kernel.org, kernel@collabora.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v7 04/10] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <aWdZAyqQQ4KwCJx-@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114083957.9945-5-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:39:51AM +0100, AngeloGioacchino Del Regno wrote:
> Some devices connected over the SPMI bus may be big, in the sense
> that those may be a complex of devices managed by a single chip
> over the SPMI bus, reachable through a single SID.
> 
> Add new functions aimed at managing sub-devices of a SPMI device
> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
> for adding a new subdevice and removing it respectively, and also
> add their devm_* variants.
> 
> The need for such functions comes from the existence of	those
> complex Power Management ICs (PMICs), which feature one or many
> sub-devices, in some cases with these being even addressable on
> the chip in form of SPMI register ranges.
> 
> Examples of those devices can be found in both Qualcomm platforms
> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
> sub-devices, and in newer MediaTek platforms showing similar HW
> features and a similar layout with those also having many subdevs.
> 
> Also, instead of generally exporting symbols, export them with a
> new "SPMI" namespace: all users will have to import this namespace
> to make use of the newly introduced exports.

...

> +static void devm_spmi_subdevice_remove(void *res)

For better readability we usually call the variable with a meaningful name, and
sub_sdev here seems the best.

> +{
> +	spmi_subdevice_remove(res);
> +}

...

> + * Pointer to newly allocated SPMI sub-device for success or negative ERR_PTR.

This is "negative ERR_PTR" nonsense. Either "negative errno" or "error pointer".
Or something alike.

> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent)
> +{
> +	struct spmi_subdevice *sub_sdev;
> +	struct spmi_device *sdev;
> +	int ret;
> +
> +	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
> +	if (!sub_sdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
> +	if (ret < 0) {
> +		kfree(sub_sdev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	sdev = &sub_sdev->sdev;
> +	sdev->ctrl = sparent->ctrl;
> +	device_initialize(&sdev->dev);
> +	sdev->dev.parent = &sparent->dev;
> +	sdev->dev.bus = &spmi_bus_type;
> +	sdev->dev.type = &spmi_subdev_type;

> +	sub_sdev->devid = ret;

Too far, may be prone to mistakes in the future. The rewritten one would look
like

	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
	if (!sub_sdev)
		return ERR_PTR(-ENOMEM);

	sdev = &sub_sdev->sdev;
	sdev->ctrl = sparent->ctrl;

	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
	if (ret < 0) {
		kfree(sub_sdev);
		return ERR_PTR(ret);
	}
	sub_sdev->devid = ret;

	device_initialize(&sdev->dev);
	sdev->dev.parent = &sparent->dev;
	sdev->dev.bus = &spmi_bus_type;
	sdev->dev.type = &spmi_subdev_type;


> +	sdev->usid = sparent->usid;
> +
> +	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
> +	if (ret)
> +		goto err_put_dev;
> +
> +	ret = device_add(&sdev->dev);
> +	if (ret) {
> +		dev_err(&sdev->dev, "Can't add device, status %pe\n", ERR_PTR(ret));
> +		goto err_put_dev;
> +	}
> +
> +	return sub_sdev;
> +
> +err_put_dev:
> +	put_device(&sdev->dev);
> +	return ERR_PTR(ret);
> +}

-- 
With Best Regards,
Andy Shevchenko



