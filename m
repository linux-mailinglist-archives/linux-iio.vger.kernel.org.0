Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C343436C13A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhD0Ix3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:53:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42626 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhD0Ix3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:53:29 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13R8osKA005256;
        Tue, 27 Apr 2021 04:52:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3866auh9dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 04:52:34 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13R8qXBu034000
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Apr 2021 04:52:33 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 27 Apr 2021 04:52:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 27 Apr 2021 04:52:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 27 Apr 2021 04:52:31 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13R8qNJo007577;
        Tue, 27 Apr 2021 04:52:28 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v3 4/6] iio: adis: add burst_max_speed_hz variable
Date:   Tue, 27 Apr 2021 10:54:52 +0200
Message-ID: <20210427085454.30616-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427085454.30616-1-nuno.sa@analog.com>
References: <20210427085454.30616-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: CFpCoVPB1_FnJEqRj_cvhVrVwFOE8U1g
X-Proofpoint-GUID: CFpCoVPB1_FnJEqRj_cvhVrVwFOE8U1g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_05:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Typically, in burst mode, the device cannot operate at it's full spi
speed. Hence, the spi transfers for burst mode have to take this into
account. With this change we avoid a potential race with the spi core as
drivers were 'hacking' the device 'max_speed_hz' directly in the
trigger handler.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 4 ++++
 include/linux/iio/imu/adis.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index f6dbfbd17d41..351c303c8a8c 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -51,9 +51,13 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 	adis->xfer[0].tx_buf = tx;
 	adis->xfer[0].bits_per_word = 8;
 	adis->xfer[0].len = 2;
+	if (adis->data->burst_max_speed_hz)
+		adis->xfer[0].speed_hz = adis->data->burst_max_speed_hz;
 	adis->xfer[1].rx_buf = adis->buffer;
 	adis->xfer[1].bits_per_word = 8;
 	adis->xfer[1].len = burst_length;
+	if (adis->data->burst_max_speed_hz)
+		adis->xfer[1].speed_hz = adis->data->burst_max_speed_hz;
 
 	spi_message_init(&adis->msg);
 	spi_message_add_tail(&adis->xfer[0], &adis->msg);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index f9b728d490b1..cf49997d5903 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -55,6 +55,7 @@ struct adis_timeout {
  *			this should be the minimum size supported by the device.
  * @burst_max_len:	Holds the maximum burst size when the device supports
  *			more than one burst mode with different sizes
+ * @burst_max_speed_hz:	Maximum spi speed that can be used in burst mode
  */
 struct adis_data {
 	unsigned int read_delay;
@@ -83,6 +84,7 @@ struct adis_data {
 	unsigned int burst_reg_cmd;
 	unsigned int burst_len;
 	unsigned int burst_max_len;
+	unsigned int burst_max_speed_hz;
 };
 
 /**
-- 
2.31.1

