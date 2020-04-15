Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F331AADCC
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415593AbgDOQUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 12:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415581AbgDOQUs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 12:20:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D9FC061A0F;
        Wed, 15 Apr 2020 09:20:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so599720wrp.3;
        Wed, 15 Apr 2020 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=EP84ogsh9NDfuDeE3+br9QlLD4Ex+blgDu0bl4JdBBHijrvMwx5Ayx/lPq1UAL5HkP
         2iSzrh/x+r7yzQ1U7l/AKcTZ43apbQd3njUyoO2GRcPEGUig69BWCbdqxCx3bs2Qxvnr
         lG4EE1ojjT+tMWb7o76l9kk1lkJbfiNaJQVzZKTFO/HYFOOoqXpaTA2SJGW6FVL3z0EG
         4puC9NsOetsqDZ24YZArV7JkLS5GtldAWsfVkMyTLcv2/nOy+roSyHFSR8k13eLjP6ru
         AB756opL2neDY1SHhJ3ByHiVjyUJnldUPor22kbx3Vqmv0a49eHK2hx1+3hhDUsgLBM9
         hmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=dpbiHl15dkm2CQFCCpvEqXFEBhVnf14tB5qjuFLDSDMgkKyluCmUZnQ6UaPOmRbyb1
         9HLzFo4kecUdvlUMvcO0YnqZtenXtZ3joglfsUbQKUUV7Ttp5/iVuRJ90UM02oCslXfA
         Yf3Dyu30Kjn15JgNVzb6d47hRDSqzVUIiMtTAc6EMRIaEd3EsYpCq3vNPm/qr16IQmu/
         RrJ2dVeRGjJZY9CbQs2aPa4z2n5RjdoqiRSEc5dHX7btgn4LV++gntKkg3ZExp3BE/Af
         WwkPRWdYfXMfr2RYYVbvSpEeY3+CXbU5m50FmRZfiszffySiHTAcL3mBlXF68nlknQJf
         M/vQ==
X-Gm-Message-State: AGi0Puaxl3L9gCzMZxC5MvzRUjzXqzMZ30ueyp7/ojMOUqAlPFWwybws
        EPo3yMywfIfirirP1AgMM0U=
X-Google-Smtp-Source: APiQypKL0zfT975PKTD7SEXe+SHz+UWGx2gUY//ZiH52Ft9oqq66VmUYnhmuvVWOGYGTFrF1iwr8rQ==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr31592637wrj.419.1586967646072;
        Wed, 15 Apr 2020 09:20:46 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6CCC.dip0.t-ipconnect.de. [91.63.108.204])
        by smtp.gmail.com with ESMTPSA id 17sm102526wmo.2.2020.04.15.09.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:20:45 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v9 6/6] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Wed, 15 Apr 2020 18:20:30 +0200
Message-Id: <20200415162030.16414-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415162030.16414-1-sravanhome@gmail.com>
References: <20200415162030.16414-1-sravanhome@gmail.com>
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

