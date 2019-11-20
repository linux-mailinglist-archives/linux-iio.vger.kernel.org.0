Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E81103DAF
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfKTOtb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40148 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfKTOtb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id q15so99851wrw.7;
        Wed, 20 Nov 2019 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztGpHglCy1aKGdb4ZiLGlUvE1egif9nfiCGe0G8RTOg=;
        b=HnBsOQHcmy4vcrGpS/FMwlS1MBKtzsNw3X2VWNEDxtBEs5glgXLVrJigpFmRs5QxfB
         5vf0VKTtlupGmOcANVFTcP4UagTnTluSdMmE8o6ce8ZQgHNC3rcxZkyQgicz7rkrrPnl
         K+qtuPT3MZmn9rLehplw6CFIfuaLtykZpvGoe5QmVQxj8gkItBOqZY2jpaxyXN+CAa0l
         tpfex1KtdQvaRUiM/KN9zOPhDn6PeWJwr7zMnGllR4eq196enSSXpx8ZUABj882SM4sZ
         RqIOg51rHVuYnp3O4KHArnLHPXte1J8rcwso+FuxX3T364AMaRe6hZ6BgFX+N84KDH5I
         5AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztGpHglCy1aKGdb4ZiLGlUvE1egif9nfiCGe0G8RTOg=;
        b=HMdQc7on7zsDHdjwrXQNbONHI912pO3770VTehSeS6MkT3GizIPFebabCnxwnzttUt
         SH2bAVJCQI0o5RUW603XG/qvY3CpqFotC5HGQ+vB62KpYjqWDOTTs35Uekb+/cvImAUI
         KvNF/Qp6B5IzEuzM3LgiyNx39Ehe1U5Ek/+V3dRZWzhmJ4KNc9CVcufF4zujmRVpEBRl
         lvnRdnnJRazw44EQD8yT3ReVcxByNf0X0aT4LXGtj+noLdUz4Fi1xkwkpL4reRiY1xg3
         MxWid+TllhVH6zxv+KzacUcz0jOPGiSKJkuIJ8EXjvm45wAuEulkxEytx9y0yzzc8qZn
         bvWA==
X-Gm-Message-State: APjAAAUDJD44WlUdNBugBNdKU5dJMi6nJT74oBxYic185IX14h79okko
        xaVcp9VFnMoGHu9HevjaJ1c=
X-Google-Smtp-Source: APXvYqx/ox+sabVqmKDxnF4qeAAGRMVmMmZmHlVXcUImDFrfRFJDGQl/0/ZG2AjDSdBsI0NRlwwnZg==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr4018601wrn.256.1574261368790;
        Wed, 20 Nov 2019 06:49:28 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:28 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [v3 9/9] dt-bindings: iio: maxim_thermocouple: document new 'compatible' strings
Date:   Wed, 20 Nov 2019 15:47:56 +0100
Message-Id: <20191120144756.28424-10-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now the maxim_thermocouple has new, more specific, 'compatible' strings for
better distinguish the various supported chips.

This patch updates the DT bindings documentation accordingly

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/temperature/maxim_thermocouple.txt        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
index 28bc5c4d965b..bb85cd0e039c 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
@@ -5,7 +5,10 @@ Maxim thermocouple support
 
 Required properties:
 
-	- compatible: must be "maxim,max31855" or "maxim,max6675"
+	- compatible: must be "maxim,max6675" or one of the following:
+	   "maxim,max31855k", "maxim,max31855j", "maxim,max31855n",
+	   "maxim,max31855s", "maxim,max31855t", "maxim,max31855e",
+	   "maxim,max31855r"; the generic "max,max31855" is deprecated.
 	- reg: SPI chip select number for the device
 	- spi-max-frequency: must be 4300000
 	- spi-cpha: must be defined for max6675 to enable SPI mode 1
@@ -15,7 +18,7 @@ Required properties:
 Example:
 
 	max31855@0 {
-		compatible = "maxim,max31855";
+		compatible = "maxim,max31855k";
 		reg = <0>;
 		spi-max-frequency = <4300000>;
 	};
-- 
2.17.1

