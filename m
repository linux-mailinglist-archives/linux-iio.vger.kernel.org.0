Return-Path: <linux-iio+bounces-18226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523FAA92421
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70806176B97
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913C2561A5;
	Thu, 17 Apr 2025 17:35:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ADA253928;
	Thu, 17 Apr 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911343; cv=none; b=F97iEUwb4EFYDB25Bee81RCAwkxqt1uaUytn8SSNiVoVkNLvRamJUH+s3DRvbZ2lIZu9D8vGbqR0+aeNkdsE286h7itWfzqttK3fnc0/hMnIyMnmy1fgQhrY3eOG42iPCaxMZHqf8RWtNfySa2xO9hiRJz3rHGVom7XtKjwnRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911343; c=relaxed/simple;
	bh=EvmR28y/PtXtMFHJ4dfKhEEr/eVouoJM5RqnN8E+CPU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBkIVDodk+MheW07owepSG7zG+wGb2THwMfSRDEgWkfLuGR/6/3WpDAhQG2S3RMLCjCBzzsgxUgpYtaoK6ViTY5BtNdj9TC6CF3CV+3cdyP0RC02MhFUspvmegL4bP/alibug8TtEsCpLlUWbOHO5C2v4DlN/iccPSeXdjx+Slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZdlLH61B4z6K8r4;
	Fri, 18 Apr 2025 01:31:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 701A5140146;
	Fri, 18 Apr 2025 01:35:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:35:36 +0200
Date: Thu, 17 Apr 2025 18:35:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Cosmin
 Tanislav" <cosmin.tanislav@analog.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, "Petre
 Rodan" <petre.rodan@subdimension.ro>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 4/8] iio: chemical: pms7003: use aligned_s64 for
 timestamp
Message-ID: <20250417183535.00004d87@huawei.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 11:52:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure that the timestamp is correctly aligned on
> all architectures.
> 
> Also move the unaligned.h header while touching this since it was the
> only one not in alphabetical order.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/chemical/pms7003.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> index d0bd94912e0a3492641acd955adbc2184f4a11b3..e05ce1f12065c65d14b66ab86e291fab47805dec 100644
> --- a/drivers/iio/chemical/pms7003.c
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -5,7 +5,6 @@
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   */
>  
> -#include <linux/unaligned.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
> @@ -19,6 +18,8 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/serdev.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
>  
>  #define PMS7003_DRIVER_NAME "pms7003"
>  
> @@ -76,7 +77,7 @@ struct pms7003_state {
>  	/* Used to construct scan to push to the IIO buffer */
>  	struct {
>  		u16 data[3]; /* PM1, PM2P5, PM10 */
> -		s64 ts;
> +		aligned_s64 ts;

Bug I think..  So another one that really needs a fixes tag.
For all these we might be lucky with padding on the allocations
but we shouldn't really rely on that.

>  	} scan;
>  };
>  
> 


