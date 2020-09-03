Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0925C42D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgICPEg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgICN6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 09:58:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED08C061249;
        Thu,  3 Sep 2020 06:10:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so2098016pgm.7;
        Thu, 03 Sep 2020 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WIT3+UL+FpungvYV1D9IfW97J9W5tsesmZlOnRL4KU=;
        b=qE6o2n8HJKYzr8LQaFzdJ57s8ECaNNIEBAKj+FvAXWdE+VE/mTIGhjc4Qg4zlvXooF
         s7PLRYxjyADHCtuiPGQ7aryX95MmnRUj8GlEn8M+qW1Vqac7RM+TAFtNZZnjTUlILZbr
         n9WUYcuXzPQyao1h0l7bXfN3uVvH10bfG/RxxTBugi38UTqmzBO4RkjFvJJ1ieGMrx1r
         vEg7/JHmsKK2WQYAZumSLzZFWRFiJl+8/3eGdCa6oFziFGQkJXbAEfwMLwriWQFCnh3L
         zHXJmVCa8f2oqPOTdWqCc7Iq8Uxf20oK56b2aUOJ6k5u/kuJQUHbub6wVWxBtp2paj92
         pi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WIT3+UL+FpungvYV1D9IfW97J9W5tsesmZlOnRL4KU=;
        b=ksqpTF44Hzu0MjGFc09TwnSDYD9rYNGrFYa8uTKdb9ecpAu/K0XX72FJfya5RttpnW
         svI88iAicil1uQ+YO8XGYTcnZ47XIKSVjCaPDZsZoYKOUsO4JJGFzwD8Fiza5qL4y07c
         pdBRlg/q12ZZT6Qm8h3t2eZ++TK/3BuIemOLbU52VYvktAjapNZkqGbgk60GguUjJY0u
         CsM+OzKRcMftTOeE//3BWidTBbn+Qbodk2LNW8opjSESkH45MTLHvJqLJVcsR0lmMgUh
         +ALKxandphQ7IFR5L8tg27QySKEh0/wNbxSBcZXh22j24AxP+ano+cWW7tUQks7rS82D
         SPlA==
X-Gm-Message-State: AOAM533aEEkUuWiJmgCS5VyBFf4J+dG6jGsWnzyssKrsjq2ku+m3k1zH
        vredohjE55242g/eWfeY/u8=
X-Google-Smtp-Source: ABdhPJwninxVNGhpsTohv0jmInMy1KARspw9LnVSe+jAaMtNOlAQj38XIlfkUm5bYScFOYFA/RnRcw==
X-Received: by 2002:a63:fb4a:: with SMTP id w10mr2877677pgj.114.1599138614380;
        Thu, 03 Sep 2020 06:10:14 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6085:e35d:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id d20sm2538270pjv.39.2020.09.03.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:10:13 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v2 3/3] iio: gyro: adxrs290: Add debugfs register access support
Date:   Thu,  3 Sep 2020 18:39:50 +0530
Message-Id: <20200903130950.6274-4-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903130950.6274-1-nish.malpani25@gmail.com>
References: <20200903130950.6274-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extend support to read/write byte data from/to the device using
debugfs iio interface.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

No changes in v2
---
 drivers/iio/gyro/adxrs290.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 4099b8917d3e..132fd16789f0 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -434,6 +434,24 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxrs290_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			       unsigned int writeval, unsigned int *readval)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!readval)
+		return adxrs290_spi_write_reg(st->spi, reg, writeval);
+
+	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(reg));
+	if (ret < 0)
+		return ret;
+
+	*readval = ret;
+
+	return 0;
+}
+
 static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
@@ -546,6 +564,7 @@ static const struct iio_info adxrs290_info = {
 	.read_raw = &adxrs290_read_raw,
 	.write_raw = &adxrs290_write_raw,
 	.read_avail = &adxrs290_read_avail,
+	.debugfs_reg_access = &adxrs290_reg_access,
 };
 
 static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
-- 
2.20.1

