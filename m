Return-Path: <linux-iio+bounces-6829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0A91559B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4897F1C22C49
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463819F462;
	Mon, 24 Jun 2024 17:41:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F4A19EEDF;
	Mon, 24 Jun 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250897; cv=none; b=H/NKo5FqgJr+9RCzkjaWbpk/23FoSzIo4io8tC+PVAAc/HQMTdrQZGRuvIrk/TMqL9VmECmLqrN5vCW2tc6NW3XtSZlb5uh+MmlCJKg2KgkmUJTs2rcpWvtBZwRoegvtn3VSzACMh1Efjgb0WDw3MLTp0y3+hZpqV0Rsx1vLpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250897; c=relaxed/simple;
	bh=meVsscu6NP0QHL0EuUs7sm7KJiFpTQ6TVGUUGb8vcN0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juB32UUv3W7pHr7PIeZanGxJKzoabnCH/G/iPklQ4HLmsal9++HDMKeAVHlGayEP6SMl/aqGruWLR/xMDhlmQTm5HnxycCzhzYWpL52kpb/50az1fXDBkGRUM4uf2bqIGZkADhVIDm4vc2OQECL0X0IuevL9hoddPT/UG+GV3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W7FbC65pgz6K9fM;
	Tue, 25 Jun 2024 01:39:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A968140C98;
	Tue, 25 Jun 2024 01:41:31 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 18:41:30 +0100
Date: Mon, 24 Jun 2024 18:41:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 7/8] iio: add sd modulator generic iio backend
Message-ID: <20240624184129.000065e4@Huawei.com>
In-Reply-To: <2dbd160b-135e-4882-9fd3-9d921742f49d@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	<20240618160836.945242-8-olivier.moysan@foss.st.com>
	<20240623161150.358f95bf@jic23-huawei>
	<2dbd160b-135e-4882-9fd3-9d921742f49d@foss.st.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +};
> >> +
> >> +static const struct iio_backend_ops sd_backend_ops = {
> >> +	.enable = sd_backend_enable,
> >> +	.disable = sd_backend_disable,
> >> +	.read_raw = sd_backend_read,
> >> +};
> >> +
> >> +static int iio_sd_backend_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct regulator *vref;
> >> +	struct iio_sd_backend_priv *priv;
> >> +	int ret;
> >> +
> >> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return -ENOMEM;
> >> +
> >> +	vref = devm_regulator_get_optional(dev, "vref");  
> > 
> > New devm_regulator_get_enable_read_voltage() slightly simplifies this
> > and means you don't need to keep vref around.
> >   
> >> +	if (IS_ERR(vref)) {
> >> +		if (PTR_ERR(vref) != -ENODEV)
> >> +			return dev_err_probe(dev, PTR_ERR(vref), "Failed to get vref\n");
> >> +	} else {
> >> +		ret = regulator_get_voltage(vref);  
> > You haven't turned it on so it's not guaranteed to give you a useful
> > answer.
> >   
> 
> My understanding is that regulator_get_voltage() always returns the 
> regulator voltage, whatever the regulator state, as documented in the 
> API description:
> "* NOTE: If the regulator is disabled it will return the voltage value.
> * This function should not be used to determine regulator state."
> 
> So, my logic was to enable the regulator only when requested, through 
> enable/disable callbacks to manage power.
> 
> Please, let me know if I missed something here.

Ah ok. I had a vague and it seems incorrect recollection that you had
to turn the regs on to get voltage in some cases.  Ah well. Clearly not :)
What you have is fine.  Add a comment though just so no one replaces
this code with the helper.  

Jonathan

 

