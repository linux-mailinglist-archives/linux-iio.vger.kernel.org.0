Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE81DAC2F
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgETHcA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETHcA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:32:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC90C061A0E;
        Wed, 20 May 2020 00:31:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m11so2651394qka.4;
        Wed, 20 May 2020 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iRfEPrYZ1xtYGkhU1NkXMfy3ReHbbp0NPMUXh7YcI8Y=;
        b=tqqqdgqAgXUZ8EmtroT3Yt7zsjmAJHxh+ub58M+OQL5p6YNwZpfDxx6PsfakqLwWfd
         rFHJqXE+ruuiBDk1ZwmM4SlVbJ5fUsPw0awd7rb0qB7PI/RHHy1VUsqyEiYNK4yMhStP
         qDsLb2ufzLl8hUoYsfc1Lln2T5Ju5+3DdAkJjMxt+El2lsvMVdfHKPcTcwluXJkfUksz
         x8Li4KVYaWHNdH4yim6EQm0LOVMVfi9JC5E8eyq9H9EpQ/tXMxoEJX/qlyOZic75/cEh
         LpdrvPKYH0Bnjp99k0DLBp46ilBRbPUNH6q8snhM+s++WRnWioIEH759JjYMyW3v/BKD
         w8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iRfEPrYZ1xtYGkhU1NkXMfy3ReHbbp0NPMUXh7YcI8Y=;
        b=NI7Q/wf17SjGcFcviduEBPZyXunWK9TKTphphE6R5tcp36WXPTRD0wFszowh4mg8Kx
         Cv41eFYNvM+hVMTIVsZGYaWP8TH10Z2JqaqozR7wFeiKCJQfHLEEwrW4lNJYi4N2ICGm
         nvoSYw8a2yBWRPWjXyx/Pgs7gbKHyHtVUGTCmL16KwYswYQdYup8qE3kZcs4swQz6Tlo
         6EcPYneT6RXCJod83WR7DIi1zQjAeof7krc9ifDeFt9X02cA8VvHweSEgb+rjeke0ife
         UVZM8z4LMgjW3y5aW6QGqz71CIZS3AMippzVzTgNhUVFxodX8fT+P7Vk7C2RaqrdBIAz
         FWbg==
X-Gm-Message-State: AOAM530cm3gmj9ZlbE66HmzT/bILRLOuzcT4b2ocQW3HzqGeHb/SaLzv
        2+7bPR5lCHd1EngYNy7eVUCSFkK8v/gaIg==
X-Google-Smtp-Source: ABdhPJwN+QhzLieNYik7JjnCgm1CC3oj2eBS936pW1H5qbjqJ46767HRcQCuRtpkAbukrCi2EzGy8A==
X-Received: by 2002:a37:8c45:: with SMTP id o66mr3288674qkd.392.1589959917527;
        Wed, 20 May 2020 00:31:57 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w9sm1702540qtn.29.2020.05.20.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 00:31:57 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Allison Randal <allison@lohutok.net>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: iio: magnetometer: ak8975: add gpio reset support
Date:   Wed, 20 May 2020 09:31:14 +0200
Message-Id: <20200520073125.30808-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
References: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
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
index 9d5b1e6908d1..d83f7e212658 100644
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

