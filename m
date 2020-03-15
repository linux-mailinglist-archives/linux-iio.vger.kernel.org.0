Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4CA185861
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 03:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgCOCFU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Mar 2020 22:05:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45900 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgCOCFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2020 22:05:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id e18so14764296ljn.12;
        Sat, 14 Mar 2020 19:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=OIJzVdRqmII3xpN14/wQN0Vvrs1lDoUVouTfyF1AzzfhS7PAX65NnJmEstFfAwHm0J
         MEdvf9urGT/J4thuvj9vk11uUp5M1ygunTCQ40PysktE5qk6p49gkKWkoPYa8hbxlpZ+
         8AHxeLhfVqkUX208e6r8trwKTkIzfc7jZVyFb0j7si5B/e5Q5XglfRDu7Lgva68dRazY
         t3ksP3zdoG8z1pawPZeocy0I+666FiKRbaFcF5tdQuT+avWEfO4hptk359IUQ52E/0AL
         Fyhc24SsfBPdJPaus75o3DysidczlxbECY0IAS4F8XJ5ZrpGp0mWMaE2ibqoijxKTHF0
         TMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=DvpDYDkZQW5E0JKHHq0vb4oxewJIyQvPWFfQMo/8bD8oXXLgOVOSOL+PE/lTjdehQr
         V4VC7LazQ5sJhE5W4SGYH3JG2I/FrUtNQYhUx2+C1ES/yF6QpNnwtNqwPutNBsNDn895
         p3iLvfFNIcFZS2wiM2eXa4dBPZGCoGkQp+cai4WlQGgxp0AktTpH120ACcDuk1pA/6/P
         x9SJl2sd/L1Yqkf5wqhujO85C9RBOQalq65EpFC5Uw0AJ5t5PcfYQj7p7JkDA4Xpdvnv
         vpWrQ0ycD3XETabaluWtpVuCxkf4yN53TgaW51Nut+4g6T5O730dosOfPqGFOUVkJ6OJ
         sHEg==
X-Gm-Message-State: ANhLgQ0stTElPSOqFS/HY90FHYnOFE+8kKoFTtPcOvZ8ZJLaVg7Iprs0
        KNhcM5G2lxsZvpyYguDvRqn/Rw7mxR4=
X-Google-Smtp-Source: ADFU+vsLbPyHg/3H2qHGT2azKEXr7tZwXNK8qhcJh9SO/kwPkfqvtObR5asqoXdlrz1UQKhDfB3WlA==
X-Received: by 2002:a5d:5290:: with SMTP id c16mr25043929wrv.235.1584230432390;
        Sat, 14 Mar 2020 17:00:32 -0700 (PDT)
Received: from localhost.localdomain (p5B3F731E.dip0.t-ipconnect.de. [91.63.115.30])
        by smtp.gmail.com with ESMTPSA id 7sm11394469wmf.20.2020.03.14.17.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 17:00:31 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 5/5] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Sun, 15 Mar 2020 01:00:13 +0100
Message-Id: <20200315000013.4440-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315000013.4440-1-sravanhome@gmail.com>
References: <20200315000013.4440-1-sravanhome@gmail.com>
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

