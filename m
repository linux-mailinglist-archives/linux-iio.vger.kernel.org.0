Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A3A3CCA31
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 20:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhGRSDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhGRSDS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Jul 2021 14:03:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B468CC061762;
        Sun, 18 Jul 2021 11:00:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m83so14164724pfd.0;
        Sun, 18 Jul 2021 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9H+LL07oPc0V9kmYs1nYHJkaHFr4pSCnkaHn51r1wo=;
        b=YtqHOMWytwFY5+osPZlV/ib9WXdxvlEGBpFh6PTB81JiVcTU3XJAMqmlXv1x9t9PwZ
         PtteWf6VVRcWo9SNLpPckmL64KKOodjbpdMLPhmrvby3hZgRGTyaBJzyT1RK5Jwzy4Ck
         QTa2ZjgKgwr7moRhCQUnlgHAr2nlphcBKmn6U2fWzwZqrKGBAg8YPgzJRfdzc7PQT0BN
         esMKsjKiDa+HWp100k4Ky1TKcDYyVhqQeI27XQYgHHw3rSKuHzVsrDvpfXx5nhMB/yry
         mgjRou2nQDbiR/07Xf7ZKb4ttuwXjbRjXTGWGh+HM9X3c1U0gK86Wfn82m5nD2lYJWUU
         bE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9H+LL07oPc0V9kmYs1nYHJkaHFr4pSCnkaHn51r1wo=;
        b=dCTPYi/6bz5mUyiG4IdJ7wvh1rp4qPDf+DEG1270uel/FtAnlKffifmsxqshaQ9Fie
         SMVXrBC3zdvZMdOOUZMfznON04X5XVkeR9IrQCsCv56e6Fjxl2WTlLxkMkOW3sHDPYom
         P3j7DWVJNp2LRnmY78MwGSa8vpG4q5ebEDHQs5TctL/AA/YBjKiVZDSGXkHKOblEbNIn
         vmHEhnhr4eEhArnoIRTR+dRWbALtMXHIrNSEF2qxUgp9Br/HtY7dd9qL5tBCCv9XSDTV
         5jEeHWayUJYsuIfKnBQ2PicyUK3k2Ku6Wl29L4Lq46+wnIOvYFRJfUj+nAjM8bUjoo8h
         RPIA==
X-Gm-Message-State: AOAM533h7fCd3swIzdt1+6wgH6dLAa+qngEzqoTcHhZlEwZB/CTPbR/h
        3g0szxeJslNKAJAfKicfw/Y=
X-Google-Smtp-Source: ABdhPJxGMfqOt4lIcC6oYyP6QUQV935KNgtOaqhPVN8IV7PzC2vzX323z0rD0dyt2MPq/ZO92tFD9A==
X-Received: by 2002:a62:78cd:0:b029:327:de34:ad60 with SMTP id t196-20020a6278cd0000b0290327de34ad60mr21990924pfc.18.1626631218274;
        Sun, 18 Jul 2021 11:00:18 -0700 (PDT)
Received: from localhost.localdomain ([125.62.118.189])
        by smtp.googlemail.com with ESMTPSA id t6sm17106711pjo.4.2021.07.18.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 11:00:17 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: accel: Add ADXL355 in trivial-devices
Date:   Sun, 18 Jul 2021 23:29:49 +0530
Message-Id: <20210718175950.34728-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210718175950.34728-1-puranjay12@gmail.com>
References: <20210718175950.34728-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add ADXL355, a 3-Axis MEMS Accelerometer into trivial-devices.yaml.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8341e9d23..0097d6e81 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -41,6 +41,8 @@ properties:
           - adi,adp5589
             # +/-1C TDM Extended Temp Range I.C
           - adi,adt7461
+            # ADXL355:- 3-Axis Low noise MEMS Accelerometer.
+          - adi,adxl355
             # +/-1C TDM Extended Temp Range I.C
           - adt7461
             # AMS iAQ-Core VOC Sensor
-- 
2.30.1

