Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333B1429F0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407175AbfFLOwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 10:52:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39524 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407091AbfFLOwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 10:52:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so26199637edv.6
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2019 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VcpZN6jk1/9bVC0qVaIXUbUOZgbUqMWmXO++ggzEl8=;
        b=SV7v+oSlKP02RKrzvraJe/XObO6YGPhyRCJfQIZM/hN0vLPDPwy79s8HM4yqQA7uFl
         4CGyBbgaYXEs+ouckzrrSxPxMmWrtC1rAWcNVIp5zXBJ1iwQU+EA9ZlBZfllUPdQeRXI
         mGoQI/lNcJUPyK9y0shi1g1hCjmAIzA7lMOztTd5aOXCQySArEso+mWng4CgDC7Rd9nI
         J6Du7cwS/HJSExCP4xlVsBAFQJPpr6R7J6tkvKdWjraOgN2Dm7cvG+fKq7PZ9jYmDPu9
         uwhCmogKBFMz9M/ZF/ZGplvKN9bCzPkGXG4NUZUusQxFp6lw3XgltG4vWcrJGyAVpydJ
         9R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VcpZN6jk1/9bVC0qVaIXUbUOZgbUqMWmXO++ggzEl8=;
        b=k0eTCfcdxGCWb4Xr0d8jpxhmGYpxmAMpeAyYkSKXoITMpAj9pWWyI9rByc5l6JGCWC
         nwDoRtcdpm9mcKvB+dwyjMq+09MAjLvy7yh/kjskkcP9v6aTbCEicUi4quiC5eE0t+qu
         kDJ4J013t0KvTV7LBsrUP9LfIB1xhlVALbyMJ1SeCL+KUIp8yFsoVe9Ds4Si8z/xSEUJ
         6wFLQh8KTuP4pY0KF+0SPPytwf8SDqSf4874/B0em20EzC4m5YF3mv4zuSD8ZLm/C8aC
         YCf7ARNJBJhbLjQr+K4fBJAesjPR87B/xNj0HGVg61jq1H0RvPuEldu5mUAt8xdUjvuE
         LIqw==
X-Gm-Message-State: APjAAAWsE0wOb00hqeKvnH2lO+cqSIGmBtsTwHVgJVnsu9dU+hfZJifV
        7cGbsuGrcw0ACiYFhLc7F09N22gNzKA=
X-Google-Smtp-Source: APXvYqzuvIXLNRoinQlWVrHS5zBEX1xZJq+QjAYHK9QzUA8loRvePk582eNBHyepokc80P+I8EHYhw==
X-Received: by 2002:a17:906:7d4e:: with SMTP id l14mr22796555ejp.188.1560351162223;
        Wed, 12 Jun 2019 07:52:42 -0700 (PDT)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id h18sm26229ejt.5.2019.06.12.07.52.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:52:41 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/1] MAINTAINERS: add counter/ftm-quaddec driver entry
Date:   Wed, 12 Jun 2019 16:52:23 +0200
Message-Id: <20190612145223.8402-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding myself as maintainer for this driver

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..6671854098d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6218,6 +6218,14 @@ M:	Philip Kelleher <pjk1939@linux.ibm.com>
 S:	Maintained
 F:	drivers/block/rsxx/
 
+FLEXTIMER FTM-QUADDEC DRIVER
+M:	Patrick Havelange <patrick.havelange@essensium.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
+F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
+F:	drivers/counter/ftm-quaddec.c
+
 FLOPPY DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/floppy.git
-- 
2.19.1

