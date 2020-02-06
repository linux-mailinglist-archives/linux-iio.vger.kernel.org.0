Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2330B154720
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 16:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBFPKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 10:10:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21762 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbgBFPKE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 10:10:04 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016F0MvK011983;
        Thu, 6 Feb 2020 10:09:43 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhm94w18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 10:09:43 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 016F9f25017984
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 6 Feb 2020 10:09:42 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 6 Feb 2020
 07:09:40 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 6 Feb 2020 10:09:40 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 016F9VRX021605;
        Thu, 6 Feb 2020 10:09:36 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v5 2/5] iio: amplifiers: ad8366: Add write_raw_get_fmt function
Date:   Thu, 6 Feb 2020 17:11:46 +0200
Message-ID: <20200206151149.32122-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206151149.32122-1-beniamin.bia@analog.com>
References: <20200206151149.32122-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=1 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=892 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060114
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add write_raw_get_fmt function to specify conversion for
hardware gain.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v5:
-nothing changed

 drivers/iio/amplifiers/ad8366.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 0176d3d8cc9c..95972ab60f42 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -180,9 +180,22 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad8366_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad8366_info = {
 	.read_raw = &ad8366_read_raw,
 	.write_raw = &ad8366_write_raw,
+	.write_raw_get_fmt = &ad8366_write_raw_get_fmt,
 };
 
 #define AD8366_CHAN(_channel) {				\
-- 
2.17.1

