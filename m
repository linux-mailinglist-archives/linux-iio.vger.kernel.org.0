Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869A0240404
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHJJbr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 05:31:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54748 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgHJJbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 05:31:47 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A9I3sI003648;
        Mon, 10 Aug 2020 05:31:44 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32sry466pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 05:31:44 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 07A9VgbO061682
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Aug 2020 05:31:43 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Aug 2020 02:31:41 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Aug 2020 02:30:46 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Aug 2020 02:31:40 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07A9VdXO023493;
        Mon, 10 Aug 2020 05:31:39 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v5 0/2] iio: accel: adxl372: Add support for FIFO peak mode
Date:   Mon, 10 Aug 2020 12:32:55 +0300
Message-ID: <20200810093257.65929-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_03:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100068
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

Alexandru Tachici (1):
  iio: accel: adxl372: Add additional trigger ABI docs

Stefan Popa (1):
  iio: accel: adxl372: Add support for FIFO peak mode

Changelog v4 -> v5:
  - squash iio event interface patch into peak mode patch
  - move patch to 100 lines length
  - use((x) & BIT(0)) construct for define ADXL372_Y_AXIS_EN(x)
  - add ABI docs to explain the use of the additional trigger

 .../ABI/testing/sysfs-bus-iio-accel-adxl372   |   7 +
 drivers/iio/accel/adxl372.c                   | 302 +++++++++++++++++-
 2 files changed, 301 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372

-- 
2.20.1

