Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7FB1E30E2
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391677AbgEZVCz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391593AbgEZVCy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:02:54 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD6C03E96D;
        Tue, 26 May 2020 14:02:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r125so13126459lff.13;
        Tue, 26 May 2020 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1e/8ZoNcbwUPL60Diy7Ut8NIpn3SdcrkymcAJ6goHE4=;
        b=VTJ3C7fQ6SNVyTPjbx6AGR6tlscqMzVI5KkkXZuUZl787seabx3tVt3UCGiTcfYqdZ
         oppuO0ogqkvt6/P0HKSLaIiUWnycDv9x4d5P/i5GnCm9rEZ2U2g89nnh/MmJaS2zqbhz
         pUS0z8FGFzQe9vF7dtDb9psNkOwKeEgLss4aBmgHG8XfBEAbaBv3suW3tzHizYVSL1CW
         Atj4bTG/z9+sjxOT/k7H6KDG9mEC6Q0oUFm28tpn1oqS4m5q4apW1YenPllYgXk4t8Ca
         UKAsRHQ71WwgXaOgGGTe7sXh1tVSLlXVmZQhbzwxY4Bs4GoSzr4vQFTl2bcBPAVoK+jN
         lSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1e/8ZoNcbwUPL60Diy7Ut8NIpn3SdcrkymcAJ6goHE4=;
        b=U0V8y0O1GN5eD5uq4Hh6kVxTvGH3T9D0cxnrVjI4lj8o0YDRdYtZQGYe47qwOV2bZr
         D/MfYnXkocrMmpfsarEVnwSjr4Z5JA8gnRWnmnSkK4muwpO6FEDw2TiPpL1g/OwM3B8w
         RkFXOEXVEtgkvxPbUzh80uaIPBB1oxA5rmdrrSCkSRP9M1h8uNO8TOtW9cvS8koVp0a5
         SUzaAzaGG1u8WArsIUyjFQcwZDAcQwzSHLR+EJ3NH7FC2gW3qhAK6bRgSvpgsA9Lw59M
         P0r5KljowW4uPK533kSlxv0jdL4euu2c2B5xKIQ4/ykrnBvIy675M9ddZlixHqvO/aSe
         0A2Q==
X-Gm-Message-State: AOAM530NJReNSbIgoQByJy/0Vz7I8K8WPRKUU6Uat6WT2JtzNf1oL7Ga
        Tl0AWDoQer7OOathikHP5i8=
X-Google-Smtp-Source: ABdhPJxOQ774qMT0880D1ET4/aT+zlBKentBtauxEZqzRM5sQnkNtuWpBrr7qB2rJjRWVNa2ypSdaw==
X-Received: by 2002:a19:c114:: with SMTP id r20mr1387456lff.210.1590526972276;
        Tue, 26 May 2020 14:02:52 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id z133sm240443lfa.41.2020.05.26.14.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:51 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 5/6] iio: light: stk3310: Constify regmap_config
Date:   Tue, 26 May 2020 23:02:22 +0200
Message-Id: <20200526210223.1672-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

stk3310_regmap_config is not modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  16027    5424     128   21579    544b drivers/iio/light/stk3310.o

After:
   text    data     bss     dec     hex filename
  16347    5104     128   21579    544b drivers/iio/light/stk3310.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/light/stk3310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 185c24a75ae6..9d1e503bc958 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -487,7 +487,7 @@ static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config stk3310_regmap_config = {
+static const struct regmap_config stk3310_regmap_config = {
 	.name = STK3310_REGMAP_NAME,
 	.reg_bits = 8,
 	.val_bits = 8,
-- 
2.26.2

