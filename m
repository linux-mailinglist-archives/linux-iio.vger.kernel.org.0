Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D0178D7D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 10:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgCDJdo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 04:33:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54020 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728744AbgCDJdo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 04:33:44 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0249IkHl010160;
        Wed, 4 Mar 2020 04:33:40 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnranteg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 04:33:39 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0249Xc30047386
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 4 Mar 2020 04:33:38 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 01:33:37 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 4 Mar 2020 01:33:36 -0800
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0249XYC0029310;
        Wed, 4 Mar 2020 04:33:34 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <mranostay@gmail.com>,
        <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: potentiostat: lmp9100: fix iio_triggered_buffer_{predisable,postenable} positions
Date:   Wed, 4 Mar 2020 11:36:33 +0200
Message-ID: <20200304093633.32264-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=933 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

The lmp9100 was attaching a poll function but never detaching it via any
IIO disable hook.

This change adds the detaching of the poll function, and moves/renames
lmp91000_buffer_preenable() function to lmp91000_buffer_postenable().
The idea is to make it more symmetrical, so that when the
iio_triggered_buffer_{predisable,postenable} functions get removed, it's
easier to see.

Fixes: 67e17300dc1d7 ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/potentiostat/lmp91000.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index a0e5f530faa9..72c814fd63a7 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -275,11 +275,16 @@ static int lmp91000_buffer_cb(const void *val, void *private)
 static const struct iio_trigger_ops lmp91000_trigger_ops = {
 };
 
-static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
+static int lmp91000_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct lmp91000_data *data = iio_priv(indio_dev);
+	int err;
 
-	return iio_channel_start_all_cb(data->cb_buffer);
+	err = iio_channel_start_all_cb(data->cb_buffer);
+	if (err)
+		iio_triggered_buffer_predisable(indio_dev);
+
+	return err;
 }
 
 static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
@@ -288,12 +293,11 @@ static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
 
 	iio_channel_stop_all_cb(data->cb_buffer);
 
-	return 0;
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
-	.preenable = lmp91000_buffer_preenable,
-	.postenable = iio_triggered_buffer_postenable,
+	.postenable = lmp91000_buffer_postenable,
 	.predisable = lmp91000_buffer_predisable,
 };
 
-- 
2.20.1

