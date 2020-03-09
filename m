Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5713C17DD8B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 11:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgCIK3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 06:29:11 -0400
Received: from www381.your-server.de ([78.46.137.84]:42058 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIK3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 06:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B6b2qdDwyNWatuTkXFhqS6Z2F4cC0LJa+wztIyyq6oE=; b=A/kFPm3sd4RjHHm61mvpv92YDz
        ZFyRpxhYQZxrhFTLfdq+5gc9xDsj5WNUnXb+0ujgJJ+7tDV7wIqX++7LC4cwdgGJ0Wu5PpGEiOSK7
        2hoHA+bBIKskokldPUxr105JnI2Uu7cUlZxI1L4zimBIXp9JPXiJ8LlhO9DI1mMbO9RMq00Wp8/cM
        4Md5mNs0+JB0SDlUurqkox9O7gCRZ9mk1H3XeAIKDqwJsQstFHkH4vDQciP8C+5swqAOtBeSeG4vi
        kfRTtRCb5Mm06Js7diSU5Ybdps/rt23gac7pAp0LZtZ9PAwfS2sxgqXrdAE/jeERlAeiYmAsCHMfN
        2evt7cVw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jBFen-0005nx-AG; Mon, 09 Mar 2020 11:29:09 +0100
Received: from [93.104.119.198] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jBFen-0007W5-1g; Mon, 09 Mar 2020 11:29:09 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Lars=20M=C3=B6llendorf?= <lars.moellendorf@plating.de>
Subject: [PATCH] iio: xilinx-xadc: Fix typo in author's name
Date:   Mon,  9 Mar 2020 11:28:47 +0100
Message-Id: <20200309102847.14291-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25745/Sun Mar  8 12:10:36 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It appears the author of the xilinx-xadc driver can't even spell his own
name correctly. Fix that.

Reported-by: Lars Möllendorf <lars.moellendorf@plating.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 2 +-
 drivers/iio/adc/xilinx-xadc-events.c | 2 +-
 drivers/iio/adc/xilinx-xadc.h        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index ec227b358cd6..2d6505a66511 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -3,7 +3,7 @@
  * Xilinx XADC driver
  *
  * Copyright 2013-2014 Analog Devices Inc.
- *  Author: Lars-Peter Clauen <lars@metafoo.de>
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
  *
  * Documentation for the parts can be found at:
  *  - XADC hardmacro: Xilinx UG480
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index dbfd5da290a4..2357f585720a 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -3,7 +3,7 @@
  * Xilinx XADC driver
  *
  * Copyright 2013 Analog Devices Inc.
- *  Author: Lars-Peter Clauen <lars@metafoo.de>
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
 #include <linux/iio/events.h>
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 4017f18b0a4f..25abed9c0285 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -3,7 +3,7 @@
  * Xilinx XADC driver
  *
  * Copyright 2013 Analog Devices Inc.
- *  Author: Lars-Peter Clauen <lars@metafoo.de>
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
 #ifndef __IIO_XILINX_XADC__
-- 
2.20.1

