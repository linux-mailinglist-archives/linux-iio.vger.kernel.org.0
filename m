Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E93D1E20
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 08:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhGVFlg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Jul 2021 01:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhGVFlg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Jul 2021 01:41:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DCC061575;
        Wed, 21 Jul 2021 23:22:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q13so2388974plx.7;
        Wed, 21 Jul 2021 23:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9H+LL07oPc0V9kmYs1nYHJkaHFr4pSCnkaHn51r1wo=;
        b=lnK137ye0FWqaFp+eGHa+s0OWJHJWImH1qDzx7qYLpSjNce8cWN3p3BjEEdkY8PDd6
         M10ipV7d4MyCuToU02ngySKcI1Aio3qymHg1sEw7PIHOSdlcl72RHmyD+QWGDQA88JMW
         UUjzppoHXx7iDQsly3OAVxHFWCjevKiqGYr5cGS3iURTYv68m45uGfabzGD84vZL/ZnM
         fVfJCEDZPg/Y+gBZQnyFZd69iQnaDgmDtoikSOn8+oPS81jweswgUDqG7vtyoCY4zsJE
         xPJSDAgM9WUDq6LqMQBVz/CkkIzMzyJWGFFQam0/heUsfcqZ2I1eAR1bJdS45srqBzb1
         KDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9H+LL07oPc0V9kmYs1nYHJkaHFr4pSCnkaHn51r1wo=;
        b=RwNHLiOVeHH6974iLj85CTGK4UIygO22BhNrdk/lJw6BmlNQT+wk7p1Ul/AoRmHl71
         /x9K2jG8M4ZKeMiqxgBqZiboe3d/VlWWEC+gWzDrRNBGHKoWfSjt+FFcpFHA+CpnNhhB
         xxsv1IyzysP/TrcybIe8YwNLJvVu58UonxIRhMsCzkpYPszGncn6nD6I6X4XN2dFLLgU
         gXsWgD2bzcqXtoM5F23TTUxVoxmqNyTLDSmJym/lObiezJBmovbHuh9RZKmGyQ7cryxS
         k6EES0+3nvnXLKW3vCEX+9fVFyPSieOXRDY0dR6nPPOQOWFqkllRSzPyiwxKCOYAjT19
         cKlw==
X-Gm-Message-State: AOAM532DMlp7JTs/efS98QJbMlfuESC7l0wTdrXWFWw9uF7E/lYe3Wiy
        VC9TNsmbyKfDYKSSfueWHDQ=
X-Google-Smtp-Source: ABdhPJzdgfdjYUP1A+AkSs4OxUJBtvyjOGPmGQidzs9/YGLt/MM7qM/nICHZQgrXk16Mywpd3gTLEA==
X-Received: by 2002:aa7:90c8:0:b029:32c:935f:de5f with SMTP id k8-20020aa790c80000b029032c935fde5fmr40085835pfk.79.1626934931324;
        Wed, 21 Jul 2021 23:22:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:4055:289:a04e:a741:7cf2:c19d:a4])
        by smtp.googlemail.com with ESMTPSA id g123sm28239326pfb.187.2021.07.21.23.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 23:22:10 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: accel: Add ADXL355 in trivial-devices
Date:   Thu, 22 Jul 2021 11:51:53 +0530
Message-Id: <20210722062155.32998-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210722062155.32998-1-puranjay12@gmail.com>
References: <20210722062155.32998-1-puranjay12@gmail.com>
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

