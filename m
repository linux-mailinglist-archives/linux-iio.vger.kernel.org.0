Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916B01DB9A1
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgETQfE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQfD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 12:35:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C02BC061A0E;
        Wed, 20 May 2020 09:35:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m11so4206976qka.4;
        Wed, 20 May 2020 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S1oAttt8TnUFaihOIweLqPpM6FRwVMdKF4fFpFm9h18=;
        b=nbICaW3FTaCd2d53IlFyS8JYH5mxwVggyc89/XZnLmVGV5ApXVLsHZndxg7+njMozd
         2UFpBmcdCk0Z1Cmg1DhpDczEEdKUQ0VEVW3AkNci8721/D3rIN5MX6IQ2BPZ0nu3qzCq
         5n9nzOxdBGXKuMWAqCJrZnb/u6p9IJzYJQrugieZjIXgrbbyele7EuXcJaT69o2GLtmr
         mF+e7+RTqvXjcDZ1DYQYMebYkOqqJiJcwRBT0ob8ClE8/sl3xKIrTuwU+HQGFjyUbKGk
         vDRuDEHG4dmXWdtHuzjZRPvf56iJ4Mg6lR5wfUpC4qRuN9VR0V1YBB8vesUcRMuYHpGt
         pGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S1oAttt8TnUFaihOIweLqPpM6FRwVMdKF4fFpFm9h18=;
        b=iOBX8UNYb5TfG8tuapwBXYLMV5ep511N3jww5ns9SPh+ZdlmhIujnUt2YpIj4dZfc3
         ISN0ogFjLkVP7Ta+JcmfhFVUZBNqc2fyvtQobJ6QbvqlAaU5sBAKk10iwvgihKreUOKX
         C64xnzopYQWU//MlnQckLpoWfFhxJd+Hih5eWB7OdLBnSIWsP4IhwdnL2HNAXKkY4EmZ
         PXKotLkuRIVQyNaUfjeb20s/Z4Sl123cKGOIYTPrGryPMTGKPTXltXXcWFGQ0ppBkFKr
         zlD8NkN+NgUIQFzcPcnZdHAWKVymqfFM6DxoKCccEmr1TmKWva/enot6wRTRBkiU+H1k
         1UWA==
X-Gm-Message-State: AOAM5337qctCf6VY6s4Mql2svNshzDnpw6h7W1WJCq93shFyIIuSDMA6
        UF00CYmUDWFrYMadom+7qEKmSANyz4uo2g==
X-Google-Smtp-Source: ABdhPJw62QdmdJ8z3T3wgHaZ5XhWeriNSzrO5nss1SiRU7tosOIB1darE7Lt+KVO+ke+zU2/fNfvVg==
X-Received: by 2002:a37:b847:: with SMTP id i68mr5367141qkf.431.1589992502169;
        Wed, 20 May 2020 09:35:02 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id q59sm2803261qtd.73.2020.05.20.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:35:01 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 2/4] dt-bindings: iio: magnetometer: ak8975: add gpio reset support
Date:   Wed, 20 May 2020 18:34:07 +0200
Message-Id: <20200520163417.27805-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
References: <20200520163417.27805-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add reset-gpio support.

Without reset's deassertion during ak8975_power_on(), driver's probe fails
on ak8975_who_i_am() while checking for device identity for AK09911 chip.

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheet says that, if not used, reset pin should be connected
to VID. This patch emulates this situation.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/magnetometer/ak8975.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
index 8bde423a2ffa..aba9ced7b6da 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
@@ -41,6 +41,11 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix
 
+  reset-gpio:
+    description: |
+      an optional pin needed for AK09911 to set the reset state. This should
+      be usually active low
+
 required:
   - compatible
   - reg
@@ -58,6 +63,7 @@ examples:
             reg = <0x0c>;
             gpios = <&gpj0 7 GPIO_ACTIVE_HIGH>;
             vdd-supply = <&ldo_3v3_gnss>;
+            reset-gpio = <&msmgpio 111 GPIO_ACTIVE_LOW>;
             mount-matrix = "-0.984807753012208",  /* x0 */
                            "0",                   /* y0 */
                            "-0.173648177666930",  /* z0 */
-- 
2.17.1

