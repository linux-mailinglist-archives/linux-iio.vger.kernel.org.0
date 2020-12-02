Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36C22CC765
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 21:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgLBUDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 15:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgLBUDl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 15:03:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9749CC0613D6
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 12:02:55 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n10so1600171pgv.8
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 12:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5If13UxZbzUYPYSGlnG6A95GWw+mvTPbOVGEWE9ood8=;
        b=S/8B7FkJWRKEvk0a7GH8tIaFCBMw11QXU83Q70IW+qUkcvgGZhrhnA/wiiJx9GGIWC
         xa7kipkkMT0V//SYHvnMYiHkIZwX4iY27bmTtkXYOCR+7YRsOgeiEFOhTv7RrDlkQoJQ
         DOtmhdccPHT7JYr5Jdt/lJx+iW9h9s4vTY/vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5If13UxZbzUYPYSGlnG6A95GWw+mvTPbOVGEWE9ood8=;
        b=TG7jS7r6NE+Sohknzigc/OY7bbSVpTIzXrVblH2mHWfdo8+i0XC1NJCq0Hs2tfwg1M
         7QOq1pR3pc466lwuXSwduHzeGOz3ZCGrBAtx5hXXGwPQbsr9XYypXrT4Xa0ut8PulZHN
         8qTppqZffICmlxXOPTjXhwlvotOU+/uxlviOEsqFrfoWZaeAvY0l9szOkl5Vzr7Y0ayD
         PdTZjD3g8IvPE92+mG6GzCNbDMMmq+8WLD6GFFzG6vN0gw3HOmbaLiyjYZLziYVbBegc
         RFvBcsHndDXqIqhaUbLBXgY5PAT+aDCXJnFgZOMN/VTKK+/SW877u8H2GzgzkV3JLepw
         J6nA==
X-Gm-Message-State: AOAM532GTMpQTkTnV6Eov4PMkofOzoEK/OacIpjw5a+o2yh521/+EWWt
        7kIJJv+nzbZ8UfEg1xDXj6cXzA==
X-Google-Smtp-Source: ABdhPJxgeXdDm3H5w340toK+i1w7gpbZhgH3rIjemTd8uUKoAUMe+wIu04XUiztHHayJ+gJSkakglA==
X-Received: by 2002:a63:6e45:: with SMTP id j66mr1408847pgc.238.1606939375140;
        Wed, 02 Dec 2020 12:02:55 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i4sm483748pgg.67.2020.12.02.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:02:54 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v3] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
Date:   Wed,  2 Dec 2020 12:02:52 -0800
Message-Id: <20201202200252.986230-1-swboyd@chromium.org>
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
translated is larger than 31. Also use clamp() because we're here.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2 (https://lore.kernel.org/r/20201120182944.543428-1-swboyd@chromium.org):                                                                                                         
 * Use clamp()
 * Add comment to clarify

Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):                                                                                                         
 * Changed ternary to consider 17 to 31 as the same as 16   

 drivers/iio/proximity/sx9310.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a2f820997afc..0e6863e4d384 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1305,7 +1305,8 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		if (ret)
 			break;
 
-		pos = min(max(ilog2(pos), 3), 10) - 3;
+		/* Powers of 2, except for a gap between 16 and 64 */
+		pos = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
 		reg_def->def &= ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
 					   pos);

base-commit: 5b19ca2c78a0838976064c0347e46a2c859b541d
-- 
https://chromeos.dev

