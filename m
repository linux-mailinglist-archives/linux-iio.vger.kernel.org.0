Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F616367C2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiKWRzI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiKWRy7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:54:59 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD0E6F349;
        Wed, 23 Nov 2022 09:54:57 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z26so18025416pff.1;
        Wed, 23 Nov 2022 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqRBdYQ0hW2GoJp2mDn0xBVx5Bwku/wXXuv0oUxCzNw=;
        b=E6ewgTv8yHrViH1SfPXTgR9/FuFvPVwgYlCxFp+KCu6kQ/U+QM5N905rlsMIya3DYy
         CGzCZThzxWxL0LA/si+Ee4w5AdQ6hc+gJuSx67Fd6fdNYlWVgEba0ZSv946EwYnW+79/
         1Kmm2A1JDMyqXC7WQ57YqNM/4nUDFEXe/y3Za3eOxeDErB/7AlTlVE/KaCaXh3fLzOCV
         R3dEDnRFSkmfKYWcXPlVI4DDD++WGHmfXQk2zT8s3+Nas1XaS0KfyuX2tLuuER/F4vPh
         CWn1PCDd6uWnvShEnIGIWqmHvTK5Ms4Bq0PJxymnd9QA65LcK5IU17/YOmBEj447Aw5T
         I91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqRBdYQ0hW2GoJp2mDn0xBVx5Bwku/wXXuv0oUxCzNw=;
        b=2UyIf7P3f430CcrxlCdDOAx3JZ7J279JmK6VtVxGlbfOljXmY/s5322eTgd6dpusGF
         UDHLM5ks9MZHlHBsBx+15xBAlSgNY4IPCcTh90rwTNhCbyF//oF0VRaIBVzqR5sS5fJd
         X8SCeHYF7hMufIiA6KQ8iqmeKXvp0nYQIgvtM9Q7sAat+YsMuyFCrHnukLGD5ep0EyjL
         m32bu6wiuPdPQB3wEK1VZnMkODuXTWs80v0rJ22/mBGhfRM/SbsqIbkTe8adCKrYSU8R
         LON2YOAuxHP11plwoYzyNW8CCzHKmBXO2TQgMX24Vr/xexob43CiCEuDZ64k+NF3EqvT
         iPWw==
X-Gm-Message-State: ANoB5pny3WbpoXnkX3bD8AYbHAJovedYmchb3Xp2MSc2vgB67cjISb2V
        f4k3tvbVNLm4HpMvtQ6KE5BgzT8cMUY=
X-Google-Smtp-Source: AA0mqf6tmbdKAoeAmkyVRcXlL6n6RnrqEIQ9SfY5AZ3pfcKyUbjLdmw3yjZaqH7VTAf0vUWcRPQXMQ==
X-Received: by 2002:a63:4d0d:0:b0:477:14ea:cee6 with SMTP id a13-20020a634d0d000000b0047714eacee6mr8264902pgb.303.1669226097387;
        Wed, 23 Nov 2022 09:54:57 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:54:56 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 4/7] mfd: mp2629: Add support for mps mp2733 battery charger
Date:   Wed, 23 Nov 2022 18:54:22 +0100
Message-Id: <20221123175425.564042-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mp2733 is updated version of mp2629 battery charge management
device for single-cell Li-ion or Li-polymer battery. Additionally
supports USB fast-charge and higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/mfd/mp2629.c       | 1 +
 include/linux/mfd/mp2629.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index a3fc02ad5ec1..57db0f5009b9 100644
--- a/drivers/mfd/mp2629.c
+++ b/drivers/mfd/mp2629.c
@@ -63,6 +63,7 @@ static int mp2629_probe(struct i2c_client *client)
 
 static const struct of_device_id mp2629_of_match[] = {
 	{ .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },
+	{ .compatible = "mps,mp2733", .data = (void *)CHIP_ID_MP2733 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mp2629_of_match);
diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
index 072c8181b48b..ee0e65720c75 100644
--- a/include/linux/mfd/mp2629.h
+++ b/include/linux/mfd/mp2629.h
@@ -11,6 +11,7 @@
 
 enum mp2xx_chip_id {
 	CHIP_ID_MP2629,
+	CHIP_ID_MP2733,
 };
 
 struct mp2629_data {
-- 
2.34.1

