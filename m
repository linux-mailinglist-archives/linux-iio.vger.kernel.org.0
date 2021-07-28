Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5773D930F
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhG1QWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1QWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jul 2021 12:22:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5D9C061757;
        Wed, 28 Jul 2021 09:22:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a20so3368053plm.0;
        Wed, 28 Jul 2021 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjFMyGog5Kk6w/B+NJeAnfvDqGwKc9dCqiMHykctlXk=;
        b=JmoZJ8uDIuwiDq+O+GwPIqafjzKCxHBvP57xGcOyjx1ykJ6cgnqKaQYB5BOb7MLvOI
         A3B2Ub92ZwEabH4G1SGWd/qsTrkuadaPZxenVLnhvA53GIUU2qDoSwKXgSUOEYDhzAeo
         MIfwtEzhLE0XLVRYmIsz42SZLvrh74quuJ0/ADWpFAl9cieQwQdO1jEQCXRH2Delx8wj
         MmpsBg60VsFh2EF13uXxRwW/e9v3LON7WbF2p+/SK49f/lYgU93B4+Pei6xr/w+d7o+U
         hnadD7au+qoYytri5aD2P/HmxWnVB021haedCtsniuut56Ni/mUhXYLOxd9w4hwJRHzK
         LnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PjFMyGog5Kk6w/B+NJeAnfvDqGwKc9dCqiMHykctlXk=;
        b=VCB/E0q9yWZlZpqWvfTg4j+7QZRq+ikC3o5xXBZYeZoeknVNiSrqpiH0UHmLV1zpHO
         9+SlJcQvv8NMT+yBZNLIDUxHFJcdbAZd34uVGrhh/Qp7GiXsQ8zokDOtRLD8jpFUl031
         wPsBmG19nD3vhR/idq5IiCcqlDrjQESGEuJjgDperq9xPWecye2kTNQL8iUq5TPZAQRO
         SjrFLDF8qU/NsQoCCDwjFFdgHrnpU3L68w8cnPgfhNpUlnH3FWYauGZBrfQE8pFQKiQ0
         HJsmJ2VkidTXpThlql5RFvIvR1oftppjD21o9Lg7XXwXRBe0mkLvW/L9/r02LrUftdT6
         NPvA==
X-Gm-Message-State: AOAM531MwvOrZgXHpV/cX8i18W34Ut+xXbrgXygTX/mtwCya6utWL0Sg
        j442QNFuGI+093PSt5lJGW4IgNmMhsYdEzuwibV/Tg==
X-Google-Smtp-Source: ABdhPJxksvMXgmArLGnue2C+oR8/58W4RNWbiJKmoc84SzeWKCtYRHBqnDJPFQPyBc6bJl/VhtzIRQ==
X-Received: by 2002:a17:90a:17cd:: with SMTP id q71mr556987pja.117.1627489319641;
        Wed, 28 Jul 2021 09:21:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:828b:a80e:e12:9310:6b88:a724])
        by smtp.gmail.com with ESMTPSA id j5sm214323pgg.41.2021.07.28.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:21:59 -0700 (PDT)
From:   Siddharth Manthan <siddharth.manthan@gmail.com>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, nikita@trvn.ru, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ktsai@capellamicro.com, lars@metafoo.de,
        Siddharth Manthan <siddharth.manthan@gmail.com>
Subject: [PATCH 1/2] dt-bindings: Add bindings for Capella cm3323 Ambient Light Sensor
Date:   Wed, 28 Jul 2021 16:30:47 +0530
Message-Id: <20210728110048.14593-1-siddharth.manthan@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update trivial-devices.yaml with Capella cm3323 Ambient Light Sensor
description.

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
---
This patch was previously sent using outlook email provider. Unfortunately
I had no knowledge of outlook being banned from mailing lists. I am
resending these patches using gmail. Please ignore the previous patches.

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 919a4bf03a5a..39fb27561a7b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -61,6 +61,8 @@ properties:
           - capella,cm32181
             # CM3232: Ambient Light Sensor
           - capella,cm3232
+            # CM3323: Ambient Light Sensor
+          - capella,cm3323
             # High-Precision Digital Thermometer
           - dallas,ds1631
             # Total-Elapsed-Time Recorder with Alarm
-- 
2.31.1

