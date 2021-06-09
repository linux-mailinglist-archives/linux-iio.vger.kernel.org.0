Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938003A0946
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhFIBfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:36 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:56307 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhFIBfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:32 -0400
Received: by mail-pj1-f51.google.com with SMTP id k7so402263pjf.5;
        Tue, 08 Jun 2021 18:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCZji4goj7QXlZQ7G+Tg1qQ7IvLJWZRrdogqrbs3ALM=;
        b=ACkOCpxDCDfZiguYpTYkrtSKfIleiPywiOpWXj9r+yf0p+9zcSNzh0pRtjhROytMNw
         hLPENnYIIEYrmOAA0LOWgmi/93MX0Jz7pMSbP0qsCMpbEKvblWsiCyEEm7JRmKkGe0eU
         N4t8z78PaI96dNN32hwBANoqURCS+bM4B1rhIKZvZLuFH+HIQhppFV25f56+5cWwQMxY
         i9G68ZCiNlzG28JQVCMB597wvPDvlUczxoWo53+UopMmC1XK+bxIx8SN7bkAHKaC3KaR
         6DPpstl5RIkDuMJWjIdw17/NXhDzv0F4FQmWSLmN0X+p/WHNMywPFHV3Sr9wmoyFteQf
         rTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCZji4goj7QXlZQ7G+Tg1qQ7IvLJWZRrdogqrbs3ALM=;
        b=d4WNQfs9F8Il8zAvC+2ANSu4yNBmD+fZSdGEmgDYtgFqMXzu66sJk8RmWE8HE1oF7r
         xyBSZtZjNacCU+jwwAzrbUz2a4Kcxbm8DfVfUtd+rdtJq5HYDizXviFnuTa7GFgewhJP
         UUVV8J0ljK407VDYMnRN/o0OskuuAO5gp6qtXis5vGQkMlUSxtk9kyBKhsz81C/e2EFz
         muU/+pOvIG7NbYTjFrnEMdSaxYzYhLa23bsTJo0IHdk85kWv8v9FdStxTg6Bm0aR1PE4
         OmiHVLp+jE5ZdOCZXDmtjJulfgDTVVv7H1pbjUSyiqVBUKUtRBvoBSZMZKAHq+lf5uQq
         Gz2w==
X-Gm-Message-State: AOAM532j2PGT9qYJ2FLhbNX1S/Z6zbQ//rU52boBhoD/DhKZyA7BterU
        IIr8td6l+YbBFXRWwkzvdl8=
X-Google-Smtp-Source: ABdhPJw8Wzw+mTITiTIF/fFew3Ep8DDA++vqep06vunlCkFhn0b+E4h8pgkUdr7Z167dUExBJtOWzQ==
X-Received: by 2002:a17:90a:a512:: with SMTP id a18mr7852442pjq.215.1623202349999;
        Tue, 08 Jun 2021 18:32:29 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:29 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 08/33] counter: interrupt-cnt: Add const qualifier for functions_list array
Date:   Wed,  9 Jun 2021 10:31:11 +0900
Message-Id: <86f7fb77f703cf2508a6b4ee9cf80aa523392976.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
interrupt__cnt_functions to match functions_list.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/interrupt-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index a99ee7996977..827d785e19b4 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -112,7 +112,7 @@ static int interrupt_cnt_write(struct counter_device *counter,
 	return 0;
 }
 
-static enum counter_count_function interrupt_cnt_functions[] = {
+static const enum counter_count_function interrupt_cnt_functions[] = {
 	COUNTER_COUNT_FUNCTION_INCREASE,
 };
 
-- 
2.32.0

