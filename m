Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20566312B41
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 08:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBHHxR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 8 Feb 2021 02:53:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2514 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBHHxM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 02:53:12 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DYymX4B2Mz67lmG;
        Mon,  8 Feb 2021 15:47:40 +0800 (CST)
Received: from lhreml717-chm.china.huawei.com (10.201.108.68) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:52:31 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 07:52:29 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 15:52:27 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 16/24] staging:iio:cdc:ad7150: Drop unnecessary block
 comments.
Thread-Topic: [PATCH 16/24] staging:iio:cdc:ad7150: Drop unnecessary block
 comments.
Thread-Index: AQHW/WjO/oq8mrsW3UC6jqko8IgJvKpN4gTA
Date:   Mon, 8 Feb 2021 07:52:27 +0000
Message-ID: <d6aaf4d4406b458a97d0e53b4a285424@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-17-jic23@kernel.org>
In-Reply-To: <20210207154623.433442-17-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Monday, February 8, 2021 4:46 AM
> To: linux-iio@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: [PATCH 16/24] staging:iio:cdc:ad7150: Drop unnecessary block
> comments.
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These have a habit of not getting updated with driver reorganizations
> and don't add much info so drop them.
> 
> Also fix a minor comment syntax issue.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

>  drivers/staging/iio/cdc/ad7150.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c
> b/drivers/staging/iio/cdc/ad7150.c
> index d530b467d1b2..4c83e6e37c5a 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -17,9 +17,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> -/*
> - * AD7150 registers definition
> - */
> 
>  #define AD7150_STATUS_REG		0
>  #define   AD7150_STATUS_OUT1		BIT(3)
> @@ -89,10 +86,6 @@ struct ad7150_chip_info {
>  	enum iio_event_direction dir;
>  };
> 
> -/*
> - * sysfs nodes
> - */
> -
>  static const u8 ad7150_addresses[][6] = {
>  	{ AD7150_CH1_DATA_HIGH_REG, AD7150_CH1_AVG_HIGH_REG,
>  	  AD7150_CH1_SETUP_REG, AD7150_CH1_THR_HOLD_H_REG,
> @@ -172,8 +165,7 @@ static int ad7150_read_event_config(struct iio_dev
> *indio_dev,
>  	return -EINVAL;
>  }
> 
> -/* state_lock should be held to ensure consistent state*/
> -
> +/* state_lock should be held to ensure consistent state */
>  static int ad7150_write_event_params(struct iio_dev *indio_dev,
>  				     unsigned int chan,
>  				     enum iio_event_type type,
> --
> 2.30.0

