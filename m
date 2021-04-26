Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1831636B84F
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhDZRvR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235532AbhDZRvR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:51:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48719611C1;
        Mon, 26 Apr 2021 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619459435;
        bh=+KkuDYhzjHOoCxQ0iJTclGkYWWSQASiqjXOJR1YFn6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wgan6guUSsaUXAVl7FzHFza3QAGt1i0LCJFq9Vdg3MlvM1aqVZ6F1RgfAQs+bQeXX
         oOANAvqhiNorV6QHSI8MeswrijV9MVpsxoejdqy4psuVU0MHK8aJXY/z6FFH2jBLfB
         dy9uK0Z35nQuKNFMi042v3FkzMFAaM9wLJJZqPQF1x1tuye48qXzbl6uot4VFm2u5c
         LDsD8dnO2DJihjWcXNkOt6dt0z6cST0QyrnDYalpvAAZreTKbxAq/FDU5CsJAK19Sy
         bYm23DqtQqra/tPuuvg2KBL+qTaanH4aCO8ln7dM9q/i/YlG8XoLxI1AloWmkAhKnu
         /sGQQrueX4jZQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/9] iio: avoid shadowing of variable name in to_iio_dev_opaque()
Date:   Mon, 26 Apr 2021 18:49:04 +0100
Message-Id: <20210426174911.397061-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174911.397061-1-jic23@kernel.org>
References: <20210426174911.397061-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

indio_dev was both the macro input parameter and the field name
in this macro.  That causes trouble if the instance of
struct iio_dev passed in is not called indio_dev.

Whilst a fix of sorts, no need to backport as it seems we never
hit this previously due to some very consistent naming in IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/iio-opaque.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index e66b029d99de..f876e3aede2c 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -48,7 +48,7 @@ struct iio_dev_opaque {
 #endif
 };
 
-#define to_iio_dev_opaque(indio_dev)		\
-	container_of(indio_dev, struct iio_dev_opaque, indio_dev)
+#define to_iio_dev_opaque(_indio_dev)		\
+	container_of((_indio_dev), struct iio_dev_opaque, indio_dev)
 
 #endif
-- 
2.31.1

