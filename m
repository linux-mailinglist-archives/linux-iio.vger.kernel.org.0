Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B681426E476
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgIQStw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:49:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24644 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728519AbgIQQ17 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 12:27:59 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HFTck1001177;
        Thu, 17 Sep 2020 11:50:50 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p677t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 11:50:50 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08HFonnN011784
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Sep 2020 11:50:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 17 Sep
 2020 11:50:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 17 Sep 2020 11:50:55 -0400
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08HFojFI030124;
        Thu, 17 Sep 2020 11:50:45 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] Refactor ADIS Burst Mode
Date:   Thu, 17 Sep 2020 17:52:19 +0200
Message-ID: <20200917155223.218500-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_10:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=773
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=1
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170119
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series refactors the ADIS burst mode. The 2 main ideas of the
refactor are:

1. As discussed in previous patches, there's no point in
enabling/disabling burst mode at runtime. Hence, we can drop the `en`
variable.
2. Replace the `extra_len` by `burst_len` where users have now to
explicitly define the size of the burst buffer. The point is to remove
the following line from the lib:

```
/* All but the timestamp channel */
burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
```

The library should not assume that a timestamp channel is defined.
Moreover, most parts also include some diagnostic data, crc, etc.. in
the burst buffer that needed to be included in an `extra_len` variable
which is not that nice. On top of this, some devices already start to
have some 32bit size channels ...

While doing this (and mainly when looking at the adis16400) drivers it
felt that the burst variables belong to the per chip `adis_data`
structure. As seen in the adis16400 driver, some drivers might support
multiple devices with different burst sizes.

For now, it does not feel necessary to wrap these variables in a
`adis_burst` structure but I don't see any problem in doing so if
required...

Nuno Sá (4):
  iio: adis: Move burst mode into adis_data
  iio: adis16400: Drop adis_burst usage
  iio: adis16475: Drop adis_burst usage
  iio: adis. Drop adis_burst struct

 drivers/iio/imu/adis16400.c   | 32 +++++++++++++-------------------
 drivers/iio/imu/adis16475.c   | 18 +++---------------
 drivers/iio/imu/adis_buffer.c | 12 +++++-------
 include/linux/iio/imu/adis.h  | 26 +++++++++-----------------
 4 files changed, 30 insertions(+), 58 deletions(-)

-- 
2.28.0

