Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5F1B822F
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 00:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDXWpG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgDXWpG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 18:45:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F2EC09B049;
        Fri, 24 Apr 2020 15:45:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so4289700pll.6;
        Fri, 24 Apr 2020 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Yvw2PcrIrqFW+K0t4i2lUjt2HcTjoS5NlVcDfZcmx4=;
        b=opWbbk1mbKhaTOokWueyaTtaELeotmFlTU7LKpLFv8KC2uGjSsHHAwJvY9swIkYlGJ
         W932Y+6yiQMMxde0dBpYp5Yu3BPbxVJ2mBH63AbQmNwk02zNuAd8w6Rc2Jdhk+OLQ4lL
         mryJH9m8LDxDFLERg5IDprGdput6eBrTvZtNApMJRX8QKBAEDhaoZHEXWW/PWjKim2cg
         diBa9nGRMZ4EzBJMPgp+a09LkuA6zEkoDe0q4uhquaKRsskV0OYAockS7rcxOxuLeE7m
         3ttr0uaexyHBZU9k4I6PALrN0IRp/KDcvfVXbV0yigO6F+Q2SD2GIK301bJslB+31UBg
         VP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Yvw2PcrIrqFW+K0t4i2lUjt2HcTjoS5NlVcDfZcmx4=;
        b=O0EZTRLXHh7OWO3dJrNXa2qbHbouSS+KDYUD7g4dykWUWFIC5vCSZJDkqLV1zXuZBN
         2j8wGBd0Ic2U9tQVatyF0IU95wnija7OzGPmOdXg3blaXPIBjBBZmsdvzUzawkReQu90
         2APu7i+4q2sRKJhDEd4f3LOlpqLJI7pdsZKrxCyiHJG7hEFV1hp4SA/XASpmoLhxQBqN
         bAa+cLqEbY6Bv++PhQQVDqTls0u3jlIpT+zOTKNWmIk0mvDnugk5a+Yl+RE6H11iuie3
         ZI4Wpx4NdbnIjdtw9S998Ins7zBKsPZ7iMrWOycr7KyeeHgQiYNL1SdahBbSI4IY9Qpy
         KmtQ==
X-Gm-Message-State: AGi0PubTkUmLty8jPZ1aord6DuGR9ouLtZV6OGVepEHVU/nz+cq+nmzi
        dS3gtfK20lvHDv8wBsnXVvo=
X-Google-Smtp-Source: APiQypLYjl3FoKxK+raU5jmzX5s9UHY+9F5TrrTyaGOky8Wn5pLDg8Q+5nDUtJLP7G5ItKGRF6eCLQ==
X-Received: by 2002:a17:90a:558a:: with SMTP id c10mr8864911pji.53.1587768304641;
        Fri, 24 Apr 2020 15:45:04 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:610b:e3c6:8c8d:27b8:7b5b:c4d9])
        by smtp.gmail.com with ESMTPSA id t7sm6710144pfh.143.2020.04.24.15.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:45:04 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, alexandru.Ardelean@analog.com,
        nish.malpani25@gmail.com
Subject: [PATCH 3/3] iio: accel: mma8452: Drop of_match_ptr macro
Date:   Sat, 25 Apr 2020 04:14:39 +0530
Message-Id: <20200424224439.5601-4-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424224439.5601-1-nish.malpani25@gmail.com>
References: <20200424224439.5601-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enables ACPI DSDT to probe via PRP0001 and the compatible property.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 00e100fc845a..66217fbcc7af 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1815,7 +1815,7 @@ MODULE_DEVICE_TABLE(i2c, mma8452_id);
 static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
-		.of_match_table = of_match_ptr(mma8452_dt_ids),
+		.of_match_table = mma8452_dt_ids,
 		.pm	= &mma8452_pm_ops,
 	},
 	.probe = mma8452_probe,
-- 
2.20.1

