Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB81B18951A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCRFQQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 01:16:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45863 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgCRFQQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 01:16:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so13224651pfg.12;
        Tue, 17 Mar 2020 22:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlwaAt0Q9Ki0s2/sS1b607ZcJpVqAr5H+69fMO0HjgI=;
        b=TzJDmjwdj55mwAp95w0Xzx8U18G2cfzG9JLhtMNbWyM+X6LQREWfBymZn9A1xhXgmS
         3sTKe1Ft+t8MrIHsTwM4MgsEAhd1CzfT2M0y8TG5sUkJKkU67pWg0mKWqSPXDzpGy6g6
         nIWXR4xRVnkvp9R3rnlSez1VwIO9RZrxEIpD3QO/8qKfPuXli/j3bWvDmeyWM+1Lueas
         zsBJh8Iad3T2kyZrmT581Tw5yeQLaQj+nf1FnFYKMLzqMYLF1AQPkyXwNAbYLLSnErPI
         l/mgYrXy0ZQnMeA4m+ssEbnTSVdiXKhFPqLuoFFimf86HfTuBnbnsIyD2SQmmMxuFJqh
         T6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlwaAt0Q9Ki0s2/sS1b607ZcJpVqAr5H+69fMO0HjgI=;
        b=hHh2EHuU3jf9wYqHpbdnBWxDaSF0xOkwoFygr+VSS+lwgAqzJlDBLkrfOQXkxrmzHs
         lQdQ0oItMOfXGSWDlByI5SFmd+hZPkRs+l3qREv6QutuYj4rZMMpmpYyBySExIA20Gpr
         uOEmirg7mRCOdpXCFcfcSKispLHpNPpxm81GVNIMD84mXgqzh7KXA49s84yK+bohQP/u
         AhB02Ptg6Ut5NkJ30DdCoF4xDY9lwC2TEy8LfQDtJFIhbkZ4+bjhV6v5bL8yUGOmKaHz
         3JUKLokYFJ9yXVd+UNZOhqbXlpxyOlO0vRZXHFizcUVi3ceSvfQHaHc/XWETiWUYJnYM
         MYSg==
X-Gm-Message-State: ANhLgQ18+qmcOrqnCXPm2whFWosye6B07/9c6REfJndGySw9YdMjag4Q
        rxWQ5mYnoe4uXYG6+kWaRIyWTqeNlDM=
X-Google-Smtp-Source: ADFU+vv7rYa7a2qA5/TNJKZmXHnyu1FhULOs8SlM3+WrA1nDojWzpiNNErloEXfgq3uS4CfhC6NxzQ==
X-Received: by 2002:aa7:9481:: with SMTP id z1mr2411232pfk.185.1584508574446;
        Tue, 17 Mar 2020 22:16:14 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6086:470e:bc8d:c185:c429:a95b])
        by smtp.gmail.com with ESMTPSA id k5sm919794pju.29.2020.03.17.22.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 22:16:13 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, nish.malpani25@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: tsl2563: convert bindings to YAML
Date:   Wed, 18 Mar 2020 10:45:39 +0530
Message-Id: <20200318051539.958-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the TSL2563 device tree bindings to the new YAML format.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v2:
  - Rename the dt-bindings to include manufacturer's name.
  - Synchronize the bindings with the driver.
---
 .../bindings/iio/light/{tsl2563.yaml => amstaos,tsl2563.yaml}  | 3 +++
 1 file changed, 3 insertions(+)
 rename Documentation/devicetree/bindings/iio/light/{tsl2563.yaml => amstaos,tsl2563.yaml} (92%)

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/iio/light/tsl2563.yaml
rename to Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
index 2a70b8d62760..141c7ae1edc8 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
+++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
@@ -15,6 +15,9 @@ description: |
 properties:
   compatible:
     enum:
+      - amstaos,tsl2560
+      - amstaos,tsl2561
+      - amstaos,tsl2562
       - amstaos,tsl2563
 
   reg:
-- 
2.20.1

