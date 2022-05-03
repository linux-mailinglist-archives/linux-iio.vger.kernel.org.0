Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB53518710
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 16:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiECOsf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiECOsc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 10:48:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF83339166;
        Tue,  3 May 2022 07:44:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 217381F44133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651589098;
        bh=UNeNPgpw1R6Fw0IfN3Kfn3Etg70pun757On7XIN528E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcpg1rk0zkxHc4rAvmUykbgwByfzuZShfN2aykJ2Ap+3ifGbwDlPW5fex+5m/hMGS
         XU7OX3SJAt73mliZph8jEa9V1f9XLrPcCW7MvOTeZ+WcRBERqCcTfTiYh6ljywmO1T
         NamTLqauTc34ID60g5IEVHZRE3T8FdWDN9gjLTSHdmnE2bOIad+2l/hidqIKQTfOs6
         C2feR8p/CGApgR7Al9OKsr0WIl02P+ko6E4ula1GO+i3ZwIg/vDH8O2csWxhtPa1Xm
         FvJnd9Zw5y+Yo6A6woksV0J6+fscGe/iUINiQcTeLvwqzJu693ZjEQE+62QnuOdn6s
         Vrjvc0z4dthhw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krzk@kernel.org, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as deprecated vendor prefix
Date:   Tue,  3 May 2022 20:13:52 +0530
Message-Id: <20220503144354.75438-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220503144354.75438-1-shreeya.patel@collabora.com>
References: <20220503144354.75438-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

'liteon' is the correct vendor prefix for devices released by
LITE-ON Technology Corp. But one of the released device which uses
ltr216a light sensor exposes the vendor prefix name as 'ltr' through
ACPI.

Hence, add 'ltr' as a deprecated vendor prefix which would suppress the
following warning in case the compatible string used in ltrf216a driver
is "ltr,ltrf216a"

WARNING: DT compatible string vendor "ltr" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
364: FILE: drivers/iio/light/ltrf216a.c:313:
+    { .compatible = "ltr,ltrf216a" },

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2
  - Add vendor prefix name as per the alphabetical order.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..02f94fba03b6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -716,6 +716,9 @@ patternProperties:
     description: Loongson Technology Corporation Limited
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
+  "^ltr,.*":
+    description: LITE-ON Technology Corp.
+    deprecated: true
   "^lwn,.*":
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
-- 
2.30.2

