Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0701457F1
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 15:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgAVOhP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jan 2020 09:37:15 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52932 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgAVOhP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jan 2020 09:37:15 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MEZBYC030667;
        Wed, 22 Jan 2020 09:37:13 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbk1ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 09:37:13 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00MEbBsW004100
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 22 Jan 2020 09:37:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 22 Jan
 2020 06:37:11 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 22 Jan 2020 09:37:10 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00MEb86u030736;
        Wed, 22 Jan 2020 09:37:08 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/2] staging: iio: adc: ad7192: move out of staging
Date:   Wed, 22 Jan 2020 16:36:58 +0200
Message-ID: <20200122143700.6069-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=887 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220132
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series of patches move ad7192 into mainline.

1. Update driver sysfs docs.
2. Move driver out of staging into mainline.

Alexandru Tachici (2):
  Documentation: ABI: testing: ad7192: update sysfs docs
  staging: iio: adc: ad7192: move out of staging

 .../ABI/testing/sysfs-bus-iio-adc-ad7192      |   17 +-
 MAINTAINERS                                   |    9 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad7192.c                      | 1022 +++++++++++++++++
 .../iio/Documentation/sysfs-bus-iio-ad7192    |   20 -
 drivers/staging/iio/adc/Kconfig               |   12 -
 drivers/staging/iio/adc/Makefile              |    1 -
 drivers/staging/iio/adc/ad7192.c              | 1022 -----------------
 9 files changed, 1055 insertions(+), 1061 deletions(-)
 create mode 100644 drivers/iio/adc/ad7192.c
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
 delete mode 100644 drivers/staging/iio/adc/ad7192.c

-- 
2.20.1

