Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4E167C71
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBULrD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:47:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4674 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727655AbgBULrD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 06:47:03 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LBiAFI026928;
        Fri, 21 Feb 2020 06:47:01 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8udupy14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 06:47:01 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01LBl0Nu063040
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Feb 2020 06:47:00 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 21 Feb
 2020 06:46:59 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 21 Feb 2020 06:46:59 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01LBku5M017142;
        Fri, 21 Feb 2020 06:46:57 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: imu: adis: add doc-string for 'adis' struct
Date:   Fri, 21 Feb 2020 13:49:41 +0200
Message-ID: <20200221114943.2056-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=988
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210090
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds a doc-string for the 'adis' struct. It details the fields
and their roles.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index ac7cfd073804..0787a3aabd05 100644
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
+ * @tx: Cacheline aligned TX buffer for SPI transfers
+ * @rx: Cacheline aligned RX buffer for SPI transfers
+ */
 struct adis {
 	struct spi_device	*spi;
 	struct iio_trigger	*trig;
-- 
2.20.1

