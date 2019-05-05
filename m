Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA30914219
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 21:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfEETdX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 15:33:23 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:7735 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEETdX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 May 2019 15:33:23 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 15:33:23 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AzBQC4N89c/49dJa1lHgEGBwaBZYI?=
 =?us-ascii?q?RgToBMiizfRCEbYIIIzgTAQMBAQQBAQIBAm0ohXhSKYEVE4MiggurFzOIY4F?=
 =?us-ascii?q?FFIEehniEVheBf4ERg1CKJgSTSZNpCYILVpFjJ26UWi2IY5gcgWYhgVYzGgg?=
 =?us-ascii?q?bFYMnkHEfAzCRPwEB?=
X-IronPort-AV: E=Sophos;i="5.60,435,1549929600"; 
   d="scan'208";a="269719874"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 05 May 2019 19:26:17 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id x45JQGbL023060;
        Sun, 5 May 2019 19:26:16 GMT
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     xe-linux-external@cisco.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: dac: ds4422/ds4424 drop of_node check
Date:   Sun,  5 May 2019 12:24:36 -0700
Message-Id: <20190505192438.2644-1-ruslan@babayev.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver doesn't actually rely on any DT properties. Removing this
check makes it usable on ACPI based platforms.

Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
Cc: xe-linux-external@cisco.com
---
 drivers/iio/dac/ds4424.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 883a47562055..2b3ba1a66fe8 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -236,12 +236,6 @@ static int ds4424_probe(struct i2c_client *client,
 	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->dev.parent = &client->dev;
 
-	if (!client->dev.of_node) {
-		dev_err(&client->dev,
-				"Not found DT.\n");
-		return -ENODEV;
-	}
-
 	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(data->vcc_reg)) {
 		dev_err(&client->dev,
-- 
2.17.1

