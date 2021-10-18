Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA724317CC
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhJRLtM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 07:49:12 -0400
Received: from asav22.altibox.net ([109.247.116.9]:43938 "EHLO
        asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJRLtM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 07:49:12 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 07:49:11 EDT
Received: from localhost.localdomain (211.81-166-168.customer.lyse.net [81.166.168.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: noralf.tronnes@ebnett.no)
        by asav22.altibox.net (Postfix) with ESMTPSA id D86FB20A22;
        Mon, 18 Oct 2021 13:37:42 +0200 (CEST)
From:   =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Jack Andersen <jackoalan@gmail.com>
Subject: [PATCH] iio: dln2-adc: Fix lockdep complaint
Date:   Mon, 18 Oct 2021 13:37:31 +0200
Message-Id: <20211018113731.25723-1-noralf@tronnes.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=PbrReBpd c=1 sm=1 tr=0
        a=OYZzhG0JTxDrWp/F2OJbnw==:117 a=OYZzhG0JTxDrWp/F2OJbnw==:17
        a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=pGLkceISAAAA:8 a=SJz97ENfAAAA:8
        a=VwQbUJbxAAAA:8 a=qOp6ErkcbECPE6MCkTgA:9 a=QEXdDO2ut3YA:10
        a=vFet0B0WnEQeilDPIY6i:22 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When reading the voltage:

$ cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw

Lockdep complains:

[  153.910616] ======================================================
[  153.916918] WARNING: possible circular locking dependency detected
[  153.923221] 5.14.0+ #5 Not tainted
[  153.926692] ------------------------------------------------------
[  153.932992] cat/717 is trying to acquire lock:
[  153.937525] c2585358 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_device_claim_direct_mode+0x28/0x44
[  153.946541]
               but task is already holding lock:
[  153.952487] c2585860 (&dln2->mutex){+.+.}-{3:3}, at: dln2_adc_read_raw+0x94/0x2bc [dln2_adc]
[  153.961152]
               which lock already depends on the new lock.

Fix this by not calling into the iio core underneath the dln2->mutex lock.

Fixes: 7c0299e879dd ("iio: adc: Add support for DLN2 ADC")
Cc: Jack Andersen <jackoalan@gmail.com>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---

Note that this patch is needed for the driver to be usable:

mfd: dln2: Add cell for initializing DLN2 ADC
https://lore.kernel.org/lkml/20211018112541.25466-1-noralf@tronnes.org/T/#u


 drivers/iio/adc/dln2-adc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 16407664182c..6c67192946aa 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -248,7 +248,6 @@ static int dln2_adc_set_chan_period(struct dln2_adc *dln2,
 static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
 {
 	int ret, i;
-	struct iio_dev *indio_dev = platform_get_drvdata(dln2->pdev);
 	u16 conflict;
 	__le16 value;
 	int olen = sizeof(value);
@@ -257,13 +256,9 @@ static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
 		.chan = channel,
 	};
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	ret = dln2_adc_set_chan_enabled(dln2, channel, true);
 	if (ret < 0)
-		goto release_direct;
+		return ret;
 
 	ret = dln2_adc_set_port_enabled(dln2, true, &conflict);
 	if (ret < 0) {
@@ -300,8 +295,6 @@ static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
 	dln2_adc_set_port_enabled(dln2, false, NULL);
 disable_chan:
 	dln2_adc_set_chan_enabled(dln2, channel, false);
-release_direct:
-	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -337,10 +330,16 @@ static int dln2_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+
 		mutex_lock(&dln2->mutex);
 		ret = dln2_adc_read(dln2, chan->channel);
 		mutex_unlock(&dln2->mutex);
 
+		iio_device_release_direct_mode(indio_dev);
+
 		if (ret < 0)
 			return ret;
 
-- 
2.33.0

