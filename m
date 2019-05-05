Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33671421B
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 21:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEETdY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 15:33:24 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:7735 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfEETdY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 May 2019 15:33:24 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 15:33:23 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AzBQC4N89c/49dJa1lHgEGBwaBZYI?=
 =?us-ascii?q?RgToBMiizfRCEbYIIIzgTAQMBAQQBAQIBAm0ohXhSKYEVE4MiggurFzOIY4F?=
 =?us-ascii?q?FFIEehniEVheBf4RhhA2GGQSLDYg8ZJMFCYILVpFjJ26UWokQLZdvgWYhgVY?=
 =?us-ascii?q?zGggbFYMnkHEfAzCObYJSAQE?=
X-IronPort-AV: E=Sophos;i="5.60,435,1549929600"; 
   d="scan'208";a="269719885"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 05 May 2019 19:26:18 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id x45JQGbM023060;
        Sun, 5 May 2019 19:26:17 GMT
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     xe-linux-external@cisco.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: dac: ds4422/ds4424 fix chip verification
Date:   Sun,  5 May 2019 12:24:37 -0700
Message-Id: <20190505192438.2644-2-ruslan@babayev.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ds4424_get_value function takes channel number as it's 3rd
argument and translates it internally into I2C address using
DS4424_DAC_ADDR macro. The caller ds4424_verify_chip was passing an
already translated I2C address as its last argument.

Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
Cc: xe-linux-external@cisco.com
---
 drivers/iio/dac/ds4424.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 2b3ba1a66fe8..ae9be792693b 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -166,7 +166,7 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
 {
 	int ret, val;
 
-	ret = ds4424_get_value(indio_dev, &val, DS4424_DAC_ADDR(0));
+	ret = ds4424_get_value(indio_dev, &val, 0);
 	if (ret < 0)
 		dev_err(&indio_dev->dev,
 				"%s failed. ret: %d\n", __func__, ret);
-- 
2.17.1

