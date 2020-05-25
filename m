Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652221E1169
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbgEYPN4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390911AbgEYPNz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 11:13:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB4C061A0E;
        Mon, 25 May 2020 08:13:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id er16so8174814qvb.0;
        Mon, 25 May 2020 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=gVXdPXXopF7sZKyfLkpXhnDjmG91BAvZFhit3m4U/Kf7vbUsdS1MaqtyiZCtOFewLu
         cyZ9abfP/ybjZJ6k7Cb7UGVRZqItL6PSgsDZeEL28hpqGQRjMLUpJxFcpUgHm7cgF0iE
         /2An10ke44dWaR9GaEhlwpjDJ3f+m/F0by2BDSq6STQ7kFOK4Y2fEwqjCQI5I0pfpc05
         TluUqb+JnuYRlkzeJAqbR75TwkwUEmnFBOV0SMpcivO2+/PMhhqUpM5n6o7DaGTpQHMT
         CRmFDalKkctWb0f7To5RJyVtdY62m1HS73qfVJfNF+OpZ4EtkcVpzf55TP63RejxRlcR
         RgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOveqjYBk1+7IoXrKWjzzpmC29NQEFV/46uICdldkHU=;
        b=OaVqg4zBwrNAMCBzaNM0XW+7PnTf3L5WFY4nTtM2WSMn9cEBFXyGMzt/FP3Slp0d/e
         PrTt0AnoSIXV0iI/O9kgheQP9eHU7TEEx0/WN0PxD5SNT8l3u3/LPehT1xspG4dALusK
         Pk1MopQRzLC83TDrQXC7oNH77UPkeltQ/iuoErrY+IbHEpK5a+Dj2s702hJziU6lqKeC
         3YIDFVn5o5HlpYAuUAXCqkOnIwm3vApbfkHnUba8KZGv7W0ACfMwWOQzefNz3QICzhcb
         YFIhh/egLqocRDBZXBbjaG28vIprYhdQVXxCfxEm6ibj0fY06nXN4ebC5n+Mv6xBWVA+
         u5Gw==
X-Gm-Message-State: AOAM532gWDJsLh0KS6AXcCZ90tJtBkXVBhAIInZcFRAhFGOm+YAsBM8Z
        Sa+ZIBE1WbE7OnXqORispXKo4GzVUao=
X-Google-Smtp-Source: ABdhPJylKVKkXL0TB1tXR1ODFqz1l+bqEr0JZSlxih5cY7X7YGhNM19C1ZKnPHu9E4iSU2ZTOSYMmQ==
X-Received: by 2002:a05:6214:18e3:: with SMTP id ep3mr15193075qvb.132.1590419634032;
        Mon, 25 May 2020 08:13:54 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m59sm15161709qtd.46.2020.05.25.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:13:53 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v6 4/5] iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
Date:   Mon, 25 May 2020 17:10:38 +0200
Message-Id: <20200525151117.32540-5-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minor comment style edits.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3c881541ae72..fd368455cd7b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -385,9 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
 		return ret;
 	}
 	/*
-	 * According to the datasheet the power supply rise time i 200us
+	 * According to the datasheet the power supply rise time is 200us
 	 * and the minimum wait time before mode setting is 100us, in
-	 * total 300 us. Add some margin and say minimum 500us here.
+	 * total 300us. Add some margin and say minimum 500us here.
 	 */
 	usleep_range(500, 1000);
 	return 0;
-- 
2.17.1

