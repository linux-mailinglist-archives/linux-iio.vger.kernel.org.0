Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31851A6B80
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgDMRhe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732882AbgDMRhO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 13:37:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2497C0A3BE2;
        Mon, 13 Apr 2020 10:37:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o81so4465427wmo.2;
        Mon, 13 Apr 2020 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=FyRQ4O4tvTTJTitTz9W28h/1N/LB+saR96VqV/dHtuDmuCaOoLZajiaIyEYWqlSNFK
         /nUN0Gvbw7+sIXhJT9QmCSA1tPmI5xuMEiUTsDUwdD7TJig99iJiIZQgB83msgwLRda5
         tDUu2UruS3Pm3yjAmmSOGAc1msp8foDihyQrUwaU4P4ajkZlgFBlD8flj7mgd6y5S6uO
         SRAw08Shw5dtKBlpGdMeshBj61gNkGGRPiIrm8G23pAHxwtW0JcMRqxszwty0+lmJ4eB
         KZ1cQRQUqeKtGPvo5Ynm1+Df16dqyhngf4HL7pRHuSTyFBwht1OQtazm73b8e+NRiZU0
         Y+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=kro5dDHDW6vtCzhS20NVOG1fXZinU86PGF8zvfIKN0f4nuyHiSIb607B9plJkYYJEZ
         RlTBuO4PKNUFcgCZH/v4+hH9Ik17QCOhuw1vOiAANW+kOZ4PYOySpenPJd1Q/mfOWgi1
         vuYSn5lfgXVCQRP9OdAFOnlCiDGk1f30dAjscqca+cd53IRePp3YshuJ459lA71WysL7
         OYuGJkgmiLZ/+W8bSImQwT4EoHzzze4Z25pRb6Mmuj7cUME2pg795ygl9RFD8gE9NRHM
         bEsKumXU/ZkgrObkcHVgt+2z6lhotxz9P5U3FylxksNrsSuCtkBGgcoEdO2OvSmeVn1e
         QHDg==
X-Gm-Message-State: AGi0Pub3rV4dvtCn1vxhf3jWrXuatrji4KRPtVRN7Nh6RUdYmonbRbU7
        bco09TyrBZQccV3rWuloxuDuRy96Ckw=
X-Google-Smtp-Source: APiQypLoFKiIymQKv4j12LxYH1Zb7462vvWxWlSn3xUcZq8EdPqS5Vh6LZWjzgYDMQin8f3MxLZQgg==
X-Received: by 2002:a05:600c:2196:: with SMTP id e22mr6836810wme.105.1586799432693;
        Mon, 13 Apr 2020 10:37:12 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6AD5.dip0.t-ipconnect.de. [91.63.106.213])
        by smtp.gmail.com with ESMTPSA id a205sm11141465wmh.29.2020.04.13.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:37:11 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v8 6/6] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Mon, 13 Apr 2020 19:36:56 +0200
Message-Id: <20200413173656.28522-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200413173656.28522-1-sravanhome@gmail.com>
References: <20200413173656.28522-1-sravanhome@gmail.com>
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

