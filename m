Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7F26A52F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOM3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 08:29:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49482 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgIOMB5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 08:01:57 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FBtDEX002322;
        Tue, 15 Sep 2020 08:01:28 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33h7pr8s3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 08:01:28 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08FC1Qls007706
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 15 Sep 2020 08:01:27 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:01:35 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:01:14 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 15 Sep 2020 05:01:34 -0700
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08FC1K9r004525;
        Tue, 15 Sep 2020 08:01:21 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 00/10] Use ADIS devm functions for trigger/buffer setup 
Date:   Tue, 15 Sep 2020 14:02:48 +0200
Message-ID: <20200915120258.161587-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_08:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=687 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009150103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series updates all users of `adis_setup_buffer_and_trigger()` to
use the devm version of it. The ultimate goal of the series is to drop
it from the lib as stated by Jonathan in [1].

[1]: https://marc.info/?l=linux-iio&m=158326796924980&w=2

Nuno Sá (10):
  iio: adis16201: Use Managed device functions
  iio: adis16209: Use Managed device functions
  iio: adis16136: Use Managed device functions
  iio: adis16260: Use Managed device functions
  iio: adis16400: Use Managed device functions
  iio: adis16460: Use Managed device functions
  iio: adis16480: Use Managed device functions
  staging: iio: adis16203: Use Managed device functions
  staging: iio: adis16240: Use Managed device functions
  iio: adis: Drop non Managed device functions

 drivers/iio/accel/adis16201.c         | 26 ++---------
 drivers/iio/accel/adis16209.c         | 25 ++---------
 drivers/iio/gyro/adis16136.c          | 37 ++++++----------
 drivers/iio/gyro/adis16260.c          | 33 +++++---------
 drivers/iio/imu/adis16400.c           | 38 +++++++---------
 drivers/iio/imu/adis16460.c           | 25 ++---------
 drivers/iio/imu/adis16480.c           | 55 +++++++++++------------
 drivers/iio/imu/adis_buffer.c         | 64 ++-------------------------
 drivers/iio/imu/adis_trigger.c        | 60 -------------------------
 drivers/staging/iio/accel/adis16203.c | 26 ++---------
 drivers/staging/iio/accel/adis16240.c | 25 ++---------
 include/linux/iio/imu/adis.h          | 27 -----------
 12 files changed, 84 insertions(+), 357 deletions(-)

-- 
2.28.0

