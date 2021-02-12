Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1ED319E16
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBLMPR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhBLMO6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:14:58 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6D4C061786;
        Fri, 12 Feb 2021 04:14:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v10so4118457qtq.7;
        Fri, 12 Feb 2021 04:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYNQDVBttWuol9Nr7vZ9TZ0pD01e0D8AxvqzWcKy2yQ=;
        b=aM0sxgfW7EgiObp2+TZrx7/lpr8sKMXQGE4XaF94+aL5T5kix2W8sOsAr8u0jENXVE
         7ifeOIOq16yrovXrbb8oiyDkt+ArzI+PtEZez5zjEvlJFN3ZFsbl6RvIAoza1oNUOCX1
         olEGary8VS5UP6uiSlIR5HLqcnjrgFztryrCUkJeSMUKk70QmoHERtWMIrvjqQqulxX0
         xMyTRO5H7Say1S18oBN+GhBXNe6kuL1byvWTOHo9i5zCEEshHdM0dxUrf0Ud9pvL7rOj
         OxFXDTRj2LBOa+80VR1/rN5SRZ27oq6IRHXOM8rvgNHGumKKjlrG3dNbN0m3JfnPzCSa
         zSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYNQDVBttWuol9Nr7vZ9TZ0pD01e0D8AxvqzWcKy2yQ=;
        b=ZMM02OgBYWyS9jaArKVcbEeeXDVBfdszjNI+sT8Bgw5NOPeLD+Zi2pjxUVDpSEzyo4
         DOyqRm34mnWgwl9fr2QgdwQz76kA8xjtfP83VbY6fvVge6wHoZMsu5ystHqm1wnylVfd
         fxr9+iA0yYBmRN/eqIZW2i+/emu8E5Qn0ABRGcAqIOvWyG66RHayoDBRB9hQJObGaILZ
         9nBlufo7gcy6n2wc/jl1pCu9D1hfWgY1HTcCn8FIHLCnNyb9un4xR3PSEubcObqk9+E8
         TfpIH6+vRmxNrLYpaSliPiRLtJ/qcB9iPSIDy7Nm6H9tdte8MorLvbZquYR81H+mU17/
         Zq0g==
X-Gm-Message-State: AOAM530B4mzQt/ocKm3pwmsyV/m6X5VllBBCCFT98GyROA3IqXxBwxqz
        p/LdjXgGLaNME5GRF6zquik=
X-Google-Smtp-Source: ABdhPJwnyJ+R/neIAfUAIjSjngmjsVTVRQEo+iuZDMXLDZrsRJ6K4GTnnYIMjHvxF2iySoUNHUa4Gg==
X-Received: by 2002:ac8:5894:: with SMTP id t20mr2078682qta.194.1613132056934;
        Fri, 12 Feb 2021 04:14:16 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:16 -0800 (PST)
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
Subject: [PATCH v8 03/22] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Fri, 12 Feb 2021 21:13:27 +0900
Message-Id: <2be0c071e7730ea16b8faa1efcd3d0d908e7f9db.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 104-QUAD-8 only has two count modes where a ceiling value makes
sense: Range Limit and Modulo-N. Outside of these two modes, setting a
ceiling value is an invalid operation -- so let's report it as such by
returning -EINVAL.

Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9691f8612be8..f0608b21196a 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -714,13 +714,14 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	switch (priv->count_mode[count->id]) {
 	case 1:
 	case 3:
+		mutex_unlock(&priv->lock);
 		quad8_preset_register_set(priv, count->id, ceiling);
-		break;
+		return len;
 	}
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return -EINVAL;
 }
 
 static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
-- 
2.30.0

