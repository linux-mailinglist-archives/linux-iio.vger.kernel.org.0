Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2876819E47F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgDDK1s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 06:27:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36124 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDK1s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Apr 2020 06:27:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id d202so10526975wmd.1;
        Sat, 04 Apr 2020 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKn/T/YOjm2g49N2GnTJO8IqVO2wTeZD3GHQLfr9788=;
        b=dtRSXMGhG4s18xOq7nSqtCjqkc4ylms0u0M83uQs9rrN9ymNzrG/RR5hIC1Xr5vlND
         HVpogzca5XksTkmZg0f8SU1Rc/9gXyOT3yvCbWRV44j51FJjThSZVFH63vTdk9HFx3uY
         DwFS9xNp3YQKmjmd5suKwSBEePJjZInMSaMQt/GRVw56rmIEtesTPYU9c71qJi/+cs8z
         P80A6ZMoUOfi0WDp2Zaa1XnxFae+FsgY+TLmNvGbYZXZwIAL+WLeh/tTMZirwziWkITb
         Joux3aOdYMqYUepG5nDeb0ZfbHb6Ifoo7kdX4IsFG6fR4U+AF8ujKOfEbOdcwH3s5JPV
         MfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LKn/T/YOjm2g49N2GnTJO8IqVO2wTeZD3GHQLfr9788=;
        b=QrudkJnvY+35e7rZvaO+YNvDtaTczXAmGV2X9qrRM/VyjHSm4vcdRMxcYlOIomoRCg
         +Nz7WIVf7JOOJP34CYqEEmzACHVT65wdQ1jM/erFaEnIWm/2G183cXTDkt1H+8sZS0py
         HE4c/htgHKwmQJIOXfTx3nEP8NiEHqs3b70zEGCfIxBqleEB1Kg2CmNC95dhu5SPc3uu
         ov5p0q8NSBFZEGrj1f48tbD9Y+9GdXk5RKL2Ydx6sL7bzPCc+T5n1phlLZ5NK4DPLWkH
         X+Bz1HtvocjzeCHf9zWCmtF4FPK8GUq8oFTYy+QXplm9oKOfUOcox+VqTdsJUo6jEyOf
         A0pg==
X-Gm-Message-State: AGi0PuavjhKHBIVz4O5lzDAjOugxKo5okoca/P1m6miVjSV4NQFmR+zw
        LgbiyMiPkkhj3Mea1AF01AU=
X-Google-Smtp-Source: APiQypJ1TtPTEK86zb3XBL8CXguASyxCagcMjtYiJSPZja45TmT27ARgAd7NnAbtGutgz0SpzfoZCg==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr12759826wma.98.1585996066182;
        Sat, 04 Apr 2020 03:27:46 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c18sm15833178wrx.5.2020.04.04.03.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 03:27:45 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: iio: adc: rockchip-saradc: add description for px30
Date:   Sat,  4 Apr 2020 12:27:30 +0200
Message-Id: <20200404102730.3295-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200404102730.3295-1-jbx6244@gmail.com>
References: <20200404102730.3295-1-jbx6244@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The description below is already in use for px30.dtsi,
but was somehow never added to a document, so add
"rockchip,px30-saradc", "rockchip,rk3399-saradc"
for saradc nodes on a px30 platform to rockchip-saradc.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes v2:
  Add acked by
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 7653aa480..bcff82a42 100644
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

