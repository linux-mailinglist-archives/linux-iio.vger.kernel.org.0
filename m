Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB79C26E28F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIQRgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 13:36:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54832 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbgIQRgN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 13:36:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HFTbX3001173;
        Thu, 17 Sep 2020 11:50:52 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p677tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 11:50:52 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08HFopmR011794
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Sep 2020 11:50:51 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 17 Sep 2020 08:50:57 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 17 Sep 2020 08:50:57 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 17 Sep 2020 08:50:56 -0700
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08HFojFJ030124;
        Thu, 17 Sep 2020 11:50:47 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] iio: adis: Move burst mode into adis_data
Date:   Thu, 17 Sep 2020 17:52:20 +0200
Message-ID: <20200917155223.218500-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917155223.218500-1-nuno.sa@analog.com>
References: <20200917155223.218500-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_10:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=1
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170119
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add burst mode variables in the per device specific data structure. As
some drivers support multiple devices with different burst sizes it
makes sense this data to be in `adis_data`. While moving the variables,
there are two main differences:

1. The `en`variable is dropped. If a device supports burst mode, it will
just use it as it will has better performance for almost all real use
cases.
2. Replace `extra_len` by `burst_len`. Users should now explicitly
define the length of the burst buffer as it is typically constant. This
also allows to remove the following line from the library:

```
/* All but the timestamp channel */
burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
```

The library should not assume that a timestamp channel is defined.
Moreover, most parts also include some diagnostic data, crc, etc.. in
the burst buffer that needed to be included in an `extra_len` variable
which is not that nice. On top of this, some devices already start to
have some 32bit size channels ...

This patch is also a move to completely drop the `struct adis_burst`
from the library.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 12 +++++-------
 include/linux/iio/imu/adis.h  |  9 +++++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index df6144285470..ac354321f63a 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -26,12 +26,10 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 	unsigned int burst_length, burst_max_length;
 	u8 *tx;
 
-	/* All but the timestamp channel */
-	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
-	burst_length += adis->burst->extra_len + adis->burst_extra_len;
+	burst_length = adis->data->burst_len + adis->burst_extra_len;
 
-	if (adis->burst->burst_max_len)
-		burst_max_length = adis->burst->burst_max_len;
+	if (adis->data->burst_max_len)
+		burst_max_length = adis->data->burst_max_len;
 	else
 		burst_max_length = burst_length;
 
@@ -47,7 +45,7 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 	}
 
 	tx = adis->buffer + burst_max_length;
-	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
+	tx[0] = ADIS_READ_REG(adis->data->burst_reg_cmd);
 	tx[1] = 0;
 
 	adis->xfer[0].tx_buf = tx;
@@ -76,7 +74,7 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 	kfree(adis->xfer);
 	kfree(adis->buffer);
 
-	if (adis->burst && adis->burst->en)
+	if (adis->data->burst_len)
 		return adis_update_scan_mode_burst(indio_dev, scan_mask);
 
 	scan_count = indio_dev->scan_bytes / 2;
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 01ba691da2f3..c502ea3b9199 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -51,6 +51,11 @@ struct adis_timeout {
  * @timeouts: Chip specific delays
  * @enable_irq: Hook for ADIS devices that have a special IRQ enable/disable
  * @has_paging: True if ADIS device has paged registers
+ * @burst_reg_cmd:	Register command that triggers burst
+ * @burst_len:		Burst size in the SPI RX buffer. If @burst_max_len is defined,
+ *			this should be the minimum size supported by the device.
+ * @burst_max_len:	Holds the maximum burst size when the device supports
+ *			more than one burst mode with different sizes
  */
 struct adis_data {
 	unsigned int read_delay;
@@ -75,6 +80,10 @@ struct adis_data {
 	int (*enable_irq)(struct adis *adis, bool enable);
 
 	bool has_paging;
+
+	unsigned int burst_reg_cmd;
+	unsigned int burst_len;
+	unsigned int burst_max_len;
 };
 
 /**
-- 
2.28.0

