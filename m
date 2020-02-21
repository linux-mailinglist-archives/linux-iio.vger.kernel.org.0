Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B59167C74
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 12:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBULrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 06:47:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7090 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbgBULrG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 06:47:06 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LBiJKk027029;
        Fri, 21 Feb 2020 06:47:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8udupy15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 06:47:05 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01LBl4op029355
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Feb 2020 06:47:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 21 Feb
 2020 06:47:01 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 21 Feb 2020 06:47:01 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01LBku5O017142;
        Fri, 21 Feb 2020 06:46:59 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] iio: imu: adis: add a note better explaining state_lock
Date:   Fri, 21 Feb 2020 13:49:43 +0200
Message-ID: <20200221114943.2056-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221114943.2056-1-alexandru.ardelean@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=890
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210090
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
index 11c915b61ae2..a3110c097fa1 100644
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

