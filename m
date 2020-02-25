Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1816C060
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgBYMJe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:09:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9840 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729458AbgBYMJd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:09:33 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PC70e7010523;
        Tue, 25 Feb 2020 07:09:32 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23agfxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:09:31 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01PC9Udq012341
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:09:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 25 Feb
 2020 07:09:29 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 07:09:29 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PC9N1H003238;
        Tue, 25 Feb 2020 07:09:29 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 5/6] iio: accel: adxl372: add additional events ABIs
Date:   Tue, 25 Feb 2020 14:09:08 +0200
Message-ID: <20200225120909.12629-6-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225120909.12629-1-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
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
 engine=8.12.0-2001150001 definitions=main-2002250098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adxl372 uses the standard event interface. The additional
ABIs aim to explain to the user that the values set in
./events/thresh_falling_period and ./events/thresh_rising_period
control the state of the device, not just the events timings.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/accel/adxl372.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e669eaaaa07e..9a7fa0d796f8 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -236,6 +236,29 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
 };
 
+static ssize_t adxl372_read_detect_event(struct iio_dev *indio_dev, uintptr_t p,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
+{
+	return sprintf(buf, "%s", (const char *)p);
+}
+
+static const struct iio_chan_spec_ext_info adxl372_ext_info[] = {
+	{
+		.name = "activity_detect_event",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = adxl372_read_detect_event,
+		.private = (uintptr_t)"in_accel_thresh_x_rising\n",
+	},
+	{
+		.name = "inactivity_detect_event",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = adxl372_read_detect_event,
+		.private = (uintptr_t)"in_accel_thresh_x_falling\n",
+	},
+	{},
+};
+
 static const struct iio_event_spec adxl372_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -267,7 +290,8 @@ static const struct iio_event_spec adxl372_events[] = {
 		.shift = 4,						\
 	},								\
 	.event_spec = adxl372_events,					\
-	.num_event_specs = 2						\
+	.num_event_specs = 2,						\
+	.ext_info = adxl372_ext_info,					\
 }
 
 static const struct iio_chan_spec adxl372_channels[] = {
-- 
2.20.1

