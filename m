Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0E224107
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgGQQ5C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgGQQ41 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E8C0619D4
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so11907019wrm.4
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXd86YlqxBtW7UZeHgyTcDp4G0PhvbjWGBrB0jc0maI=;
        b=gXP1A1aPqfzAOvdHNbPtLs+jIhv54GQIbTAccgxgr1wt1kn9EpupuLOyas02qh3Fc4
         aAXKauKVOUBG3l+VRgo/RdfDeZ1G42tkVR3s4aIDxL5dUHdbg/5/xQN5dZahRXDmPmkt
         xLwL3x7xHoSEQo3Jxl84dEa2RWgcLgAZxPwEl2aOD7W00BdoLQ+h1AAIEcGGPCS2LYR0
         y0igGQBBnKCGKDevvhCzrkAAkKfKwxwsWq6rybKHU6asMYRQPgysnadd/5iHvMcqn9dJ
         KIAQPpOk464Eu5Jl1xNAEjwKkq9Q/MpFYoWxHU25xXjFhMdHwjM8IDe51XIF8biw6Cde
         c7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXd86YlqxBtW7UZeHgyTcDp4G0PhvbjWGBrB0jc0maI=;
        b=FGZF8uihOqcvgaS9B1Wv/AML+Yv2X0z9fMusYkV6IKPVZJ8kH8j+huJqAPWJ3fUQgH
         J3OtL1/isAIUPoSgD7QsTs4rD7Kd+uLKrvdtUbcPR+D5IrMyPSgkQdhjy68Zj9jer+hS
         Xqly7MI6LXyIiDxXnqu6FHy4PQhnaQyHql02h1wfbYZUZvD7jdwEQbHE3d36e5JlQXhC
         mjKv51VDb2xufbFkRWSQh98OpA3u9UM0CC/4zMP30IAkGeopA+vN8uIEaYCBB50Rtx7L
         UVOYBXdk6epuQPZn9joui8XC+5ZHiTy42TodpqT8rc+zXpY/CRtABQkLvmGbTq5iSaoU
         dzbw==
X-Gm-Message-State: AOAM533XTG9e1bDZJhGLEOZ7/DugpbU+efVEmj/ENd7GzY62F1LANtBz
        Ma9Noy56p1Ih3uN7B257GNyQbg==
X-Google-Smtp-Source: ABdhPJxhKbEduZnoaaEhkBeqsaOavVhq+n3Sa8BgaDFiVmZt2/qoLy17eSHZ1GVMU3+BfR0KoDuf9w==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr12304154wru.158.1595004986049;
        Fri, 17 Jul 2020 09:56:26 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 25/30] iio: imu: inv_mpu6050: inv_mpu_ring: Demote seemingly unintentional kerneldoc header
Date:   Fri, 17 Jul 2020 17:55:33 +0100
Message-Id: <20200717165538.3275050-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is the only use of kerneldoc in the source file and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:118: warning: Function parameter or member 'irq' not described in 'inv_mpu6050_read_fifo'
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:118: warning: Function parameter or member 'p' not described in 'inv_mpu6050_read_fifo'

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 9511e4715e2c1..b533fa2dad0ab 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -111,7 +111,7 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
 	return result;
 }
 
-/**
+/*
  * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
  */
 irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
-- 
2.25.1

