Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0055E26E519
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIQTLD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 15:11:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55492 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728412AbgIQQUN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 12:20:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HFTf43001204;
        Thu, 17 Sep 2020 11:50:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p677u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 11:50:56 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08HFos1O011815
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Sep 2020 11:50:55 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 17 Sep
 2020 08:51:00 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 17 Sep 2020 08:51:00 -0700
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08HFojFM030124;
        Thu, 17 Sep 2020 11:50:51 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] iio: adis. Drop adis_burst struct
Date:   Thu, 17 Sep 2020 17:52:23 +0200
Message-ID: <20200917155223.218500-5-nuno.sa@analog.com>
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

As there are no users anymore of this structure, it can be safely
removed.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/iio/imu/adis.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index c502ea3b9199..04e96d688ba9 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -20,7 +20,6 @@
 #define ADIS_REG_PAGE_ID 0x00
 
 struct adis;
-struct adis_burst;
 
 /**
  * struct adis_timeouts - ADIS chip variant timeouts
@@ -108,7 +107,6 @@ struct adis {
 	struct iio_trigger	*trig;
 
 	const struct adis_data	*data;
-	struct adis_burst	*burst;
 	unsigned int		burst_extra_len;
 	/**
 	 * The state_lock is meant to be used during operations that require
@@ -508,21 +506,6 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 
 #ifdef CONFIG_IIO_ADIS_LIB_BUFFER
 
-/**
- * struct adis_burst - ADIS data for burst transfers
- * @en			burst mode enabled
- * @reg_cmd		register command that triggers burst
- * @extra_len		extra length to account in the SPI RX buffer
- * @burst_max_len	holds the maximum burst size when the device supports
- *			more than one burst mode with different sizes
- */
-struct adis_burst {
-	bool		en;
-	unsigned int	reg_cmd;
-	const u32	extra_len;
-	const u32	burst_max_len;
-};
-
 int
 devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 				   irq_handler_t trigger_handler);
-- 
2.28.0

