Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5871995BC
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgCaLsu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:48:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58274 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730742AbgCaLsu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:48:50 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VBgdAq019423;
        Tue, 31 Mar 2020 07:48:31 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3023g58t7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 07:48:31 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02VBmTK7012158
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 31 Mar 2020 07:48:30 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Mar 2020 04:48:28 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Mar 2020 04:48:28 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 31 Mar 2020 04:48:28 -0700
Received: from NSA-L01.ad.analog.com (nsa-l01.ad.analog.com [10.32.224.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02VBmGgC024975;
        Tue, 31 Mar 2020 07:48:25 -0400
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
Subject: [PATCH v3 4/6] iio: adis: Support different burst sizes
Date:   Tue, 31 Mar 2020 13:48:09 +0200
Message-ID: <20200331114811.7978-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331114811.7978-1-nuno.sa@analog.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003310107
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add burst_max_len to `adis_burst`. This is useful for devices which
support different burst modes with different sizes. The buffer to be
used in the spi transfer is allocated with this variable making sure
that has space for all burst modes. The spi transfer length should hold
the "real" burst length depending on the current burst mode configured
in the device.

Moreover, `extra_len` in `adis_burst` is made const and it should
contain the smallest extra length necessary for a burst transfer. In
`struct adis` was added a new `burst_extra_len` that should hold the
extra bytes needed depending on the device instance being used.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
 * Nothing changed.

Changes in v3:
 * Reworked commit message;
 * Made `extra_len` const;
 * Added `burst_extra_len` to `struct adis`;
 * Changed adis16400 accordingly.

 drivers/iio/imu/adis16400.c   |  2 +-
 drivers/iio/imu/adis_buffer.c | 13 +++++++++----
 include/linux/iio/imu/adis.h  |  9 +++++++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 05e70c1c4835..ef9d26151448 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1194,7 +1194,7 @@ static int adis16400_probe(struct spi_device *spi)
 		indio_dev->available_scan_masks = st->avail_scan_mask;
 		st->adis.burst = &adis16400_burst;
 		if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
-			st->adis.burst->extra_len = sizeof(u16);
+			st->adis.burst_extra_len = sizeof(u16);
 	}
 
 	adis16400_data = &st->variant->adis_data;
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index c2211ab80d8c..22d95cb3ded8 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -23,25 +23,30 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask)
 {
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
-	unsigned int burst_length;
+	unsigned int burst_length, burst_max_length;
 	u8 *tx;
 
 	/* All but the timestamp channel */
 	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
-	burst_length += adis->burst->extra_len;
+	burst_length += adis->burst->extra_len + adis->burst_extra_len;
+
+	if (adis->burst->burst_max_len)
+		burst_max_length = adis->burst->burst_max_len;
+	else
+		burst_max_length = burst_length;
 
 	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
 	if (!adis->xfer)
 		return -ENOMEM;
 
-	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
+	adis->buffer = kzalloc(burst_max_length + sizeof(u16), GFP_KERNEL);
 	if (!adis->buffer) {
 		kfree(adis->xfer);
 		adis->xfer = NULL;
 		return -ENOMEM;
 	}
 
-	tx = adis->buffer + burst_length;
+	tx = adis->buffer + burst_max_length;
 	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
 	tx[1] = 0;
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 94031b3fc9d5..221715099429 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -83,6 +83,8 @@ struct adis_data {
  * @trig: IIO trigger object data
  * @data: ADIS chip variant specific data
  * @burst: ADIS burst transfer information
+ * @burst_extra_len: Burst extra length. Should only be used by devices that can
+ *		     dynamically change their burst mode length.
  * @state_lock: Lock used by the device to protect state
  * @msg: SPI message object
  * @xfer: SPI transfer objects to be used for a @msg
@@ -98,7 +100,7 @@ struct adis {
 
 	const struct adis_data	*data;
 	struct adis_burst	*burst;
-
+	unsigned int		burst_extra_len;
 	/**
 	 * The state_lock is meant to be used during operations that require
 	 * a sequence of SPI R/W in order to protect the SPI transfer
@@ -502,11 +504,14 @@ int adis_single_conversion(struct iio_dev *indio_dev,
  * @en			burst mode enabled
  * @reg_cmd		register command that triggers burst
  * @extra_len		extra length to account in the SPI RX buffer
+ * @burst_max_len	holds the maximum burst size when the device supports
+ *			more than one burst mode with different sizes
  */
 struct adis_burst {
 	bool		en;
 	unsigned int	reg_cmd;
-	unsigned int	extra_len;
+	const u32	extra_len;
+	const u32	burst_max_len;
 };
 
 int
-- 
2.17.1

