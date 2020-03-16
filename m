Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB6186B78
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgCPMwq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 08:52:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37918 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730982AbgCPMwq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 08:52:46 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GCppZL024408;
        Mon, 16 Mar 2020 08:52:24 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yrv64ny49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 08:52:24 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02GCqNEq027813
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 16 Mar 2020 08:52:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 16 Mar
 2020 08:52:22 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 16 Mar 2020 08:52:22 -0400
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02GCqD8J003537;
        Mon, 16 Mar 2020 08:52:20 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 4/6] iio: adis: Add burst_max_len variable
Date:   Mon, 16 Mar 2020 13:53:10 +0100
Message-ID: <20200316125312.39178-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316125312.39178-1-nuno.sa@analog.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_03:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160064
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

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis_buffer.c | 11 ++++++++---
 include/linux/iio/imu/adis.h  |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 7871b468e9e9..ddf4bdca7e72 100644
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
 	burst_length += adis->burst->extra_len;
 
+	if (adis->burst->burst_max_len)
+		burst_max_length = adis->burst->burst_max_len;
+	else
+		burst_max_length = burst_length;
+
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
index 94031b3fc9d5..5bdd6f457e78 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -502,11 +502,14 @@ int adis_single_conversion(struct iio_dev *indio_dev,
  * @en			burst mode enabled
  * @reg_cmd		register command that triggers burst
  * @extra_len		extra length to account in the SPI RX buffer
+ * @burst_max_len	holds the maximum burst size when the device supports
+ *			more than one burst mode with different sizes
  */
 struct adis_burst {
 	bool		en;
 	unsigned int	reg_cmd;
 	unsigned int	extra_len;
+	const u32	burst_max_len;
 };
 
 int
-- 
2.25.1

