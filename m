Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1564CB0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfGJTWe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 15:22:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39709 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfGJTWd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2019 15:22:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so3230488ljh.6;
        Wed, 10 Jul 2019 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGcv9mcQt15OKP2ZEu09JZzCQ/XGig1FQYgLetE/8xA=;
        b=ZzeJW1PJUKth0voeUgOV0grdDYJiJl9rzgRuVsTsVY/0zHthn/b5P3+GjkxprP/5cc
         nsyBdbuqWVgiCLQhMGzB49INs8JHWayubzmHsCNP+U6x3Q8HLnAZ8s8e9noK/SVbuLQ6
         8ShY79DDL2oL1MKHs8ztPJcsjDexHaVzycGzEjkd+BOtUXuCn2sQpAXpyGbiCHFk2S2D
         2LvBbn4SBWpiLQqrIClQdbIn16XtzSuIhVjKUwcg5v61denofPV+JTNfan04JDUTnoYx
         T7gkKAIsffoD2TSyYKoqv59lUQx+WonWZZc68TMgBdhZyPj04SiZ5vuX6zd91THxcMje
         vnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGcv9mcQt15OKP2ZEu09JZzCQ/XGig1FQYgLetE/8xA=;
        b=hafuT4yA8PK350DX/6bVb4U9TRf0oxHaafKBWTpqEtZ0vTsB2akAmXZpA8kjrguJbS
         wemNr3HLH91qGRNliuTYDEok9d6vMOwZVFIjomtONc1Teg2pJQAtqQ5qCQHEoqEClLwe
         X0/rGjtimJ1knhD7GD37LuLD2Bz9uuhJerDj9h8bM4673a04VBQ1NJs3X4wPDBT2afIN
         q35R5KuR/aZlI5GLtPD1BCxGzO3zsxflRLrxRQDUcOaMSQ2IVZyvUTZa6K2pYY3U63FG
         IAgONrhM1Xm05bnOjjaf9PzL7Txo4xPZu3m5TbnXg5cgor6trX5JPanD0d5YvwyGRrcx
         CByA==
X-Gm-Message-State: APjAAAWqJEBVMN4AZzennbKDnwnlt6Hu0odo6Jr54USy9zSn8yPMIciB
        mYSGEWaxneKx+mEBykUj2OCkaVKfTc8=
X-Google-Smtp-Source: APXvYqymZd17Nknw20aGdU5Tfa+nKhRr2RcSQr4gpXh3XmnaL51jsFR2D/nFQyRgAUptPciSlA6Zbw==
X-Received: by 2002:a2e:8602:: with SMTP id a2mr17767251lji.206.1562786550554;
        Wed, 10 Jul 2019 12:22:30 -0700 (PDT)
Received: from arch.lan (89-70-29-67.dynamic.chello.pl. [89.70.29.67])
        by smtp.gmail.com with ESMTPSA id a70sm603515ljf.57.2019.07.10.12.22.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:22:29 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: add entry for plantower pms7003 driver
Date:   Wed, 10 Jul 2019 21:21:55 +0200
Message-Id: <20190710192155.11489-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710192155.11489-1-tduszyns@gmail.com>
References: <20190710192155.11489-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add myself as a plantower pms7003 driver maintainer.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad498428b38c..771de33ef737 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12548,6 +12548,12 @@ F:	drivers/i2c/busses/i2c-puv3.c
 F:	drivers/video/fbdev/fb-puv3.c
 F:	drivers/rtc/rtc-puv3.c
 
+PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
+M:	Tomasz Duszynski <tduszyns@gmail.com>
+S:	Maintained
+F:	drivers/iio/chemical/pms7003.c
+F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
+
 PMBUS HARDWARE MONITORING DRIVERS
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.22.0

