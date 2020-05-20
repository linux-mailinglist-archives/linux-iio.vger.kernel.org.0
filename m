Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81871DBE4B
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgETTsG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 15:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTsF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 15:48:05 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44187C061A0E;
        Wed, 20 May 2020 12:48:05 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id l3so1951132qvo.7;
        Wed, 20 May 2020 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f08QCVkXmCuV4hmVQ66aE7hr9gARDnjGT1g+Wtl0yJA=;
        b=VHhNNquwAk/a7Usf6kujmahG7WWe64TkkdgxddTbEL2SUmyPov1o9vfRewqpN7lltl
         /YoejAgiqe3hT7tYhWLgy0aiO9pXdWaGtHN7SILIiJXXxYMFT0esW0oB/uGHFjobKQMQ
         KeDafpbVZ14qFWGhlhGpMZrZNznv27RywTOG+9tLt5pO79K6q/T8orlmw6h7N+T2OVRx
         61pRMf42QkaqzzeHABzChlKq9msWesFzueneS5g1YQf0oOMsKAtSgYlHDNK4+c6h3YTL
         N87REPb/rgQKkmisaUYxrgnvyq8hd093VqF/fg2YtXGxFXRJbuuZeQZtWa4QmvQ+rqIF
         KzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f08QCVkXmCuV4hmVQ66aE7hr9gARDnjGT1g+Wtl0yJA=;
        b=RWo6cvI4rmWZIoSIQMCZCwnNXG+Vs91aiIIs7hMKTjUy69h7hEfcKtsA/2BGsHFzZQ
         APkY0ykcPC0mVNlJJ8mbpV/06ZyHkpJNJn7suDLqw4/2osXqPQCvzi16jqf1GNzbkLZK
         gmEebEO2c8JgNvXvjtYe7z2aNeXjcELyqbpiDGg/icS3VEhYE/ZZa314npM8us10cdtY
         dRYDlra5UQmqDbSaJN/wSE4WWk+TQaOZKOBGfu6igk3QBE/jzHu0yb7R7W8qM+xxUX9v
         CA8nl6NEZAZrH44NYHSE0p0uIEnZEtjoTDfOR3E+fnKonTC4PW7RGXnDZ8qZvbIeEehs
         UI1w==
X-Gm-Message-State: AOAM533kcmvxpw483Qt7eXU58cNwiGh/as3U/HZGpXIB2XX17qhau3nl
        VZ55zdilZaGB1Z5Yetq3WKgetyVjjyc6Xw==
X-Google-Smtp-Source: ABdhPJw8TgA1AaDY2H2R1Lt+vM3lgCDO/EE6rPFMSX6YN8NM35i95lEAOuQ7IZN0JeLJQpEgcXU/eQ==
X-Received: by 2002:ad4:556a:: with SMTP id w10mr6853745qvy.100.1590004083983;
        Wed, 20 May 2020 12:48:03 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m33sm3158419qte.17.2020.05.20.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:48:03 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 3/5] iio: imu: bmi160: fix typo
Date:   Wed, 20 May 2020 21:46:42 +0200
Message-Id: <20200520194656.16218-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix a typo in MODULE_AUTHOR() argument.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 6af65d6f1d28..77b05bd4a2b2 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -853,6 +853,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_GPL(bmi160_core_probe);
 
-MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Bosch BMI160 driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

