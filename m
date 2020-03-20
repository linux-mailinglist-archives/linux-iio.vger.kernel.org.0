Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3318C8D5
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 09:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCTINE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 04:13:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43351 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCTINE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 04:13:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id f206so2834757pfa.10;
        Fri, 20 Mar 2020 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CrN447fN6LzaqaN5HpxD6vw53ZOseuY+17TDGInnXvc=;
        b=M9i9fAcqigJkKUlI5cmiQxlGwMl9+F/aX1FUFDDo/m3jmMBLEbA6HXxswaozU5ABew
         hVGdKZweFszsrshvBzYXOfaD7O3aPhBrV0F9DNJy0SV30x/2QCZPR6IX/qcNrq8MF0yH
         tAp03NrPKVBp6kU7CWAb0AF7yx4TJEoGckLyiek1wERVpW6nA2mrmbgu6EtVSpoGPV5r
         vIiHzsvwTVNuka8NjCYj7DJdzEJWjI4wB8InigEhesC6NztNZAeHCIJyPkX4Q8XmhA66
         WO0u3Hw8eDd4ZezNmqMzB9wMB5i1Fl33tFZP/aRKL5DHYK6kFWCJT+jLfLOkCNQVsa7v
         wAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CrN447fN6LzaqaN5HpxD6vw53ZOseuY+17TDGInnXvc=;
        b=WyKPHfwGvMgrrsiTd9IlGUPT3SE9cI6V6ShtjVIY0Knf5jQkZqhdU3pbv3ZB5SxWtU
         mhyjlcroP5XZcyjoSUepYlA1m6rs4x13QJh2qafGWCbP7dCoylqsrIGL9d4grqsQ2EvX
         nnuEnIqh8jEfMx7yNozYy3rGdvtDaLIeUBcZgP80FpjWO4cdh8V4yU0nDvc93tu3pbTU
         hDhOuCfCL9JA+0+6FsX5VTNb7shDAvsMIoXrSCNQwXol+VTKWeT4CNz6Tpesewnbrh7X
         tEYp79CLL94W/0agXhtFCA5n7ZYkFWYpBTB//Sta94hnOP70jDl2UZiSBpa09qFBhn/6
         WtCg==
X-Gm-Message-State: ANhLgQ1BO2/Bnwk4xOgYRwFPXgokD3fMukIVxqlKWfqqf39A/H3ST4pU
        IyHRG0C+x4kHFIyE3YIbdM4=
X-Google-Smtp-Source: ADFU+vsY+zmqe13rR4x20zpyrk+4GMQrQZKJomgIMTnkHCJVUAUaq5FmwHGppwwHqCyIrpfGhFS4Eg==
X-Received: by 2002:a65:44c1:: with SMTP id g1mr7556161pgs.362.1584691983391;
        Fri, 20 Mar 2020 01:13:03 -0700 (PDT)
Received: from syed.domain.name ([103.201.127.92])
        by smtp.gmail.com with ESMTPSA id h26sm4665329pfr.134.2020.03.20.01.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2020 01:13:03 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:42:58 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     jic23@kernel.org
Cc:     vilhelm.gray@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] MAINTAINERS: Add Syed Nayyar Waris to ACCES 104-QUAD-8
 driver
Message-ID: <20200320081257.GA5818@syed.domain.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Syed Nayyar Waris as a co-maintainer for the ACCES 104-QUAD-8
counter driver.

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fa40c3..55c7794 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -276,6 +276,7 @@ F:	drivers/gpio/gpio-104-idio-16.c
 
 ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
+M:	Syed Nayyar Waris <syednwaris@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
-- 
2.7.4

