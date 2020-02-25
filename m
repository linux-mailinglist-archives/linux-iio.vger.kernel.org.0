Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C2916BED4
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 11:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgBYKdf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 05:33:35 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5482 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730292AbgBYKde (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 05:33:34 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PATLEI007210;
        Tue, 25 Feb 2020 05:33:33 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23ag9g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 05:33:33 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01PAXW2X065414
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 05:33:32 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 05:33:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 05:33:25 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 05:33:25 -0500
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PAXM28029020;
        Tue, 25 Feb 2020 05:33:23 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/3] iio: imu: adis: add doc-string for 'adis' struct
Date:   Tue, 25 Feb 2020 12:33:17 +0200
Message-ID: <20200225103319.20751-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250084
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds a doc-string for the 'adis' struct. It details the fields
and their roles.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* changed tx/rx descriptions to
  ```
  @tx: DMA safe TX buffer for SPI transfers
  @rx: DMA safe RX buffer for SPI transfers
  ```

 include/linux/iio/imu/adis.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index ac7cfd073804..63e456aa5c8a 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -73,6 +73,20 @@ struct adis_data {
 	bool has_paging;
 };
 
+/**
+ * struct adis - ADIS device instance data
+ * @spi: Reference to SPI device which owns this ADIS IIO device
+ * @trig: IIO trigger object data
+ * @data: ADIS chip variant specific data
+ * @burst: ADIS burst transfer information
+ * @state_lock: Lock used by the device to protect state
+ * @msg: SPI message object
+ * @xfer: SPI transfer objects to be used for a @msg
+ * @current_page: Some ADIS devices have registers, this selects current page
+ * @buffer: Data buffer for information read from the device
+ * @tx: DMA safe TX buffer for SPI transfers
+ * @rx: DMA safe RX buffer for SPI transfers
+ */
 struct adis {
 	struct spi_device	*spi;
 	struct iio_trigger	*trig;
-- 
2.20.1

