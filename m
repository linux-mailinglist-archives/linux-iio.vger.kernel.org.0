Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8623DED61
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbhHCMG5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbhHCMG5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:06:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A95C061757;
        Tue,  3 Aug 2021 05:06:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a20so23509746plm.0;
        Tue, 03 Aug 2021 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwJZ+FRHmPdVwm0/Cne9BWGWHB7Nx2ph+8GMBriVPGo=;
        b=NTem+pkvyz3M/u5VjRQwsmmDGNloiGzV+oR7glIH/HFdYnQ98DNxbSymxCdY3BgM2s
         QlRWpKLt6GwQS5p2H0N3+EC2EmgbDJlRmSFh88V1cwtyTO9GwsjM1vOXa/EzambMhA5A
         3A185UhljFQ5NZqBtccFkRd7hFEbz4aUqYX11e3AWjVdJcE7wQdfkx9te9CfVddqUYHk
         A3UDKpIoTCv10Vor/i8a3hjcHvSIaoRZxchRh090Ky/qt1gg86EjQl8uAr5ILYb/5ioR
         sNLP9OQIiFI0WVyVUk3FucUJdke5raumtLdEuvJC4vgg/Voq15hk6lYLOInoemwzAGqa
         df5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwJZ+FRHmPdVwm0/Cne9BWGWHB7Nx2ph+8GMBriVPGo=;
        b=hbmxrIUIo2b5QVg9VX40vpqwaT7qMZxbJQ2S91DjXMA0V0SoRIUbqjHjdNnDSEFy8I
         UWa4BsULtIAdIchD0Dogg2zn8R+NGpPmD3wo4tbkRZvgxn3vkJ+9FpN4UcZe4aZ3epHu
         oPNxf2o8AACsfK1xma1Xj63UTxv88yu+qkrMeuSXhZAUi5aADoEcl5IKMlk2IXZh8Omy
         r+fHiPZI2mFA9pY9pF3jbZBpJdPF8vZ77eMmSXvKVrlnkIdiXTsiHmL6EhmPSKECGSR0
         f5/uKcoQ7oIwsKQmoOrYMGoIJYmwaygU3972SBpQAjWDHn7jizRuinStohSW5wm0pPN/
         9vSg==
X-Gm-Message-State: AOAM533N5MLaP5NyeZDPlVHhIvCESZiCpoDaOJvSWpfj9w17q9dgbTK6
        vrjhwv0M3fnzAMpjRcKfW1c=
X-Google-Smtp-Source: ABdhPJx7iYzeWpTrP94hIsTJ4WXIr0TQZsRbh0RmiS5LYEvELWQrYXJERtSsV13WL96l31egt9ZJ1g==
X-Received: by 2002:aa7:8d56:0:b029:327:6dc:d254 with SMTP id s22-20020aa78d560000b029032706dcd254mr22101625pfe.69.1627992405250;
        Tue, 03 Aug 2021 05:06:45 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n35sm7197502pfv.152.2021.08.03.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:06:43 -0700 (PDT)
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
Subject: [PATCH v14 01/17] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Tue,  3 Aug 2021 21:06:11 +0900
Message-Id: <a2147f022829b66839a1db5530a7fada47856847.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
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
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 09a9a77cce06..81f9642777fb 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -715,12 +715,13 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	case 1:
 	case 3:
 		quad8_preset_register_set(priv, count->id, ceiling);
-		break;
+		mutex_unlock(&priv->lock);
+		return len;
 	}
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return -EINVAL;
 }
 
 static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
-- 
2.32.0

