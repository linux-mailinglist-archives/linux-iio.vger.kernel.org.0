Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BF1957D3
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0NSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:18:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45000 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 09:18:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so10625761qkc.11;
        Fri, 27 Mar 2020 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L+Che3BA8te7SV8wCt917Jrt1vzM2zOvTpRhsfZRSOk=;
        b=MBSaBSYHh5ibQIRQ6rtpannGv3SXckH/zbCFRhqk9bizgnOgzpCIQGLdypyroudV72
         2j5UlDCtLV2Euwdz9Nww74Y5RQRIfM7G/FOQQSwWbpiHnl0fQj7JnE0V3hh5jplDt6W9
         X7SgZp63JaqB/cloPK3QcYuvIM2M3Vj6thOz1RrZPRZD4pejLLXICPmHQvjC2ApS59IS
         HFBVy88sNYzHq+QLci6iPcPJ7yV70ED2Dzzp58aCnGhNY+AaKGFmCgwhSRjYbwlrEwnV
         Jo2sHivCzRx4D9YOdCh0Nm9YmAMsDrac928FbgLfpERnHdvX8V5yDdiJiHKjgBbn73yN
         SUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L+Che3BA8te7SV8wCt917Jrt1vzM2zOvTpRhsfZRSOk=;
        b=Zlppr1UIVqedClgRgnlAP77T0zwL5jvT1kbrNqVXL8n3RfLkKBXwIjzoBge/sIIQ6Z
         RegRKbUXUHB09l2WhSSKMN8r8pkAyYQysDuRwwC+EKMBkHA4as8erdJRc0g124w2Ljjw
         H/QL7QSyj9TvvqBNp64QR2xVFBfC4DhjRLmorLCZNrVsUkLH2ixnCdiMsfttP+mVWhoj
         md45C0n9y0SCfYMpahZMDjuHRjjplAys9wHgO7i4NY4xx8L05PX44rMGVJo6YUDYNBwe
         GLnVG0348x190hDthOIR6Gkp1/+x5agKL706m0FzdHZOnPiL2QL9b1IovBRXZnF4K7+Z
         e/og==
X-Gm-Message-State: ANhLgQ1+v76YZdrN5LMVhuG+Y73Aa9XNvDRBBtrPFlkx/fh8ddkw3eT9
        QxNdMbFu+svonaK4SGjb6BE=
X-Google-Smtp-Source: ADFU+vu4VmSp+OlpO90Fqymv+3eN4TkDMPdmrJ/4hmrUKas0ka1MGoazzD11DgP15SgpkgXbVzWlGw==
X-Received: by 2002:a05:620a:348:: with SMTP id t8mr11062886qkm.407.1585315120277;
        Fri, 27 Mar 2020 06:18:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:5bb::4])
        by smtp.gmail.com with ESMTPSA id o186sm3663914qke.39.2020.03.27.06.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:18:39 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, alexandru.tachici@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: dac: ad5770r: Add vendor to compatible string
Date:   Fri, 27 Mar 2020 10:18:23 -0300
Message-Id: <20200327131825.23650-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The compatible string in the example misses the vendor information.

Pass the "adi" vendor to fix it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index d9c25cf4b92f..f937040477ec 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -144,7 +144,7 @@ examples:
                 #size-cells = <0>;
 
                 ad5770r@0 {
-                        compatible = "ad5770r";
+                        compatible = "adi,ad5770r";
                         reg = <0>;
                         spi-max-frequency = <1000000>;
                         vref-supply = <&vref>;
-- 
2.17.1

