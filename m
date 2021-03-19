Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8E341AA5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCSLBt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCSLBe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5873FC06174A;
        Fri, 19 Mar 2021 04:01:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y27so3426090pga.9;
        Fri, 19 Mar 2021 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeVMUELsSRVxeUS6ro8QPXwbMLileU2G6rPw+jVjGYk=;
        b=X24pb7+dYFtj2mM5k/2cLtbb+JoOMN6PVCV5K2nU1mFYA8HUghz240ARKjWBo2R6oL
         nW3SfEKupdMjFc4Y0HVfnVTWQEyUQ/h9gsR+JfPJ3XLjBcpfyioM5fKW0TnxZsSVAGQh
         SiTcftcT+mI5TJYGdvMP05FD/OdACJVIqc9uQE4jw6CM99rbxmSW9z9W+egHJAFsoBTZ
         xP2D4Hg5yIRu2d0zTN6+xtaMgcC4aSnOmZy3JwRVmoAh97w5cZFQqLEypsXsRcftXWRA
         MInGS+KjZhIElejzH+LUouoOZ7dahXxwuu4lSxlM87f7rucczOA6HD3qWbHKq0m5VldZ
         5UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeVMUELsSRVxeUS6ro8QPXwbMLileU2G6rPw+jVjGYk=;
        b=HtPcLHvvhwHiBg4p4BHPUjunsPeb5hTbs/B3XQOo812sO6XO8f0Sy8z1P5loNBS0ds
         qhWL6ycxWzsJwCO81UQtjoQAYa20g69VK0eh6DDn8B6oPLR1HcL7GPtwkbLD0pCRtvG2
         2B0qRtpyrvTum61YK3PAs8oD8kGRJERtwT1JstSJNUS3HK7YYNCOSjE7QItdX03GLNur
         /S/NPwjv0xpwo5Cm2rQa7JGZDm9nl7vO7WqShR23Cfb8A2mhcP06vBFUcEkTckZhfiJj
         w3waTZa2qQujfCEmdc94Fj9XDhesr+JPVRpwTlJzc+Uu+CQ4Cp1vudxxUp7yHuBDcKjZ
         wqmA==
X-Gm-Message-State: AOAM533feXnIdlRrPn6VNSNZfsj301r7U4NOsJL/d0C+MY0QJ7DnvMsH
        UsLhYUiFu9u4PVH7InZWcHM=
X-Google-Smtp-Source: ABdhPJz8LoFhKaWgFy/KKzChvQwuknU/7/8FINs7N2t4xXiUnnQdM+uove8u0VdoRkUHpy37LHB9Lg==
X-Received: by 2002:a65:4c08:: with SMTP id u8mr10701760pgq.203.1616151693937;
        Fri, 19 Mar 2021 04:01:33 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:33 -0700 (PDT)
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
Subject: [PATCH v10 06/33] counter: 104-quad-8: Add const qualifiers for quad8_preset_register_set
Date:   Fri, 19 Mar 2021 20:00:25 +0900
Message-Id: <4a227eea6fa6aa1648fb0ccba6e924b6f95b2752.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add some safety by qualifying the quad8_preset_register_set() function
parameters as const.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 0fd61cc82d30..51fba8cf9c2a 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -632,8 +632,8 @@ static ssize_t quad8_count_preset_read(struct counter_device *counter,
 	return sprintf(buf, "%u\n", priv->preset[count->id]);
 }
 
-static void quad8_preset_register_set(struct quad8 *priv, int id,
-				      unsigned int preset)
+static void quad8_preset_register_set(struct quad8 *const priv, const int id,
+				      const unsigned int preset)
 {
 	const unsigned int base_offset = priv->base + 2 * id;
 	int i;
-- 
2.30.2

