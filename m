Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AF72153AB
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jul 2020 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgGFIDM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jul 2020 04:03:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2880 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728640AbgGFIDL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2020 04:03:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0667tMTu013293;
        Mon, 6 Jul 2020 04:03:10 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 322km7e1e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 04:03:10 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 066838fc000899
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 6 Jul 2020 04:03:09 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Jul 2020 01:03:07 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Jul 2020 01:03:07 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 6 Jul 2020 01:03:07 -0700
Received: from saturn.ad.analog.com ([10.48.65.100])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 066832Sd010445;
        Mon, 6 Jul 2020 04:03:04 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: dac: ad5592r: un-indent code-block for scale read
Date:   Mon, 6 Jul 2020 14:02:58 +0300
Message-ID: <20200706110259.23947-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706110259.23947-1-alexandru.ardelean@analog.com>
References: <20200706110259.23947-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_04:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 cotscore=-2147483648 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007060063
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The next rework may require an unindentation of a code block in
ad5592r_read_raw(), which would make review a bit more difficult.

This change unindents the code block for reading the scale of the
non-temperature channels.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ad5592r-base.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index cc4875660a69..7ea79e9bfa1d 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -376,7 +376,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 {
 	struct ad5592r_state *st = iio_priv(iio_dev);
 	u16 read_val;
-	int ret;
+	int ret, mult;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -414,23 +414,21 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
 			return IIO_VAL_INT_PLUS_MICRO;
-		} else {
-			int mult;
+		}
 
-			mutex_lock(&st->lock);
+		mutex_lock(&st->lock);
 
-			if (chan->output)
-				mult = !!(st->cached_gp_ctrl &
-					AD5592R_REG_CTRL_DAC_RANGE);
-			else
-				mult = !!(st->cached_gp_ctrl &
-					AD5592R_REG_CTRL_ADC_RANGE);
+		if (chan->output)
+			mult = !!(st->cached_gp_ctrl &
+				AD5592R_REG_CTRL_DAC_RANGE);
+		else
+			mult = !!(st->cached_gp_ctrl &
+				AD5592R_REG_CTRL_ADC_RANGE);
 
-			*val *= ++mult;
+		*val *= ++mult;
 
-			*val2 = chan->scan_type.realbits;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
-		}
+		*val2 = chan->scan_type.realbits;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
 		ret = ad5592r_get_vref(st);
-- 
2.25.1

