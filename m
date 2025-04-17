Return-Path: <linux-iio+bounces-18223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A189A92404
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2B33BFF4D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC68255235;
	Thu, 17 Apr 2025 17:29:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5F1ADC8D;
	Thu, 17 Apr 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910944; cv=none; b=V2vHnv0pDBHYIDdJthIjLG1kXlZXBdVkgE67keVfEx90KdKxaH1PYOgSeThSwA/cvex6arkoBiKI4OczxqCpzAyzr/AnH+lWULjiCH1uOH80xQvmFoYzGhlS7SVqe7kZCeN9coaS6EY6ABhchhOIDeHVVxVvPVv3j4gq0lyET6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910944; c=relaxed/simple;
	bh=k9js8k1DblZUqKO1N8ynxGv/BOYalCNLHuHhyMjosWk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzgd6F4bMStGQzt5aHGaG0Ib76nuIOhWZ8Q5L+IrT6TPucwKFI6uOsO0If54nwN/C/uoXw74UEJ2hn0HbZD03Q/AJds+vnx9fDBj+rMAIcdQukfBJ0pfjq8JPGShSfr3+mdoQBUoba5uuRQ2keVKbnZfd2ThA4n9BOw15/9Zz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZdlBd67RWz6K8r4;
	Fri, 18 Apr 2025 01:24:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 71D3D140145;
	Fri, 18 Apr 2025 01:28:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:28:58 +0200
Date: Thu, 17 Apr 2025 18:28:57 +0100
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
Subject: Re: [PATCH 1/8] iio: adc: dln2-adc: use aligned_s64 for timestamp
Message-ID: <20250417182857.00002561@huawei.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-1-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-1-eafac1e22318@baylibre.com>
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

On Thu, 17 Apr 2025 11:52:33 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure the struct itself it also 8-byte aligned.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/dln2-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index a1e48a756a7b519105393f77c4aebde1f2f85d50..359e26e3f5bcfe16d723f621bdfc01df2dfcf6a9 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -466,7 +466,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct {
>  		__le16 values[DLN2_ADC_MAX_CHANNELS];
> -		int64_t timestamp_space;
> +		aligned_s64 timestamp_space;
Bug :( So needs a fixes tag ideally.  Fine to just reply with one
(or I might go digging if I get time).

>  	} data;
>  	struct dln2_adc_get_all_vals dev_data;
>  	struct dln2_adc *dln2 = iio_priv(indio_dev);
> 


