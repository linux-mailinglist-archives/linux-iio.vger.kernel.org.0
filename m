Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9415AD09
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBLQSA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Feb 2020 11:18:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32946 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLQSA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2020 11:18:00 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CGENMH001203;
        Wed, 12 Feb 2020 11:17:59 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udmyfn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Feb 2020 11:17:59 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01CGHwGd052873
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Feb 2020 11:17:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 12 Feb
 2020 11:17:57 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 12 Feb 2020 11:17:57 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01CGHsf6001230;
        Wed, 12 Feb 2020 11:17:55 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 0/5] iio: adc: ad7192: move out of staging
Date:   Wed, 12 Feb 2020 18:17:16 +0200
Message-ID: <20200212161721.16200-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-11,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120125
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series of patches aim to move the ad7192 ADC from staging
into mainline.

1. Makes probe fail in case get_voltage returns an error.

2. Changed the iio_chan_spec tables in order to set the required
attributes at compile time.

3. Removed spi_device_id table and moved ID_* in of_device_id table.

4. Updates inline sysfs docs.

5. Full-diff patch to move the ad7192 out of staging.

Alexandru Tachici (5):
  staging: iio: adc: ad7192: fail probe on get_voltage
  staging: iio: adc: ad7192: modify iio_chan_spec array
  staging: iio: adc: ad7192: removed spi_device_id
  Documentation: ABI: testing: ad7192: update sysfs docs
  staging: iio: adc: ad7192: move out of staging

 .../ABI/testing/sysfs-bus-iio-adc-ad7192      |   24 +-
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad7192.c                      | 1034 +++++++++++++++++
 .../iio/Documentation/sysfs-bus-iio-ad7192    |   20 -
 drivers/staging/iio/adc/Kconfig               |   12 -
 drivers/staging/iio/adc/Makefile              |    1 -
 drivers/staging/iio/adc/ad7192.c              | 1022 ----------------
 9 files changed, 1073 insertions(+), 1061 deletions(-)
 create mode 100644 drivers/iio/adc/ad7192.c
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
 delete mode 100644 drivers/staging/iio/adc/ad7192.c

-- 
2.20.1

