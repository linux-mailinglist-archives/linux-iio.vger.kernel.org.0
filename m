Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88770DCCCE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502437AbfJRR3N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 13:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26827 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406251AbfJRR3N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 13:29:13 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C35AC05AA6F
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2019 17:29:13 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id z21so6547042qtq.21
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2019 10:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2oj75l9QzVi3O8swsxVYBJiXU84Ws6wegO8SmVESxbQ=;
        b=kQU4MUswN38VhKm9Xp7n0t9Rjh8MVEZVHIdR5R28FNZitx+89+LgzaZyPfa/YfRK3f
         4k3HvguO88a9zfTmupRsBTI9qmDYsT0oXC8oHOZHaZxZSAGaWDpr1V/VJYXKXcdGkqSS
         HioYiw6DJhjMC0EYgCETWIGMyTBKlP3q1c5PtlkJ/pgr1H0zjklTUwTPy4jQtWJq6BJD
         Dc/NpKpDerdiuaqBHCEJsYSkEzIrzF0eUOzXB3dhorpdEI36eD5jhKSnPL6FUGaY1oai
         OyS8jO0H4Uhl1t+KYU3sHB9ihkY72Nc8ZzAY5/o3zsRVuTjd6CtvMBTeUnppbkrctx2x
         OZ2g==
X-Gm-Message-State: APjAAAWb6ssw6XF7xgMm/AWHAabJg9M0mzGIITeQfV13zTNPrh8IagK3
        MUapfIWhzLz8+eii4e8yBn6Eise0qz2SbANvsB8st7tKZEVGG8diuiyo3rSpdOB5pckEf0+1fq3
        2TltA6r72KcIoIj/JMY3k
X-Received: by 2002:ac8:70ce:: with SMTP id g14mr10793086qtp.215.1571419752217;
        Fri, 18 Oct 2019 10:29:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfDp1Xn2DKDFOFHm9+c+k6Z7LtK3Pq8ebJ45zwI0obsNiJa/TYKBH4+5c+1bVr1cSveoWwKg==
X-Received: by 2002:ac8:70ce:: with SMTP id g14mr10793054qtp.215.1571419751848;
        Fri, 18 Oct 2019 10:29:11 -0700 (PDT)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id a15sm2798852qkn.134.2019.10.18.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:29:11 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] tools: iio: Correctly add make dependency for iio_utils
Date:   Fri, 18 Oct 2019 13:29:08 -0400
Message-Id: <20191018172908.3761-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

iio tools fail to build correctly with make parallelization:

$ make -s -j24
fixdep: error opening depfile: ./.iio_utils.o.d: No such file or directory
make[1]: *** [/home/labbott/linux_upstream/tools/build/Makefile.build:96: iio_utils.o] Error 2
make: *** [Makefile:43: iio_event_monitor-in.o] Error 2
make: *** Waiting for unfinished jobs....

This is because iio_utils.o is used across multiple targets.
Fix this by making iio_utils.o a proper dependency.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I realize that we don't really need the parallelization for tools
because it's so small but when building with the distro we want to use
the same make command and -j wherever possible.

This same issue also appears in the gpio tools so if this looks like an
okay approach I'll fix it there as well.
---
 tools/iio/Build    |  1 +
 tools/iio/Makefile | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/iio/Build b/tools/iio/Build
index f74cbda64710..8d0f3af3723f 100644
--- a/tools/iio/Build
+++ b/tools/iio/Build
@@ -1,3 +1,4 @@
+iio_utils-y += iio_utils.o
 lsiio-y += lsiio.o iio_utils.o
 iio_event_monitor-y += iio_event_monitor.o iio_utils.o
 iio_generic_buffer-y += iio_generic_buffer.o iio_utils.o
diff --git a/tools/iio/Makefile b/tools/iio/Makefile
index e22378dba244..3de763d9ab70 100644
--- a/tools/iio/Makefile
+++ b/tools/iio/Makefile
@@ -32,20 +32,24 @@ $(OUTPUT)include/linux/iio: ../../include/uapi/linux/iio
 
 prepare: $(OUTPUT)include/linux/iio
 
+IIO_UTILS_IN := $(OUTPUT)iio_utils-in.o
+$(IIO_UTILS_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=iio_utils
+
 LSIIO_IN := $(OUTPUT)lsiio-in.o
-$(LSIIO_IN): prepare FORCE
+$(LSIIO_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
 	$(Q)$(MAKE) $(build)=lsiio
 $(OUTPUT)lsiio: $(LSIIO_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
 IIO_EVENT_MONITOR_IN := $(OUTPUT)iio_event_monitor-in.o
-$(IIO_EVENT_MONITOR_IN): prepare FORCE
+$(IIO_EVENT_MONITOR_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
 	$(Q)$(MAKE) $(build)=iio_event_monitor
 $(OUTPUT)iio_event_monitor: $(IIO_EVENT_MONITOR_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
 IIO_GENERIC_BUFFER_IN := $(OUTPUT)iio_generic_buffer-in.o
-$(IIO_GENERIC_BUFFER_IN): prepare FORCE
+$(IIO_GENERIC_BUFFER_IN): prepare FORCE $(OUTPUT)iio_utils-in.o
 	$(Q)$(MAKE) $(build)=iio_generic_buffer
 $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
-- 
2.21.0

