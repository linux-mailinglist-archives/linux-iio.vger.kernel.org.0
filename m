Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889153A21DA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 03:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJBcw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 21:32:52 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:34759 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJBcw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 21:32:52 -0400
Received: by mail-pg1-f175.google.com with SMTP id l1so21249555pgm.1;
        Wed, 09 Jun 2021 18:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04JQUBj5ojtPgamHPjVaFmIunywue518T+c+n9FraKc=;
        b=pq+yZjguSpqkV/6RKRqOXHV4/j1clvSjJFb50W4sJMya4++9w2S7o+RIrl34XrPEfH
         yWHMCw0IyPK7wVE5sepswVWZw5bUtSrpBf1Jx8UVY5mJLhgLFjYrwSJSJINVWThoNpYa
         lUwtZD+zaW3Fhazr8Zl6lvCxxKiyQOT8spRXVzWw2PSIiRYstidRw5OjNrn4wyRlyW/y
         u6iW5+Pi3EjVefWQXjwPsjbwzatKn1nd3ovZP9+/mwaK20+m51MywH1iGXNdxxxfoV+T
         c600JiDCYauKvdL4kEHRf+3KVkHb739CeERa7WtHob3pTxGSw72J0CPiW6LC40zoyCY/
         IS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04JQUBj5ojtPgamHPjVaFmIunywue518T+c+n9FraKc=;
        b=gyTVmlQWswvyV5Z8Kw361XvglLMionskT1n/21L/u6aPq8aqV+nuZb3sfYggw86w+L
         srJGwgLG6nvgprAIEy2CVjdF5OoIYfFGw5sGgndoBQMf/i99TcQdVqP7RQXc2/IL+0fq
         zuKOWoczWD2mwxkH3reEsvHZiQxqr8t6N4drOeVKbP4ihbEt3lL0mhwUKcxLHMZEUXp9
         8rranGD6bm/Ft1Ljjr9c7/lfMqeO6+I2DdadULMyPyhLmvuIZkthxpCfIazaVFBlVxxt
         /ioKLGzCtfthDkdCvUvfhMtOdqZe6oCVYC87XlQsZI1ZtDPQ9vXSU5HOurFS9CW/wAnT
         /xCw==
X-Gm-Message-State: AOAM5328APvDGpRdL4w0xEJ7FVE0bs/flmn/xrVWZF9bBDq3S3xmdXeP
        /oCrUkhGyEx7eUgZj8bySx0=
X-Google-Smtp-Source: ABdhPJxQZRnUnOuLeBHoJ0EgR9cfbWnwbyCBeKqcENQjPhDF8qbc36iBxieuEvq6YQjLI+FdL/fSJw==
X-Received: by 2002:a05:6a00:1a88:b029:2ea:548:5ed4 with SMTP id e8-20020a056a001a88b02902ea05485ed4mr523658pfv.47.1623288596641;
        Wed, 09 Jun 2021 18:29:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id d12sm633856pfo.113.2021.06.09.18.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 18:29:56 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Thu, 10 Jun 2021 10:29:23 +0900
Message-Id: <20210610012923.146727-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
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

