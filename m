Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18D1A6448
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 10:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDMIf3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 04:35:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61996 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgDMIZR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 04:25:17 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D8IM2v003751;
        Mon, 13 Apr 2020 04:24:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30bat4p9c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 04:24:56 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03D8OsxW020716
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 13 Apr 2020 04:24:54 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Apr
 2020 01:24:53 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Apr 2020 01:24:53 -0700
Received: from NSA-L01.ad.analog.com (nsa-l01.ad.analog.com [10.32.224.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03D8Om3s026405;
        Mon, 13 Apr 2020 04:24:48 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v5 0/6] Support ADIS16475 and similar IMUs
Date:   Mon, 13 Apr 2020 10:24:39 +0200
Message-ID: <20200413082445.17324-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_02:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the adis16475 and similar IMUs. This driver
will be the first user of some changes on the adis library. Hence, the
first three patches are related to the library:
 * Add anaged device functions for registering triggers with the library;
 * Updates the way `irq_mask` is passed to `request_irq()`;
 * It adds an update_bits() like API.

A new patch was introduced (iio: adis: Add burst_max_len variable) in
order to make burst32 configuration at runtime.

Nuno Sá (6):
  iio: imu: adis: Add Managed device functions
  iio: imu: adis: Add irq mask variable
  iio: adis: Add adis_update_bits() APIs
  iio: adis: Support different burst sizes
  iio: imu: Add support for adis16475
  dt-bindings: iio: Add adis16475 documentation

 .../bindings/iio/imu/adi,adis16475.yaml       |  137 ++
 MAINTAINERS                                   |    8 +
 drivers/iio/imu/Kconfig                       |   13 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/adis.c                        |   25 +
 drivers/iio/imu/adis16400.c                   |    2 +-
 drivers/iio/imu/adis16475.c                   | 1336 +++++++++++++++++
 drivers/iio/imu/adis_buffer.c                 |   58 +-
 drivers/iio/imu/adis_trigger.c                |   72 +-
 include/linux/iio/imu/adis.h                  |   87 +-
 10 files changed, 1728 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 create mode 100644 drivers/iio/imu/adis16475.c

-- 
2.17.1

