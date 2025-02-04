Return-Path: <linux-iio+bounces-14973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38CA274B0
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176CD3A1CC6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9251213E99;
	Tue,  4 Feb 2025 14:45:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB5213E6D;
	Tue,  4 Feb 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680303; cv=none; b=WwvYA9iY/a/MFPqAhkhyB8w8r0iP9THAxUNqz95ZIGT19nXedfnjzo/AxfVADGXJBrzQFSswoMZsPGYB+xJAi76iMWzSNpBhfMuUgx85BIiZnuOpqybL/6xwj1ocIDEyDf4HedppLk7cCcuZ3qUWBaHGp1rP9rX8xtBJ0CMQZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680303; c=relaxed/simple;
	bh=Al09zTPmds8XPTTGdnYx2Vrxx4rrbmGm90vzgpxyLzg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae8oEdo++9yhb8ixpn66zFDEhNrOK00Z6XyYO723ywXsge4fFD+xy9KYs+wrL9VyhjBaMiEPaTB5n16GDRdTyPcfj7ciQ/KMGMHAYxXHCDPgsIOgh5zFzYaB5xxzEzQbP20Rz0sLZvZE0Gs64HJjjkZsrrPTyKQGhqxsf9Eyggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnR2Z2DCnz6J9yR;
	Tue,  4 Feb 2025 22:44:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EECF140B55;
	Tue,  4 Feb 2025 22:44:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 15:44:58 +0100
Date: Tue, 4 Feb 2025 14:44:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <ulf.hansson@linaro.org>, <linux-iio@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Claudiu
 Beznea" <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] iio: adc: rzg2l_adc: Drop
 devm_pm_runtime_enable()
Message-ID: <20250204144457.00000248@huawei.com>
In-Reply-To: <427572c8-72b7-41fa-b065-fcb398a30779@tuxon.dev>
References: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com>
	<20250117114540.289248-2-claudiu.beznea.uj@bp.renesas.com>
	<427572c8-72b7-41fa-b065-fcb398a30779@tuxon.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 14:25:38 +0200
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Jonathan,
> 
> On 17.01.2025 13:45, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > 
> > On all systems where the rzg2l_adc driver is used, the ADC clocks are part
> > of a PM domain. The code that implements the PM domains support is in
> > drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
> > being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> > domains support is registered with GENPD_FLAG_PM_CLK which, according to
> > the documentation, instructs genpd to use the PM clk framework while
> > powering on/off attached devices.
> > 
> > During probe, the ADC device is attached to the PM domain
> > controlling the ADC clocks. Similarly, during removal, the ADC device is
> > detached from the PM domain.
> > 
> > The detachment call stack is as follows:
> > 
> > device_driver_detach() ->
> >   device_release_driver_internal() ->
> >     __device_release_driver() ->
> >       device_remove() ->
> >         platform_remove() ->
> >           dev_pm_domain_detach()
> > 
> > During driver unbind, after the ADC device is detached from its PM domain,
> > the device_unbind_cleanup() function is called, which subsequently invokes
> > devres_release_all(). This function handles devres resource cleanup.
> > 
> > If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
> > triggers the action or reset function for disabling runtime PM. This
> > function is pm_runtime_disable_action(), which leads to the following call
> > stack of interest when called:
> > 
> > pm_runtime_disable_action() ->
> >   pm_runtime_dont_use_autosuspend() ->
> >     __pm_runtime_use_autosuspend() ->
> >       update_autosuspend() ->
> >         rpm_idle()
> > 
> > The rpm_idle() function attempts to runtime resume the ADC device. However,
> > at the point it is called, the ADC device is no longer part of the PM
> > domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> > APIs directly modifies hardware registers, the
> > rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> > being enabled. This is because the PM domain no longer resumes along with
> > the ADC device. As a result, this leads to system aborts.
> > 
> > Drop the devres API for runtime PM enable along with the other devres APIs
> > after it (devm_request_irq(), devm_register_iio_device()).
> > 
> > Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---  
> 
> As of my understanding, currently there is is no conclusion from the
> discussion at [1]. If it's not too early in the discussion, can you please
> let me know how would you prefer to go forward for fixing this driver?
> 

Quickest might be to propose a patch similar to the one for i2c that thread
references. Post that as an RFC and see if Greg KH or anyone else shoots it
down? Also verify it fixes what you see here of course!

It was on my list to do, but quite a few other things on that list so
if you have time that would be great.

Thanks,

Jonathan

> Thank you,
> Claudiu
> 
> [1]
> https://lore.kernel.org/all/20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com/
> 


