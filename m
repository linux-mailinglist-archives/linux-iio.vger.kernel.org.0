Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52F5420174
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJCMPp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 08:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhJCMPo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 08:15:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AFDE61B43;
        Sun,  3 Oct 2021 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263236;
        bh=xF9xHctqtPr7TM9GLkhgy+HoyDsCbBnDBZBMMA0Dj+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAzzRYUZ5onCk0BJ92XIMq5UB/MeKAQKX28IY7wrxm/G+oboXXV/I8M6JiqlgnKqr
         jfiRNIN3dSGOc+oK+K+fuUs3TKBvRVHLaayEBgy0RBwtWmzh7kXXPwURRYhn2qDvmO
         BR+okZ/DcRrxf8xf3zaWtsNmUADnbWvxqZ5tzf4dcc+vHa2IiJzaj7nhpF5l197zO/
         yjf4yJuysJHPN9wMLJXaRYw+LpQvgj+z6DyK3aYtrI3hmVIN9vibgQqN0Q7Ymu+oMY
         uLDTqFwpTSnT/iKamQZXLcvlgieupyVwx7dcDIqpAH8Lkjr+EqBj3CpisYf8bc7F4e
         JixDmePYlxXVg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/7] iio: prox: cros_ec_mkbp: Drop unused IIO headers.
Date:   Sun,  3 Oct 2021 13:17:11 +0100
Message-Id: <20211003121711.279736-8-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003121711.279736-1-jic23@kernel.org>
References: <20211003121711.279736-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Identified with the include-what-you-use tool.
To keep patch simple, only IIO headers that were clearly unused have
been considered.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 8213b0081713..55785a55a43b 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -19,7 +19,6 @@
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 #include <asm/unaligned.h>
 
-- 
2.33.0

