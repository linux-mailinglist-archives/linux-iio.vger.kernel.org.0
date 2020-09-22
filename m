Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB40274A09
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIVUTv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 16:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgIVUTv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 16:19:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA862C061755;
        Tue, 22 Sep 2020 13:19:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so15261234ljm.3;
        Tue, 22 Sep 2020 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S2U6wwtCWqdcr4h4UyNb/EZpSOd/ROirDasW3vU93+Y=;
        b=JpbkxPjtTdP5pr3nrKNG031XI7P9vzMgcAdea4CMTqhyX4/DoVCNEpvY5rMRLxW2Vq
         4rIom6amGd4jem3NVPAYRrTfH3O9L4EZwTS7iwsvdmvFVtUG7jCFDhzUCL6H+qq0HwcW
         BU32w7uoxshPo4Q+nax4EGGfVeqcjuw74H+1Yd9BhhS5DRatOOqqn51C5LuS0MMX7F5c
         YsxYtjxFYOypBv4ZmWdU5A6r+tPqJfvigeYlh/2IBnCErjftzbFW6DKVM5Le/CsjWzwp
         UGCncJo8RRXEc7nJD9T/Qpf27nfZzszP0XHVyLfqjLn6le110fB5+fNUL7R6DJGUf4l8
         yzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S2U6wwtCWqdcr4h4UyNb/EZpSOd/ROirDasW3vU93+Y=;
        b=BMbNIC+ArOjOtoypyjoIwDwQwzhJmivqstbm80B2X9AU1V+4DJAlkegNf/YuHDrDn7
         4bH8jDYEBHJBw8aHaRQm8cVh80to/cEEaOnn+dnwehdZ3VR14JpsV4elddrP5Q1bcEpE
         gEx54GnUBtiU14kih8By+vJt65bLmAfoaJ7okz7gDYF/FRk8lMn1k307noY+eyiX98b5
         s5vtCpWOB9W9ldZMIJKj/ewfObR9jBVz4RqoB+SgKc9lRKq2KmW3rk7BSxv8BCfHcIJi
         1uGdxHHzywUWFyY4ZiKA91V4BhjFGw0GPwq8x6QtDpOIM08hSFje1Xorq7jZhyIrnPvz
         +GNw==
X-Gm-Message-State: AOAM530dnOWi0oUspdAtLWsKvnSqQRjOJqEmZJuNy6q0H3zwACPJU0E1
        VBVG0lwpXr5a8NxlYe0d9Y8=
X-Google-Smtp-Source: ABdhPJxOEQoClB2ZdVBHcyBliyMuqRLy+PoyXyZe7RP6Bk4Ct2s0a3CAs4Bf4refaGvkIn7AoRX5KQ==
X-Received: by 2002:a05:651c:386:: with SMTP id e6mr2212684ljp.424.1600805989074;
        Tue, 22 Sep 2020 13:19:49 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id z9sm4143867ljc.22.2020.09.22.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 13:19:48 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] counter: microchip-tcb-capture: Constify mchp_tc_ops
Date:   Tue, 22 Sep 2020 22:19:41 +0200
Message-Id: <20200922201941.41328-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only usage of mchp_tc_ops is to assign its address to the ops field
in the counter_device struct which is a const pointer. Make it const to
allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index b7b252c5addf..039c54a78aa5 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -253,7 +253,7 @@ static struct counter_count mchp_tc_counts[] = {
 	},
 };
 
-static struct counter_ops mchp_tc_ops = {
+static const struct counter_ops mchp_tc_ops = {
 	.signal_read  = mchp_tc_count_signal_read,
 	.count_read   = mchp_tc_count_read,
 	.function_get = mchp_tc_count_function_get,
-- 
2.28.0

