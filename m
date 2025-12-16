Return-Path: <linux-iio+bounces-27123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94738CC4D75
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54702302AAD1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282A346ACC;
	Tue, 16 Dec 2025 18:21:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF3346AC3;
	Tue, 16 Dec 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765909280; cv=none; b=Kw15tAYUDAy9IOAPgywIHVDZEpkhhN8gSS2eG4AsfuGQHSu7VMvTeBAVYpWirGpTMF6tk81WjSJWx5zW1PNh7k9t+vyOc9bYyouQYh6WYEWaE6UxJsJSBW+6Q6jp1TfI05SJxh+NK1YnvuX3insnA3/vFaK9qUXaPdwtgA5d7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765909280; c=relaxed/simple;
	bh=Wfcu7573yc2ab5v6nKY8wi70XO8aiefr4nBDJ9aNgPQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ie7/ANX0hBZ14hJOk6zh4NzUxvtGgdXQzO/7sKF94aiPuDRtLf2TeqRylsAOadNGfKShm45ZXMR2eOnOX3/svBGzozmOJL62RyxQqbcfomY9bnd8C2ddAliSUfz54okqvijxg1xj1VKml/0iwssM1AYwlsJuTUH3xSGFW08ntig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dW4x5134fzJ46CH;
	Wed, 17 Dec 2025 02:20:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CE9A40539;
	Wed, 17 Dec 2025 02:21:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 16 Dec
 2025 18:21:08 +0000
Date: Tue, 16 Dec 2025 18:21:06 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Tobias Sperling <tobias.sperling@softing.com>,
	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <20251216182106.000051c3@huawei.com>
In-Reply-To: <bef2e71c-fd76-4e73-9e53-422f9fa96757@baylibre.com>
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
	<20251211-ads1x18-v8-2-5cd12ac556da@gmail.com>
	<064e059b-5c86-4c41-8de8-b6a728361fd3@baylibre.com>
	<DEYY46ZUJQ35.YBNYWLGZMRYA@gmail.com>
	<bef2e71c-fd76-4e73-9e53-422f9fa96757@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 15 Dec 2025 12:09:31 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/15/25 10:54 AM, Kurt Borja wrote:
> > On Mon Dec 15, 2025 at 10:55 AM -05, David Lechner wrote:  
> >> On 12/11/25 10:25 PM, Kurt Borja wrote:  
> >>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> >>> analog-to-digital converters.
> >>>  
> 
> ...
> 
> >>> +static irqreturn_t ads1018_trigger_handler(int irq, void *p)
> >>> +{
> >>> +	struct iio_poll_func *pf = p;
> >>> +	struct iio_dev *indio_dev = pf->indio_dev;
> >>> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> >>> +	struct {
> >>> +		__be16 conv;
> >>> +		aligned_s64 ts;
> >>> +	} scan = {};
> >>> +	int ret;
> >>> +  
> >>
> >>  
> >>> +	if (iio_device_claim_buffer_mode(indio_dev))
> >>> +		goto out_notify_done;  
> >>
> >> This should not be needed. It should not be possible to
> >> exit buffer mode without triggers being stopped first.
> >> (No other driver is doing this.)  
> > 
> > Previously I had my own lock here because ads1018_spi_read_exclusive()
> > needs locking.  
> 
> What exactly are we protecting against here? I.e. give side-by-side
> lists of possible concurrent function calls where there could be a
> problem.
> 
> Any call to iio_device_claim_direct() will already fail without
> calling iio_device_claim_buffer_mode() here. And since this is
> an interrupt handler, we don't have to worry about reentrancy (it
> can't be called again until the previous call returns). And nowhere
> else in the driver is calling iio_device_claim_buffer_mode(). So
> calling it here doesn't actually add any protection AFAICT.

Agreed we shouldn't need this. Given these comment and my lazy nature,
Kurt, would you mind spinning a patch on top of this series that I can
squash with it on my tree?  That should be easier to review than
a full v9.  If you prefer a v9 of the whole thing, that would be fine too.

Thanks,

Jonathan
> 
> > I dropped it per your suggestion in v1 I believe, but
> > given the discussion in the cleanup.h series I was thinking in bringing
> > it back.
> > 
> > But yes, the scope can be adjusted too.
> >   
> 


