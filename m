Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C720B1A4B0C
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgDJUUG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 16:20:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33191 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgDJUUF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 16:20:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id v8so5485656wma.0;
        Fri, 10 Apr 2020 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=ZREyo9VAamNGHEpM0RaThvIV8s6WxHv1ooboukJgXL81fWWwgcZs8q6WmfpVEi4m6+
         2ROUPGY99aRffzWJaiINTYvm0ITfwANQQxYXuKxFcXrd7Y9R5DLfNguP3Vbdt2dfkvqw
         P+1HlXK7flzOA5YUeWhmcQZcA0ekVfKJwW6brOa8LbcP2PqFffF0Y4RlghClAyzjQJKc
         Xz38dGzqggoAd8IBmLoVUi0fEbK2O/BdBkD5bIU4avX4rDoj3i9DaOGMhrVmqADc6J7y
         pSUVSgd/vLUW0UGhDWhYqBMhR9ijamNAXra8KBu9AJK7VTRgu2/IHAVXsKkocjnCeTha
         KB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=jCq5J9SrPBXrn75VH3Td8LHr/dOy54K1V+nmKvWTCl6H7YZ5MBS+b4JoAxEhp4dWEw
         UwrVtACRTqf1hBFsccQ4iNseaMUXSEt/9XZfHuC/7LTwhQZQ2FCreMbm1wbnwRSs2HrX
         eWej7W61QEz3NcvEDkDqdbaky3vcwCtjFk1pEZt5fv+ddymyh42dpE7Nkxv0torAJvFp
         nbRpzJ4DHwYZqm4HNolmh2uhIT9pRkGmAUBIarBBg3RbM8l8xlrExQ/4e36IwbLrQPNC
         z5Rni6wAQqGhOwzw4r4N1c/oCYUry4goZSU1zXCCyqTGO9KeFLD1b0RRiXto9fqdizoL
         qkxw==
X-Gm-Message-State: AGi0PuYLjsGqQavhBOFu1pK1kPND7Tn0gbAFdd2hFtmQ1XQmscGnDR+p
        vtD60kjgU9ohyn/06c1XNn9mGYpOtYQ=
X-Google-Smtp-Source: APiQypIOjRvoPTITCeRplqz25ybqmtiKlMNHbnLrVW5teKaW+xj8O9sZrrYB3gfYPHVk32XR8fZKgw==
X-Received: by 2002:a1c:8084:: with SMTP id b126mr6494234wmd.135.1586550003241;
        Fri, 10 Apr 2020 13:20:03 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6388.dip0.t-ipconnect.de. [91.63.99.136])
        by smtp.gmail.com with ESMTPSA id n11sm4405187wrg.72.2020.04.10.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 13:20:02 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v7 5/5] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Fri, 10 Apr 2020 22:19:48 +0200
Message-Id: <20200410201948.1293-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410201948.1293-1-sravanhome@gmail.com>
References: <20200410201948.1293-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mp2629 Charger driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32a95d162f06..0f82d5a7a614 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11358,10 +11358,15 @@ F:	drivers/tty/mxser.*
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
+F:	drivers/iio/adc/mp2629_adc.c
+F:	drivers/mfd/mp2629.c
+F:	drivers/power/supply/mp2629_charger.c
 F:	drivers/regulator/mp5416.c
 F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
+F:	include/linux/mfd/mp2629.h
 
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
-- 
2.17.1

