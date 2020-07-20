Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57BE225818
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 09:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGTHDt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 03:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgGTHDt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 03:03:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDD2C0619D4
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o22so9605520pjw.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S91pqBIXOMqhpCywJzCF5HgxB4jKWpemY7PxHePdq0o=;
        b=I6q1y0tcxAMjjdoJod5qWJYE7KSLaohAiISvZTT5LBHNp+Ib+Q3NJ4EIIQTdFlo/Bg
         RlZVLz1JqElwkcxzTtVSxJH5PDGgZcZ3sSy/B3jv01PPAAFKCnJ38HMtArX0saZ9e5Eq
         ZHfhh+BypuEeX61UngdMaWabPSO+ZeQWxBBWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S91pqBIXOMqhpCywJzCF5HgxB4jKWpemY7PxHePdq0o=;
        b=HnovUHe8rJMIhw79YR25c9BlgLTuyU4avAMcp2izccp/Y5+rbxYJPmEkajfW2J3xab
         TWZODa0lbAER1rySO8FZoDGf2/94QfcXrU5N24O6XI8TFZVmfCSJk7mhTJ6u2bJiJn42
         ZGF3xbSAp9SqKTPuDXm0Qkih2E+OT+hxKAA1Z4HRXbZyhGo/+mGsQ/s+Nhr3LzAfzgqu
         W5uZx56PMBzAHEncpFY+wb2kMf+PITpZ8i/D3iXzLfswRHtLBS9z/8Gv1pGCSQBT66xI
         aiKzn/tsyfM3cVRpKpMJda7YdATUZNHiXbre1fIUPotlr8ktBAkilIKYNV2/GPGwjajl
         7gTQ==
X-Gm-Message-State: AOAM532hfZh6bOo10k3nL9yvvUyUI87VIkcR34eABXLAlfYBzBPtDFLK
        CGJczSUbqRjexYp4mBpuJWlTwgzbsEMtEQ==
X-Google-Smtp-Source: ABdhPJyU0s4WREt+vb3NfmlvNYiYPuiSOOW1vWuul25+/XsrNtiGhLF7+dza35AzIiS1VSeZwurVxA==
X-Received: by 2002:a17:90a:1109:: with SMTP id d9mr22659634pja.201.1595228627529;
        Mon, 20 Jul 2020 00:03:47 -0700 (PDT)
Received: from ubuntu.Home (anon-62-111.vpn.ipredator.se. [46.246.62.111])
        by smtp.gmail.com with ESMTPSA id gn5sm10613862pjb.23.2020.07.20.00.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:03:46 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: chemical: add O2 EZO module documentation
Date:   Mon, 20 Jul 2020 00:03:29 -0700
Message-Id: <20200720070330.259954-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720070330.259954-1-matt.ranostay@konsulko.com>
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
index 69e8931e0ae8..46496dc250f2 100644
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
@@ -19,6 +19,7 @@ description: |
     http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/RTD_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_probe/EZO_CO2_Datasheet.pdf
+    https://www.atlas-scientific.com/files/EZO_O2_datasheet.pdf
 
 properties:
   compatible:
@@ -29,6 +30,7 @@ properties:
       - atlas,ph-sm
       - atlas,rtd-sm
       - atlas,co2-ezo
+      - atlas,o2-ezo
 
   reg:
      maxItems: 1
-- 
2.27.0

