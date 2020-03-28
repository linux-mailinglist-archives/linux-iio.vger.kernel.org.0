Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0A196249
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 01:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgC1AMN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 20:12:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41009 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgC1AMM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 20:12:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so13840265wrc.8;
        Fri, 27 Mar 2020 17:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=DdTPzQSSS2/ubRNz+h06dvMkaDyQidAdmr7yJ2mTtmmTwzoqX6EHYnr0/MwAzRwGIE
         RlcOLbE+F3AacmuCQTK8cJEUKLDZ+4GKWInY23uvDR8OcceGXEu1iIzT8YGICQ310UD7
         R8sUAcg2tpT4wWOBgSFav6VS+nxi7rK8To1sI4x7ydopKcNgLFJZB3X27lJqCtTd7NQV
         wzoecopKD726yrk77Mnx14+2EyvKPbz6Zf7B2sz2Z7HuOmmrbAeWFKe55y3u48e/+hyX
         BsohhHNKFVMeipbdBiZNDG7EogXjwZXoTtY7myZWugekXEj/1ozS2LW82aJI8P1rXddw
         Gwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=b7KISZY4KukTC/TCg7eHhPfhdrLrjFCxq5ZlewscCGbzVmtdtrEajF+G+ioOeemOcd
         vM/2I3TqaC/UFblrToRniQcYKg2kdAbDTUtBXkOrmLmUtBYJ64OhlIFNAdusvyvtSBSD
         frp15DZ7M2WmQtv14rZqo0Vrxo80/+MsnFiJvKfj1ILVLgbm7eiX7CJOax7bVl4x0PRp
         mRJeh+Qkb0PPDM+6atMP/k7oXuKMCiG6h86faWhZJKX9ELfin/wt6G03daqcfYU3TT3C
         hpOgI3Sqgs+8pTBaU0+7+9bmlM7dxrq/OPeylgBo+5CgfHHiQbn3+7qHuLsxeHQjZhjZ
         ZKww==
X-Gm-Message-State: ANhLgQ2yemu/uw+OMX19GTQhs/kvD3n45bPEHm4ns8QbHesVeg1022Qo
        O8rBETRjSjY6gbcUq0HIsJdKnIKzFRs=
X-Google-Smtp-Source: ADFU+vt71LrkRSMzxCIoPkaoBOOACxjN15QoBbVzam8LUQZNktZELWKtn3lpLjnGh6viJMYFrwKTUw==
X-Received: by 2002:adf:fc42:: with SMTP id e2mr1999357wrs.45.1585354330434;
        Fri, 27 Mar 2020 17:12:10 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7536.dip0.t-ipconnect.de. [91.63.117.54])
        by smtp.gmail.com with ESMTPSA id 61sm11237956wrn.82.2020.03.27.17.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:12:09 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 5/5] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Sat, 28 Mar 2020 01:11:54 +0100
Message-Id: <20200328001154.17313-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328001154.17313-1-sravanhome@gmail.com>
References: <20200328001154.17313-1-sravanhome@gmail.com>
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

