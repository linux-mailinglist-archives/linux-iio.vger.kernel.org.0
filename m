Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27461E12F5
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbgEYQr7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391128AbgEYQr6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 12:47:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B963C061A0E;
        Mon, 25 May 2020 09:47:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so17874640qke.13;
        Mon, 25 May 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f08QCVkXmCuV4hmVQ66aE7hr9gARDnjGT1g+Wtl0yJA=;
        b=mtrYLpjgJQNVFS8E4zeO5sj75OZJGvwc8onHdvABW/VG1RnE+/feTDefzb/dqcb7WU
         GzQjwewubJs4x7/SRLbOhO8/twrTo+qOq1DrH9Vuln5zsr2NOdrR2fbrX5zqH0H6CIjg
         1jhwagy/0Geas6fvJ/t0I+WfCt3OB0F3pmaNnWYZhD6VFjhjKgqXJWfOg7t/GaKfpEAK
         i3p/fYjdq1G2Bq/RCdG7rN9UY7OgERsbwV6dGEmuyNa6F5AApHtN2sbvpn4mY47sBrfL
         m/vDmhNx4i08CSSN4zijny0E6IzdTH8qmI9g0+8py2WQ+xc029ni7MZUGvNZpnUCbcDK
         jV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f08QCVkXmCuV4hmVQ66aE7hr9gARDnjGT1g+Wtl0yJA=;
        b=P0fbhVr5FYngGeWiLWlkvtJCZfr0N8+zAii+0q+uL1rriQMJ0fWypqW40qo0dnYc78
         7JC7wizjFBmvqSsE3vh9xl2MPOPAVN5bEHHrZjp2sHLmVy3IXTp+Vbus1zr5SyJi6PRV
         7gg9QrDAnj9/1kO6wbQ7ZUoFpliOpzKbcdpGp575mSqK7KLxZ4JWSZDj6Crg/l5eEZYU
         J5bj9QzlhJHqTTvqjj1Gci0JkzyUyNx0sAnWg/oe7ShqWJodRcqoNbPngQXinHbc4Exz
         EaSgqDBCIhOvTNADx6SyQ3gEKv2e6i9VBk+5ErhCii/6wX+zOaHTPfxCAVygnsWS4dwy
         +gTg==
X-Gm-Message-State: AOAM533BHLcR1Gv4rH9hGThpvSx69z7jW1jQTAjjRV3UWg/CRyzmbJof
        ecVMUF/wjjA2Mfrmkq70Q5lEznvV4Oc=
X-Google-Smtp-Source: ABdhPJx1v80pnFUvJQ+AGjxvzJ7JmPHZ/DhmR1h84N79yenNOioS305scgXWQswecFCwJ6b8T2ujqQ==
X-Received: by 2002:a05:620a:4e2:: with SMTP id b2mr14310528qkh.16.1590425277348;
        Mon, 25 May 2020 09:47:57 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id g5sm15559618qti.87.2020.05.25.09.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:47:56 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 3/5] iio: imu: bmi160: fix typo
Date:   Mon, 25 May 2020 18:46:02 +0200
Message-Id: <20200525164615.14962-4-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
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

