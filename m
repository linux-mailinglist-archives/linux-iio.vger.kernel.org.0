Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC464E54C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Dec 2022 01:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLPAlG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Dec 2022 19:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPAlG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Dec 2022 19:41:06 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB0E0D7;
        Thu, 15 Dec 2022 16:41:05 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:4b69:2d37:349b:46fa:7114])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D1E78852CE;
        Fri, 16 Dec 2022 01:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671151263;
        bh=kz4UnBbbdxDg/oqdHfRYzsAl2AeBOhZ+GBnT+WGsSIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kQrvIoDd3JH4pmAviSTgEmydJ1u5pBgGCUJpp/CGRBZXwMeIUqBul9Z67uA4d7LHE
         mUHKwv/nGUJ+oaUPWVxRHGNY5JgiuahpFh7AIoJ7wMiAJpr8ZOmnD9GmgR7UqgsaO8
         lv/U5YTDWXI0wN3JKBSNrQp1WTlOApEO7fS2DSl1XddvF+kHE+MMfzH5uKovLJ2F5P
         FyjnT0bO6PtHiHXX4oYAGFySWcgihd72+nT1Aqdktu8AtYufrHEUFVluDk1B0oNlp3
         2ww1/uyKBwfgt5llXEjEyOVQWWD3lwXYZQiRo6BSGOIgpoJK9X5WD0FuRe3yZNf4eX
         NXLtRLDHs7yIg==
From:   Fabio Estevam <festevam@denx.de>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: iio: adc: max1238: Fix a typo in the description
Date:   Thu, 15 Dec 2022 21:40:15 -0300
Message-Id: <20221216004015.2902966-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix a typo in the description, where "interface" is spelled incorrectly.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
index 50bcd72ac9d6..60d7b34e3286 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Jonathan Cameron <jic23@kernel.org>
 
 description: |
-  Family of simple ADCs with i2c inteface and internal references.
+  Family of simple ADCs with i2c interface and internal references.
 
 properties:
   compatible:
-- 
2.25.1

