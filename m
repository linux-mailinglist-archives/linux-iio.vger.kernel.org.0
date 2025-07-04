Return-Path: <linux-iio+bounces-21346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4521AF8E5F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 11:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC09A8031B3
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11D2ECEBB;
	Fri,  4 Jul 2025 09:14:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C32BEC52;
	Fri,  4 Jul 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620488; cv=none; b=NDd74PvRfJZi4Vk6KJ6lMw48t2tCOL+G0wh054l9jWgJv6K/LOmsofAL3ofPjUs7DfW8aAHM2x+hlebwN2L5+7AvTGam6u1/7+uy03d99emjn0FcIGbhre2DdQxNwkBCFga5n83KVeIKesT0YZywybGZG2uVxQXdJdTOMOgEjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620488; c=relaxed/simple;
	bh=pG589rTagnPuJelNEMUsa9fPH/v65e1hwQqDqexgHsw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrKFwmKKQ2hSyJeO4SkL/7VLHisJA4aWKNlDRXuPNENxDcLqe6LJiIGgObh8E3Pi/FTU0x3Zhn0Em26ZESqs5olhnpj/SzGV/N1PphCnkYljSzA+x7Y2LrSFzRAZgVUePGu3g3y2rMkyfVLWyStrkrOsg5lxgr7R4hjBk0ogJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYScg4BMbz6L55T;
	Fri,  4 Jul 2025 17:14:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 546161404A9;
	Fri,  4 Jul 2025 17:14:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 11:14:42 +0200
Date: Fri, 4 Jul 2025 10:14:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<matthias.bgg@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<kernel@collabora.com>
Subject: Re: [PATCH v2 4/6] iio: adc: mt6359: Move reference voltage to
 platform data
Message-ID: <20250704101441.00004cbd@huawei.com>
In-Reply-To: <cbd79481-474e-4c9f-bbe8-367917115ccd@collabora.com>
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
	<20250703141146.171431-5-angelogioacchino.delregno@collabora.com>
	<aGaThTSAriz46D7T@smile.fi.intel.com>
	<cbd79481-474e-4c9f-bbe8-367917115ccd@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Jul 2025 16:40:38 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 03/07/25 16:28, Andy Shevchenko ha scritto:
> > On Thu, Jul 03, 2025 at 04:11:44PM +0200, AngeloGioacchino Del Regno wrote:  
> >> In preparation to add support for new PMICs, add a `vref_mv`  
> > 
> > I still think that the vref_mV is a better naming.
> >   
> 
> Ouch, I think I missed that comment; if there's nothing else to change,
> I wonder if the capital V can be fixed while applying?
> 
> Otherwise I can send a v3...
> 

If that's all that comes up I'll tweak whilst applying.

J

> Cheers,
> Angelo
> 
> >> the AUXADC_VOLT_FULL definition.
> >>
> >> As a consequence, the definition was also removed.  
> >   
> 
> 


