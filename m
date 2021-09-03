Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD760400112
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhICOMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:12:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14214 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233092AbhICOMm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:12:42 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1838x6BV008664;
        Fri, 3 Sep 2021 10:11:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3augp61cjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:11:30 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 183EBSXh040537
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Sep 2021 10:11:28 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 3 Sep 2021
 07:11:27 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 3 Sep 2021 07:11:26 -0700
Received: from nsa.ad.analog.com ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 183EBOFA024311;
        Fri, 3 Sep 2021 10:11:24 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH 0/5] Fixes and improvements to the ADIS lib/devices
Date:   Fri, 3 Sep 2021 16:14:18 +0200
Message-ID: <20210903141423.517028-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bypJnd5M_8jIR5xCSJJrG5BQuX5YxNNh
X-Proofpoint-ORIG-GUID: bypJnd5M_8jIR5xCSJJrG5BQuX5YxNNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=914 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds some fixes and improvements for the ADIS library and
devices. There are two fixes:
 
1) On the library 'adis_init()' function, a call to 'adis_enable_irq()'
was being done. That does not make sense because
'__adis_initial_startup()' will reset the device and put the data ready
pin in the default state. For some drivers, these could mean that we
were leaving probe in a state different from the desired one.
2) The adis16480 driver was registering a managed reset action to put
the device into sleep mode in the unbinding path. Well, not all devices
supported by the driver support sleep mode.
 
The rest of the series is a minor improvement about passing the handling of
enabling/disabling IRQs (for devices that cannot unmask the data ready
pin) inside the library.

Nuno Sá (5):
  iio: adis: do not disabe IRQs in 'adis_init()'
  iio: adis: handle devices that cannot unmask the drdy pin
  iio: adis16475: make use of the new unmasked_drdy flag
  iio: adis16460: make use of the new unmasked_drdy flag
  iio: adis16480: fix devices that do not support sleep mode

 drivers/iio/imu/adis.c         | 17 ++++++++++++++++-
 drivers/iio/imu/adis16460.c    | 18 +-----------------
 drivers/iio/imu/adis16475.c    | 19 +------------------
 drivers/iio/imu/adis16480.c    | 14 +++++++++++---
 drivers/iio/imu/adis_trigger.c |  4 ++++
 include/linux/iio/imu/adis.h   |  2 ++
 6 files changed, 35 insertions(+), 39 deletions(-)

-- 
2.33.0

