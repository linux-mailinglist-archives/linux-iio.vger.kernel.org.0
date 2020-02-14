Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB7D15D646
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBNLHj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 06:07:39 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:29979 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgBNLHj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 06:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581678457;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=YyDFw5TguckXzOIfpbwtA2u8J5qqnlddwqEV2aVIVII=;
        b=pXj0TI6c/JHfP90Jtqe0BESLqhKoyQO3oicet4w16l92yZntRKja5V5OMK7cZfpdZc
        8RDXDxVsBhEvrKZoQA5Yjw37AtYWW7t4t/LBi6Y7EZK9xLwcC0Xx0KH/rnFajfgqUttG
        uI867Kfvp/DOvbkft/Lb8ExewOh9xOTBctPTQ3+TQYMt52wRkswus6nUy4vXHFxhfnPN
        inK3y9gO24mrwZtnpaPHmD8kKtd4eGGGO8SWdBUHyOL/bIFLe6KNVit1agnHpemqoSLK
        MakWYLP8RGMq9Y7FuI1yJ3N97FrLQjLMd6oz86wP/0RKGQCI1IaERpeHxvPZpvtcmyPZ
        Rc6g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXucnvtxFRYw=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id a01fe9w1EB4bPG0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 14 Feb 2020 12:04:37 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: magnetometer: ak8974: Fix negative raw values in sysfs
Date:   Fri, 14 Feb 2020 12:03:24 +0100
Message-Id: <20200214110324.70972-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

At the moment, reading from in_magn_*_raw in sysfs tends to return
large values around 65000, even though the output of ak8974 is actually
limited to ±32768. This happens because the value is never converted
to the signed 16-bit integer variant.

Add an explicit cast to s16 to fix this.

Cc: Linus Walleij <linus.walleij@linaro.org>
Fixes: 7c94a8b2ee8c ("iio: magn: add a driver for AK8974")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/magnetometer/ak8974.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index fc7e910f8e8b..d32996702110 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -564,7 +564,7 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
 		 * We read all axes and discard all but one, for optimized
 		 * reading, use the triggered buffer.
 		 */
-		*val = le16_to_cpu(hw_values[chan->address]);
+		*val = (s16)le16_to_cpu(hw_values[chan->address]);
 
 		ret = IIO_VAL_INT;
 	}
-- 
2.25.0

