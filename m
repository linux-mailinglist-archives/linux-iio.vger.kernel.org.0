Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2972E332686
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCINUy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhCINUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F35C06174A;
        Tue,  9 Mar 2021 05:20:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so5186847pjb.2;
        Tue, 09 Mar 2021 05:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bg5qFyXKAm+O0oZX3oySwuvn9LP/nKtXNZnKHyMJuCw=;
        b=pe3koxT5n4t/VhCCDA7GwX6ehizUjwoZ4L28oLnp3eR51AGzcCWGKtKb9rqj6Q0EHA
         qBEvsEYAssU+tLeuUiK4ZcbSmgCk1mdIohDXLqIE6VFwYT/4BKP7kbaPOuTXRawDyL88
         GTT54CpQgWZB0mB19eZLkVb3d9TMgDJcWLdn465X+/yGqNyTTqKWf6zIzenvd1ZdL1VF
         Zv705GwIH1KWI+EcyxCQW/yd3OkmcjxIc1aZWlULvad1KMomwLYsU2MCR0PJtkkxzBtf
         hWgNAQPJyYRiPtsf/FLMXkn+AEKtzah8PSOohV4QdhPZZ49/DidPBXujvJtB1TiDVW7M
         gh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bg5qFyXKAm+O0oZX3oySwuvn9LP/nKtXNZnKHyMJuCw=;
        b=rem27sRXRa7ptRocYcR35IyjNbXKx3kZ0qP9lkAiXUbdDKyCBxX+6UaTPZMZwXWQAd
         JBlDHvZ6x7RvGwXSn6yMst/JWeDTSIWLzQWoBhayQBLffBSCz0RQb3KxvgfxFRki/joO
         x/U+koTgR8ZoZ28dRFXbmFZLT8tXIWnHvbSZTOMkkc/fy9TMqMJRqFckF7XBIYwEUIKf
         enE7W5Dp+vZd1nIIpnxC7tM9u3SicsmSWHc+b+kfU2lnG3axdhG0pkuqGwzAcX6IT2ju
         q0SJPhzSagX9UGKPdDitquhlUUockQCR+e+mvYnNw74dfQQa98xloZaabvxPJJSUWM+y
         0KVg==
X-Gm-Message-State: AOAM530hSVvMRdB6D6jFm2vYps/S3GX1Pk5EIjj12n5ky2CjINT7/Zt2
        s/SV4rAie4wulnAaJ4ZNAa8=
X-Google-Smtp-Source: ABdhPJwOqzhV8kA4WQiAnQbL8enOzmt6KpcxjVrGgHYUAz/sr3uZG4aolV2X49YSZs0b+UU4gthLvA==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr4669996pjb.217.1615296022135;
        Tue, 09 Mar 2021 05:20:22 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:21 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 02/33] docs: counter: Fix spelling
Date:   Tue,  9 Mar 2021 22:19:15 +0900
Message-Id: <a474ed8bdbb6acf4dad5d92ed3e36c7fa21e6540.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"Miscellaneous" is the correct spelling.

Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index b02c52cd69d6..64fe7db080e5 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -307,7 +307,7 @@ Determining the type of extension to create is a matter of scope.
 
 * Device extensions are attributes that expose information/control
   non-specific to a particular Count or Signal. This is where you would
-  put your global features or other miscellanous functionality.
+  put your global features or other miscellaneous functionality.
 
   For example, if your device has an overtemp sensor, you can report the
   chip overheated via a device extension called "error_overtemp":
-- 
2.30.1

