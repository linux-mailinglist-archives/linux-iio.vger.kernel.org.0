Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53635B26BD
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbfIMUgd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 16:36:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388167AbfIMUgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 16:36:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id r12so18838235pfh.1;
        Fri, 13 Sep 2019 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Z0dOj7erolHZiw1ueP8ahOWvD/RxOwlZu4iI2DGsYgY=;
        b=JePFpv4jtqm3k75bUAhPaPeBOwPkjKb3EuMgifyS9dp25EFyVs80DCTRNwV71LN8JG
         q0HGjOttvImzdDcFSWsc3m3WRBF1Zuzsh3rf6fvIc9JA3STlrLCw/SbYb7GlNlsD0uAG
         pmtv2LqXsvijDvTfM7RnMcO/dcBPqAQEADVflXWerp9hLIPenzIMUMdiyoVlt8bazfMI
         pAH5O49V9Qqp/scpI+Ie50M4p3TCVeMtdph0WSJfYtrfvkwXlwM1YBkpOuNTUDrGWR67
         VJRFRWj/oPnnCdHoGQboYS4BfBd8KpMD9prEqCpFBJTtGSLFswCb8ayr//NRy7i1GfmS
         RAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z0dOj7erolHZiw1ueP8ahOWvD/RxOwlZu4iI2DGsYgY=;
        b=KttOUdmuVv74NZSH6HW4qPr6TWP1w/Ad+4FFCFszMZjCUnu8kbhujzhMoNDqo5+K7P
         r6fLy0LuNmS8GBw0rBqf5cNOkA0NmJLGQKasa5YKcd00B8mI7gIrX4WboHQWbTKK9mj3
         SSjTI8BstCKm/mux+/wSGocmbQUs05vtiKtkpfkgYZoW6mQ/xipoggXdwxUZf6NbyXmi
         QOjo7HyFHDP2Y0/qCfSRp+8Ejhsr5o+P+flqDHE4xsewoF712e9CPHyVbHg1IN7x5Hu/
         1/l1cdMFYD2bY68ymGKr5rgQBfQmbK7ar3EORoOcQVC0BA4UO1wSWJb7duFIwTDb0dh2
         itSQ==
X-Gm-Message-State: APjAAAWhq0AJGHSo91Hh3ueo9/bN5uZTzVZA47FhQuAS7s2OgtvGOeKb
        4HjldWJiFHP+m6tT8MHqrVM=
X-Google-Smtp-Source: APXvYqzbYlUr99W7oZuQgWRIU0dwuUdr89WZOpA54Xc4iE0OSywy0WJV9EA3/sI4FKC424tlR62nRw==
X-Received: by 2002:aa7:8dcf:: with SMTP id j15mr48595781pfr.5.1568406992288;
        Fri, 13 Sep 2019 13:36:32 -0700 (PDT)
Received: from SARKAR ([1.186.12.73])
        by smtp.gmail.com with ESMTPSA id u9sm30215333pfn.29.2019.09.13.13.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:36:31 -0700 (PDT)
Date:   Sat, 14 Sep 2019 02:06:27 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        gregkh@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>,
        rohitsarkar5398@gmail.com
Subject: [PATCH] staging: iio: ADIS16240: Remove unused include
Message-ID: <20190913203627.GA1320@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Bcc: 
Subject: [PATCH] staging: iio: adis16240: remove unused include
Reply-To: 

'#include<linux/gpio.h>' isn't being used anywhere. Remove it.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 82099db4bf0c..a480409090c0 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -7,7 +7,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-- 
2.17.1

