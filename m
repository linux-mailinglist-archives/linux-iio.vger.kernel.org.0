Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311036D64E4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjDDOMS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjDDOMO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 10:12:14 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8903ABD
        for <linux-iio@vger.kernel.org>; Tue,  4 Apr 2023 07:12:10 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id m16so18497510ybk.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2023 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680617530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDg8gjgCK4cCzQVwhhCZvTIORe+B4i8BW2+BbUTMc8k=;
        b=DiobnlWTCEyBk4WPYFAHKg30bRzkskmSJ72Wcz0czZXBfiyEDWRHKO9j7HFFgmztHX
         xTXtdNMXXSAw/AMwjYmqyhquuzlygHqo1/eOGOM8k1x+2K95ixzBaZ3AzQVnLBYkVssL
         is9Dub6pRZJl9zSbNIakbfXudTP0IXFFXRKemRvFcXaYEfRE+jMAgdIu9rqNCsCKcqH+
         NH2mMYvnftLWNjIjTz9qQEeVS04uRRKlmWRk2lVyO526Mp6wwBPvwvi7OOh9JxSVRmAv
         Dq3fsXDYkQoXuTcX4jJE2kPlWqfV+GN7mu/Hnmvpj4yC8MNr7lkMYkVANC/PFdK8DxEG
         jVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDg8gjgCK4cCzQVwhhCZvTIORe+B4i8BW2+BbUTMc8k=;
        b=QRizWtuJI63+DxCdoH3nMGVUiHjPgcw1k++BX199yq7p4cH4qYFVZXMDaz6PRk+BmZ
         MDXUzs021HL85r+L7xfzxuVRMQp8Qc77R6nIVKFmUPGK83xB2sEY/q95kgHaFDff6cod
         K7Als+ENQidouydFd3mqclkFhctXUIu39f5QZeGkkIwBVdt0d/WWUcfKSMKDKryPywG+
         54H57f7WyKylUk5g3jMi/cZLj0cOxaypa7bWYh9WL+o3pBTeKrRy8YMG4++oHCxCAa6H
         ieGZwT610CbImFp6FdAyJouuARYsVkqls4q/NSEoqGotzuQxpCZmm/6G0osUUWX2DQ0k
         Jh9g==
X-Gm-Message-State: AAQBX9cCp3X9NRJJU0WXnH5qsQNQBgTyp0OBlKeqRxuYYJtkDo4q3Khd
        K1J3xvf+MG7UcfLlWM1d2Vtxdw==
X-Google-Smtp-Source: AKy350aJGwj3RDu4Ip5Xdz/OSHSTb1FUZElsBmHZwE/xAe13jchQE1CQ2cXbPFPEjl7DmWZ7kx4QeA==
X-Received: by 2002:a25:aa53:0:b0:b05:af93:c3d7 with SMTP id s77-20020a25aa53000000b00b05af93c3d7mr2826487ybi.62.1680617529787;
        Tue, 04 Apr 2023 07:12:09 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d195-20020a811dcc000000b00545a08184d8sm3202750ywd.104.2023.04.04.07.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:12:09 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 5/5] iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll
Date:   Tue,  4 Apr 2023 10:12:02 -0400
Message-Id: <f7fa811a002d0572c63b5a5ab7a478a5383ff840.1680564468.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680564468.git.william.gray@linaro.org>
References: <cover.1680564468.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADC sample captures take a certain amount of time to complete after
initiated; this conversion time range can be anywhere from 5 uSec to
53.68 Seconds depending on the configuration of the Analog Input Frame
Timer register. When the conversion is in progress, the ADC Status
register CNV bit is high. Utilize regmap_read_poll_timeout() to poll
until the ADC conversion is completed (or timeout if more than 53.68
Seconds passes).

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v4: none

 drivers/iio/addac/stx104.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index f300cce52787..0cdb824b6bb6 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -206,19 +206,22 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 
 		/* trigger ADC sample capture by writing to the 8-bit
 		 * Software Strobe Register and wait for completion
+		 * Range is 5 uSec to 53.68 Seconds in steps of 25 nanoseconds.
+		 * The actual Analog Input Frame Timer time interval is calculated as:
+		 * ai_time_frame_ns = ( AIFT + 1 ) * ( 25 nSec ).
+		 * Where 0 <= AIFT <= 2147483648.
 		 */
 		err = regmap_write(priv->aio_ctl_map, STX104_SOFTWARE_STROBE, 0);
 		if (err) {
 			mutex_unlock(&priv->lock);
 			return err;
 		}
-		do {
-			err = regmap_read(priv->aio_ctl_map, STX104_ADC_STATUS, &adc_status);
-			if (err) {
-				mutex_unlock(&priv->lock);
-				return err;
-			}
-		} while (u8_get_bits(adc_status, STX104_CNV));
+		err = regmap_read_poll_timeout(priv->aio_ctl_map, STX104_ADC_STATUS, adc_status,
+					       !u8_get_bits(adc_status, STX104_CNV), 0, 53687092);
+		if (err) {
+			mutex_unlock(&priv->lock);
+			return err;
+		}
 
 		err = regmap_read(priv->aio_data_map, STX104_ADC_DATA, &value);
 		if (err) {
-- 
2.39.2

