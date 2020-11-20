Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36E2BA38F
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 08:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgKTHip (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 02:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKTHip (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 02:38:45 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B1C0617A7
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2020 23:38:45 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bj5so3620584plb.4
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2020 23:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPHueWPsAzZX4KIbpi2s6NnCrn6gqE31TO7Qw8ZTpxA=;
        b=FOCqRMWV/Bcq2gUH3zBrLdf1fWn70LdOMd/c3/Ql46jWp6iKXzzUrCkXVmoDsrHO0y
         WilWcVIUP4BIQrKbjta2j2kpPZufPo8rfrEXlTJ2Uu8rBRUsMvY6t3BLYb5pfI75lAck
         t8/jCeBgTFSWmMS7S+27UeM9MLxYv12Z1g984=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPHueWPsAzZX4KIbpi2s6NnCrn6gqE31TO7Qw8ZTpxA=;
        b=g90aQUzjtz3TEldwwucxMK1OV1/7MAqRMYIm7SFiNzEqa0vmdqqu3Ow++6Vy2BfpWh
         jSQX8/v8kxO3TkvF0plbZDjHPpV8yZF2MODBwMUwQ4pl2CHQZmpbHsHhKT2scFXbGr23
         ED7quyIczse/sSN7fqJBYFlsmz98UgTujnII7P4sYWvIioTyo2Jp/INGynDewyXX85ko
         LfBJUGXMK6c97JhLLRtPDvuMhQAthtn6eWZeT3uRb2qRcBmkbqNsKpHMtguY1DuX3otT
         Y1uz9ulo8d2HUkNNhT8NzVnfdeaYP2kfYrIlHJ7D+6tdoTkK28lxX/bhnMCQNAwurtXM
         eNQQ==
X-Gm-Message-State: AOAM532M2UPY6Tfddif6RLjsB4dd0CypSz/Su3eUyPSq7hi6JJFQhPMN
        U7f1md3LxTVr98RF9VQoqK/IbA==
X-Google-Smtp-Source: ABdhPJwKINDMQKOdcjkPXg2iJjG8fKHb/zDVo/Wq0wmZWYnnZeuyXVNZYS1HqeVul8qCUnbH2q1Org==
X-Received: by 2002:a17:902:74c2:b029:d7:cce5:1813 with SMTP id f2-20020a17090274c2b02900d7cce51813mr12506702plt.50.1605857924548;
        Thu, 19 Nov 2020 23:38:44 -0800 (PST)
Received: from smtp.gmail.com ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id o9sm1742633pjr.2.2020.11.19.23.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 23:38:43 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
Date:   Thu, 19 Nov 2020 23:38:42 -0800
Message-Id: <20201120073842.3232458-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This DT property can be 0, 16, and then 64, but not 32. The math here
doesn't recognize this slight bump in the power of 2 numbers and
translates a DT property of 64 into the register value '3' when it
really should be '2'. Fix it by subtracting one more if the number being
translated is larger than 16.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This fixes commit 5b19ca2c78a0 ("iio: sx9310: Set various settings from
DT") in the togreg branch.

 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a2f820997afc..5d8387ed9301 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1305,7 +1305,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		if (ret)
 			break;
 
-		pos = min(max(ilog2(pos), 3), 10) - 3;
+		pos = min(max(ilog2(pos), 3), 11) - (pos > 16 ? 4 : 3);
 		reg_def->def &= ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
 					   pos);

base-commit: 5b19ca2c78a0838976064c0347e46a2c859b541d
-- 
https://chromeos.dev

