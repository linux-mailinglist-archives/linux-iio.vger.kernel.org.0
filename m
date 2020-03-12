Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9A183772
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCLR1S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 13:27:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41691 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCLR1R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 13:27:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14so8549710wrt.8;
        Thu, 12 Mar 2020 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KRSE02FZm7P6c8Anz7DXTPwgZAh3XR1PfKI0+YqCsH0=;
        b=qQQ1/YtRsH2+vLCwlAajQJMDrp3OULhLWCtX7IpMOgnFTwLtTXNSgfGYAhEFtOiZL2
         UjfMkU+J9uvd4uMsYq70mS9IbVjwU27S+X8RTEE9sy0d2hcIQueH2bGyhDAj2XPZRd5E
         1sAjq5z2Cd1WkdBN9q+hEKKFLgV5KwlNHjLfqxPSjXzm+eAV6Kdzjk17Si0u6xDDLRo7
         iX/Bmkmie+R5nR9kw+lirXhbPUa0wFLQgi0fp5q4itjZ0ROSwApdTecvkwyds2SRxXdx
         S3SVXpDM/TYdE8OL+ppmhmRSHk02v2+nwJ4zi98d/oYgbBzoZrG7ddLUAHafsPIzBnZ3
         JK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KRSE02FZm7P6c8Anz7DXTPwgZAh3XR1PfKI0+YqCsH0=;
        b=DggbD4epitbvS4S0WR+5RyrF8axcIf0vku5GsuLa2wS8FzwpJVhnCHa61lHscFjFAg
         kQurb8d4sFR7+xylJUxR/OnwRxV+29F3Lf37mkvXwsANlg01y1V6CJgsvnrS42sQdyFb
         PQiEVxxe2BBWbsluPBjiSQGdtpIGMJRVCBJoKo2LWhY7LS/jSylIzjYGfT5+8hvX+z3W
         x1ZNLt6ws9QLXLo0+/jHGhYuNQH/eIVUfnQD66iwxLZ4Oya3ReuOkZPbucNeImdLV0q8
         K5+kDBd8zM2byrS+IbXPUCGW4/oNvGO533HW51BVSOcoepRaH07mOjyuY0Qo5wchyrHJ
         CcJA==
X-Gm-Message-State: ANhLgQ2iOWIyX1P7LKk5PoTKBQGwzHjDnRJ3i/V9iC/3uwFN/415cBbA
        /A6vI0c6IVbJYRdWXW3K3Ng=
X-Google-Smtp-Source: ADFU+vtyIPEP5nNpgz4gNZUrnKE69622tnMXOM8gjU2WgftE1hbzMUd0a84T94iCL+m+jkbziJD95Q==
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr6181433wrs.263.1584034035519;
        Thu, 12 Mar 2020 10:27:15 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6C4B.dip0.t-ipconnect.de. [91.63.108.75])
        by smtp.gmail.com with ESMTPSA id c11sm76254500wrp.51.2020.03.12.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:27:14 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        fabrice.gasnier@st.com, beniamin.bia@analog.com,
        linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
        fabrizio.castro@bp.renesas.com, info@metux.net,
        hancock@sedsystems.ca, gregory.clement@bootlin.com,
        renatogeh@gmail.com, plr.vincent@gmail.com,
        miquel.raynal@bootlin.com, marcelo.schmitt1@gmail.com,
        paul@crapouillou.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 5/5] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Thu, 12 Mar 2020 18:26:49 +0100
Message-Id: <20200312172649.13702-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312172649.13702-1-sravanhome@gmail.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
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
index 58bb5c4753a8..5f803196d244 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11352,10 +11352,15 @@ F:	drivers/tty/mxser.*
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

