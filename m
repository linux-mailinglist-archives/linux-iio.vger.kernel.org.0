Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92691341AA3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhCSLBr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhCSLBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EBCC06174A;
        Fri, 19 Mar 2021 04:01:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y27so3425752pga.9;
        Fri, 19 Mar 2021 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TpNtbXoxyIjRd7QIp1WNUGV3OlR+l0VzEx11bA72Sw=;
        b=bGsyS/ntHB5J/zGOzWa3dDyJ+RSrk0AxzcTTabPa/qWzSF3DAQkcBBYPCERu5rU5/L
         /Tpp7DtV9HaJHtMyRTwa9QF+cO1KFylnYYX0zCk3n0pCx8jDthkoiATd01qRCQl32SoJ
         rBFrtroMaqCCnK8fAh1FJhtZhtwxb5AdtpztX4O3YecnWYidtuMs+j3td9/dI1tAXP6l
         YEfWvLnIbxnmsj2t9dvTXyh//iJksnwS3T0AcYJcLvo+ZZziwXXeqaEOjXRlP28GXWMB
         qztwaapx0RSzcWGJBFDxMY5J3IDt3c1QgW459KejscA78lWdxtZxgJGXLYOXKCnTxLCI
         nYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TpNtbXoxyIjRd7QIp1WNUGV3OlR+l0VzEx11bA72Sw=;
        b=n4K/Jb249k3Wt8vRfzygKBqR1FVq+f7P9eBbytreisv7lzNflAhe2df7wpq70HUZ4B
         P6zUNQBynBQqafcxJyuyEQ3rGIZJrTcZY1FxAMHN04Y5Ld5momKXAWGoMCx4/gjof/zy
         aOGuAxHutf89AOBQnxEfeLw+sJbbb0KdrIGCR1kNzGU816+DArB62er6GZdEHybe1k1q
         Ns1hRsxqws3qGW/0n8xScMYGCQGNWufDHzzKSyebjfLem+C+o5GT/cOS8ixVChvl8kCl
         TB2XlXDITHDYJ9ad7md5fNE2Ec31NM7gcU2EsifHm28pfSTCJDRU3yTwOXbunJFj4PfR
         je3Q==
X-Gm-Message-State: AOAM53082fndt0JTAjYMNmcWS0vM3H4/4L4+g5/4kXRgd7tf9J7dBQa7
        kSRJLzuMQNdqQMt7uzaqJ0I=
X-Google-Smtp-Source: ABdhPJzxh9zmvHiKp9AVLB5uChGOrHdkMdux+y77XRdYYBPJAs8ueovVpELDjCWf+ul14cb+iAaEDA==
X-Received: by 2002:a65:520d:: with SMTP id o13mr10965823pgp.57.1616151683853;
        Fri, 19 Mar 2021 04:01:23 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:23 -0700 (PDT)
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
Subject: [PATCH v10 04/33] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Fri, 19 Mar 2021 20:00:23 +0900
Message-Id: <98676f9a2e9cf991d7a002b3b264cca774e5b3c8.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
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
index 4bb9abffae48..233a3acc1377 100644
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
2.30.2

