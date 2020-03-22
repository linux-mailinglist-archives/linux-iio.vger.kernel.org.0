Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8C18ECF2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgCVWag (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:30:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37016 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgCVWae (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:30:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so14682033wrm.4;
        Sun, 22 Mar 2020 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=iNlo842b2IZbB4k4GNg40U38B5BAXAYpbvKeEk7Dc/+bOAjMapsHryR3aodBMAu0cw
         EhX70aCHLZUKf86vdEDJn4JFhLVF2jntWk/OioFzw+qYk0hrnj5XNCraPCdso4646mcF
         jglG6rqrp0Aq1Oqnl7aNsiqiZGSc4c/o43i11Gj1zRCQi5S7eLbfX3hYpnVMePdh3AgH
         cIJLy+s08J2uO/rTN1btWrg9TCj6fthHcbyW+ackw+jRWPBetHTc0pDig4d3A0bgZrEL
         Ev6XinvZkDFEQq/CUCyjqNxCU+6DRvWHByc3cJSp3Rw+UtYv6/FFiFLeVcOgyLByp+bL
         sYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=pb8HVAAhl9uqmFGhLAW7M7hz1ehXY7NQtz6hSrsZ8uxP/5jMsJH4Sre4IVpYUbVcw5
         p4z60KlIEfYyiwiylUNvebB6Semu/2DWlPSg9EzXh1Pl7xtweIheysCT7gWTmYbvlEBT
         2WqnscZnLk9wCzAVY5MlDYET7S+7Dng7CRMt9zLtM7bwmyRvCdxkjcX3F9CAZNRW5n5y
         Jvvh+lOv8Y2bwIOJiSTKVXIkCu6xvHWaIa/dZkUr9QHo2SJ2LkXv/tm003z9HQilrX80
         7C35QNuVtatxGTLLezVgzYnW5xDfcAiJmc31K4q3gkncd80mtXVMq8hq8PRkLdPqwwEM
         wivw==
X-Gm-Message-State: ANhLgQ0e/MxTzPv5xNZes+tTMPP3Oz1X/WOHnAV2YMT2IzXlqYV87Ran
        jMYdC5xUPulUQxjikjb+FfQ=
X-Google-Smtp-Source: ADFU+vtdKjMEZ3M5NceBBY7KjXw4/hbXmYf/MhFtXlDNzKjzmO9VqLfZH/7KCuV2EVVjaBeh5Dls6w==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr27376880wrn.29.1584916231767;
        Sun, 22 Mar 2020 15:30:31 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id p13sm8060517wru.3.2020.03.22.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:30:31 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 5/5] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Sun, 22 Mar 2020 23:30:16 +0100
Message-Id: <20200322223016.11509-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322223016.11509-1-sravanhome@gmail.com>
References: <20200322223016.11509-1-sravanhome@gmail.com>
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

