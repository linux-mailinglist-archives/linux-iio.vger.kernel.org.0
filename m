Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB26B1C107C
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEAJq6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 05:46:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAJq6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 May 2020 05:46:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0419ih4s059571;
        Fri, 1 May 2020 09:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=HJfT2thdVLxQN5Sy2p8pzC7CYdR5GiuAT2ZYnrvYh2U=;
 b=z/FWrWBqHJ9WPaoiq8+Ld0kcnD/5370tm56zsx1f0DsaDe8AqMeCnpflpVti09uje9tJ
 irUfPILm1nrifxKpxQMbGovlAo/hBvCVfhyj7QOT5lriVtdW7gKbq8JDSJ46coOg6AL4
 CGw47U1nQkxGW5fmPUbJc4kdGleynWEVNQiRumQJmpBBlhTschiulT6o4u0xYDpOQHtE
 MZO4WrOL+htr6eMUQr62S54a8Q+8UsMVtF53mXEAwxWmUccoG38wy6xd9JTo2lvQwF/Q
 jE1vXoARxMcpms3PS6YacJRDlgeIsScY1uf24pS1H6tF5iITGSlWDAHiV4u8q+Q+EkZE Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30r7f81m2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 09:46:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0419hURc159171;
        Fri, 1 May 2020 09:44:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30r7ffyuq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 09:44:55 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0419itRV012180;
        Fri, 1 May 2020 09:44:55 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 May 2020 02:44:54 -0700
Date:   Fri, 1 May 2020 12:44:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dragos.bogdan@analog.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R
Message-ID: <20200501094449.GA960353@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=721 phishscore=0 suspectscore=3 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=754
 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=3 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Dragos Bogdan,

The patch 3a6af93dd66e: "iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for
AD7091R" from Mar 11, 2020, leads to the following static checker
warning:

	drivers/iio/adc/ad7476.c:312 ad7476_probe()
	warn: this array is non-NULL. 'st->chip_info->convst_channel'

drivers/iio/adc/ad7476.c
   288          ret = devm_add_action_or_reset(&spi->dev, ad7476_reg_disable,
   289                                         st);
   290          if (ret)
   291                  return ret;
   292  
   293          st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
   294                                                    "adi,conversion-start",
   295                                                    GPIOD_OUT_LOW);
   296          if (IS_ERR(st->convst_gpio))
   297                  return PTR_ERR(st->convst_gpio);
   298  
   299          spi_set_drvdata(spi, indio_dev);
   300  
   301          st->spi = spi;
   302  
   303          /* Establish that the iio_dev is a child of the spi device */
   304          indio_dev->dev.parent = &spi->dev;
   305          indio_dev->dev.of_node = spi->dev.of_node;
   306          indio_dev->name = spi_get_device_id(spi)->name;
   307          indio_dev->modes = INDIO_DIRECT_MODE;
   308          indio_dev->channels = st->chip_info->channel;
   309          indio_dev->num_channels = 2;
   310          indio_dev->info = &ad7476_info;
   311  
   312          if (st->convst_gpio && st->chip_info->convst_channel)
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is an array, not a pointer and it it's in the middle of the struct
so it can't possibly be NULL.

   313                  indio_dev->channels = st->chip_info->convst_channel;
   314          /* Setup default message */
   315  
   316          st->xfer.rx_buf = &st->data;
   317          st->xfer.len = st->chip_info->channel[0].scan_type.storagebits / 8;
   318  
   319          spi_message_init(&st->msg);
   320          spi_message_add_tail(&st->xfer, &st->msg);
   321  

regards,
dan carpenter
