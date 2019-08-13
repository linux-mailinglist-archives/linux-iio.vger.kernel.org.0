Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE18AF19
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 08:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfHMGCt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 02:02:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33100 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfHMGCs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2019 02:02:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so76019973lfc.0;
        Mon, 12 Aug 2019 23:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYs/TeSQkX85iQZMbtgHOzb7k5bWDJf7qaO4aRO65P0=;
        b=M0Hs00+YMfK0l3khXgXrzYl9SKLaT6Q5lrdR+7DP15Nf4FbrKIPIFckS75D1Kc+riF
         qZWC2qVQS2+q++e28SvQXtxmxcLi/WLSrk86ZdaomvHdwInB8Q59LA0xYASNGid65BM1
         Kf9fZ1IeVEdHWUbcjenv0wXLL7W8Kv1+chHrLrfZ/P36Sml4jDZZKcgCzIOBShKG26nA
         Ipx4TYsgNyyftBwGChK7LUX6vIjExPRXBLOYPnBj5sgXA4gv/N2n73Qk8ZdHjafW1bZ9
         fpCwbzXbOomn0/3cEkpAA//mjK120cX3fsDzd7BjlY3X7cuCuiUx7U2HRMuQueqkxC3m
         aibQ==
X-Gm-Message-State: APjAAAUyPOS3cLjv49nY3SDElOL8nyxsbhr7BrnzJldB8rDmDEzBsHjB
        vu6BQdk8bg2dKI1awEGVdP4jI9PH9is=
X-Google-Smtp-Source: APXvYqzsXx97aM7qAQVYx4w7Fvwbfj/KqihGRJoXPwAOcP9e69r6uUv1QAngcjZL6bwotd1iR301sQ==
X-Received: by 2002:a19:8586:: with SMTP id h128mr22421374lfd.62.1565676166636;
        Mon, 12 Aug 2019 23:02:46 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id e26sm21426667ljl.33.2019.08.12.23.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:02:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH] MAINTAINERS: ftm-quaddec: Fix typo in a filepath
Date:   Tue, 13 Aug 2019 09:02:34 +0300
Message-Id: <20190813060234.11940-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix typo (s/quadddec/quaddec/) in the path to the documentation.

Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Fixes: 517b2d045aeb ("MAINTAINERS: add counter/ftm-quaddec driver entry")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b4717ea2cfe..f31b852acdf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6321,7 +6321,7 @@ FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
+F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 F:	drivers/counter/ftm-quaddec.c
 
-- 
2.21.0

