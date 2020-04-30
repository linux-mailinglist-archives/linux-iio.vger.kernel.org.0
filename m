Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E829D1BF2AD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgD3IZA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 04:25:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56596 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgD3IZA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 04:25:00 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U8FOox015336;
        Thu, 30 Apr 2020 04:24:46 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30pes2ga6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:24:46 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03U8Oiaj034150
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 30 Apr 2020 04:24:45 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 30 Apr
 2020 01:24:43 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 30 Apr 2020 01:24:43 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03U8OeVK032631;
        Thu, 30 Apr 2020 04:24:40 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <Eugen.Hristev@microchip.com>, <Ludovic.Desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH] iio: __iio_update_buffers: Update mode before preenable/after postdisable
Date:   Thu, 30 Apr 2020 11:24:55 +0300
Message-ID: <20200430082455.1628-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_03:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

It is clear that we transition to INDIO_DIRECT_MODE when disabling the
buffer(s) and it is also clear that we transition from INDIO_DIRECT_MODE
when enabling the buffer(s). So leaving the currentmode field
INDIO_DIRECT_MODE until after the preenable() callback and updating it to
INDIO_DIRECT_MODE before the postdisable() callback doesn't add additional
value. On the other hand some drivers will need to perform different
actions depending on which mode the device is going to operate in/was
operating in.

Moving the update of currentmode before preenable() and after postdisable()
enables us to have drivers which perform mode dependent actions in those
callbacks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

This patch is also a V2 of this older patch from a while ago:
 https://lore.kernel.org/linux-iio/1431525891-19285-5-git-send-email-lars@metafoo.de/

However, in this recent context, it comes to fix this:
 https://lore.kernel.org/linux-iio/b9ab676489de3575984dac5610fcf05fd8742a38.camel@analog.com/T/#mc09284c8f79250b92a52fd5b8d1f541d1c02c0c0

At this point, I don't have a clear idea if this approach is good or
not; since the motivation is to fix the at91 adc.
Hence the RFC.

Some excerpt from the AT91 discussion:
-------------------------------------------------------------------
I decided to do a bit of shell magic for this:

get_files() {
git grep -w iio_buffer_setup_ops  | grep drivers | cut -d: -f1 | sort | uniq
}

for file in $(get_files) ; do
    if grep -q currentmode $file ; then
        echo $file
    fi
done

It finds 4 drivers.
Though, `get_files()` will return 56 files.

drivers/iio/accel/bmc150-accel-core.c
drivers/iio/adc/at91-sama5d2_adc.c
drivers/iio/adc/stm32-dfsdm-adc.c
drivers/iio/magnetometer/rm3100-core.c

The rm3100 driver doesn't do any checks in the setup_ops for 'currentmode' as
far as I could see.

So, Lars' patch could work nicely to fix this current case and not break others.

Semantically though, it would sound nicer to have a 'nextmode' parameter
somewhere; maybe on the setup_ops(indio_dev, nextmode)?
Though, only those 3 drivers would really ever use it; so doing it like that
sounds like overkill.

So, we're left with Lars' patch or we could add an 'indio_dev->nextmode' field,
that may be used in just these 3 drivers [which again: sounds overkill at this
point in time].

Alternatively, this 'indio_dev->currentmode' could be removed from all these 3
drivers somehow. But that needs testing and a thorough understanding of all 3
drivers and what they're doing, to do properly.
-------------------------------------------------------------------

 drivers/iio/industrialio-buffer.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 30af8af8f312..efcc44b62946 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -989,6 +989,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	indio_dev->active_scan_mask = config->scan_mask;
 	indio_dev->scan_timestamp = config->scan_timestamp;
 	indio_dev->scan_bytes = config->scan_bytes;
+	indio_dev->currentmode = config->mode;
 
 	iio_update_demux(indio_dev);
 
@@ -1024,8 +1025,6 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 			goto err_disable_buffers;
 	}
 
-	indio_dev->currentmode = config->mode;
-
 	if (indio_dev->setup_ops->postenable) {
 		ret = indio_dev->setup_ops->postenable(indio_dev);
 		if (ret) {
@@ -1042,10 +1041,10 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 					     buffer_list)
 		iio_buffer_disable(buffer, indio_dev);
 err_run_postdisable:
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
 	if (indio_dev->setup_ops->postdisable)
 		indio_dev->setup_ops->postdisable(indio_dev);
 err_undo_config:
+	indio_dev->currentmode = INDIO_DIRECT_MODE;
 	indio_dev->active_scan_mask = NULL;
 
 	return ret;
@@ -1080,8 +1079,6 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 			ret = ret2;
 	}
 
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
-
 	if (indio_dev->setup_ops->postdisable) {
 		ret2 = indio_dev->setup_ops->postdisable(indio_dev);
 		if (ret2 && !ret)
@@ -1090,6 +1087,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 
 	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
 	indio_dev->active_scan_mask = NULL;
+	indio_dev->currentmode = INDIO_DIRECT_MODE;
 
 	return ret;
 }
-- 
2.17.1

