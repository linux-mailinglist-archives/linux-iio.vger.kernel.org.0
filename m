Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE63E4EA2ED
	for <lists+linux-iio@lfdr.de>; Tue, 29 Mar 2022 00:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiC1WSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 18:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiC1WSO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 18:18:14 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A94E21480C3;
        Mon, 28 Mar 2022 15:15:00 -0700 (PDT)
Received: from hp-amd-paul (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id cde6e2ef (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Mar 2022 21:28:46 +0000 (UTC)
Date:   Mon, 28 Mar 2022 16:28:45 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IIO: accel: dmard09: fixed code styling issues
Message-ID: <YkIojTZmFbFxVMyr@hp-amd-paul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cleaning up code.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 drivers/iio/accel/dmard09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index 53ab6078c..cb0246ca7 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -24,7 +24,7 @@
 #define DMARD09_AXIS_Y 1
 #define DMARD09_AXIS_Z 2
 #define DMARD09_AXIS_X_OFFSET ((DMARD09_AXIS_X + 1) * 2)
-#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1 )* 2)
+#define DMARD09_AXIS_Y_OFFSET ((DMARD09_AXIS_Y + 1) * 2)
 #define DMARD09_AXIS_Z_OFFSET ((DMARD09_AXIS_Z + 1) * 2)
 
 struct dmard09_data {
-- 
2.35.1

