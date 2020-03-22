Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2025218ED1F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgCVWqn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:46:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgCVWqm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:46:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so14702951wrv.5;
        Sun, 22 Mar 2020 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=HIr4scsd5CyEHBoqj1U5s520InaNnU6ukkhaIeFvp/H4MXzlrxKHL7C+z676GpP4+k
         zQ7HMfbZW1cjxYHAs2V/WWYabNTwpjYRCzkfnWtN6C8AHyKxQjozli8Q20eN4lPQyrLR
         XcmRb5Dcixl5lgVQ7ayeCPrL83hBIZAjEzNLF8LcHiwigfpXpfUqtPUzMt8qzBmov50K
         NLBmmvPN6M5v5m74HdpSdVeSCW6w+rvLu7RaWAN9kvVRoEAD4rcB36jVJUfraGS71ciX
         0EInl/B9hHDS77jnW3kTA2W2xsaZIhuu1pBRJlpvpJ3qinvRsPeCyGq9sGpzpe9DGceR
         LOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6QvXfJZlpggMK4ANi6m9pBKzrWALkcbq78l8N8OifPg=;
        b=F+p2m2kJeZwW59fcdaopwqx5/7ru58vzBoB+j8qjB716EFJ1SviFg/rlD1Nm4IwnDG
         fxxVQOXAy6K6fYp06nd/hZElIS7RgzicwCgmJZK1KmBvnsf8ZIQ9LfBqJnGjQW+WnkHb
         TERTBRfxg4pc7Uz05aAtJ6In39m6WahcH4u5rWtD17nHY/RTQBFhxQ7K7ohtAR+hpt5U
         8ysM7n1zh6Vez3F+Yl6gfaOMrW+aGJmWdcXQsKyOfJH/wdzojmrK/OgvfGFN5diF31Lu
         PZXftuLcM1wNUTPZuplQSPhvfT0VCJN9yVF+4MIztrh9nFmVCFijXrx9F3bCuwaCOwNZ
         uWVQ==
X-Gm-Message-State: ANhLgQ30L9x5Z+ZC/E/SD40fa6a2Bzpi597ayadNo/HSH1YovftSQE2b
        thPKdHkYs8twc28p8kCZPHE=
X-Google-Smtp-Source: ADFU+vtC61VOoEmFTPzpk2jh6z2sJXWYoQ7hNyHjcRLmkgxTZQ/sfrLGUtTaPogC6cRtvvBCIdQmpg==
X-Received: by 2002:adf:b31d:: with SMTP id j29mr11690199wrd.218.1584917200180;
        Sun, 22 Mar 2020 15:46:40 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id r9sm19158549wma.47.2020.03.22.15.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:46:39 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 5/5] MAINTAINERS: Add entry for mp2629 Battery Charger driver
Date:   Sun, 22 Mar 2020 23:46:26 +0100
Message-Id: <20200322224626.13160-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322224626.13160-1-sravanhome@gmail.com>
References: <20200322224626.13160-1-sravanhome@gmail.com>
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

