Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06071312B4F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 08:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBHHzw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 8 Feb 2021 02:55:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2516 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhBHHzn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 02:55:43 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DYyrr4pt6z67m3R;
        Mon,  8 Feb 2021 15:51:24 +0800 (CST)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:55:02 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 07:55:00 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 15:54:59 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 15/24] staging:iio:cdc:ad7150: Tidy up local variable
 positioning.
Thread-Topic: [PATCH 15/24] staging:iio:cdc:ad7150: Tidy up local variable
 positioning.
Thread-Index: AQHW/WjJYs7ylX3tTUunouiF4Evgy6pN4usA
Date:   Mon, 8 Feb 2021 07:54:59 +0000
Message-ID: <7beef56608a54546ab88b8c76e8f4487@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-16-jic23@kernel.org>
In-Reply-To: <20210207154623.433442-16-jic23@kernel.org>
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
> Subject: [PATCH 15/24] staging:iio:cdc:ad7150: Tidy up local variable
> positioning.
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Where there is no other basis on which to order declarations
> let us prefer reverse xmas tree.  Also reduce scope where
> sensible.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  drivers/staging/iio/cdc/ad7150.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c
> b/drivers/staging/iio/cdc/ad7150.c
> index 9e88e774752f..d530b467d1b2 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -108,9 +108,9 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
>  			   int *val2,
>  			   long mask)
>  {
> -	int ret;
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
>  	int channel = chan->channel;
> +	int ret;
> 
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -143,10 +143,10 @@ static int ad7150_read_event_config(struct iio_dev
> *indio_dev,
>  				    enum iio_event_type type,
>  				    enum iio_event_direction dir)
>  {
> -	int ret;
> +	struct ad7150_chip_info *chip = iio_priv(indio_dev);
>  	u8 threshtype;
>  	bool thrfixed;
> -	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> +	int ret;
> 
>  	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
>  	if (ret < 0)
> @@ -227,10 +227,8 @@ static int ad7150_write_event_config(struct iio_dev
> *indio_dev,
>  				     enum iio_event_type type,
>  				     enum iio_event_direction dir, int state)
>  {
> -	u8 thresh_type, cfg, adaptive;
> -	int ret;
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> -	int rising = (dir == IIO_EV_DIR_RISING);
> +	int ret;
> 
>  	/*
>  	 * There is only a single shared control and no on chip
> @@ -251,6 +249,8 @@ static int ad7150_write_event_config(struct iio_dev
> *indio_dev,
> 
>  	mutex_lock(&chip->state_lock);
>  	if ((type != chip->type) || (dir != chip->dir)) {
> +		int rising = (dir == IIO_EV_DIR_RISING);
> +		u8 thresh_type, cfg, adaptive;
> 
>  		/*
>  		 * Need to temporarily disable both interrupts if
> @@ -533,9 +533,9 @@ static const struct iio_info ad7150_info_no_irq = {
>  static int ad7150_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	int ret;
>  	struct ad7150_chip_info *chip;
>  	struct iio_dev *indio_dev;
> +	int ret;
> 
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
> --
> 2.30.0

