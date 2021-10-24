Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A15438ADA
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhJXRPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 13:15:37 -0400
Received: from www381.your-server.de ([78.46.137.84]:54156 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhJXRPg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2021 13:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=Dwzu+VCYET1CP10+5+7RkGGIT/ZdlZtPJzTzWAcQDyY=; b=CVAgeXH3FxM3ntESJ+IVqvuUAN
        ZNSrBuGKC53TsiWjc0g7+WwJzN3nvGIQnKPeHSEYiN1DQlc0BPrvi4PxV76BkTCh6Qg3/FNa+an8i
        88GyYwMf/0kg+M/Bgkk9JKpLnGhJ43Ta8fJ9efiXz9AsTl084x+zzZyUrLWFt6TRMWPQ3Y80kOTUu
        gZ96nXe7RrS5GeXhTZ5UDkbrhP3FmUA0hwGwAipotKOaZZC4qS9bCwMYnLOg0fSOks7vKYEVtrtYx
        n3tGD2MEvCjhV6/Svaj8v0udiD6CrK7B7H2t/jt/2uinJ8+99bzLKUVygBmdNcrgmDf1JcDEZjn1e
        4YklpJAw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meh3Y-000BgR-Vz; Sun, 24 Oct 2021 19:13:13 +0200
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meh3Y-000VNB-Qd; Sun, 24 Oct 2021 19:13:12 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tiberiu Breana <tiberiu.a.breana@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio: ltr501: Don't return error code in trigger handler
Date:   Sun, 24 Oct 2021 19:12:49 +0200
Message-Id: <20211024171251.22896-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26332/Sun Oct 24 10:18:48 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO trigger handlers need to return one of the irqreturn_t values.
Returning an error code is not supported.

The ltr501 interrupt handler gets this right for most error paths, but
there is one case where it returns the error code.

In addition for this particular case the trigger handler does not call
`iio_trigger_notify_done()`. Which when not done keeps the triggered
disabled forever.

Modify the code so that the function returns a valid irqreturn_t value as
well as calling `iio_trigger_notify_done()` on all exit paths.

Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7e51aaac0bf8..b2983b1a9ed1 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1275,7 +1275,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 		ret = regmap_bulk_read(data->regmap, LTR501_ALS_DATA1,
 				       als_buf, sizeof(als_buf));
 		if (ret < 0)
-			return ret;
+			goto done;
 		if (test_bit(0, indio_dev->active_scan_mask))
 			scan.channels[j++] = le16_to_cpu(als_buf[1]);
 		if (test_bit(1, indio_dev->active_scan_mask))
-- 
2.20.1

