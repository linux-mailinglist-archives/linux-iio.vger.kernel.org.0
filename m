Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0891957D5
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgC0NSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:18:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38050 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 09:18:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id z12so8453066qtq.5;
        Fri, 27 Mar 2020 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T7eY4a/HYQ1VC4MYo7ru+bOccPR0lnPmCuIuMoGep/w=;
        b=Jt8OGO4S8HwNCjo7ObiAfdKl3BtkbBC+oA5jObUN2wqJocvAe977Q/uf1u3Kx+W64t
         YyeQKLbFd1zOtPXUulQtcCWECyZ6YVl9n1RzAg4BEdK/L8WG3cyc8aIdS4ZFLdiq5b9g
         TexefD2jdvBAdkll+HiJ9SqdSW7N4fCrFTtwgMq5oVSdQ6QItoCxn91Sim37q23f8oB/
         4zZGeA3eJwLNKlmpevDzQFyU1LDkxftQOwOYHwoLKDSh+jxJdVVpLAHOUvS/c1sK+Utz
         P4FDEPzxujZpaT2Stk1nuhOmRELiWvS0TFnRWjhZePDkgXq9rmdkG5NXdm2tQOw3cFLc
         a4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T7eY4a/HYQ1VC4MYo7ru+bOccPR0lnPmCuIuMoGep/w=;
        b=M1MZvbP9tlwFEjG1QlGlNqAnYc3j0QQUzudx3uEVA1p4ROQipGO5xMxveEYOMCnf/V
         iRfgCfIgYv6SCrfMLUEoaIbjowt24LtiQztjJ5vHXEk3E/aQo72H/tdmMAa2jc2AyVW3
         XCQA2DaMQmE+05YrWoSlSCzpAFsdRT4K9ZkKs6k3Wt+QFDuWj12vW4+Mtw83BeWWI5eb
         HALRbQCvPfSszrIvLzhSpV4QjTHhEPa9XqMFpRgToSLiTwg/WBxrBldw2MNSJyZvJ9Za
         FgSm+Mz9Ca6UhcQbjFHx05s+TFfnLCJbtQDMLrVgd2V7uqVaCMROJ/aDNc70ZAc+QPOl
         g+aA==
X-Gm-Message-State: ANhLgQ3P+wk7cIXrGL7uD1fG6wU7joYI1SuHPbQeq9+DMQYSD2zBFKXg
        FEyoJr0oKw4gdxOnTLFRIsE=
X-Google-Smtp-Source: ADFU+vuqJFGro+uqvxFCrqTmxleF3uzivT1N4KpCgw4ewJef8Pf7D/9jc9OjrDz2kaB9+MDVQDcmbQ==
X-Received: by 2002:ac8:378d:: with SMTP id d13mr13996056qtc.227.1585315123155;
        Fri, 27 Mar 2020 06:18:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:5bb::4])
        by smtp.gmail.com with ESMTPSA id o186sm3663914qke.39.2020.03.27.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 06:18:42 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, alexandru.tachici@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] dt-bindings: iio: dac: ad5770r: Remove unneeded unit names
Date:   Fri, 27 Mar 2020 10:18:24 -0300
Message-Id: <20200327131825.23650-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327131825.23650-1-festevam@gmail.com>
References: <20200327131825.23650-1-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following warnings are seen with 'make dt_binding_check':

Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:29.35-32.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@0: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:34.35-37.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@1: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:39.35-42.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@2: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:44.35-47.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@3: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:49.35-52.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@4: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:54.35-57.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@5: node has a unit name, but no reg or ranges property

Fix them by removing the unneeded unit addresses.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index f937040477ec..fa86ef52b121 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -151,32 +151,32 @@ examples:
                         adi,external-resistor;
                         reset-gpios = <&gpio 22 0>;
 
-                        channel@0 {
+                        channel0 {
                                 num = <0>;
                                 adi,range-microamp = <(-60000) 300000>;
                         };
 
-                        channel@1 {
+                        channel1 {
                                 num = <1>;
                                 adi,range-microamp = <0 140000>;
                         };
 
-                        channel@2 {
+                        channel2 {
                                 num = <2>;
                                 adi,range-microamp = <0 55000>;
                         };
 
-                        channel@3 {
+                        channel3 {
                                 num = <3>;
                                 adi,range-microamp = <0 45000>;
                         };
 
-                        channel@4 {
+                        channel4 {
                                 num = <4>;
                                 adi,range-microamp = <0 45000>;
                         };
 
-                        channel@5 {
+                        channel5 {
                                 num = <5>;
                                 adi,range-microamp = <0 45000>;
                         };
-- 
2.17.1

