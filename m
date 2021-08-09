Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1F3E45B3
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhHIMiT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbhHIMiT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 08:38:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C1C061798;
        Mon,  9 Aug 2021 05:37:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q2so16145880plr.11;
        Mon, 09 Aug 2021 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YrGQgqGpCuLsyKe+6eE+fTLPLd7PVMeC09xlnHEioFk=;
        b=Xmey9OnLsaawQFO6oRlKijU6vHYzB7c8gUdFesgvdaWIYUX9uj5yJ67tDqyPyFRNgF
         T3MVHTCTv61gfgpm1BNqPzsJukMpgnsmEfLoj/H5TRf70XkixrZ+ARIbsSLDQ8oNXX1N
         gpFoJxNfAeyAZc8MMos0ctvVIxlb82cXXFyHNNE5ZbAnBT8CSUatPpgADrMT+Uf2HVh0
         Rd1YqF+HRaANnZj3G69EecTyGjldJuAiZAodjVo5dzNo6l1XTAMoHGRhmhkdCp4ipwP+
         gxNtbv5f41OC8GHUuyZAxXg+iHk5dpqp1+N0YUw06ASaIY9Vy2bbEkwCY7MD7ap3qYTX
         Sv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YrGQgqGpCuLsyKe+6eE+fTLPLd7PVMeC09xlnHEioFk=;
        b=ZkYtK89HnUQu5sj9/ZIko4Aai75pfnaPibqjXhMIn8fWaTH+HpQPfVBeQQL8phPyCo
         qFxWPqYcJCMGy9qxRYlO8UOgqPgX5ksCngE+fG0vkNi+OGMQFUcD0Uowa6W0aNraj7di
         drGFBilgptPOI1zoBNa+DhsQBBbm/piLu6iSHrvjFXUG039941eoH7qQnRolmqVtzqFg
         TswKQvzY+jQ9xASVxWOUGVsdJSiiahZmFnMGTdqH+EF1CGktQxmLwmhak6mleiZkqYNZ
         ryIWEck3YDyir8khzDgYAFulLzGWIt7z/3dn3wZ9Ea/T2aTxBAi63htOUORNGq9/UcBq
         XHvQ==
X-Gm-Message-State: AOAM5301Er+/w7g35Work6ti1ixbPbqLmfIohvV35nPvcQVvm/IZ+GT+
        hDwh1AQAfy1t56/kj6yFTQ0=
X-Google-Smtp-Source: ABdhPJzWMdAAZP8xzP65xPj/pNIi/2biRgjteeQJJxGxRH7GHQ24mLzrW3SYde869EcAs3pBecHuNQ==
X-Received: by 2002:a17:903:31d5:b029:129:18a9:6267 with SMTP id v21-20020a17090331d5b029012918a96267mr7661761ple.43.1628512678282;
        Mon, 09 Aug 2021 05:37:58 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id e35sm22382177pjk.28.2021.08.09.05.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:37:57 -0700 (PDT)
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
Subject: [PATCH v15 01/13] counter: 104-quad-8: Describe member 'lock' in 'quad8'
Date:   Mon,  9 Aug 2021 21:37:26 +0900
Message-Id: <43b4acab9e238638c7067dd4a363a42f94c94ccb.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds a kernel-doc comment line describing the 'lock' member of the
'quad8' structure.

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 5283ff128c17..0caa60537b14 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -28,6 +28,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
 /**
  * struct quad8 - device private data structure
+ * @lock:		lock to prevent clobbering device states during R/W ops
  * @counter:		instance of the counter_device
  * @fck_prescaler:	array of filter clock prescaler configurations
  * @preset:		array of preset values
-- 
2.32.0

