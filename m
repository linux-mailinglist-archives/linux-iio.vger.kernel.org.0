Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC70319E14
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBLMOx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhBLMOw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:14:52 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53996C0613D6;
        Fri, 12 Feb 2021 04:14:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v3so6493581qtw.4;
        Fri, 12 Feb 2021 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9MVM1xcNi7V1HTtwx+BbT8RtO64EAjisI3WqrvzlhM=;
        b=QcUZkZomdc1mBWtdJCbI8UkHhb0aAtHBnqRDKPasQ4dnD76ls/uIzGfxJtzRk2UN5w
         inQFS+mJjFkLeHMuho3EMLTTixJp4Qh2qlLAvIQwgwaTDf/+cmjKWgYflveVEYH71q2j
         WAgblfQ8eqCROJSBU6h6V4bhq33sUCJjqZ8I+yr80am7twLzHNORpuWb1zQ6ezmZErtr
         cdnfMPP7rRLeCftiz67UsB/NzkJDY5faMfFiZ49YYlz/FLYxjSO5RQZ3UM83SHZeKeJP
         021WR/8enqbdXwBKGxkLgptdSlCHDUJwE/8of3dzc/iZxMZT/ZsNjfvD8pVV+7m0LqI9
         tUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9MVM1xcNi7V1HTtwx+BbT8RtO64EAjisI3WqrvzlhM=;
        b=GNgRPw8Pg8u4FplNn9u7z/DKuNgX0ziu2++O9Iad0w5z7dbB+RzIwTIqpLEzKFvoGY
         ZvzF+Qi8b8tu3Ed4mQUbHan99znGUhcrURLTpHZpUz16XTeB9TVJtDdYUN2aQUVBZBP5
         P2zlA/XMwgwFG2MZrc2qoHhnr2L12NDyyq2ZBVi+rWhQq0ipSeGil8oXkUHGjXOzfrYq
         hzPAa6c0IKeBVWtVatPfpaaq36ZVdJCHraws61STSwXdC01kRE9yEPMEByfrniM1driu
         eyy6Wx+ng6LLWI+pvXxqEv0oN+0d2jrPP4wvG1bunAQJIX/9TBqqzj61FI9C1wkU3BLZ
         pyGw==
X-Gm-Message-State: AOAM532P4ZxaCNg0n7c4NbwQvGDiOpGclYSvOfOa/0BTIJJTU7Jb0nln
        ARBcFYdAGdlhewbBmmhF5xydacyAn/0=
X-Google-Smtp-Source: ABdhPJwihv1BKw1Q0mvejQLLioSu6ygUVQZgDYd/xvUVbf7c7bZduNPZmX5WR9aK4EZVYHRVtVRI8w==
X-Received: by 2002:ac8:149a:: with SMTP id l26mr2030634qtj.210.1613132051207;
        Fri, 12 Feb 2021 04:14:11 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:10 -0800 (PST)
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
Subject: [PATCH v8 02/22] docs: counter: Fix spelling
Date:   Fri, 12 Feb 2021 21:13:26 +0900
Message-Id: <0f90d3ae0305224abd6350059bcb00ac44bd858b.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"Miscellaneous" is the correct spelling.

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
2.30.0

