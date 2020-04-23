Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFA1B5E97
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDWPF3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 11:05:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43239 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgDWPF2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2020 11:05:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id g14so6541593otg.10;
        Thu, 23 Apr 2020 08:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnMPGKKs/H1frZAsMjB7virpgwwMnPWXLdtUhLaJnsM=;
        b=jIgRBgbBjeHmebXh7WYcKPAH3jML6kzlSSQVUUMGbirKLSqDkiH1YePqdyec3m1tGE
         ED4i6ZliKQyD0IvLjJTHC/8QCYK6GnSPbDgsC6ziUaCa5IPEW9bWC7iFxjl4qmlC7qH2
         DRufL6lZQRryPKUKRp+aGs1aMJfKrvQXYSPTFLm2RdUnOgaPyyhxGx5Eo+hUyDpjYRnZ
         61C0DQpvNGnwO7QSeAdCecZ4q3OAur3s0KcfUBWGxni/JUACfDZM2M+CrCN3OvO92E/U
         NMNv2hLy4SzCmOPJNqdyCUE0SCWvqYAVXzYR6r1GTDT7nwcQ6ExlEXGJCP/sF6w1xIuu
         wuiw==
X-Gm-Message-State: AGi0PuYKVVjQMq5ZwlJaEIDRBOdC3b6fiM+F2IIjaLEOk8Pxb/GlpuEU
        bpGDDpOrMcf0JzOg3Ov7NEgPshM=
X-Google-Smtp-Source: APiQypKittqv9AFwMJYvTsZFfmrwTJqlXnWsfTdZFtvja3y880GKkC3waKfN0IDdsV4C1NgoMK9Lcw==
X-Received: by 2002:a9d:412:: with SMTP id 18mr3958646otc.233.1587654325886;
        Thu, 23 Apr 2020 08:05:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id w11sm659264otm.53.2020.04.23.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:05:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adi,ltc2983: Add missing quotes on dependencies
Date:   Thu, 23 Apr 2020 10:05:23 -0500
Message-Id: <20200423150523.23984-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the bracketed list form, any strings with commas have to be quoted
or they are separated.

Fixes: 3986a14870cb ("dt-bindings: iio: Add ltc2983 documentation")
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 8fb46de6641d..04da5c48a5e9 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -260,7 +260,7 @@ patternProperties:
       - adi,rsense-handle
 
     dependencies:
-      adi,current-rotate: [ adi,rsense-share ]
+      adi,current-rotate: [ "adi,rsense-share" ]
 
   "^thermistor@":
     type: object
@@ -349,7 +349,7 @@ patternProperties:
       - adi,rsense-handle
 
     dependencies:
-      adi,current-rotate: [ adi,rsense-share ]
+      adi,current-rotate: [ "adi,rsense-share" ]
 
   "^adc@":
     type: object
-- 
2.20.1

