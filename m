Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC13A0917
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhFIBeX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbhFIBeX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:34:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8AAC061574;
        Tue,  8 Jun 2021 18:32:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x10so11682864plg.3;
        Tue, 08 Jun 2021 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzSSFM9eA7D/nASKgieKIKXoM9U+od0SIxRVo0RKwbs=;
        b=T37gis28MP075rqTyRhAlrTWtsa3kDZQh1r47qcKH0NNEVSompkKpN5d7z8GDHGHqz
         VlzszmEKm7FtBv5XEJH6XDp+8+BIkZl9JCTA/fGHu1WoypHkO74bmkZTclWCEZBtW9yZ
         RTN3tIBQXoILSRugZw5mxdymx8R0xy0U4naAciR4tfkPoTv3MC07yhkHoM9ISpDKs1Zj
         b79JYllFGL0YAt8EiQHH8IrZSiVflGpAvEUehWNlEgSu8pP0tkSDXz5LGr5kHL9L3cqf
         j9195/L44+nURGJQoYjms3Rp9Uiqd1IVCETmsf/WEUSFnzOYR5HQOXmnHvoexyiSpXPF
         QHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzSSFM9eA7D/nASKgieKIKXoM9U+od0SIxRVo0RKwbs=;
        b=EhWSj0lSPLPmbRNOrQPPuSXYZtiua3u/mLs9E0Go/4xJYVVhRg0BPOFOZAq6F90wYx
         gNeitqloMx7hcqFwvWgFF0gRofZhxjy8gyvpWjPF9eenHdq1PNLCcuamJRwNKk6wnITF
         h9Pt8mBO0/xck6JXzwuG7hQyusPY7hBU6HgytTl9SZuP4mqR8c9/mv0Q9oP96bGEJ835
         HHdBmTWr/Vn/qp0fhBFf5rN8iRIgrOPbCKM4v3YY8dG5MRhE0D40HMHUngRRYgvZdWWG
         20thKhhwGuBtdAwqzsAjCz4KUYdpITdF7l42Jx2e4DiBZhM9MGhXRPPAxLkANjh+FBqe
         rBRQ==
X-Gm-Message-State: AOAM5325bhlCl90JQNnerHJ/mwT4YaseIVngH7rYSodHXNHuEHCvGRnf
        M/djmCX3bI+DtGhyZkWGN7g=
X-Google-Smtp-Source: ABdhPJzHx8m37RAm6th5rtYK4N+44f3lBAKH9sGXux1cR9nBP9hDBHSt90KBliON8+mHPJtsukB/tw==
X-Received: by 2002:a17:90a:e541:: with SMTP id ei1mr28850129pjb.189.1623202339993;
        Tue, 08 Jun 2021 18:32:19 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:19 -0700 (PDT)
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
Subject: [PATCH v11 06/33] counter: 104-quad-8: Add const qualifiers for quad8_preset_register_set
Date:   Wed,  9 Jun 2021 10:31:09 +0900
Message-Id: <050f1b518eeae8e3683f7d6d11f3219a137adf48.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add some safety by qualifying the quad8_preset_register_set() function
parameters as const.

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
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
2.32.0

