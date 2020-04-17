Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4B1AD90E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 10:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgDQIu4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729949AbgDQIu1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 04:50:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96465C061A0C;
        Fri, 17 Apr 2020 01:50:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so2092153wrs.9;
        Fri, 17 Apr 2020 01:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1xmMluktHzlM1NHImtN6fu8B+63KJSJdW/amOIZcZQ=;
        b=sJ4OMOgLzl0LD2rp3+h0uF22ob9fCFsZeGskB9gVeeCCvxJEyRplsDwqoRevOGWqve
         po32fK/b2jDw10opRqMsrgK68kUsCcepe0aMhIweZ0h8zXXN/uJFxX9zRhDlTyqTJsHN
         wqn9eoxfmmmOgNSn48O3TDdy18xhKK8CBtaueibg7mqcW7ptJhXZA7XIyVtF5JF15cPA
         wZILJMCo1D595AXJT+2cQnK084+T690u1FiNCN5z3ter9tlSqwTvuvrxTUKfYcH8DJZk
         c5A6xky0x2JglGBbPreiXrJft6kCF6k1U8en7VltMH4GvARrbuUn142d+4ROEiO9X2Bc
         6Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1xmMluktHzlM1NHImtN6fu8B+63KJSJdW/amOIZcZQ=;
        b=Iy618uItsScWh+s8A5Vx+tHelw7tfQ3pAy71frFFsOZ3pDbzBgYE5IKvsj9+3FTOOq
         wwD/uHZ9AltW1xHtf+CuO097mGU4DgwpBkK2qXzqwF627ixpk4+A0HxXlrw4+mm7J5+b
         MUZ9ejiA9wIqcjSP/sA7x6AWa534+EWo254YCzGinE8xq29glCzANOg2FYjyP4goVO3b
         rS8AUaRc99KwfDCmIieDZSgnFRSCeD0mavOnAVv3jurnInngPI8fIAmHjqjREcoJxvoY
         +7jsu2i0fr14n1Fk/JKtVhVK44khoCucp7+gr4GDGwr7PHRcvIaCu3K0A/20H6DTJKtN
         4s4Q==
X-Gm-Message-State: AGi0PuaPYskI8GOZEglGQGjbVN+0tZbP2dO1BeRT8yQigwc+Sv83rLiS
        Zu8gaNIq43GJ9VQ8BS1rOJI=
X-Google-Smtp-Source: APiQypJuv+sq0bF2eNkKo6NH7aK7IZZYZcqmgUTqDrAqE8NWB2MGlU5GlWDJBdXMNZmFD+sT//GZzw==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr2963313wrn.390.1587113426255;
        Fri, 17 Apr 2020 01:50:26 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7443.dip0.t-ipconnect.de. [91.63.116.67])
        by smtp.gmail.com with ESMTPSA id l5sm6807527wmi.22.2020.04.17.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:50:25 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v10 6/6] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Fri, 17 Apr 2020 10:50:03 +0200
Message-Id: <20200417085003.6124-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417085003.6124-1-sravanhome@gmail.com>
References: <20200417085003.6124-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mp2629 Charger driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

