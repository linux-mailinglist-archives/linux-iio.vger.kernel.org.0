Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDA332691
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhCINU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCINUx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:53 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1745C06174A;
        Tue,  9 Mar 2021 05:20:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b23so810766pfo.8;
        Tue, 09 Mar 2021 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvARqXgeQ2fZeiR/U1XlXXl6N9XMxqOiCPuY7eJJp30=;
        b=daDaJJOuSYYv2U02zs+uchgqbT0gUVfefQebIL0i4wEieLWddHnNzkXYRuIF2Lcfkg
         PPYTwLFD4JRIpZ244rbGj1/4gruuuGVHk5NN3zyAwjTSUIcLoBJovLdzbu7mpvZPULpu
         ZDUUi2D8sPog66u8TuDPAv3Z67uUxKzwsxFfmepV8Z4Vhlh1dqzcLGG9MLSShZjoEdPy
         1wI3yVsYJXhAjlIeY8+VWegA0dMrAh7awbZ38Nb8GFrdjE73E5ltkLM8KyZsEU73IDAP
         YxuC+r8czFtxV14NhFpXVtDsCn2m4WsEjD/Hj8CevL67DxMUJdc019sOgqgWggoo4QVL
         R7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvARqXgeQ2fZeiR/U1XlXXl6N9XMxqOiCPuY7eJJp30=;
        b=b4LZw9ybb2npd6QpNSLdkV/mHisVp4YWUzryxVvivgU0jIWeLbu4jA2rk69HmSFMJI
         OzuZhm2srnzR4NxLWUpJMJ4YMqkbTgEAyvBxtwt9hkuDx/IFEDjfEw7Zy8l9pHqZbOFw
         kUbmrE+Yj1jmdZpU65LoSjGbx34mvA0c9IbjLZIELcD3yUr+K46wCkazYia5CiCu+ebb
         xMyPZA6S9Jm0OFYGDtHC5mtoCWY/ozm6G4IP6+u4rzJABt4aAwaxyE/bt7uESq7EaP8N
         xBQJ6nLItXradRdevM64sg9njdnM0dCea7/zmDMIthBROSgMQD3z/oPnE+eoK0VpNvJi
         osHg==
X-Gm-Message-State: AOAM531pVD3pIzl8bRt+WuQZbLZ2257f66UnsSso0KriWmaG+IrdwM4n
        rriCb22ydr7PZH1gt62hCkw=
X-Google-Smtp-Source: ABdhPJzRAXelYHDtirlTtKesTFBuImAY941y8ZqiNjYmDxoddlkFWj+wWb14a12LcAATmO1yfpjUng==
X-Received: by 2002:a63:1946:: with SMTP id 6mr14219508pgz.359.1615296052621;
        Tue, 09 Mar 2021 05:20:52 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:52 -0800 (PST)
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
Subject: [PATCH v9 08/33] counter: interrupt-cnt: Add const qualifier for functions_list array
Date:   Tue,  9 Mar 2021 22:19:21 +0900
Message-Id: <fd566f436d28dae842a45f942bf25738ab6bd139.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
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
2.30.1

