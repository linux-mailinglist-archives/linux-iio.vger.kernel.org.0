Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D625B40BE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfIPTBK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 15:01:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43464 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTBJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 15:01:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id u3so796384lfl.10;
        Mon, 16 Sep 2019 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2qEccuK5M0KaH9plkbZML+GYrMGeAxlIfBWhOFICTs=;
        b=R9jk8HNGUF1B1xokpI6pOJu72n/BjXgo8Svaaslkju05WtSqxhkqLjYno7HaS3B0Ln
         ezNFYvl10xAPTQpgL8/WmMcCYgVeJyDzgS6qhKgb7RAf9qdvsPnSU4djUo5iw/iwelwv
         u2N09LuAq/vy8Ts48pnABo3oja+IR+PQnfhRKfNa7eJdHkHPntpK80s4hbs1v2Sr7Yld
         AP9U38wmayYYts57xG1Z9FEcAGBIugGZ0Rcuy9VVmCNYz9Nd6IM7t5n4knVKFAY8QYhW
         Y/MrPjugZ1vmFFzjzvQHTQF1PrPJWXmcegzv56NBgvAq8zjWdZkQL54hYPMdBetkd7is
         8WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2qEccuK5M0KaH9plkbZML+GYrMGeAxlIfBWhOFICTs=;
        b=GkJgygKboCdqlaE3JcNXcqS4npCPqphxsdwloI53ocjaPzzcYOBwGZGUMmqzNzf65x
         FU3lgQSykkFSdCiQ5/LNP3KuRR0+7SwcLFRGPp4zHBsPxgX3tEQlFFw19wQBptvmRv7+
         hERS9EGthEaSDvoG3KtQc4kRTJhm3kVVlL3lcnybiLFi2qtV74Od7BP0V6VFuv1+ZwNw
         sZJq0Ryk08Cps0+31UC5fkUSRpSJ4dtnAqPiy9pk3Mev9hXoPHLdZVk91DitwlNhpJGQ
         W+1hL5KL1C+/zZCx82tDVk8awAkqxbtCRWnBuFNQc+PJt8ShaB8LLxIF2b3wgl2rn8Ei
         fqMA==
X-Gm-Message-State: APjAAAWHghM9LWSLaH574flSnl47snMTKSwTFg1PxNFIO6AW8TNBBRPP
        2lyzIfNuKwD/bgkNvTBkaiEAKzoopyXQIA==
X-Google-Smtp-Source: APXvYqxC7lPyWDsE2FiRJETKwl4ssw78oh+b7m3LidNF7YQupn5sqcpmQ4S2mH3sZ2gOu43WSUsODw==
X-Received: by 2002:ac2:4853:: with SMTP id 19mr475207lfy.69.1568660466662;
        Mon, 16 Sep 2019 12:01:06 -0700 (PDT)
Received: from arch.lan (89-70-31-203.dynamic.chello.pl. [89.70.31.203])
        by smtp.gmail.com with ESMTPSA id z9sm8414053ljn.78.2019.09.16.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:01:06 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: add entry for ROHM BH1750 driver
Date:   Mon, 16 Sep 2019 21:00:24 +0200
Message-Id: <20190916190024.9955-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916190024.9955-1-tduszyns@gmail.com>
References: <20190916190024.9955-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add myself as a ROHM BH1750 ambient light sensor driver maintainer.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0c03740b9fb..928059c5cd49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13792,6 +13792,12 @@ L:	linux-serial@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/tty/serial/rp2.*
 
+ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
+M:	Tomasz Duszynski <tduszyns@gmail.com>
+S:	Maintained
+F:	drivers/iio/light/bh1750.c
+F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
+
 ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.23.0

