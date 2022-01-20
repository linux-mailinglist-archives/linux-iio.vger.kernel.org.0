Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD7494BE6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 11:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376345AbiATKks (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jan 2022 05:40:48 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41646
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242823AbiATKkr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jan 2022 05:40:47 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D6334004C
        for <linux-iio@vger.kernel.org>; Thu, 20 Jan 2022 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642675246;
        bh=CIaWdycdf6EnsUbHUYnMZAiCInJx2eq/X/xjpakBzuQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ktYpBh4Y5os9s/2KcJDsOW7A3oa7fHd61E6P/iQRojOTxe1yrVPa0lEkgVa0Qhqyr
         b/SneIx7zOlmdAOboW9a74dxgwNoWr8tv86o08aniaadmG9xK/N+wYd6qUro0vYZlr
         1jFFqEM0zYR+r9FMJ1U9oxloGq4njNcwrgF9jXKtPzazIUyFRrcJNXknRMMsKS/RTe
         K4Nem1MPF2dt8zUOxbErbO4MZKzm9STfX+whrk3E460SWjzpTO5r9gLjKAnRWlPY0v
         v4SMJBQJeWqWDq7X8ZDegseuKJ2jtJOvHXVTh30SIm6YMvJznghRs6XOCUnlVwp1H5
         67yHX6tPHmeAw==
Received: by mail-ed1-f72.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so5495031edt.15
        for <linux-iio@vger.kernel.org>; Thu, 20 Jan 2022 02:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIaWdycdf6EnsUbHUYnMZAiCInJx2eq/X/xjpakBzuQ=;
        b=VOUl17uXbdXywntqj5LNINoJgcKAH6ZkyE/V2z9Ag0PV4ncYu5LtToXDPI0l4hsPNF
         zID7ol+E+BiPldtxCecT7g0h/ueS1G0TO39Z/N+EE+yE0e7RIn7X/oYm2E0PdO+oXzKT
         7CaK+4B6wr+lQuZMiIMOphJKut0MNy13aMuMWisYQVy/C9a9Sq/mbCz5pGngzPVqmqHx
         fQ9tq0tjTYJYOHqiX/KwI+zPFPIVKfzdzbwm6u518iE3AI2iz97Hi1qObHIJoJzIIN6I
         feHXMlEyKuqBAH5VYRzdtgHf08SYFRoWc3ABq0mVDAWaJdlQLQJQs//dD2cfmz6xA9dZ
         t8MA==
X-Gm-Message-State: AOAM53098byFEzDJWpa3urMfvImbXOnpwVCufntIvFs6sBak4tR6YT7x
        iRX9F7ZT1KgPoGeCx/tw4fLU2HjEkJGVYy2iEn28c6UOOaD9PB/8t8mn2Hsuj5WHgm52eyFkG9e
        nCdRnsceelYLVU44KlqsM75v+rLaQiIKB0YEmUg==
X-Received: by 2002:aa7:cada:: with SMTP id l26mr36252486edt.376.1642675246173;
        Thu, 20 Jan 2022 02:40:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOVdHelYM1YUGXc2eLxbDQYo3SvaFYtGr9v9V5EvnkcgU+gHMzyQwtlgK6qkEsaiz8QyjvsQ==
X-Received: by 2002:aa7:cada:: with SMTP id l26mr36252465edt.376.1642675245973;
        Thu, 20 Jan 2022 02:40:45 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z8sm836027ejc.151.2022.01.20.02.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:40:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Simon Glass <sjg@chromium.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] dt-bindings: display: bridge: drop Enric Balletbo i Serra from maintainers
Date:   Thu, 20 Jan 2022 11:40:08 +0100
Message-Id: <20220120104009.159147-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enric Balletbo i Serra emails bounce:

  <enric.balletbo@collabora.com>: Recipient address rejected: User unknown in  local recipient table

so drop him from the maintainers, similarly to commit 3119c28634dd
("MAINTAINERS: Chrome: Drop Enric Balletbo i Serra").  Add generic DRM
bridge maintainers to Analogix ANX7814.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/display/bridge/analogix,anx7814.yaml  | 4 +++-
 .../bindings/display/bridge/google,cros-ec-anx7688.yaml       | 1 -
 Documentation/devicetree/bindings/display/bridge/ps8640.yaml  | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7814.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7814.yaml
index 8e13f27b28ed..bce96b5b0db0 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7814.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7814.yaml
@@ -7,7 +7,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analogix ANX7814 SlimPort (Full-HD Transmitter)
 
 maintainers:
-  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+  - Andrzej Hajda <andrzej.hajda@intel.com>
+  - Neil Armstrong <narmstrong@baylibre.com>
+  - Robert Foss <robert.foss@linaro.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
index 9f7cc6b757cb..a88a5d8c7ba5 100644
--- a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
@@ -8,7 +8,6 @@ title: ChromeOS EC ANX7688 HDMI to DP Converter through Type-C Port
 
 maintainers:
   - Nicolas Boichat <drinkcat@chromium.org>
-  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
 
 description: |
   ChromeOS EC ANX7688 is a display bridge that converts HDMI 2.0 to
diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
index cdaf7a7a8f88..186e17be51fb 100644
--- a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
@@ -8,7 +8,6 @@ title: MIPI DSI to eDP Video Format Converter Device Tree Bindings
 
 maintainers:
   - Nicolas Boichat <drinkcat@chromium.org>
-  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
 
 description: |
   The PS8640 is a low power MIPI-to-eDP video format converter supporting
-- 
2.32.0

