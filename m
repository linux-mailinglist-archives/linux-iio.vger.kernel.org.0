Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61B2315FD
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgG1XFu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgG1XFt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 19:05:49 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C278CC0619D8
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t18so17772805ilh.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AM59jIQYU2CvWOeFM3ngOpDG1QHH1+7BTtSJzp1GFow=;
        b=FEh+/FwgUzqP+c5bzHLYHINr+d192UCaIZiMxxT67ECRBXi+JBTwyim6DMlrKBPLdM
         zyC8o+DppB6BHO2L4XRveDASnVzPOsbTxgLMwbhEHigBwLC0H1tvUJ+wNlRxLkBa4Ctw
         SmMveWRwhdCahFGFdsifE4Eqse1/dkEAvyq1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AM59jIQYU2CvWOeFM3ngOpDG1QHH1+7BTtSJzp1GFow=;
        b=rQhug996b0Z3ikxAI650GE65Y5fZNQ4Qm4CT5pHwFypflF2MO6hJf5rA9SxBoXwqtw
         z/iRiCC8PPPvGTdAQopI0PbXhfAeaq8hwUZfbGG9EHuQmE+Ej60JGVufGoOgk9Al24Jn
         nyAjkSy9CvIDhAi0+ugPSI9RJNiZl+mxCP7LgY2DK7ANHjwGBh4tzv5WLaNbtkYxtVRk
         wJvu+tATKd0JJu9yo3jnJLwcf2z+iqbVW5wC4xNLw9kO3G2fyXFOcUD16lTeyvAQAQs2
         pl3JxUD+T976kpBc1YsPFH0m8a+6F4btH97zvLUz8VhRti2lRVep5AlYRAemzTS9a8R4
         H10Q==
X-Gm-Message-State: AOAM532BJOz9MNLHl5j3a1hPha5dnYxSUtrxQwUxAiiBoqL/zA69rr+B
        xL9jLkkMGhEjY1QyBkqhzqap8w==
X-Google-Smtp-Source: ABdhPJxvRCgWq7gqc0hnPFB/W3nKDK5a7ATpFyEVwGjnraxwV/R33ljGYEyoojjknLpWN3J8FIqn9w==
X-Received: by 2002:a92:89c9:: with SMTP id w70mr23431764ilk.250.1595977547204;
        Tue, 28 Jul 2020 16:05:47 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:46 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 13/14] iio: sx9310: Drop channel_users[]
Date:   Tue, 28 Jul 2020 17:05:19 -0600
Message-Id: <20200728170317.v2.13.Ia5c5fdbdfff576ab5d034cde46c25cc66a4baf50@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

This struct member isn't used. Drop it.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Campello <campello@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v2: None

 drivers/iio/proximity/sx9310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index b15ace422862ff..6607732edd034a 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -132,7 +132,6 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned long chan_read;
 	unsigned long chan_event;
-	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
 
-- 
2.28.0.163.g6104cc2f0b6-goog

