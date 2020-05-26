Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C411E1DEE
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgEZJH3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731716AbgEZJHR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:07:17 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32DC08C5C0;
        Tue, 26 May 2020 02:07:17 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c35so695378edf.5;
        Tue, 26 May 2020 02:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+S40BVUPgPSUdWykoDheY5kQW7B2En+DiDAHKy6z5dU=;
        b=aDygklhGqGUfLYeA/rc8mhK9DamK2+T6P7wNaW1L3uA4jK3iRV96Q6c2bFsaMjDDzC
         ZEa4nNcyHrxo3Aw/EsdG164KutYZeGlXVoY7FitvyiOZWRwiTR8bKEXkOYBY9k+Q+2wV
         fsaIR9JvTLkdIAfrWy061l+A8w0tQ01SrcVLtGbtyTdpYOKsrE2ZZx0c3dgZEJ+WfbJo
         ydWbGL5N4NSIg/GbEcHLNwNTbLec84U4Sf1tJ5PlHGsGEdxDPSkFDxEBKLN6XNiGL4Wk
         WkbD0yqH0koQtzNEKj2hShwe9KGNM6KBmvgBmCKfFtx9QBkyEvwS9+9YYJ5Op+izNCJb
         wGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+S40BVUPgPSUdWykoDheY5kQW7B2En+DiDAHKy6z5dU=;
        b=rDFqzJAJ4Dmm/KI1LbEIfFwppfhIzWFVufoDVHbIh2qejTlP45vBHMOt/9CS4E0iEA
         SWoK0412DxkopgsedwbDDPXkm7+31BN55upDkFNh6yEJ8SFp8EDL5KIaY2PQ9mNpwoRi
         vjWVHz0rACJI/z0k1lix8/0DBoGH0E+2ZQJ72Lsnh0tUIrQHwaJ/1FGc6qBQCavWRy+/
         vD5s8QqAzC95YMP7QzEI9hTWbfei/6L43J7mJCZkxQRo5PwJDwez8ozA8ojS/nqYMyoT
         D5rrKvVqXyIXL/5/UHOwXqZMswN+9usKYmT3Cdo98p4sZhp+MTuYLFIEdqvR3hkF0b4o
         25mQ==
X-Gm-Message-State: AOAM5321noZYWmzx71PikK/5u9cZ/bDVAw5K9TFPZ1z5eyteERh2iwAx
        DYKWVUMmBtrVkeRrqfFTBNEBY1gbD1A=
X-Google-Smtp-Source: ABdhPJw7CpT9GgGjzICTDDEadxChbZGHAU3k5+0EHCDWM0fmFJWSxdLsJvK19Kj9IQ6MXkHGd9rSCg==
X-Received: by 2002:a50:f182:: with SMTP id x2mr18993351edl.336.1590484036039;
        Tue, 26 May 2020 02:07:16 -0700 (PDT)
Received: from localhost.localdomain (p5b3f6e09.dip0.t-ipconnect.de. [91.63.110.9])
        by smtp.gmail.com with ESMTPSA id c7sm17870535edj.54.2020.05.26.02.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:07:15 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        sravanhome@gmail.com
Subject: [PATCH v12 6/6] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Tue, 26 May 2020 11:06:46 +0200
Message-Id: <20200526090646.25827-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526090646.25827-1-sravanhome@gmail.com>
References: <20200526090646.25827-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mp2629 Charger driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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

