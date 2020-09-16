Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4297026BE6F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIPHpf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgIPHpd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 03:45:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A482C06174A
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2020 00:45:32 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b22so5851514lfs.13
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2020 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOVo1u3ISodBoRQj0xeoYhbegmTCRvXHeSQSNZhMTiE=;
        b=QNqrft4Ee36StNvgvhWe3cXRap/zmqfHBndqkGJaGqHegY96FQ9goA7TGkR81+7QOs
         nIAbFXbce906Pti2cqcOeCmhwhyk/1yuH0Zn7AP1G0lA5yBgaPEZYgVpY4fN6kZNFqj1
         T69SuJhPJpV7xiPiVe4G1wHSTiB9MlXEAG6/tqL0SfpXU5fv3V06Z/uGMycDpYul0jXQ
         qTZA33omdvIm4q5lQGtXFakCAVX6GpENdvQdARuFXLF3n9MhXCdEb4CgeBFobCQoW31i
         8Oa9m5M2dpxMmZIhgG+900U5yB6cLVR5oEa96dGRvsHlbhO2n0BQw67KZ6qP3FkXxiCy
         rLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOVo1u3ISodBoRQj0xeoYhbegmTCRvXHeSQSNZhMTiE=;
        b=g/IX92gL3MW8jukM60BptPPOf/uNTTcdycgEhaJSlRPUznbSzxTAl/OkblERb2lu11
         5OEZgRLzP760PFapYE+2lhhcj7x6z6NQgY6MwiNkcN3Q5XT9IK2qI9phiJOL0SakEXap
         9FsS/OZ2ASY9CbY3KOJz9sAvL5Sb2azyi6CIyNAm+44W/4RoS8xW4glld8xXiva793w3
         ELn7jvuJKtrKgpx849UAklLB1PLiKZXQSYa78NjSxU6pOD1r1HNiykq0dCsdvRE/2BRl
         oSVZIHR5kpEo3nj+UBbQXTaecA8Y2jVhRk2UNNcjX/Dua8UQqoeHJYpvxtJ7MBzRjaW4
         G4EQ==
X-Gm-Message-State: AOAM530WNbdWHeaa7Y4e23UbdoJrkgtNVdLYIWrjetTk5BB8AWah2q3k
        V6CQ4v6sqiSINhwhyX/fpoOpLp7slpcdokaV
X-Google-Smtp-Source: ABdhPJyqEuFgsUmKXu7SN5bpPFsahMoQ+IKpWv8R1qvkfrQj2ijyDV5fCybj2R23chOqwj72Fc5Hew==
X-Received: by 2002:a19:4085:: with SMTP id n127mr6936054lfa.425.1600242330877;
        Wed, 16 Sep 2020 00:45:30 -0700 (PDT)
Received: from localhost.localdomain ([193.201.216.203])
        by smtp.gmail.com with ESMTPSA id t2sm4442845lff.157.2020.09.16.00.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 00:45:30 -0700 (PDT)
From:   Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     songqiang1304521@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: proximity: vl53l0x: Add IRQ support
Date:   Wed, 16 Sep 2020 10:44:57 +0300
Message-Id: <20200916074458.873359-1-drobyshevskyi@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200913113357.47e0c0a1@archlinux>
References: <20200913113357.47e0c0a1@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since IRQ support was added to the driver, update bindings accordingly.

Signed-off-by: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
---
(no changes since v1)

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

