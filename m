Return-Path: <linux-iio+bounces-19809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5BAC11BB
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 18:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDCC3BEEBF
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B54629B8C3;
	Thu, 22 May 2025 16:54:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48929AB17;
	Thu, 22 May 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932864; cv=none; b=aSvZizB/Vpd+0gztvNQPi6wvGXFC04H/y+ORCihUbXe8f+Kd0LS6cuxa4a157qKHURDrER2p3ax3k25DT8FHvVaxxZNIBBDOYSXyhSl0LEc9M1HHwYcDzwrRfF6Ld5pDyhVZFXU6Xd9FIyFSnWEFXYAYzWLZRXo6CSd4Avnruao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932864; c=relaxed/simple;
	bh=MHE8elGOD3VOUv5LCmib7J4CnzJcr2ulHeMksQP+Izg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8m29d2aDzs8jJMYJVEhGiG+qSl0vcrtu0D4TWYJj0QM++JSw/F67K38S47K+qHq9e+o2GOvcVkmR/jMLqjgW0IkOnTSfOQm6RKLKWQRtOxBQi3HyBRyxdEihPfqpnEpRoIcq0gCZePb8A0NyuFyplUpN/JC9QnUf+R8XjWr9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b3Dln5JKZz6M4c0;
	Fri, 23 May 2025 00:49:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E51211402EF;
	Fri, 23 May 2025 00:54:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 18:54:18 +0200
Date: Thu, 22 May 2025 17:54:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: adi-axi-dac: fix bus free check
Message-ID: <20250522175416.000047cb@huawei.com>
In-Reply-To: <20250522-iio-dac-adi-axi-dac-fix-bus-read-v1-1-26ec358c57bf@baylibre.com>
References: <20250522-iio-dac-adi-axi-dac-fix-bus-read-v1-1-26ec358c57bf@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 22 May 2025 18:47:31 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> This patch is intended to fix [1] that looks not yet accepted in any
> upstream branch.
> 
> Poll function must check for a value equal to 0 (bus free condition).
> 
> [1] https://lore.kernel.org/linux-iio/l6vu54ltxd7pydkzl6xbbq55gedumzbsllfxnljyngwcg4c6zd@w6qxgn2vby75/
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Hi Angelo.

That was stalled due to tree shuffling.  Given as you
observed it hasn't made it on to any tree yet, would you mind
squashing this in and posting a new version of that patch?
That will probably end up cleaner than me trying to remember to squash the two.

Thanks!

Jonathan

> ---
>  drivers/iio/dac/adi-axi-dac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index b6cfe07701d47440df478f7b9b4c579434b99a25..a0e546dba3680371e00dc4c8973d4f450c18cf2d 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -641,7 +641,7 @@ static int axi_dac_wait_bus_free(struct axi_dac_state *st)
>  	int ret;
>  
>  	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, val,
> -		FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == -1, 10,
> +		FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0, 10,
>  		100 * KILO);
>  	if (ret == -ETIMEDOUT)
>  		dev_err(st->dev, "AXI bus timeout\n");
> 
> ---
> base-commit: 50b8b618e598468e35551003d7e5cc5db14ee113
> change-id: 20250522-iio-dac-adi-axi-dac-fix-bus-read-244fbc07313c
> 
> Best regards,


