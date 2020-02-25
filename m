Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7156816E933
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 16:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgBYPBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 10:01:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52276 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgBYPBH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 10:01:07 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so1356501pjb.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2020 07:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=dDJ+ophuc0rsonzeLWDePL6AJkh0L49xgiit/I70EsU=;
        b=ZcQ8Hqr7ZPm4BdeF8bgpagl9fX5jrXAu1VyacBxBaKVwYGbxWu8wrzSyy2+p3O2+/h
         Dy5jpx1QQ65/OdejJqFxcoV91xUS2+4LHFboSaXqmOOZiJwP7jyTUU3E3dIE0TstLtgf
         0HaERYqB38XOM6y5D2EJxxsdZgs7TU7LREWNYOcTkLUJiTxqMHUfe4cSj5oOO6i4xCue
         rTlT9M/7lGMq/Ygh8tQgTizCo+G8+f+LygD8H/8OgLyGBNw0MlzYYLGOWmvEhsB4JE0G
         l4ZXaxUiae5lM6WGuHffUoC9ZUTptoKHU34mT7zvVRC3lIFlzofh+Y59No8YW9S+w/g6
         m00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=dDJ+ophuc0rsonzeLWDePL6AJkh0L49xgiit/I70EsU=;
        b=NBRSePHpeGyKsyivubTvRFKySZiLDFdEyT1plXY6RtO4QYcOjZL6wmdjXSCmzDh/yJ
         qSmvigKfreuwZ2stxA6JQRHtasfzJgg1PVOGPAyeY86MKbfZKcknUCLNsFS2oN5xvANx
         V6zQe7VzalJ8uKi9lD51XRTyeVzzrcIrmewaF7SbBycCGFC+csQGxxQ7vCar3PE2EqcW
         i/xhJT8SAEdmr5b3/k0fgdu8uKbVXcDfd9p9ePfAEKLIKTREn3W58rMlxbkzhRnQdaAW
         Ko1pcfc2cA7D7TV/MGAMeXgZ1iPT3OqdTBhiA4mW6/bk6zqq5tlzJYo2kGIky16raZQx
         nVYA==
X-Gm-Message-State: APjAAAWwfU0e1CNKBmpLqLzhKQ6FxneiuaX8LdwYOhGnOud4lgUBifOC
        rP0QlapmCRu7nDpAz1emMMA=
X-Google-Smtp-Source: APXvYqzgTiN/EmB7DNtu2m2mWEGUraVUqdhRA0AV2wGjtrcrTyN+W4cla+Lubkv9BE44e2ZmJZNLZw==
X-Received: by 2002:a17:90a:234f:: with SMTP id f73mr5520424pje.109.1582642866596;
        Tue, 25 Feb 2020 07:01:06 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id a9sm17120716pfo.35.2020.02.25.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 07:01:05 -0800 (PST)
Message-ID: <5e5536b1.1c69fb81.5f37a.daf6@mx.google.com>
X-Google-Original-Message-ID: <20200225150102.GA20845@rohitsarkar5398@gmail.com>
Date:   Tue, 25 Feb 2020 20:31:02 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v2] staging: iio: update TODO
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since there are no uses of the old GPIO API, remove the item from the
TODO and some new items.

Changes from v1:
Add work item mentioned by Alexandru in https://marc.info/?l=linux-iio&m=158261515624212&w=2

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/iio/TODO | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 1b8ebf2c1b69..e54510c2ef5f 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -1,11 +1,17 @@
-2018-04-15
+2020-02-25
 
-All affected drivers:
-Convert all uses of the old GPIO API from <linux/gpio.h> to the
-GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
-lines from device tree, ACPI or board files, board files should
-use <linux/gpio/machine.h>.
+- Documentation
+  - Binding docs for devices that are obviously used via device tree
+  - Yaml conversions for abandoned drivers
+  - ABI Documentation
+  - Audit driviers/iio/staging/Documentation
 
+- Replace iio_dev->mlock by either a local lock or use iio_claim_direct.
+  (Requires analysis of the purpose of the lock.)
+
+- Converting drivers from device tree centric to more generic property handlers
+  Refactor old platform_data constructs from drivers and convert it to state
+  struct and using property handlers and readers.
 
 ADI Drivers:
 CC the device-drivers-devel@blackfin.uclinux.org mailing list when
-- 
2.23.0.385.gbc12974a89

