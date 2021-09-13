Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A608D408A2F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhIMLaj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbhIMLai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 07:30:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22CC061574
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 04:29:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v19so3367910pjh.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfoENClijP5gdD7xuDkNBoWdUfMDgkyOc6qJ1KAohPY=;
        b=oL+KovyrKNkgVbEbUGhoxjNyuI9WEEKCZaHmtKaUZti3DYBGsD74ZfLqoCwDyw+6sZ
         fwKowR+Wq2IUjOJ6eUuWLrnNSbpu1AN011zm/U9jAlQwgOffXn6iVFzCi5JYkzIA8AM3
         SVYedHa4qsl9UIxjpHFNGtK0F0/AQAh5ObYkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfoENClijP5gdD7xuDkNBoWdUfMDgkyOc6qJ1KAohPY=;
        b=4H8do5gcK3JX86UqlHjZ5FsYLOoxwt0k+rMUAlGiQ2C6VS+Uo75yLEmx1APUJJvAUW
         RuPGeBYlGvjPcsbRXETiVZkRIo3eCmQDggEzW55qTx1lPnwNm/kL9Y0OhDP48fWhsf3C
         oPdhwFbm+xnajn/z8f4xzoykyAa+H5KZdsmExixR61kDah/zTuyIu9M96T4NtCIUQgn5
         fOkIKCdyxqwSAO5IijYF5IpxEP0+bsvU9Y5zT0sfqJfDZJGNMtKSIOtTa9r8dt4B94xa
         oCf9wuyJ6B0EQqGbo5Hu3V6drp+BtbqQCoFKlZmgT5nPTZjYONrHIvwjron7EqHNGPMq
         +cBA==
X-Gm-Message-State: AOAM5334Ya5/9oTqM0ixPCYECFJ2F/echBxIV7oevFd5nvwdg+ofaWSe
        ouOJkwuWDS+51xxXPHyK5SYh2w==
X-Google-Smtp-Source: ABdhPJzT/5yaxY/5ENcuHbT99u6Tv7Ca3HYaaLWiHKmqVJiUmD6xN/KRcpkRjXjl6mHAoqlTnrv7kQ==
X-Received: by 2002:a17:90a:1982:: with SMTP id 2mr12341017pji.112.1631532562068;
        Mon, 13 Sep 2021 04:29:22 -0700 (PDT)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id z8sm6650000pfa.113.2021.09.13.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:29:21 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     jic23@kernel.org, lars@metafoo.de, jmaneyrol@invensense.com,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: Mark acpi match table as maybe unused
Date:   Mon, 13 Sep 2021 20:29:13 +0900
Message-Id: <20210913112913.2148026-1-daniel@0x0f.com>
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
Ignore the first version. I'm an idiot and generated a patch,
check that it worked, noticed it didn't, fixed it up and then
forgot to regenerate the patch before sending it.

 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 95f16951c8f4..3ef17e3f50e2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -249,7 +249,7 @@ static const struct of_device_id inv_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
 
-static const struct acpi_device_id inv_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused inv_acpi_match[] = {
 	{"INVN6500", INV_MPU6500},
 	{ },
 };
-- 
2.33.0

