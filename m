Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675A62BC1A5
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgKUS6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgKUS6e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 13:58:34 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5AC0613CF;
        Sat, 21 Nov 2020 10:58:34 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id e14so6430963qve.3;
        Sat, 21 Nov 2020 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFjaJZuynUW/jiD2LmvMLqzU5w0zOiTpH6aDJp8WgyU=;
        b=sjNdbfUPqAvLre0onh1/8exd3einPBT+7CIoTc4PvZLyklN3hr2dQwWeVpNH68n5MB
         eTUOVOxtz0KbUr+F2M1ydwU+124V8r8S60nAVoeEGoeY4zp0f7j4pcM1WxgWYeiaEvn1
         VwdkMPLOJcjuWV3ndOm5bXE50QLeT0sm39GF36C6VmCWJWyohjJFE4HoudoD/TdQqGbo
         pZ4cFyvcvXt2fVTYAjNFCzDIKKM4UzT/Sxy403d6m56aW5/mt/c2Nur+86qwjBKLPUHp
         ke3O6BX8qC3e+TgbpqQSUa23PnlX+if+MwaUMx+gjI6ikmUsAmCqTa/ferku3TbNnjtL
         hGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFjaJZuynUW/jiD2LmvMLqzU5w0zOiTpH6aDJp8WgyU=;
        b=hFVYzQxENYLZ9hQ06nzKmyOVDdXW+YVih++bxHJJXkvamKR+LnFE2r3sd8Jn8JyG5R
         E5G+ewkz9Ia88Z9E8Qv9iP/zlKK40Rt0ihaG0KyD712tQYlibPoKbJ5xgI2BRGOx14o7
         dZUBIut9438KFDINMJID0od126OQmhcWJmLwghbhIqKwIdVssJt99FT8o6Rn/A/EcQaO
         VQ+xHchV1FfxEu68LaJhHnWXNgKKmaOG13krzz9hubqDLqA8DDsJKPjo5JEUHJRYFrXA
         aIw67EasUKhmNKNphP4mG/BeoxKbZNM2YHnNPPHdhHCr6DYISLKVAMhMijW3HirpzkIx
         gk5w==
X-Gm-Message-State: AOAM5309n9UMxqo4cErmNOKb5Or/daBUYzS9WbRr9K9p/+11x+BjSY9I
        ZbAQhv3Cuve7O4ypWTzftT7xaK9ghINC1A==
X-Google-Smtp-Source: ABdhPJwxFmvZ376xNN9a+nX2BXJ73bZKc13nFQW44g1RUOZXw7X5GzyK9Xw8wQg5otETPtNW+1Fz9g==
X-Received: by 2002:a0c:f701:: with SMTP id w1mr1736457qvn.36.1605985113484;
        Sat, 21 Nov 2020 10:58:33 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id h142sm4651520qke.104.2020.11.21.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:58:32 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v3] MAINTAINERS: Add Kamel Bouhara as TCB counter driver maintainer
Date:   Sat, 21 Nov 2020 13:58:24 -0500
Message-Id: <20201121185824.451477-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Changes in v3:
  - Reorder entries to match preferred MAINTAINERS ordering

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 913b5eb64e44..1ee380dfe189 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2104,6 +2104,13 @@ S:	Supported
 F:	arch/arm64/boot/dts/microchip/
 N:	sparx5
 
+ARM/Microchip Timer Counter Block (TCB) Capture Driver
+M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/counter/microchip-tcb-capture.c
+
 ARM/MIOA701 MACHINE SUPPORT
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.29.2

