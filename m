Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B5196D5D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgC2Mb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 08:31:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43400 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgC2Mb0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 08:31:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id m11so11678783wrx.10;
        Sun, 29 Mar 2020 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=NYHCJt3Ku9FOElSWdLyvILotVUQ7ZCoGExqhh1hga+Ilrw7vDZuekdpSow5u1b/pUU
         WgkjB4wm5XfHB8qAAuhtzCgyzrKGEcT2iwCxqrgyoHFWFOuvOLRrWuBWIMdsDniv9/Ln
         WCIlkU8kF+wP8dOWqMgEA0uRysKESLErcTVJcxxNZgB9HtdvB5nULiIpKerjEGieIkIO
         5GiJ7vUMwLEdnHa+Kivz0wYNBzfwpBLqKWWEZIjyFKhlntgewA7hOe/1QP/w2mmq26cy
         GI/HFZj1yVjCuuf2vofTkK76RaugXKgYPbbIsW6M3D8GhqL/uA7wY6g8/TTCyUPRKJ5C
         S3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=FXMpYTAmZMokSy4WnEwnyWHprRFfoOero4rPuOMRjNFJ1+7s9bTjxiqQyQhqddMPaA
         LWjQfXwyMgiX+CtDQ45BNGTXgbf+IKBrwensyIP1sR6l6Flg+ntsV7nRuP4hVAf9kOyu
         2VwgJiE5eXNB14v71EhxEwB3IuQkHZJVo5l5z65jPemOVyoR3LLBrHL9uvv/+vhhXRFW
         rEdHIkmpKpZb0wke/yrT/ugaMH3l6PCqj9rTPmsMu0zZCFYI6GZoJZAqJqjZi7lj3ddt
         p0YyPoFzRH/WCJhZGrPb/YU212UvABHGW1bUgI1PIzGwoRRpQHa6hb6oHkvI/HGkA6NJ
         xA7A==
X-Gm-Message-State: ANhLgQ3Fmgg95W42ghMZJL5r2efjL8TUuebHL0kz+5uOVztIk0TYajTy
        r8OU1zV7v05cwzOKPQQiMvw=
X-Google-Smtp-Source: ADFU+vsqYKxoPbkbC9jA9HPJE9a9Nl32Esg9+w5puOxENCLxVc7vGrEBRwu4U9NAk5FO57lzaIepTw==
X-Received: by 2002:adf:fc4c:: with SMTP id e12mr9500732wrs.265.1585485083974;
        Sun, 29 Mar 2020 05:31:23 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6BD9.dip0.t-ipconnect.de. [91.63.107.217])
        by smtp.gmail.com with ESMTPSA id f9sm17259108wrc.71.2020.03.29.05.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 05:31:23 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 5/5] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Sun, 29 Mar 2020 14:31:10 +0200
Message-Id: <20200329123110.26482-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329123110.26482-1-sravanhome@gmail.com>
References: <20200329123110.26482-1-sravanhome@gmail.com>
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

