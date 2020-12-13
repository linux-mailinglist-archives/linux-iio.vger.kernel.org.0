Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4932D8F12
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404225AbgLMRZc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391774AbgLMRZc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 12:25:32 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B351C0613CF;
        Sun, 13 Dec 2020 09:24:52 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id iq13so4940967pjb.3;
        Sun, 13 Dec 2020 09:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ynUaEpsEiEz0ejoqZQtxyLmuvONt7mY31z9UMZmBqrg=;
        b=lB5oJiSsStxJAd2Wxa48tsFNwCsy6Ra3YKgA/SioVMiudEc69fq9H0T4VgyuVhMwWl
         PZg/1hh1y+KQ29qoYktIdVdeaK/JkLnU87tpyQu8sp+ot/dLdCx4RWxFgluTV1wwNM2n
         xysv6Ly0zZV3FKU3YkSBa1Zvkrr0m/3zT7/BmQrbqMampKUbeGVcGQY7Ic0SxLBReJvb
         hF15ZDf/OVckYE0dksbU8oXePatEZHtMR+vuGk+A4R+UhUoV7em+sQnTX2dsyoeFlEUk
         aDjuTL3Zh4YxVv0tChLsHGQ/IMcKL5zKo5DthCiSm/MzJ8S+zx8kxAlFbn1UDitY//Ij
         Id7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ynUaEpsEiEz0ejoqZQtxyLmuvONt7mY31z9UMZmBqrg=;
        b=UqdobnS4O8j9XYfASZ7yrIAz+sjIVvH5h88V8cIRREft6Lp96mQHfgmqJslCHfyrzd
         WDtjoy3HZm0AYg6eEwsUwsjrEOdBRZqnSP/O17seE3cA9ZsRF3W7QUM3O75hlUABnpiU
         n4jFl8jaEmENGdPidrwk7F/iXEvcRgijz3DnzA+0LarlU5QfN5UX63Cm3SyWR+3dCruS
         +t/gACX66tF+Lt9zjXeI4W9bvZdINTKCVC3bcHvpK+btKUY4F14mfdQzAQA0KOWGIcOu
         iaT0LW+hiKqhwooLD5aVkO7v6F9sx7lIcyd3WFChqJetcfHFt2BuU0n+vbddQd43NXgb
         PVFA==
X-Gm-Message-State: AOAM531mlTBdcqEK+Pz3yQJcu1LNZOPrIoEFaFMNatVYoEim0D1l/jaf
        iXSs8HHOYkefbAKU63VsX366l+Ejb5MUWZ/7
X-Google-Smtp-Source: ABdhPJzmWfWZY0MmPn0XVmLoJ82aPcEp1BoUFiGGXzptPaDUS4fF9XLh7iZPP648u5PJq5+oub91lQ==
X-Received: by 2002:a17:902:7606:b029:da:246c:5bd8 with SMTP id k6-20020a1709027606b02900da246c5bd8mr19330240pll.27.1607880291814;
        Sun, 13 Dec 2020 09:24:51 -0800 (PST)
Received: from localhost.localdomain ([2409:4073:4d9c:e725:65e2:47cd:81e3:bc30])
        by smtp.gmail.com with ESMTPSA id y15sm15593863pju.13.2020.12.13.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 09:24:51 -0800 (PST)
From:   devajithvs <devajithvs@gmail.com>
Cc:     Devajith V S <devajithvs@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: accel: kxcjk1013: Document regulator supplies
Date:   Sun, 13 Dec 2020 22:54:35 +0530
Message-Id: <20201213172437.2779-1-devajithvs@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Devajith V S <devajithvs@gmail.com>

kxcjk1013 devices have VDD and VDDIO power lines. Need
to make sure the regulators are enabled before any
communication with kxcjk1013. Document support for
vdd/vddio-supply to implement this.

Signed-off-by: Devajith V S <devajithvs@gmail.com>
---
 .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
index 5667d09df..fbb714431 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
@@ -20,6 +20,9 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply: true
+  vddio-supply: true
+
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
 
-- 
2.17.1

