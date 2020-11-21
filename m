Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066F22BC187
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKUSnO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 13:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKUSnO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 13:43:14 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C5C0613CF;
        Sat, 21 Nov 2020 10:43:13 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d28so12290637qka.11;
        Sat, 21 Nov 2020 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKqEf7aCpa5U5cJQIRSDqTpFri/det2hzHXu5WbYouo=;
        b=oHAeqViqnrqvRBrYwv8FiEod+tLoFi2FZUUFANuGpdR1eFM4C+4TDHd4Vnj/ROGykh
         KYoW9lTHVt7Hune+sDgP4hZTnqZSXadTVK7BFaO72L8G3+OSuDvIlZKHQuMNO7YmCDiX
         6GpY+9Mg4KpCvTUZinYR4qAtiQVeatvOQHJT/dn2se+W4L36ljUAI+hsE7NNgI48m4zh
         j1XhndVoy9EDnocFjrGeJFv0zJSAS5tXH+CKFr5vQnKMXkcpzvZcvSBA0YL2eB70IEz5
         9hHuVWn6DGrg2daEQvyY16cj+mMn9s6XkI5zx6Q5CtS2SPM0hiJeEZ41N54g2koDSPhK
         qQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKqEf7aCpa5U5cJQIRSDqTpFri/det2hzHXu5WbYouo=;
        b=E3DuM4iQURrmr49SyxDlXCZ1A/Qm9jQbCjHncqS5Kddo9IhpGgRut/QO/3yHNnChLz
         X7NeEHV3qUvISTPkedMAgSw9XyEbJfXsM2/ZoQUy3+7qNqQOnV7PpJ/dpN1ggyeZOXRX
         SONdViSfHyRwcfl0329I34tZABTHOtzn1r/sd8K7kg21+snQqPsGPi/3x4gE1TOCEzX6
         LOTNX3wVZbR7dCEp/hHbTXKaBsA/2n/6TeiXb/DE10CK8MplQcMHCF1mhO8Sit/MPZDT
         KvUqeBDKFoW+iB0aUG7vQxWk/qihmGmgBu/Bl9tBwN2rNO5Cx8i38Gz/bXbTnHaIrJHA
         dUPw==
X-Gm-Message-State: AOAM531AnZkwFDCaWViKl/L8onW6ZGamRrCNvE2czrafz+y7zd8qRaBu
        T/WqVb86GlIZsUOi9IZvR/9lhiq09uZyUQ==
X-Google-Smtp-Source: ABdhPJxLJKJCIa6qdpdS+CI3pe9/tIlQW0KH5SJhwa0Q/FHd9Y6XmrXiJT69p3LSTcg70LaKaLWZUg==
X-Received: by 2002:a37:c8b:: with SMTP id 133mr7585795qkm.155.1605984192860;
        Sat, 21 Nov 2020 10:43:12 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id x4sm4933303qtm.48.2020.11.21.10.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:43:11 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v2] MAINTAINERS: Add Kamel Bouhara as TCB counter driver maintainer
Date:   Sat, 21 Nov 2020 13:43:05 -0500
Message-Id: <20201121184305.450149-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v2:
 - Reorder section names alphabetically
 - Rename title to ARM/Microchip etc...
 - Add linux-arm-kernel@lists.infradead.org as mailing list

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 913b5eb64e44..1bc3acf55ed4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2104,6 +2104,13 @@ S:	Supported
 F:	arch/arm64/boot/dts/microchip/
 N:	sparx5
 
+ARM/Microchip Timer Counter Block (TCB) Capture Driver
+F:	drivers/counter/microchip-tcb-capture.c
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-iio@vger.kernel.org
+M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+S:	Maintained
+
 ARM/MIOA701 MACHINE SUPPORT
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.29.2

