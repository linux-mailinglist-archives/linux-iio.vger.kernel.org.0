Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC24341AA8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCSLBu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCSLBo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC87C06174A;
        Fri, 19 Mar 2021 04:01:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y200so5625261pfb.5;
        Fri, 19 Mar 2021 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCIsrz/xNvA8l6ynJhWaN/C4nkgE8ErMLRxbZcB8jd0=;
        b=am/M0nVLA6ftbdIkBJC85jGx6ceAzyM00ClgAXBg541rE5bK6A+wFcQfakS/ZWqkg1
         gamQ9xCPIsmi4YpN0aQqREqPnl4PS6Q35iX09W+AJD+ypBMZ+Z0mpi6waAoh+8/MARTT
         cc33HDM0mNeAMW4lN2dVsCVp1ZqWvKxU32LqbchgFLVV10rVNmfquOneDsNtgilXi813
         d8r4ROtk5bKf/LpcDkE8NOpzLDgvcDuGEsGRH4os16N2y7bPQN0ZmETIYRF5xB4LO2f4
         JsixGDErfCTV+au9XB15Uusyu3pFn9SjhTT7a40KRd1ZsxoyiNIANFKs/3Ecrsy9ejwH
         9trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCIsrz/xNvA8l6ynJhWaN/C4nkgE8ErMLRxbZcB8jd0=;
        b=CqELw46vomkA3SdWqJL9eL7XIh7WzYJW3jBZF6VGHOoG9Ex1rf8A5jTMUpe0KT7kp9
         2o7NRxrhc78JO5S69cY47Eg1V6bsY7HSo1DLKsx/rQ8XklhVejfqIWvkWIu4rwLpUoqP
         C39MI3Gai/1/Ni+D2Mw7dTku2Cm4i2FI9U4LtFSXSkwlsckOB5cGWlPETx2o8tn3SEYf
         IzreXBsgPCeDzIKlvj8aZDp4t0y9h9sxxcDjCYSwtWbUllY9pWIxqRj3Xg1f80Kn/OMi
         nXF6OumoJAtrdbGLeBmnyl4ms7hjY9EhrlZjKwUHac1zDAUF9O2GTqnPaU21lPhP2wnm
         8k6g==
X-Gm-Message-State: AOAM5335c7UKrngzSWyS02q3ICew0MC7IW5jTMvvYodRXy2/f9cQwmsG
        hpgeaEMfokMxYnoxeQ5FT9XaWBXho7kkHw==
X-Google-Smtp-Source: ABdhPJyKv5HtcVkjQgECZi+ZwlOiOa96Ec+AS01yofO/WrXx2aXH4fKPJt8mdlUA9B36kq6B2dkFgg==
X-Received: by 2002:aa7:95b5:0:b029:1ef:272f:920c with SMTP id a21-20020aa795b50000b02901ef272f920cmr8767965pfk.21.1616151703668;
        Fri, 19 Mar 2021 04:01:43 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:43 -0700 (PDT)
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
Subject: [PATCH v10 08/33] counter: interrupt-cnt: Add const qualifier for functions_list array
Date:   Fri, 19 Mar 2021 20:00:27 +0900
Message-Id: <ae7132b943c51fb5b7a9c9bb247c26bc74c9a8b6.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
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
2.30.2

