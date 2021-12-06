Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1EA469990
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 15:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbhLFO6A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 09:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344755AbhLFO57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 09:57:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08BC0613F8;
        Mon,  6 Dec 2021 06:54:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so10660964wme.0;
        Mon, 06 Dec 2021 06:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hroQBssVxccXajSIae+vPPzUFUCBfFmeKRgOcB2d4Jg=;
        b=laMQzgB9Kc7SGSnTUCCGTKOhZsn2+fU4lLtJWBUTXBJTfe4kNE4bzeP5J//rVa/OL2
         a84DsGfDpn41aP2kQLXahj7MBW4GA5I7M+YxPpxfVuZNv6m2pJHVbMSmrWhU0+0E+s3E
         +pfKfG5XOxHKt7uhfgkGdqAuWfheNsNdizAlhCkQcYFGRUy5V8QONplcUuttldY7DOMy
         vZLlf443NJyd6xS/4qx7HICV/aXlhY5LNimJfvkD38nGS8tvCth6IExYGUFo8Ji0qaIv
         2c72jw66U8IN0OdZauDmqbxY8KQlC6CpzR1s5USZwvcGW+sogZ4izNEi52+PNAhYn6ot
         +BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hroQBssVxccXajSIae+vPPzUFUCBfFmeKRgOcB2d4Jg=;
        b=uDQ+jNzVvSVIX1WnrjM+mtWHIS769ShgGnud55UM2UdhVCJY4bodEbCiYCXZCkTd3I
         6bXnpBhQaYrzNqoBP0aEOEB3zSasYWezJlKtoXysfc8LN7UKHZcq0U1q/hSlIYYCnnXD
         pE1ektT0Bch64QFM6xicx4nCeXfU8XH3oW1ghNSacaJccD44ZYHXo1adV2vEy2/DvJWK
         e3TeOLWA6ourQh775U0AjbOCTakomYIuCo8e+U++0oTm5TojYBkSRWX8MFl5ojifBnCJ
         1AIcRumKaZHyPXPcyrhVfvheTrR79pFFc0PqfIQk21DN+1v+8Dxt8nV3QFhb3ZCRFFHA
         TEjA==
X-Gm-Message-State: AOAM530s/pnmEqYRqJIGHNGjKH/KxCpbtRgrYDmBxznAAu5w6s5oFdkR
        HcaXGleIDXyRgpnDw83cX4oWoGD3vjo=
X-Google-Smtp-Source: ABdhPJwZE6cTUOHICfFzcEVWtMASsJaXM3HxaMiAyaWZhGFpqA1EIUcGmP+pJr3aOVZ93eKwXxqkSg==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr38803253wmi.107.1638802469123;
        Mon, 06 Dec 2021 06:54:29 -0800 (PST)
Received: from localhost (pd9e51d39.dip0.t-ipconnect.de. [217.229.29.57])
        by smtp.gmail.com with ESMTPSA id z14sm11783269wrp.70.2021.12.06.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:54:28 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: exynos-adc: Use correct node name
Date:   Mon,  6 Dec 2021 15:54:27 +0100
Message-Id: <20211206145427.218436-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

According to the murata,ncp15wb473 DT bindings, the node name should be
"thermistor", so use that in order to make the example validate.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index c65921e66dc1..81c87295912c 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -136,7 +136,7 @@ examples:
         samsung,syscon-phandle = <&pmu_system_controller>;
 
         /* NTC thermistor is a hwmon device */
-        ncp15wb473 {
+        thermistor {
             compatible = "murata,ncp15wb473";
             pullup-uv = <1800000>;
             pullup-ohm = <47000>;
-- 
2.33.1

