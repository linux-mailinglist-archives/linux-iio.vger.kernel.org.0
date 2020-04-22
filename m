Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1F1B4BC2
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDVR1p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 13:27:45 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbgDVR1o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 13:27:44 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 02688571B8635F29F7B1;
        Wed, 22 Apr 2020 18:27:44 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 22 Apr
 2020 18:27:43 +0100
Date:   Wed, 22 Apr 2020 18:27:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: correct DO-SM channels
Message-ID: <20200422182742.00004e9b@huawei.com>
In-Reply-To: <20200419232847.32206-1-matt.ranostay@konsulko.com>
References: <20200419232847.32206-1-matt.ranostay@konsulko.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 02:28:47 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> IIO_CONCENTRATION channel for the DO-SM shouldn't be indexed as
> there isn't more than one, and also ATLAS_CONCENTRATION_CHANNEL
> macro scan_index define steps on the IIO_TIMESTAMP channel.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

Fixes tag?

J
> ---
>  drivers/iio/chemical/atlas-sensor.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c
> b/drivers/iio/chemical/atlas-sensor.c index
> 82d470561ad3..7b199ce16ecf 100644 ---
> a/drivers/iio/chemical/atlas-sensor.c +++
> b/drivers/iio/chemical/atlas-sensor.c @@ -194,7 +194,19 @@ static
> const struct iio_chan_spec atlas_orp_channels[] = { };
>  
>  static const struct iio_chan_spec atlas_do_channels[] = {
> -	ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_DO_DATA),
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.address = ATLAS_REG_DO_DATA,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		},
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(1),
>  	{
>  		.type = IIO_TEMP,

