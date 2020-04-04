Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA719E483
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDDK1t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 06:27:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgDDK1s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Apr 2020 06:27:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so11572601wrd.0;
        Sat, 04 Apr 2020 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVSJoHbvcfmZpvtqW1QMAa9hF+P/zoaKi8Qrm6r+ndg=;
        b=T6k2XJE/Uqlk1RphsmcJrro4Z0Nj/Ryos/pqYdDEHVCi2IVFAhdHAtNHK7q/U+xE9r
         ZRidSZ9V8sPjckcwQuaZhOa2b8ddsfasZ2QEl6oThLUdNtVZ3wQHf1cj/wf2CUwoEZtc
         RxErU71+u2mL2rFxox8VPoG5EVbIcLGeFLpfY3lWQSUaHOFCmH3F6d800Gv+XqOMZQo8
         tIDGUqbagUpsimqRvNA3B18gBysb2/M9UX2sRIezHwfRbrbysBbBytfxIjLxC91Lrhyp
         pPn1FJSjCsxOTOtlahO1GfIm/gxbtZd9CkJVwM2L13Rr63fstBn+4m8J5hxpa0WJ8yo4
         zjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVSJoHbvcfmZpvtqW1QMAa9hF+P/zoaKi8Qrm6r+ndg=;
        b=EWKAHnWjGIEiiCgDSSi69hSaUEM+TRMvB7I7EY5IFtUusy3qUGofm13DuuK2FjMdnn
         wF0J0XBMrHcQYPOuhmXyFGHjiRILF9PyEbUVVMRS0R+aGf/ujuv6VcYI4L/wQrS/vKYn
         H+1MQth/GkrMfwv7feittXGEzW7Fcedk5KpfsX8Ga/cL7XaNfXLQSSqEBrmlfRNKmQFp
         5SZ9KMp1Uv4PXc3BZG4vN+BmaajWB1IdCP/msAIFf2qC0LNfXZcsrFTlMKcZmZF5YV53
         5geUvd3yupGHJSNYFGNsB5ewhSvrcKDXrLuLgV72FiyUu6JsCao25iarTZah1WvO7p0M
         6D+g==
X-Gm-Message-State: AGi0PublkTDzIofDTgTKjwaEmgeFlbGfCIQ97IJveMGA+IIV1OWgoJQ6
        K7RuS3B5eH2eg7njHbc27QY=
X-Google-Smtp-Source: APiQypKyTC4hKbderIKuXA6Q5B/gmQ6ZWFbLZ/OBBiIVvMHiy01dzmVzsPU6v2Y2zCim1xn68pfeTA==
X-Received: by 2002:adf:e445:: with SMTP id t5mr13982590wrm.352.1585996064992;
        Sat, 04 Apr 2020 03:27:44 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c18sm15833178wrx.5.2020.04.04.03.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 03:27:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: rockchip-saradc: add description for rk3308
Date:   Sat,  4 Apr 2020 12:27:29 +0200
Message-Id: <20200404102730.3295-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200404102730.3295-1-jbx6244@gmail.com>
References: <20200404102730.3295-1-jbx6244@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The description below is already in use for rk3308.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3308-saradc", "rockchip,rk3399-saradc"
for saradc nodes on a rk3308 platform to rockchip-saradc.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes v2:
  Add acked by
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 9b9882323..7653aa480 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -17,6 +17,7 @@ properties:
       - const: rockchip,rk3399-saradc
       - items:
           - enum:
+            - rockchip,rk3308-saradc
             - rockchip,rk3328-saradc
             - rockchip,rv1108-saradc
           - const: rockchip,rk3399-saradc
-- 
2.11.0

