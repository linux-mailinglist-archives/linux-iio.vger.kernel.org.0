Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1D18481A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 14:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCMN3j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 09:29:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40240 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgCMN3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2020 09:29:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id z12so1106946wmf.5;
        Fri, 13 Mar 2020 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUHN0X5sdrI7D0GMcD6M5Z+3axinNY1E4lzMr1PVACQ=;
        b=G1C54Bdb16WNvSIBd1FwsBhkuDdryGinNrlo8xqYr7AGyLpVtPTtNffGmu5s3IB1Mp
         xPh5AwgNANFWWIG72b7V7Q8EQgEB9VLMRISdv4vZHRWhZla3ClqFfoJB6UlQ2WpPA/BD
         OSGWBT/MADHWNNtv66MqlucLcqi1PbRJHsfO2TnpszE9t/MoZP+37qFzFxWhom/MGeEC
         FlnYVdCPZLOFgzc6ljTbHMEedF05VuLmxcr8K8fepYkadg+ib18o9CCL9sPIralJOiza
         uD7T3VTPWw+8BnKdm/X/KCsfRSwXLQ8vjweE8oTwFpLrpkrdTBm7HSaslkksP/4gjo8N
         3jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GUHN0X5sdrI7D0GMcD6M5Z+3axinNY1E4lzMr1PVACQ=;
        b=pCWu9YfHh/aLQXqdvzAXS4gkRo1BAVt0+GP/DC6XR3qAf8LYd0vGUXSWvWD2ZfMA6X
         ctJRjEVZmCJkUgQfAzt9LQijBPX6SVR+L2l686pqkuuI9idphoTNTxCfAfrHkEMIF5mv
         97J6B64dgGdVQEduuTD+zqM1bcmrLF3J4jiDbjA5jfDsIbV2eqMrO1MwKdLd5Vg0Bo5g
         Jet9GuxGlOOdFb4RU2DcrjrAOQSb76l75oNh0noK27ORVXHpBy1uQ03HnbX0KXlwvbii
         aBzBJ+8K9MPVXPt1ZixQrdwge4HCCtvo3GTt+FhsGnEOM1E1pBJ8bFf+b4EIzHttJpWz
         /6gw==
X-Gm-Message-State: ANhLgQ161T6zD+fsuR8IZu9OYyInjRACTILwLgxQvH8yKd0z7050XAwd
        J6i423WNAeikZwfMxtYAzSY=
X-Google-Smtp-Source: ADFU+vsqxMJxy9G94+rLdzbFa6PMVw0t6uXOSQDXS2UJ1O6jpUhOXYstXxO0/H6x2XH1SMXnO4Mwyw==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr11203124wmf.71.1584106175901;
        Fri, 13 Mar 2020 06:29:35 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z19sm17576705wma.41.2020.03.13.06.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 06:29:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] dt-bindings: iio: adc: rockchip-saradc: add description for px30
Date:   Fri, 13 Mar 2020 14:29:26 +0100
Message-Id: <20200313132926.10543-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200313132926.10543-1-jbx6244@gmail.com>
References: <20200313132926.10543-1-jbx6244@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The description below is already in use for px30.dtsi,
but was somehow never added to a document, so add
"rockchip,px30-saradc", "rockchip,rk3399-saradc"
for saradc nodes on a px30 platform to rockchip-saradc.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index d3b78604b..5f398d882 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -17,6 +17,7 @@ properties:
       - const: rockchip,rk3399-saradc
       - items:
           - enum:
+            - rockchip,px30-saradc
             - rockchip,rk3308-saradc
             - rockchip,rk3328-saradc
             - rockchip,rv1108-saradc
-- 
2.11.0

