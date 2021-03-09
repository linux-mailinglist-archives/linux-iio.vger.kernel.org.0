Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B11332687
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhCINUz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCINU1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:27 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF1C06174A;
        Tue,  9 Mar 2021 05:20:27 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v14so1827473pgq.2;
        Tue, 09 Mar 2021 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8tDypyv5ahTAAMuxI8NeVKXWRsIZA+Poj3szWZsqgo=;
        b=AYFaivlvQ/oLIjqJsJ/oehFS2L+56XUaU6sHt6nqOxr8FYpHMoGpDayLhwbo+RksWm
         m7Gdt+fW7hkOkEmzec0TM8IDtMPPmzEbDFvYQ+YT0XYHv66cHlTmoL1ghMEgsCalRPZB
         Es2RSKI/6Bj1qBz5P7gFOivsQoQCTuTIGUo2z8IupngTF9Jx0J4Zrc9WtdNTTQ2UoRqS
         dApjEniHKrL/jhZukBBhOnIZX2SNyrhB/at8RH6/sL/hBbFJWuJbPnQH6zzoM3bixpPG
         r8ZJe2EXD/nkza8KiXAtWxFAvgr9II1Xfmr0u1gQkwUeGo8voIN4det8zp4pwRs6K5Vv
         FBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8tDypyv5ahTAAMuxI8NeVKXWRsIZA+Poj3szWZsqgo=;
        b=MGOGlk2CpIG81od9v0mjvFzO18G5/GqA8Y2KRQeFeQFWpiIU5S7t8XMitZNtxk6x/y
         PDb7GdPznm0KtY1ek8GwJO4440/uHYSSCePp67q+pSsw41PNWAMeDePiJAJ6Y4W7sw3y
         HUMnwgvy/yVk7b0g6dKt3FR+ERIIi0fRvAKWhDudjc1zmjSB7tphTVj3jsDPLhMimWHY
         Vb8yR+lVgSIkYm+Ev28TRJ+a34gOuFv2N68e8Nont2txjlWWdDvg4DvBsRv75ltwAIw1
         BZKDckDKT0VPdpSAfAm4oqGBff+louweels6uFouWjPREat2/HW2QhiV5clmSGLb+SEp
         /G2A==
X-Gm-Message-State: AOAM531aSJCHEVwHX3Zql5gxVmG4Qy/lkZ41IOJphuT8y7yJTMPvA3v6
        uit9w6WYbe+kzYDK1I0fBE8=
X-Google-Smtp-Source: ABdhPJxZKUUTrkGax8iWT8D8hxgyat5r+1Lghh1cpjR/93ysYtEmj5xKbxB+lyQOaaMyj9VgK4pDiA==
X-Received: by 2002:a63:2441:: with SMTP id k62mr24161252pgk.332.1615296027115;
        Tue, 09 Mar 2021 05:20:27 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:26 -0800 (PST)
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
Subject: [PATCH v9 03/33] counter: 104-quad-8: Remove pointless comment
Date:   Tue,  9 Mar 2021 22:19:16 +0900
Message-Id: <75913055bea8c4200f35727c03dd090d84f46c51.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It is obvious that devm_counter_register() is used to register a Counter
device, so a comment stating such is pointless here.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9691f8612be8..4bb9abffae48 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1082,7 +1082,6 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
-	/* Register Counter device */
 	return devm_counter_register(dev, &priv->counter);
 }
 
-- 
2.30.1

