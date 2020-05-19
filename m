Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2951D9078
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgESG6k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 02:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESG6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 02:58:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F62C061A0C;
        Mon, 18 May 2020 23:58:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so14512244wrc.8;
        Mon, 18 May 2020 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fgREyKjff7N+7JWNDs3uGB4t29VL/TFRo7x/0hYtz3g=;
        b=Lf3/+do0F4iiTpuBw4bTQbfX++RlKxaxpY+GquHmiFE0PzWZrxI1yR+99aM5tpfeH4
         EomvGrPdTv0NFTrznPD3N1ibSacAa6omjZZcYg9v2rjUuFq22v/Lq74nAYGKBq8Ksxqo
         4x5fvv9mPi50Vm3LoFox9qBKTWBsScXeyTlv89n2Z/Xu/Xrwc6qHwzdrovoJjt6Ur6lK
         f9M6gYLRuRqL2j7S7sg5FC0g3oL7Z45TehhZRljhtWzvn8j5a6IUnFk+75r0ugWhYvmL
         xlLUB/UPsUzKGRvjN42KlC3jsVMf/2PMx55of9IQ6vMG/G3vr99u1UVB3azfT1BAwX1y
         YYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fgREyKjff7N+7JWNDs3uGB4t29VL/TFRo7x/0hYtz3g=;
        b=nvqcsJcIWqXcHy+LQAH40Gnw+tghaz1YX8vfKQiikiQmUNmcUlcCx5ZcwCAtoFJ2qj
         TfxIO75aHjp2eeEsrUB6t3MqHX3SFl+FC5OloEqTdtxrWRuPFuJRcYe9p3xsECHGNDNm
         t8604OI4UTyvnHpn4RM3FXaaCsjhaUdDBsXLWyRiORXPGsTTTX46+dyoq54HmosyafhZ
         rtiN3ENDxACdpvNhxmlv+0XlFTP/NWDNgvWlA3Z6J+zJgdjl4v7HiA/R59Y2YxPUJkUl
         Fz6n7dipF0pnu8VHq+TY2N+Quc2iA7msfcbAfwIgPSzDzrsgtFghHTcNe4H/n32uA42j
         ODTA==
X-Gm-Message-State: AOAM533JA5cKApjspxfQiQe59WvsXXVREUdL1tN3kH6/8stI7BZj+yZz
        55KXfqA/RwF0U9JEQraHZZ6P2/OgkqpSSQ==
X-Google-Smtp-Source: ABdhPJzDZgWDJkU9XwCBSoNr3U013Fw71PkMKwlLojJvYv06QTdemOsA5/LeBNAM0cVhJ6btwRotBg==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr25419963wrv.73.1589871516599;
        Mon, 18 May 2020 23:58:36 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id p7sm2597550wmc.24.2020.05.18.23.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 23:58:35 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: magnetometer: ak8975: add gpio reset support
Date:   Tue, 19 May 2020 08:57:42 +0200
Message-Id: <20200519065749.4624-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add reset-gpio support.

Without reset's deassertion during ak8975_power_on, driver's probe fails on
ak8975_who_i_am while checking for device identity for AK09911 chip

AK09911 has an active low reset gpio to handle register's reset.
AK09911 datasheed says that, if not used, reset pin should be connected
to VID. This patch emulates this situation

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/magnetometer/ak8975.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
index 86e3efa693a8..a82c0ff5d098 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
@@ -37,6 +37,9 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix
 
+  reset-gpio:
+    description: an optional pin needed for AK09911 to set the reset state
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
             reg = <0x0c>;
             gpios = <&gpj0 7 0>;
             vdd-supply = <&ldo_3v3_gnss>;
+            reset-gpio = <&msmgpio 111 1>;
             mount-matrix = "-0.984807753012208",  /* x0 */
                            "0",                   /* y0 */
                            "-0.173648177666930",  /* z0 */
-- 
2.17.1

