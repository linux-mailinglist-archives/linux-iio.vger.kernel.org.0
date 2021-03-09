Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD533268C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCINU4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhCINUc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:32 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD7C06174A;
        Tue,  9 Mar 2021 05:20:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c16so6568703ply.0;
        Tue, 09 Mar 2021 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uo8aZJ7uFJm9IN0X5m8O12CJstLR4Mg3ThLr0VJ0OLA=;
        b=iyVwdDeb0d9ar/SgQS8NCqCJF8zBmbqYEU7YVIcfERfeXU9rRk+X9zQwpng9qVLZda
         d1yQFwkRQ8moVuHOC4RaL4Eo+CI1Jg13S3Hg6IASCNLMFxuYym7guA7qAb4WPvmIhWn6
         P/fdq6zIxxYWhKwBGjfuOapE0xGM0vv5wE20G+6Ri5Twoc+Wx5yUlWsdz13BfRWUowNs
         saUOHkge4Z82XVoDKISrpPzLWDywMrP/a+UBj+RSFBKZNgXdtK1ZH2UiUnola7ptT952
         yBn8kK5z87O+8qTLztPBkh6iP7/J+wmtH/wZUR+UVgqVXKcvt1/VcQUQF/CG6wjMMSJy
         lFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uo8aZJ7uFJm9IN0X5m8O12CJstLR4Mg3ThLr0VJ0OLA=;
        b=oc1KcUyDV8LjJQ11TAx/r83sWhaFHFd/tACCdEQC6KYxUkxRXONjX+0Dvxl9JE+0bX
         zCPYI8+bOlV0KiUB2EVJ+NtaClo81W8MxGRyLKHVai+pzrJ9I6xnfNplb8IttOseFW0e
         VaKXTmw8uKKdtqZUpcav8INtcTwjTCV8CU5IyRH15tKFJOEcWJw3AkI2/DxuoZnV6QBF
         YnALzTqmD3+AihLrFxC5V5KkxvMMGRIvxTEH1iwgqNbiF9/Bc9j0bvfZM8oP9BHHhhvd
         DLUJG4yif/P3w58f1gMLnkSeanTrw0lR7IAm5HqAEWy779Ce/ay6UY0yz5iY9btmUp0m
         mlWA==
X-Gm-Message-State: AOAM531pbiuAoWNWzN4UVTQ0Nc5zYTP3kKj3qirHV+f/yzWGfFgTp2so
        Q4J+9fJS8BgNNU39Pkekoqk=
X-Google-Smtp-Source: ABdhPJzztWhpH23pplZlKp2maeyt5sWNUAAE2Am8BwuwOdJ/qsjqY345MQI6zfkVfbAY+PYd8TblmA==
X-Received: by 2002:a17:90a:cca:: with SMTP id 10mr4613485pjt.103.1615296032134;
        Tue, 09 Mar 2021 05:20:32 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:31 -0800 (PST)
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
Subject: [PATCH v9 04/33] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Tue,  9 Mar 2021 22:19:17 +0900
Message-Id: <ab32428600ac501761775f65a69f103859166d55.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
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
2.30.1

