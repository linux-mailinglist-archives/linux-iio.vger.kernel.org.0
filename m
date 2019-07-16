Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9CD6B077
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbfGPUd1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 16:33:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41843 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPUd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2019 16:33:27 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so37964733ioj.8;
        Tue, 16 Jul 2019 13:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJc1PcJm9Tt09i+2U5/xWRkjZFmGO/Wn7hMK25ujlGw=;
        b=EDcEfboTO/4q81ES400SGr8JMyFcPCBa153/+y6Q9dy9FKrrIkzuppMSMvlzr5cJDc
         Y2E51UVngVr3nk7dFi96rn/orN+6jBun1OKr+jBtrHI5pAhr8tSYweOg/ayHy/gPmlCe
         sDhJLLmBjOeZ/svkEc7aCSL9IGj/+jnUd7yjFcOzD/26rhwObY/9p/Wds0e5UnkL92hs
         lv8kd0yJ2IYjSvb1R2p/4RsFcp4vS6jLxTUNAtoXKSE64Ps63yA8hRqypvNljGsv6/J0
         oT2vdDSj62MycNabZ91Lp88kEcIVQroPGwXBKyTP7LoVlLY7EsnzuVC31xMKona5a50P
         h26g==
X-Gm-Message-State: APjAAAVvd5p6wLA4QtN6+2izR9fqkLrfUu/n4rcI56pDeQiirRkB7Vdf
        C4lu8UvnTyVGCQ1rM5ZquQpkFVk=
X-Google-Smtp-Source: APXvYqzGKqRg3xuVUiB/PIvC9kmukt3EEX04P6L+1ohND3H//O6fPFUDf9l5Je8IwSruzJXGGRKs9Q==
X-Received: by 2002:a6b:7602:: with SMTP id g2mr21037284iom.82.1563309206203;
        Tue, 16 Jul 2019 13:33:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id k2sm16605168iom.50.2019.07.16.13.33.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 13:33:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: avia-hx711: Fix avdd-supply typo in example
Date:   Tue, 16 Jul 2019 14:33:23 -0600
Message-Id: <20190716203324.12198-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that examples are validated against the DT schema, a typo in
avia-hx711 example generates a warning:

Documentation/devicetree/bindings/iio/adc/avia-hx711.example.dt.yaml: weight: 'avdd-supply' is a required property

Fix the typo.

Fixes: 5150ec3fe125 ("avia-hx711.yaml: transform DT binding to YAML")
Cc: Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Jonathan,

I have some other fixes I'm sending to Linus and can take these 2 if 
that's easier.

Rob

 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 8a4100ceeaf2..d76ece97c76c 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -61,6 +61,6 @@ examples:
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
-        avdd-suppy = <&avdd>;
+        avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
-- 
2.20.1

