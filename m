Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F28E78D
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2019 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfHOI7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Aug 2019 04:59:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33326 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOI7e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Aug 2019 04:59:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8wv9N016053;
        Thu, 15 Aug 2019 08:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=NOyNWtkVoqyPJNSvFmROYTt7fYLKh1PcchhUSUu7iWc=;
 b=VtyGwuslcniAQC4M1/whICOgf70Qkh/wwEflzweZ5Gl2KGV2yWqwJy9LLR2wUigZJ13o
 4isiaLqHyv3mZufIUI2Cwpo5hm32a5Y+87XQgFELXyXyv/UE9z/b2byuUWwaeuHgnziR
 Mv0n86m7brNcVVRbs8lgNysnRKQkTE3++GzCkiG2IM+lQhGX14alOxH8xv18KnKmPMDX
 0Q6cXbYSHMWthc2aqq57kZfCO4KDF58gEIQQpCKNbAX3qW+N1x+HP25pTu8ZqrIzRsPB
 0x1HTY5br8JOjMVJqhs3MMSwBfb7EeeufRu4ivHSBz6RCPwBiwUrkrJEJbchkCgmPtQc Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbtsu0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:59:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8vfqj037097;
        Thu, 15 Aug 2019 08:59:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ucgf0teew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:59:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7F8xShN025988;
        Thu, 15 Aug 2019 08:59:29 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 01:59:27 -0700
Date:   Thu, 15 Aug 2019 11:59:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     alexandru.ardelean@analog.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: imu: Add support for the ADIS16460 IMU
Message-ID: <20190815085922.GA1025@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=850 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Alexandru Ardelean,

The patch db6ed4d23dd1: "iio: imu: Add support for the ADIS16460 IMU"
from Jul 23, 2019, leads to the following static checker warning:

	drivers/iio/imu/adis16460.c:158 adis16460_set_freq()
	warn: 't' unsigned <= 0

drivers/iio/imu/adis16460.c
   152  static int adis16460_set_freq(struct iio_dev *indio_dev, int val, int val2)
   153  {
   154          struct adis16460 *st = iio_priv(indio_dev);
   155          unsigned int t;
                ^^^^^^^^^^^^^^

   156  
   157          t =  val * 1000 + val2 / 1000;
   158          if (t <= 0)
                    ^^^^^^
Unsigned is not less than zero.

   159                  return -EINVAL;
   160  
   161          t = 2048000 / t;
   162          if (t > 2048)
   163                  t = 2048;
   164  
   165          if (t != 0)
   166                  t--;
   167  
   168          return adis_write_reg_16(&st->adis, ADIS16460_REG_DEC_RATE, t);
   169  }

regards,
dan carpenter
