Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26B3EC447
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 19:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhHNR53 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 13:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhHNR5M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 13:57:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB7C0613CF;
        Sat, 14 Aug 2021 10:56:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bo18so20227563pjb.0;
        Sat, 14 Aug 2021 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPj6ILOpZZ50aP1T2Ut52iloC7VUEnx1pfAKnDIgyys=;
        b=ZCLYlcIFXK0ix9ufR6HHuPVlgU5MyUKBAjw78tybsWhiqIbHTvlwKfUGUaIcb+ibD/
         D8e4tFCXxeWwTkeIfBlj7Sz6F6pvyE6pDRrAghnPyYtqri3CnckN0z4EFxBQHNnlMhIS
         5KMb/+IuuK4w/Nl5YQgKgH4nykW0uBDTr0kKpNkC83kXRAtdYPu+xHyTAyTAVFKdaGKQ
         2/zDIOALP8STp4xx1lXhf0THTkmFSM96UUwxwW/IbFmaJFm5GF9qCGwU+LA+hrzhJUSz
         5XcgLmNDsWZyMqbtvegiPoSNuLB+5LON+w6lL1zooKilpEo8QrWuRHhoO5HKErdNwVt+
         8D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPj6ILOpZZ50aP1T2Ut52iloC7VUEnx1pfAKnDIgyys=;
        b=MGf1u2vnFECDKzyM5GExifYx8iDpKzqTwJqqRrl+EzLbiGGvW+mpiXCH4yk8HNgg/U
         X+IysbvLWRVsjDKKwAAyn5QWfDH4k9zA2LnDGMMsor1lg1+NwgM5zdB3KqzZ2W9P2VSp
         170ahkZHFkoR6DZnYIjuOYSU14gTSy0wKsYNv3s8omB4LSd22LmsLJFPI9DCB14kETag
         wflecmFKvliZgbHyoXiUMUhqZfmB5J28kP8lF53IY7DPRWOMVMcYtaB7TZxXb4FZvO3p
         fbYye2DMcncspAocFepXEmWw5p3enGrVKU9aui6HAJCXP3xLW1YMbywAjbhHa8P9okIZ
         l5Rg==
X-Gm-Message-State: AOAM532TSx+iuufsllfB+GEyk+ASKjarGBsbJWGt6nU3+V4TIlkCLX6f
        NjMEdCUiAkONKRvJYECI7kY=
X-Google-Smtp-Source: ABdhPJzbf1psfm9bgbVTkGLHwGSfB844UNQJD+0LyJnlIaztqDFklpYLXrDrbUp7qpkRmuXIOYd13Q==
X-Received: by 2002:a17:90b:f83:: with SMTP id ft3mr8287632pjb.173.1628963803854;
        Sat, 14 Aug 2021 10:56:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6293:2348:f0eb:567b:5544:c735])
        by smtp.googlemail.com with ESMTPSA id q26sm6305380pff.174.2021.08.14.10.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 10:56:43 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
Date:   Sat, 14 Aug 2021 23:25:39 +0530
Message-Id: <20210814175607.48399-2-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210814175607.48399-1-dmugil2000@gmail.com>
References: <20210814175607.48399-1-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add AD5110, a Nonvolatile Digital Potentiometer into
trivial-devices.yaml.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8341e9d23c1e..55c8a6ce5057 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -33,6 +33,8 @@ properties:
           - ad,ad7414
             # ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
           - ad,adm9240
+            # AD5110 - Nonvolatile Digital Potentiometer
+          - adi,ad5110
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
           - adi,adp5585
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
-- 
2.25.1

