Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4932FBE8
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCFQ3Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 11:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCFQ3S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Mar 2021 11:29:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA8EC06174A;
        Sat,  6 Mar 2021 08:29:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w17so10359328ejc.6;
        Sat, 06 Mar 2021 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ey8Iam28nWwFN4fqDqHWXz4/dWKH/12t99L89RsheoI=;
        b=tvdyAvS58OLLGgC+WvrF3dui6xqtzqAfCkutRS7zWByztDn0Bmu9Kqh26vV+L7KBJY
         8VIw2C1H0FbIpy/WSD+zmR4E42AS7Wg4KcGgI9qh/BwCEaRQeM7IObKy4K+mL1vcqD2B
         Yo85WIim7R4xEsIkuwJYkCPVa1FbP5ab+39orFE56a4QR3E5eAAZxWQc+JmsGH0yabBU
         ojF0Mav+tFph/UadgkVGpuAhW7meQZtvIH/z4DiMp0cDwnwoWVwW7e1LStlE7ByTU4sM
         gTOjz/0ZMm+KEHplkVoRqw+BoysL0uF2beOOxuNAFUdIGoKXP9nYWNq14eqF78rI7D59
         9KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ey8Iam28nWwFN4fqDqHWXz4/dWKH/12t99L89RsheoI=;
        b=cQBuG+H8zBnRHQ15MosYAk68EZBz8CsDmWEmf2/Ow9267zaEAsjZUrjxZmldveEaeq
         xD1gCA+CCfJQHdta9cdX8Rn+yWIdN0lh2mxPRJvYILHTDeyxs2LqMvGrJko5e10DVxbp
         NvKKU2pULfdvhhjSpwLknMnAwMwPTjfvCFDosHm3pORkPo3ROqTAYI5KQjd0GYU2i4al
         BJR+kPXPQSRXRZL1rfFfpM5k3bFKWs6scffAYYGkVK9GwpaE3GNzOwCEKQvWZdF93Ti+
         0z1abIdffS6P5ejfv/E8TRDYMoAgnpVg9TwWmmiQd0MvNctquKQ7ZZvz9Qnl0J2c3IbK
         BjzQ==
X-Gm-Message-State: AOAM533kZs1BtfrD2gUrCdZnoIaNSB0BDrU2x8SxYOSPOHjQp85FGJhy
        O+SgV+KH+gscurik0u2EhTUC8q19vYy0mw==
X-Google-Smtp-Source: ABdhPJwA+ARDP33bRighyeE1YXRk/HIoXy4caD6XU0gZC5nO0dsYGgdE8VjloFPOsmUx5HHowcO2NA==
X-Received: by 2002:a17:906:f02:: with SMTP id z2mr7554520eji.469.1615048154849;
        Sat, 06 Mar 2021 08:29:14 -0800 (PST)
Received: from saturn.lan ([188.27.130.90])
        by smtp.googlemail.com with ESMTPSA id q1sm3493349ejt.65.2021.03.06.08.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 08:29:14 -0800 (PST)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: kfifo: mask flags without zero-check in devm_iio_kfifo_buffer_setup()
Date:   Sat,  6 Mar 2021 18:28:34 +0200
Message-Id: <20210306162834.7339-1-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As pointed by Lars, this doesn't require a zero-check. Also, while looking
at this a little closer at it (again), the masking can be done later, as
there is a zero-check for 'mode_flags' anyway, which returns -EINVAL. And
we only need the 'mode_flags' later in the logic.

This change is more of a tweak.

Fixes: ae9886d6aa29 ("iio: kfifo: add devm_iio_kfifo_buffer_setup() helper")
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---

Apologies for the late-ness of this.
I don't know if this makes sense to squash in the original, or to have
as a fix commit.
It is a bit messy now that the original is committed into the tree,
and now we're fixing/tweaking it.

 drivers/iio/buffer/kfifo_buf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index e8a434f84778..8e3a1a9e495c 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -275,9 +275,6 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
 {
 	struct iio_buffer *buffer;
 
-	if (mode_flags)
-		mode_flags &= kfifo_access_funcs.modes;
-
 	if (!mode_flags)
 		return -EINVAL;
 
@@ -285,6 +282,8 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
 	if (!buffer)
 		return -ENOMEM;
 
+	mode_flags &= kfifo_access_funcs.modes;
+
 	indio_dev->modes |= mode_flags;
 	indio_dev->setup_ops = setup_ops;
 
-- 
2.25.1

