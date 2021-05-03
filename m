Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45137135E
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 12:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhECKIv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 06:08:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43082 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhECKIt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 06:08:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143A3lX6097332;
        Mon, 3 May 2021 10:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0m6CZKMKH0CXm0dLQ0wuv9R6uvsrR8sLUyperFhMgWQ=;
 b=XUMu9wd9V9A+Uoz4d0UJUDQ2Ww8J1dRk//bZ+A2Q4fvYe9lR+Po9sMG/MT6cN7eqmAy6
 SetGbtUJdTaQ30DLGjPxfDGPAYRfq765WbFGFEEzdMZ9lDLOWYbf0WImEgjqEf9OVE6q
 YGHwNdfQ4tRR8gilOqDN0Pha1onnllAxMrYgFOgVhT1gUuEvPbmfXnHFvRr/4IDEL2ZE
 hDlsOFZFSMCko9TvnviEjkmyNM6EzaEW8dFyQq9Xmx3rGuoH/Rfir351BZVt2wUr8q8A
 zaAi5KdNg8KQAq5L/47y+jOPk4tZJ7UtygfrlVeZfo98mK3GTTcLqQXHfVsJ8GbkBy4R Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 388xdru5yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:07:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143A5EXH145104;
        Mon, 3 May 2021 10:07:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 389grqgd7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:07:30 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143A7Ulg151722;
        Mon, 3 May 2021 10:07:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 389grqgd7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:07:30 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 143A7S4w017140;
        Mon, 3 May 2021 10:07:28 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 03:07:27 -0700
Date:   Mon, 3 May 2021 13:07:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] staging: iio: cdc: ad7746: use dt for capacitive
 channel setup.
Message-ID: <20210503100720.GP1981@kadam>
References: <cover.1619841953.git.lucas.p.stankus@gmail.com>
 <3e7f2a0a8960cece185f518ff2b7ceb87891edcd.1619841953.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7f2a0a8960cece185f518ff2b7ceb87891edcd.1619841953.git.lucas.p.stankus@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: hZadFzO0eJeomz8GQTOutIhakF-cZ0Dr
X-Proofpoint-GUID: hZadFzO0eJeomz8GQTOutIhakF-cZ0Dr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030066
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 01, 2021 at 09:32:53AM -0300, Lucas Stankus wrote:
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index dfd71e99e872..531f1b96dea2 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -18,8 +18,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include "ad7746.h"
> -
>  /*
>   * AD7746 Register Definition
>   */
> @@ -676,10 +674,11 @@ static const struct iio_info ad7746_info = {
>  static int ad7746_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> -	struct ad7746_platform_data *pdata = client->dev.platform_data;
> +	struct device *dev = &client->dev;
>  	struct ad7746_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	unsigned char regval = 0;
> +	unsigned int vdd_permille;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> @@ -703,26 +702,39 @@ static int ad7746_probe(struct i2c_client *client,
>  	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	if (pdata) {
> -		if (pdata->exca_en) {
> -			if (pdata->exca_inv_en)
> -				regval |= AD7746_EXCSETUP_NEXCA;
> -			else
> -				regval |= AD7746_EXCSETUP_EXCA;
> -		}
> +	if (device_property_read_bool(dev, "adi,exca-output-en")) {
> +		if (device_property_read_bool(dev, "adi,exca-output-invert"))
> +			regval |= AD7746_EXCSETUP_NEXCA;
> +		else
> +			regval |= AD7746_EXCSETUP_EXCA;
> +	}
>  
> -		if (pdata->excb_en) {
> -			if (pdata->excb_inv_en)
> -				regval |= AD7746_EXCSETUP_NEXCB;
> -			else
> -				regval |= AD7746_EXCSETUP_EXCB;
> -		}
> +	if (device_property_read_bool(dev, "adi,excb-output-en")) {
> +		if (device_property_read_bool(dev, "adi,excb-output-invert"))
> +			regval |= AD7746_EXCSETUP_NEXCB;
> +		else
> +			regval |= AD7746_EXCSETUP_EXCB;
> +	}
>  
> -		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> -	} else {
> -		dev_warn(&client->dev, "No platform data? using default\n");
> -		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> -			AD7746_EXCSETUP_EXCLVL(3);
> +	ret = device_property_read_u32(dev, "adi,excitation-vdd-permille",
> +				       &vdd_permille);
> +	if (!ret) {

This test is reversed.  I wonder if the static checkers can catch the
uninitialized variable bug...  It's probably better to write it as:

	if (device_property_read_u32(dev, "adi,excitation-vdd-permille",
				     &vdd_permille) {

So it matches the others.

regards,
dan carpenter;

> +		switch (vdd_permille) {
> +		case 125:
> +			regval |= AD7746_EXCSETUP_EXCLVL(0);
> +			break;
> +		case 250:
> +			regval |= AD7746_EXCSETUP_EXCLVL(1);
> +			break;
> +		case 375:
> +			regval |= AD7746_EXCSETUP_EXCLVL(2);
> +			break;
> +		case 500:
> +			regval |= AD7746_EXCSETUP_EXCLVL(3);
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  
>  	ret = i2c_smbus_write_byte_data(chip->client,



