Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF651AF767
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgDSF7S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 01:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgDSF7R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 01:59:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ADFC061A0C
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 22:59:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t11so5214521lfe.4
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 22:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VX6tMFQF79i/ftypgBXXLpWGwJKO5n2LFJJUQCNDLbI=;
        b=RJ33wKWejDpS2Ipxi/6KpgRd2TsK6UK7IEQBXh0leVCfXwTswxyXOU07l9cQ7T0UbJ
         GnG+rDxnOCsXEsLyHrFMI2VMoz48ZgNgla4KpOnum+kX0JgvvrAqhxihvvq5YT5PrIQn
         3ppS4VQloeSgUz8y5N7Wr2FfDpurUoTtKkPhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VX6tMFQF79i/ftypgBXXLpWGwJKO5n2LFJJUQCNDLbI=;
        b=Nr6kPcpKzspt7yV+sW0c99pfBWQqMPBZ/BisRO4YjOBuN9iC5k3tk0+mGnEn/Q/hDN
         CnQG9r9eldrlRMt3WxqC8/s5BjojwhlMWa0DboSkrgemaiO7wv5D1fydxyLuPuBc/JEb
         swwuEjTeteJ4bpOdg/Aed9mbLL+WOpdj3Spx90gSJNapoeh+uxflXOFsxLCIrV5eLCEy
         8F/heuurWFWnkMrUTTBgvgWDwQShQsmtpFW+G7fBaAfj+vFfRKB7/dyI3Xq49AG7wtrO
         RN6V8xu4jFy3qNOd9mNMHiM0xEbgJZ7Xuq7BZ+HRwhXT1a+T4ykI43kQoIKQQE2gA5+Q
         9hzw==
X-Gm-Message-State: AGi0PuazmJ7CvfhOqxE6/5SUyHgrB4RR3g8PIG36bIMxXm6bJCEgDosv
        77zZaPhGZVfPgImJhq+rn3sHtA==
X-Google-Smtp-Source: APiQypI4DCS3C4Gs2/uM8b7aDdMghRBbhCvJDYDOE420VG79WlV8vg37lT8Mmch2hkGzHpzN2Ug2Gw==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr6833828lfc.60.1587275954334;
        Sat, 18 Apr 2020 22:59:14 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 4sm12407715ljf.79.2020.04.18.22.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:59:13 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: chemical: add Atlas Scientific RTD-SM sensor docs
Date:   Sun, 19 Apr 2020 08:59:06 +0300
Message-Id: <20200419055907.23411-2-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419055907.23411-1-matt.ranostay@konsulko.com>
References: <20200419055907.23411-1-matt.ranostay@konsulko.com>
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
index edcd2904d50e..0e510a52920d 100644
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
@@ -17,6 +17,7 @@ description: |
     http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
     http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
+    http://www.atlas-scientific.com/_files/_datasheets/_oem/RTD_oem_datasheet.pdf
 
 properties:
   compatible:
@@ -25,6 +26,7 @@ properties:
       - atlas,ec-sm
       - atlas,orp-sm
       - atlas,ph-sm
+      - atlas,rtd-sm
 
   reg:
      maxItems: 1
-- 
2.20.1

