Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A379516BED1
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 11:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgBYKdb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 05:33:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2178 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbgBYKda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 05:33:30 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PATLEH007210;
        Tue, 25 Feb 2020 05:33:29 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23ag9fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 05:33:28 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01PAXREI065399
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 05:33:27 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 05:33:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 25 Feb 2020 05:33:26 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 05:33:26 -0500
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PAXM2A029020;
        Tue, 25 Feb 2020 05:33:25 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 3/3] iio: imu: adis: add a note better explaining state_lock
Date:   Tue, 25 Feb 2020 12:33:19 +0200
Message-ID: <20200225103319.20751-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225103319.20751-1-alexandru.ardelean@analog.com>
References: <20200225103319.20751-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=876 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250084
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 'state_lock' mutex was renamed from 'txrx_lock' in a previous patch and
is intended to be used by ADIS drivers to protect the state of devices
during consecutive R/W ops.
The initial patch that introduced this change did not do a good [well, any]
job at explaining this. This patch adds a comment to the 'state_lock'
better explaining it's use.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 20339025c75f..dd8219138c2e 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -98,6 +98,17 @@ struct adis {
 	const struct adis_data	*data;
 	struct adis_burst	*burst;
 
+	/**
+	 * The state_lock is meant to be used during operations that require
+	 * a sequence of SPI R/W in order to protect the SPI transfer
+	 * information (fields 'xfer', 'msg' & 'current_page') between
+	 * potential concurrent accesses.
+	 * This lock is used by all "adis_{functions}" that have to read/write
+	 * registers. These functions also have unlocked variants
+	 * (see "__adis_{functions}"), which don't hold this lock.
+	 * This allows users of the ADIS library to group SPI R/W into
+	 * the drivers, but they also must manage this lock themselves.
+	 */
 	struct mutex		state_lock;
 	struct spi_message	msg;
 	struct spi_transfer	*xfer;
-- 
2.20.1

