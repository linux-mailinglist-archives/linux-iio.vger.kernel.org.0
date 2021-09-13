Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95174089EE
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhIMLPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 07:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbhIMLPJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 07:15:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A71C061760
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 04:13:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w7so9101946pgk.13
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxGGH396yqKFz9F5OWRNHSsNaRXLO9ooc/L9AlOkzKQ=;
        b=QxWZtqYGlOGpSOGBS4dUjJX2STngIdVu9tALWqKwJ7b8hYjpl8RcdVW/0X1vzuc2Ec
         qSqYceB2e9nKjZ5He5OFHyh+JO+gUv9h37mURskCyV0xZxneNSFG9HuGdQdFA7WZOxSF
         0jH3StCqwyJqFDGdkbN/iG9CNYkf+d/+RBYGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxGGH396yqKFz9F5OWRNHSsNaRXLO9ooc/L9AlOkzKQ=;
        b=Ia0hwOyrkY8D5LRTF8iARHGW02QpAifQc9UfsvRdlgqPSAf1vOfxKU9dfLAA6VHQl8
         G57H8p2xleHRJ0szAGuaUPerHokI7bnvSrzoTBiFoXO25Hk9YvPQk3gKdJVMwayrqgnJ
         ndr/J8c5wDwniJxLh6fYL+9Gu7KxdRxs0ONrBpllwpRugsizcM+Qsm/bBFtQ55vExqXz
         7z3DUMDlpSyiz2L/Pj6d+nYTVEVY5J0bcUAr9rv7gbxBe9P49vhCfpzVG9vLL35HnDoi
         uAWHkuuT5Hh5jnXBAHrh5jVfPp2z1Dw0TVo9m7qyFRAKjL+WZbWJkgxpx4LbjA+aFej2
         nLQg==
X-Gm-Message-State: AOAM531hYkx4m9yjOfs4nQ6Vv3UdqnisVbbJJrvarHxzgWHpbikM6VEB
        lilQEsxqoNV4J+MDRlVGGEaGbLcA+sJaUA==
X-Google-Smtp-Source: ABdhPJx4zqnR2yH4LqHuWbBCIRfqyPGQpPzE6od/re+HxwMX1sy9Fqfn351DvGCHyyNBJEhgZc5SgA==
X-Received: by 2002:a63:e510:: with SMTP id r16mr10781699pgh.34.1631531633041;
        Mon, 13 Sep 2021 04:13:53 -0700 (PDT)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id p24sm8340153pgm.54.2021.09.13.04.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:13:52 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     jic23@kernel.org, lars@metafoo.de, jmaneyrol@invensense.com,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Mark acpi match table as maybe unused
Date:   Mon, 13 Sep 2021 20:13:46 +0900
Message-Id: <20210913111346.1957635-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When building kernels without ACPI support the table is declared
but is not used because ACPI_PTR() turns it into a NULL.

Add the __maybe_unused attribute to stop the compiler whining.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 95f16951c8f4..dbd613178f01 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -249,7 +249,7 @@ static const struct of_device_id inv_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
 
-static const struct acpi_device_id inv_acpi_match[] = {
+static const struct __maybe_unused acpi_device_id inv_acpi_match[] = {
 	{"INVN6500", INV_MPU6500},
 	{ },
 };
-- 
2.33.0

