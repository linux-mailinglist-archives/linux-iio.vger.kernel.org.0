Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1D26A23D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgIOJci (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 05:32:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30846 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbgIOJcf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 05:32:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08F9VO8k016234;
        Tue, 15 Sep 2020 05:32:14 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33gu851uxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 05:32:14 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08F9WDQx047060
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 15 Sep 2020 05:32:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:32:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 15 Sep 2020 05:32:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 15 Sep 2020 05:32:21 -0400
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08F9W7vf027664;
        Tue, 15 Sep 2020 05:32:08 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Ardelean --dry-run <alexandru.ardelean@analog.com>
Subject: [PATCH 00/10] Use ADIS devm functions for trigger/buffer setup
Date:   Tue, 15 Sep 2020 11:33:35 +0200
Message-ID: <20200915093345.85614-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_05:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=672 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150087
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

 drivers/iio/accel/adis16201.c         | 16 ++-----
 drivers/iio/accel/adis16209.c         | 15 ++-----
 drivers/iio/gyro/adis16136.c          |  9 +---
 drivers/iio/gyro/adis16260.c          | 15 ++-----
 drivers/iio/imu/adis16400.c           | 15 ++-----
 drivers/iio/imu/adis16460.c           | 13 ++----
 drivers/iio/imu/adis16480.c           |  7 +--
 drivers/iio/imu/adis_buffer.c         | 64 ++-------------------------
 drivers/iio/imu/adis_trigger.c        | 60 -------------------------
 drivers/staging/iio/accel/adis16203.c | 16 ++-----
 drivers/staging/iio/accel/adis16240.c | 14 ++----
 include/linux/iio/imu/adis.h          | 27 -----------
 12 files changed, 30 insertions(+), 241 deletions(-)

-- 
2.28.0

