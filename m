Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAB26407C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIJIsj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIJIsb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 04:48:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47EC061573
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 01:48:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so3123615lfq.11
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2020 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6dYMbZPxDWUW+EivTuPYPxEQ+J1IHPHt2d+FJn/ZB0=;
        b=pXkZdD7I4GjCneABSYGGQ+nEVgSr4l7xhsZAzvcodsQpENRlKuxtGwLMoe2KY/G0gY
         gXAbO4d6ksBechjfuzPgP1aeonzEuWs7txQQxJYcV5ge+zfhwDzRmrfGoBwkGdMcVraD
         DedcgptTmPWLMcvqY4qjA52zRf1QIB8/eYP034v0Fsu1mGEeC14ZWtwVSa4L0L4b3WR/
         G3HhvAgCrwsGV3p5XK5ib35uvfDrZs9rTe+WnaI5OqlPzw4tKk8vHZTxhQiuiSuWk4J7
         q/L7u+n2lWEyrHfjdJHh/OppReTB0P8NXyl+YjAevS354bVwbGNvyjwlN1XHbrKJxflK
         OjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6dYMbZPxDWUW+EivTuPYPxEQ+J1IHPHt2d+FJn/ZB0=;
        b=Jj63qxmNqDHOUdIV4wH+mHS8GISSfNHTtpKxOQ7rOm9GESb4ngJyv05zF078099DfJ
         NNzqV/FD+XZ4PvpdhsFyPxfoehGDKON4psevbV3yLGC6iUNsWIgU7T9zPzSsd33SOtgw
         0VObb0LFykovyIfQyel7OkKGFF85AftrFIL0YcKrKcIsAxHSeTEJ43bgUkebGW2iZKlp
         K59P92OtudACQGUs+8HCuAkYqcP692ITWeBeXkS/WD5aVttpaeFLOOJ9vb0gMwqrvy93
         L8K+9HQmdmrQIfeuzmgoiF0YfBuQwGiCjfND49t70ygzlS8+bUKVKOD9AP3wDOEyXy7z
         TA8g==
X-Gm-Message-State: AOAM530Sr8Rxh4UDghB1/FjzDpD7nID5XDqD2x2W2y7q+I9uWwW7aDD0
        fhUArxREWZZSrOC8gYvMwCvMp7lTq7UvzZHa
X-Google-Smtp-Source: ABdhPJzrsFbcFDtnKd13Gv6nXuZjeolrordzFk8sggTRJMun+KNl8MoFfa3yEGdva54yuohcaoVrzA==
X-Received: by 2002:a19:be0b:: with SMTP id o11mr1288315lff.117.1599727708636;
        Thu, 10 Sep 2020 01:48:28 -0700 (PDT)
Received: from localhost.localdomain ([193.201.216.229])
        by smtp.gmail.com with ESMTPSA id u9sm1131500lju.95.2020.09.10.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:48:28 -0700 (PDT)
From:   Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     songqiang1304521@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: proximity: vl53l0x: Add IRQ support
Date:   Thu, 10 Sep 2020 11:48:16 +0300
Message-Id: <20200910084817.209131-1-drobyshevskyi@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since IRQ support was added to the driver, update bindings accordingly.

Signed-off-by: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
---
 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
index aac5f621f..dfe00eb96 100644
--- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
+++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
@@ -4,9 +4,15 @@ Required properties:
 	- compatible: must be "st,vl53l0x"
 	- reg: i2c address where to find the device
 
+Optional properties:
+	- interrupts:	Interrupt for notifying that new measurement is ready.
+			If no interrupt is specified, polling is used.
+
 Example:
 
 vl53l0x@29 {
 	compatible = "st,vl53l0x";
 	reg = <0x29>;
+	interrupt-parent = <&gpio>;
+	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
 };
-- 
2.26.0

