Return-Path: <linux-iio+bounces-22135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A35B1530A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 20:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA076189166B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF3029ACF6;
	Tue, 29 Jul 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhf5H2tN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33914220680;
	Tue, 29 Jul 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814523; cv=none; b=mOGGcTCIRjt9BxeS2tYXFrvC+V0E51MoGPvvv6RwH0y3bXo2OG0IJ2ZsavKPrW1oyb90UL8N11KLd8KzJsmIsAxJ/jEdAOU62U8R/vINGGq2C8KPksV5gBF7VFDgSuoZYSBUtJde0jYeTWKEmgqBCFDstFsU7n4UTieZWvjMOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814523; c=relaxed/simple;
	bh=V6Dcqa0TG7W5slu9uXHtRB+QqM48OfTcq9W5IaelKrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD6tSPbfQnH5UxidPaBVV+Dxcwo4BQOIn8NLHUrjxMigrhp/tVczJzLX2LhijeoDn0KWFb/D9cSKhssN5aSMR4Swv7obqBuAb2H/xuK8QSRSiw/UyVoNM4l9UkxlkD68Cvd9X4UU8fLsvXFE/OJKZx+gM7aClQHtfjqFWt1ZtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhf5H2tN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA4BC4CEEF;
	Tue, 29 Jul 2025 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814523;
	bh=V6Dcqa0TG7W5slu9uXHtRB+QqM48OfTcq9W5IaelKrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bhf5H2tN9kMMxWl2WeZhvWPmpxfLH67XYeFVV/Xl0v3LAO5IKnbHUGx6cetAw8r0E
	 NelH/JRUL7KPtddjW2mY7kr7uscHlx82JXR8M/D7wnaN/BSVWG5YRbG2PwoySQDHVr
	 3FVSj7MEg1Sl4KKhtpobSnWImVZdjcdhMRfUBodtAxJ6oJYmzJ5W+HcvXMSM0TePYS
	 GqoloI3NFa22QSdSkQmso8fHGjMcWucCv9CBXLvVP//8Y3Q7ejE2jXgXsNFuQjlqWe
	 mvY6mquSuCyIyS4jxoOsNUCMvkQ/frlVHDw5PWcbWiVDFJYaMn7pdUYUtI991hiIgd
	 I1roqP1SAbJyQ==
Date: Tue, 29 Jul 2025 19:41:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, sboyd@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
 u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org
Subject: Re: [PATCH v2 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <20250729194150.1985404b@jic23-huawei>
In-Reply-To: <6ea0495e-21d8-41a8-b1b0-1c99c2929de5@collabora.com>
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
	<20250722101317.76729-2-angelogioacchino.delregno@collabora.com>
	<20250722150930.00000a2f@huawei.com>
	<6ea0495e-21d8-41a8-b1b0-1c99c2929de5@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +/**
> >> + * struct spmi_subdevice - Basic representation of an SPMI sub-device
> >> + * @sdev:	Sub-device representation of an SPMI device
> >> + * @devid:	Platform Device ID of an SPMI sub-device
> >> + */
> >> +struct spmi_subdevice {
> >> +	struct spmi_device	sdev;  
> > 
> > Having something called a subdevice containing an instance of a device
> > does seem a little odd.  Maybe the spmi_device naming is inappropriate after
> > this patch?
> >   
> 
> A SPMI Sub-Device is a SPMI Device on its own, but one that is child of a device.
> 
> Controller -> Device -> Sub-Device
> 
> Before this version, I initially added devid to spmi_device, but that felt wrong
> because:
>   1. Sub-devices are children of devices (though, still also devices themselves)
>   2. The devid field would be useless in "main" SPMI devices (struct spmi_device)
>      and would not only waste (a very small amount of) memory for each device but,
>      more importantly, would confuse people with an unused field there.
> 
> So, this defines a SPMI Sub-Device as an extension of a SPMI Device, where:
>   - Device has controller-device numbers
>   - Sub-device has controller-device.subdev_id numbers.
> 
> I don't really see any cleaner way of defining this, but I am completely open to
> any idea :-)
I was thinking it was a specialization at the same level as the old spmi_device
(not it's child). As a child this is fine.

Just showing my complete lack of knowledge of the SPMI code :)

Jonathan

> 
> Cheers,
> Angelo
> 
> 


