Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE427BD9A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgI2HKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 03:10:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9590 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgI2HKL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 03:10:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T75BKp016052;
        Tue, 29 Sep 2020 03:10:07 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg625dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 03:10:07 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08T7A5hW049604
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 03:10:06 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 29 Sep
 2020 00:09:58 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 00:09:58 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08T79hUp013506;
        Tue, 29 Sep 2020 03:09:59 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 6/9] iio: adc: at91-sama5d2_adc: use devm_iio_triggered_buffer_setup_ext()
Date:   Tue, 29 Sep 2020 10:09:05 +0300
Message-ID: <20200929070908.10456-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929070908.10456-1-alexandru.ardelean@analog.com>
References: <20200929070908.10456-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change switches to the new devm_iio_triggered_buffer_setup_ext()
function and removes the iio_buffer_set_attrs() call, for assigning the
HW FIFO attributes to the buffer.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b9c3cc6d5913..b012ce766f91 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1665,11 +1665,17 @@ static int at91_adc_buffer_and_trigger_init(struct device *dev,
 					    struct iio_dev *indio)
 {
 	struct at91_adc_state *st = iio_priv(indio);
+	const struct attribute **fifo_attrs;
 	int ret;
 
-	ret = devm_iio_triggered_buffer_setup(&indio->dev, indio,
+	if (st->selected_trig->hw_trig)
+		fifo_attrs = at91_adc_fifo_attributes;
+	else
+		fifo_attrs = NULL;
+
+	ret = devm_iio_triggered_buffer_setup_ext(&indio->dev, indio,
 		&iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
+		&at91_adc_trigger_handler, &at91_buffer_setup_ops, fifo_attrs);
 	if (ret < 0) {
 		dev_err(dev, "couldn't initialize the buffer.\n");
 		return ret;
@@ -1678,8 +1684,6 @@ static int at91_adc_buffer_and_trigger_init(struct device *dev,
 	if (!st->selected_trig->hw_trig)
 		return 0;
 
-	iio_buffer_set_attrs(indio->buffer, at91_adc_fifo_attributes);
-
 	st->trig = at91_adc_allocate_trigger(indio, st->selected_trig->name);
 	if (IS_ERR(st->trig)) {
 		dev_err(dev, "could not allocate trigger\n");
-- 
2.17.1

