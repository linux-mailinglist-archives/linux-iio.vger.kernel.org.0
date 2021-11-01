Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4094419DC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 11:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhKAKaQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 06:30:16 -0400
Received: from www381.your-server.de ([78.46.137.84]:55824 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhKAKaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 06:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=6LjhSCB5QmSh6YRF6B+KB+CgVyC3VL7xH/m6PpKE+P8=; b=ffTdVICYSb6WuNHdmWUNNN1Xgg
        XVJl3r77HSEQD5gSQktEvPYckPtI/85npL5hCVYf9as3C4XCChTfvrUwLdu0EIJGYYeI0szLOnDbj
        ksb9/+bASsgHxV924S7zSseZ9S6i5M3qAYB5rb3MiN6bV4ZzIUBvyuLqsTrb7Wiz38HUwHBhFBzcz
        TqhI2rQwnGkB5Hkac4AgQ++sT6bwVQmyWFlVqTyYBrL9DRegLHFpQ6gTue4VpaowiqvwllIOyYZ7/
        SzwWP3U1m11HZNDIDVXA+mUn0ssp+F8a/PW3iC5lwG9IPe87nhNH2pNgE996I/VV98QqFbMb/1JOf
        OvbY0t1w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mhUXS-0006Yn-3n; Mon, 01 Nov 2021 11:27:38 +0100
Received: from [82.135.83.112] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mhUXR-000ACc-W6; Mon, 01 Nov 2021 11:27:38 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: mma8452: Use correct type for return variable in IRQ handler
Date:   Mon,  1 Nov 2021 11:27:34 +0100
Message-Id: <20211101102734.32291-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26340/Mon Nov  1 09:21:46 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IRQ handler's return type is irqreturn_t. The mma8452 uses a variable
to store the return value, but the variable is of type int. Change this to
irqreturn_t. This makes it easier to verify that the code is correct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 09c7f10fefb6..64b82b4503ad 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1053,7 +1053,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int ret = IRQ_NONE;
+	irqreturn_t ret = IRQ_NONE;
 	int src;
 
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
-- 
2.20.1

