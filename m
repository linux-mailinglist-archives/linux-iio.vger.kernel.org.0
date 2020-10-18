Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36AB291EA7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 21:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgJRTyG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 15:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbgJRTyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 15:54:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A79C061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:54:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c20so4716966pfr.8
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=pnaK94k+vLfOsVR1UspWl4F2TZXuhKlduQhAhQkJwMc=;
        b=mbImQp0bdk9T7s/Gp3LtTnactMFODyr1jgVGAb2rWCMrTNcb9UlV0Ha6dbFxYRpAPv
         PbyaQW8Ps38If9TMqDo5AoW15H18faCXZ0G04xaaZEPDTqhU66xzRuwloiQj22VfYSbL
         VxmyOVUx71uWajfKM6UErELmKSLS+IaAphxlZITho9FyqBNToH/NzZZwyYkprrNnwr2l
         6r0g4y8nutGqX99WKPGV+Z42YaqMlLTzb+f8BPwWHyMPyvw49+LxbKT03cNgU+6Vpwj9
         hAMQ20ZDI9kO/UzgHJGpDz4Pj4+HphlkcWo1fUM8ZoAoBBw4F8rSLyIAn6d4wZs9G8Ra
         Hv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=pnaK94k+vLfOsVR1UspWl4F2TZXuhKlduQhAhQkJwMc=;
        b=gkc0AFKthu5l4cXp3sW/CnJUTr0yiKGtHNl4JGJAowN0Y034hTAUHt23OSsHXe2f6B
         3y66KdKkuWpwXhvGwULZfHmH8y1yqofEHihhSpkvsNJ8nljNb3wpqjSwUcYcdqMg0ll9
         wZere0kdrw6gkmvy9HGEpW/XDU421rJJ01oPKXY/1SoLKMYnOcMVKYJNa8kjqf5ikxA4
         XY/qxFc5GFG/uKVZPTp19E7yHCvaEkZ20t1tIz4a0oOBawymkuR0/NwaH5ZiuJj5fPS8
         N+qGzxHfula/ZOkjEbkJe1BuvsXZSEmy17iMYbyQ5JEe8kWynUCRcLztJ6l7kRjYLDZB
         v9Xg==
X-Gm-Message-State: AOAM533czlss4aPqr+qcMVz55wlKkrf0ZrCyrptBP87/nKmDG5bOtMvD
        5Y1VkliRT4B/d6neTaHyHrjk
X-Google-Smtp-Source: ABdhPJz/R+AM2XhkKGR3ZCBoNn+gIrzo7qOQCIIr+oNiNmktlmRAugcVMVu1hGhg6Cqm8nhvxn2fwg==
X-Received: by 2002:aa7:8a91:0:b029:155:ec80:8bc2 with SMTP id a17-20020aa78a910000b0290155ec808bc2mr13073852pfc.72.1603050842700;
        Sun, 18 Oct 2020 12:54:02 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id hg15sm9412074pjb.39.2020.10.18.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 12:54:02 -0700 (PDT)
Date:   Mon, 19 Oct 2020 01:23:57 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     andy.shevchenko@gmail.com, jic23@kernel.org, wsa@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, alexandru.ardelean@analog.com,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: light: vcnl4035 add i2c_device_id
Message-ID: <20201018195357.GA814864@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add i2c_device_id table for the vcnl4035 driver,
enabling device instantiation using i2c_new_client_device()
or from userspace in cases where device-tree based description
is not possible now, like device(s) on a gbphy i2c adapter
created by greybus.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v4:
	-update commit message, add punctuation.
 v3:
	-modify commit message for readability
	 as suggested by Jonathan Cameron
 v2:
	-fix commit message
 drivers/iio/light/vcnl4035.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 765c44adac57..73a28e30dddc 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -652,6 +652,12 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
 			   vcnl4035_runtime_resume, NULL)
 };
 
+static const struct i2c_device_id vcnl4035_id[] = {
+	{ "vcnl4035", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
+
 static const struct of_device_id vcnl4035_of_match[] = {
 	{ .compatible = "vishay,vcnl4035", },
 	{ }
@@ -666,6 +672,7 @@ static struct i2c_driver vcnl4035_driver = {
 	},
 	.probe  = vcnl4035_probe,
 	.remove	= vcnl4035_remove,
+	.id_table = vcnl4035_id,
 };
 
 module_i2c_driver(vcnl4035_driver);
-- 
2.25.1

