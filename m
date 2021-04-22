Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ADE367E6D
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhDVKRh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 06:17:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49660 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235782AbhDVKRg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 06:17:36 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MAGK9a009171;
        Thu, 22 Apr 2021 06:16:51 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3834980gbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 06:16:51 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13MAGods039917
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Apr 2021 06:16:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 22 Apr 2021
 06:16:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Thu, 22 Apr 2021 06:16:49 -0400
Received: from nsa.sphairon.box ([10.44.3.58])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13MAGffI027460;
        Thu, 22 Apr 2021 06:16:47 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 7/9] iio: adis: add burst_max_speed_hz variable
Date:   Thu, 22 Apr 2021 12:19:09 +0200
Message-ID: <20210422101911.135630-8-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422101911.135630-1-nuno.sa@analog.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: mo3vkqJa6csDYODn3C_IhBvaLl3CHwE8
X-Proofpoint-GUID: mo3vkqJa6csDYODn3C_IhBvaLl3CHwE8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_04:2021-04-21,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Typically, in burst mode, the device cannot operate at it's full spi
speed. Hence, the spi transfers for burst mode have to take this into
account. With this change we avoid a potential race with the spi core as
drivers were 'hacking' the device 'max_speed_hz' directly in the
trigger handler.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 4 ++++
 include/linux/iio/imu/adis.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index dda367071980..82239da2f441 100644
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

