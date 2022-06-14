Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786D54AF3F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 13:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiFNLVW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 07:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiFNLVV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 07:21:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB624BDD
        for <linux-iio@vger.kernel.org>; Tue, 14 Jun 2022 04:21:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x62so11128639ede.10
        for <linux-iio@vger.kernel.org>; Tue, 14 Jun 2022 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NQwnkhAN7Cg4g5w7mvM4Ci1RXtQxsQy+sdI93SNNjs=;
        b=dc45YxVoR4oQKmCwTltJ9m7qQc8SNNDv5pKGkg18kxUQC7Y6x5HXcqboO3DhENrnwE
         4OTDcMyJGarBed20ejt+cv+WSbxUU4vTmILALlN+uIMInmj/BAZC8222OHqJ9rSbJesb
         EFVc6+929kc9EIV0mdM1fWjHRI17F686RN27aysfLF9eyI7cPbfuiXikcTfvk4r2vcLx
         tVTLfLvTiDkccueG/zm8RAJ4s34lNFYhnU3qTvEuMmDGDdvX02NLxjCMGKZg1UcgZulS
         /TrATixDwemhXtNgohlR01/zb8XSIvDeNzBYcpf7UtdHYHZ2StAYu0x93SFDZkrXGhIz
         2eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NQwnkhAN7Cg4g5w7mvM4Ci1RXtQxsQy+sdI93SNNjs=;
        b=Prwnv02pcOjue/Zh+2OLyJuWYfz01sdCLuksaIy7LVjMDBVE8D1SUdHZXobub93v4x
         n4mrUA934myZfaGBeCzXfpJuUymW05GeUKTU4jUHyuB0Qd+zZ4BweST3TAkGMOLw0/7B
         eFU1/Kn/C/1ZS6VjP7D/GgdV5/70MQ/yyt6dEmES4uO0KJAqEcpNE8LJcTpbOTU5KyZF
         QMpDdmefI4Owz3LZE9bjT82XQN7aua0wWPEoVh2WpPQQtTh2PuPqDybx2Pic3Q4ZtOFP
         bTAcIszxaLQz/zOMNoby5yf6OFHlzhlDr2dXUwt99lulLCQMmcQobg2T0dHgZ9IDGe+y
         etNw==
X-Gm-Message-State: AJIora+cv+YZN2F1KPhATJkxmDLlxI2DzD1DA8fKQLUb0ZghcDljUNrN
        JRNNAKk9ugbmBBcyhmtEe94at6Y++d6zIQ==
X-Google-Smtp-Source: ABdhPJy336wbk+SBxaM4ycmxvmA6fFTw+x7ClCI7aTudJZOQKX8wuVPQpr4idZt2tMg3Lk00BAS6Ww==
X-Received: by 2002:a05:6402:f14:b0:42d:f989:4a21 with SMTP id i20-20020a0564020f1400b0042df9894a21mr5447518eda.168.1655205677875;
        Tue, 14 Jun 2022 04:21:17 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id vp5-20020a17090712c500b006f3ef214ddesm4919424ejb.68.2022.06.14.04.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:21:17 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-iio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] proximity: vl53l0x: Make VDD regulator actually optional
Date:   Tue, 14 Jun 2022 13:20:50 +0200
Message-Id: <20220614112049.302278-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Contrary to what the naming might suggest, devm_regulator_get_optional
returns -ENODEV in case the regulator is not found which will trigger
probe error in this driver.

Use devm_regulator_get instead which will return a dummy regulator that
we can just use as if it was a proper regulator.

Fixes: d3d6dba56dab ("proximity: vl53l0x: Handle the VDD regulator")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
@Jonathan: As discussed in the other email, maybe you want to
adjust/remove the "Fixes:" tag. Your call.

 drivers/iio/proximity/vl53l0x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 3b7a33ff601d..c7c4d33d340f 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -237,7 +237,7 @@ static int vl53l0x_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EOPNOTSUPP;
 
-	data->vdd_supply = devm_regulator_get_optional(&client->dev, "vdd");
+	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->vdd_supply))
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
 				     "Unable to get VDD regulator\n");
-- 
2.36.1

