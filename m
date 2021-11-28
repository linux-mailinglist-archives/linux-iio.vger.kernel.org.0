Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729A44607FD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358684AbhK1RZQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56222 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbhK1RXQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FBC6103C
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0491AC53FC7;
        Sun, 28 Nov 2021 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638119999;
        bh=hxyDxNkAlWrD29JWy+EQN+hhFg7JvNbUY57VYrqbQhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXW1vmh5UoWIuWyZKjzC6nzF6D4LV8XP0o8KZ5lrS7bGqhkfo2q10j9XaItDltTAY
         avIzDhIlhhsY2KtRlJApzvuoXAEFJ5JF0QtNkGJ0DfoFZAJTv8aQJUpspHC55151WD
         cQNJQWhQyedDUUopjZYZWC7rNLODzlpttVT10wEzTjgfPNadMvA8ccqW+lO5Lq9gIl
         3muYFs5o6Iaq41gkY6sA0Ka9WhhNYOzZVDZX2K9UFyaS1QdRCMZVmVckXMe6GEaryM
         X85evF2UXfOf9zgeM1pnfmAEFzz9YWdxsSbPh0nKIDz0CScunlBhK1u8+koBzZGgXS
         GdkDRGdg2ntNA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 03/12] iio:adc:rcar: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:36 +0000
Message-Id: <20211128172445.2616166-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cast to a uintptr_t rather than directly to the enum.

As per the discussion in below linked media patch.

Link: https://lore.kernel.org/linux-media/CAK8P3a2ez6nEw4d+Mqa3XXAz0RFTZHunqqRj6sCt7Y_Eqqs0rw@mail.gmail.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/iio/adc/rcar-gyroadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index a48895046408..727ea6c68049 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -511,8 +511,7 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->model = (enum rcar_gyroadc_model)
-		of_device_get_match_data(&pdev->dev);
+	priv->model = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.34.1

