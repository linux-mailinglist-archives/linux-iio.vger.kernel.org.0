Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4C4344F5
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 08:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTGMz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 02:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJTGMz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 02:12:55 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14FC06161C;
        Tue, 19 Oct 2021 23:10:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so4601327otk.3;
        Tue, 19 Oct 2021 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKg9EjzdwjkynYiQFahq3nQ5iPSpRZ4rXkfIYG32xcw=;
        b=TsuadMfgh/GFJNDD+k45aJlv52+kHcCKwEXHJoS/wOkW24o3bmT4AnuEqdjINH0iqG
         yxAzJIG63NN5uIwszW4PrJmXXDQ+5nJKzwoEPWGe2g3mvfglPZD9PwDHFQki0L7lvXgK
         MdSpCf6RGy7ynFQMbVGGfxlSNI01l7SpS8AZ3AFny4208jr56lO+aDetEI8UWQayzF8C
         A9dd+aen++mEe8DILo1Ca1HA8uOiz7TyhQrBKvdi94ocup16AcYLEcXzacMxHQQvAkUx
         WEVgMMmhMa0oWOogwkMZhQXP5xTku3XOWBt7hMGG7P4W5IInXO+Z5cs312MyJQS9Hvv+
         y+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKg9EjzdwjkynYiQFahq3nQ5iPSpRZ4rXkfIYG32xcw=;
        b=20LsNfV+z7XPBY7pCjVFrLdI45SYrX7FtsuSTbH5/31KiQqcSTWdL6ik40xBmiwe6h
         nj8OWtx3zXAWY8Ep47f4FVSu6aCtCTiaUwHVqgIJI4VHyJjEyh0P0XEw8XG+MaIQ2mff
         kkaeO4yCaqX0ibcUe+0N2xEEuHapvkgv1mhjol/0Iz6xRnhSQqnPZCdWF3dtYhdFZJAw
         pk9Re5aeWhWrl0Sieg+cgWwCKvxyqFaE1OX0cuJ1c2BTS+hDq/TxtnH3X93rgvQtB9g1
         n8Wu6AR3jF/z6VDDrAlJMVZpapaxWOlZYK9L7+OX8VrwLYq0ITtOzfk2vfoknoYccUZU
         QLtg==
X-Gm-Message-State: AOAM531cxWbk5mPpJTSABPID36oQRQpUv8oVXlRVR8bGhRE6sHiTQYOz
        Q2E+Sa5V4TgZ9zT+lmZXGYI=
X-Google-Smtp-Source: ABdhPJwAs2Mu3y2pfrcfs4Vpe07BG3d7WnB1Nn1kNYu1Uo1TTQKAzUkY80nETMmR50KRsypXYO5OFA==
X-Received: by 2002:a05:6830:23ac:: with SMTP id m12mr9518853ots.357.1634710240717;
        Tue, 19 Oct 2021 23:10:40 -0700 (PDT)
Received: from localhost.localdomain (c-76-30-1-35.hsd1.tx.comcast.net. [76.30.1.35])
        by smtp.gmail.com with ESMTPSA id c21sm288182oiy.18.2021.10.19.23.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 23:10:40 -0700 (PDT)
From:   sesankm <sesank.mallikarjuna@gmail.com>
X-Google-Original-From: sesankm <26676400+sesankm@users.noreply.github.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        sesankm <26676400+sesankm@users.noreply.github.com>
Subject: [PATCH] Staging: iio: adc: ad7280a: fixed coding style
Date:   Wed, 20 Oct 2021 01:10:27 -0500
Message-Id: <20211020061027.34148-1-26676400+sesankm@users.noreply.github.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

fixed issue with coding style

Signed-off-by: sesankm <26676400+sesankm@users.noreply.github.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index fef0055b8990..473f95118214 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -829,14 +829,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
  * The function argument is stringified and doesn't need a fix
  */
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-			     in_voltage-voltage_thresh_low_value,
+			     in_voltage - voltage_thresh_low_value,
 			     0644,
 			     ad7280_read_channel_config,
 			     ad7280_write_channel_config,
 			     AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-			     in_voltage-voltage_thresh_high_value,
+			     in_voltage - voltage_thresh_high_value,
 			     0644,
 			     ad7280_read_channel_config,
 			     ad7280_write_channel_config,
-- 
2.33.1

