Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91743222498
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGPOAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGPN77 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCFC08C5DB
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so7203536wrn.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fxti/ROfl2G3M6gtYz5bbB24uIJ/yIrzz6aDgoU+YhY=;
        b=sPXdRyUrAhHuTpuewy5VfCaU8QEjM1NaNAfcP84fpBcu50J3lpb1HY52y8zutzFjFN
         YmTSRpW8jZX5AGVMjqgoEerb2+UU3NqVNXsAsjWipg2eVPj+HGNB1gHrBV4Ec0zkHEIr
         Ak7tX6sy9RzXsd9VjDh+j+5xKbEU59b6nwSPNF4E44nUFe+voE+UfA0Vkn/sdH4XUfta
         N8I0u5FcCE9ARjwwDsGwhdrNgdnXKrhIfxyff6Wu/wv9WqOsfspMeko4vS3BXmUCCMkc
         +V/AWxJ7GsxvErjrTV0s8qlTXYu1ocvWMkvzUzOO3QRbTECQyOc3eizmnKqLv7m1eiBh
         zprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fxti/ROfl2G3M6gtYz5bbB24uIJ/yIrzz6aDgoU+YhY=;
        b=XBoORXRA0dIhAKxTBnROcToEY+v1n4VT7omaBjv984RgBl9qjcoJPngDXMGeTK934E
         5SRHAn5lAkqxfBqrZbBA5PP+0UyOjtOb6IqY6RbqkMGuAxicOe4RXg+GQ6qjTABRhUip
         A4QJiSAAc1khXmgsB/qu9+sDN/sqzZ3dcvG0wGWm1eoVFTph8TIEGgJulzUhqGcr5k/o
         rHsRNWhu2v3vx1usrr18kbLSuabVvrPOpff9z6mbTmTJv7hQ19doQE2iHPqmAlf9EbfY
         LzimAvA92Va/d/uq+4cLv9lVJrlzISVTCTorMFZnea4krGB/gxYen4o3Fi+qNtf3agXd
         1DZg==
X-Gm-Message-State: AOAM5311WSLO51+X0DZXUj0muscYKn39WS9adVxkoL3hK5Iack16iWoz
        cE0cesCU0C9Z1Fa0PSGS1BR27w==
X-Google-Smtp-Source: ABdhPJzM/jUx9vNqBhmh4/2ZUSjp3tre1unOwqfSVQ5aaqX4Xt96FB0tgeJaU8jAp7Fs4XGKDQQLWw==
X-Received: by 2002:adf:f452:: with SMTP id f18mr5192867wrp.78.1594907998275;
        Thu, 16 Jul 2020 06:59:58 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 21/30] iio: dac: ad5449: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:19 +0100
Message-Id: <20200716135928.1456727-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5449.c:75: warning: Function parameter or member 'lock' not described in 'ad5449'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5449.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index d739b10e52362..e9530835479af 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -56,7 +56,7 @@ struct ad5449_chip_info {
  * @has_sdo:		whether the SDO line is connected
  * @dac_cache:		Cache for the DAC values
  * @data:		spi transfer buffers
- * @lock		lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  */
 struct ad5449 {
 	struct spi_device		*spi;
-- 
2.25.1

