Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F753178CA1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgCDIj2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 03:39:28 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54480 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgCDIj2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 03:39:28 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0248UCGJ020216;
        Wed, 4 Mar 2020 03:39:25 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ygm52abvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 03:39:25 -0500
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0248dNFX036291
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 4 Mar 2020 03:39:24 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 00:39:22 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 00:39:22 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 4 Mar 2020 00:39:22 -0800
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0248dJYq021800;
        Wed, 4 Mar 2020 03:39:19 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/2] iio: at91-sama5d2_adc: split at91_adc_current_chan_is_touch() helper
Date:   Wed, 4 Mar 2020 10:42:18 +0200
Message-ID: <20200304084219.20810-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-03,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change moves the logic to check if the current channel is the
touchscreen channel to a separate helper.
This reduces some code duplication, but the main intent is to re-use this
in the next patches.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

This patchset continues discussion:
   https://lore.kernel.org/linux-iio/20191023082508.17583-1-alexandru.ardelean@analog.com/
Apologies for the delay.

Changelog v1 -> v2:
* added patch 'iio: at91-sama5d2_adc: split at91_adc_current_chan_is_touch()
  helper'
* renamed at91_adc_buffer_postenable() -> at91_adc_buffer_preenable()
  - at91_adc_buffer_postenable() - now just calls
    iio_triggered_buffer_postenable() if the channel isn't the touchscreen
    channel
* renamed at91_adc_buffer_predisable() -> at91_adc_buffer_postdisable()
  - at91_adc_buffer_predisable() - now just calls
    iio_triggered_buffer_predisable() if the channel isn't the touchscreen
    channel

 drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a5c7771227d5..f2a74c47c768 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -873,18 +873,24 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+
+	return !!bitmap_subset(indio_dev->active_scan_mask,
+			       &st->touch_st.channels_bitmask,
+			       AT91_SAMA5D2_MAX_CHAN_IDX + 1);
+}
+
 static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	/* check if we are enabling triggered buffer or the touchscreen */
-	if (bitmap_subset(indio_dev->active_scan_mask,
-			  &st->touch_st.channels_bitmask,
-			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
-		/* touchscreen enabling */
+	if (at91_adc_current_chan_is_touch(indio_dev))
 		return at91_adc_configure_touch(st, true);
-	}
+
 	/* if we are not in triggered mode, we cannot enable the buffer. */
 	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
@@ -906,12 +912,9 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 	u8 bit;
 
 	/* check if we are disabling triggered buffer or the touchscreen */
-	if (bitmap_subset(indio_dev->active_scan_mask,
-			  &st->touch_st.channels_bitmask,
-			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
-		/* touchscreen disable */
+	if (at91_adc_current_chan_is_touch(indio_dev))
 		return at91_adc_configure_touch(st, false);
-	}
+
 	/* if we are not in triggered mode, nothing to do here */
 	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
@@ -1886,14 +1889,10 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 		return 0;
 
 	/* check if we are enabling triggered buffer or the touchscreen */
-	if (bitmap_subset(indio_dev->active_scan_mask,
-			  &st->touch_st.channels_bitmask,
-			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
-		/* touchscreen enabling */
+	if (at91_adc_current_chan_is_touch(indio_dev))
 		return at91_adc_configure_touch(st, true);
-	} else {
+	else
 		return at91_adc_configure_trigger(st->trig, true);
-	}
 
 	/* not needed but more explicit */
 	return 0;
-- 
2.20.1

