Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C973047F3B4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhLYQLO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhLYQLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE12CC061759
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008DQ-LM; Sat, 25 Dec 2021 17:11:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dS-006ah4-BD; Sat, 25 Dec 2021 17:11:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dR-0007fc-DW; Sat, 25 Dec 2021 17:11:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de
Subject: [PATCH v1 09/23] counter: ftm-quaddec: Convert to counter_priv() wrapper
Date:   Sat, 25 Dec 2021 17:10:42 +0100
Message-Id: <20211225161056.682797-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Qqpt+RIrORwuC+ko5p/I1RZVPs6DxJb6yX67Xpe80y8=; m=O/hbHSowifJBTpUmrGb87d4c+26dGvtHSBxVMu37a1o=; p=6pn1OojDAH74dd/doVZuAymC4K8Kkh3FuAv9xfxzgvs=; g=310c4b20e4d7bee8e70610ad57b3dedc48ab7907
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQksACgkQwfwUeK3K7AkxhAf/Y7p olhsVfAca4oOlcTHm+hQP+ipzklEsT/3I4fidKMoowlMZQQxi5MfMFh+LUWnEFSJTOP1jqoOiMLYi M8MXJ/7U5T/T9v0t64y2DfOaRpkuRy5MJLExleiYnzE7uVC3ugrj/qxnCXLg5+yz/gx+Y6orBXSqN dC5cbs3zUjFXHDDlC9JRw/7nFlCBnKNPxKXAYpydgnTtnB+RD8LYnR7aB0REzfbaF3s5PzOGCcUVK RMsA9O3N0KWnew8TRbRpACO6RyN+aKvfdExBV562eOu8DVVuvfJ4C0bG8R+RN8bKmM9NBxybvuS+8 Bkc5zcz74uPRf3zfgdtXOb6VzkFZfdA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 9272f7b58beb..f5d92df6a611 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -118,7 +118,7 @@ static void ftm_quaddec_disable(void *ftm)
 static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 *cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = counter_priv(counter);
 	uint32_t scflags;
 
 	ftm_read(ftm, FTM_SC, &scflags);
@@ -131,7 +131,7 @@ static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 static int ftm_quaddec_set_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = counter_priv(counter);
 
 	mutex_lock(&ftm->ftm_quaddec_mutex);
 
@@ -162,7 +162,7 @@ static int ftm_quaddec_count_read(struct counter_device *counter,
 				  struct counter_count *count,
 				  u64 *val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = counter_priv(counter);
 	uint32_t cntval;
 
 	ftm_read(ftm, FTM_CNT, &cntval);
@@ -176,7 +176,7 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
 				   struct counter_count *count,
 				   const u64 val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = counter_priv(counter);
 
 	if (val != 0) {
 		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
-- 
2.33.0

