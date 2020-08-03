Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A6923AB8D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHCRUy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 13:20:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10752 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727803AbgHCRUy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 13:20:54 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 073H4tdq023250;
        Mon, 3 Aug 2020 13:20:52 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32n69efbae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 13:20:52 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 073HKokS063783
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 3 Aug 2020 13:20:51 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Aug 2020 10:20:49 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Aug 2020 10:20:49 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 3 Aug 2020 10:20:49 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 073HKlag008684;
        Mon, 3 Aug 2020 13:20:48 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v4 0/3] iio: accel: adxl372: add peak mode
Date:   Mon, 3 Aug 2020 20:22:16 +0300
Message-ID: <20200803172219.33911-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_15:2020-08-03,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

This series adds the possibility to configure
the device, from sysfs, to work in peak mode. This enables
adxl372 to capture only over threshold accelerations.

1. Create sysfs files for falling_period/rising_period
and thresh_falling_value/thresh_rising_value in events/ dir.
Set INT1 reg for activity/inactivity and push
event code in events fifo on irq.

2. Document use of iio events sysfs files.

Alexandru Tachici (2):
  iio: accel: adxl372: add event interface
  docs: iio: Add adxl372 documentation

1. Device FIFO can now be set in peak mode and only over the
threshold accelerations will be stored. Driver sets adxl372
FIFO in peak mode when the peak iio:trigger is selected.

Stefan Popa (1):
  iio: accel: adxl372: Add support for FIFO peak mode

  Changelog v3 -> v4:
  - add mutex for threshold write so that writing the two
  registers becomes atomic
  - added a trigger for peak mode, when selected in the trigger
  user interface, adxl372 will start recording only peak acceleration
  data in the fifo
  - added a adxl372.rst doc file explaining the use of iio events sysfs

 Documentation/iio/adxl372.rst |  46 +++++
 Documentation/iio/index.rst   |   1 +
 drivers/iio/accel/adxl372.c   | 328 +++++++++++++++++++++++++++++++++-
 3 files changed, 367 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/iio/adxl372.rst

-- 
2.20.1

