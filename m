Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398DD2240ED
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGQQ4U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgGQQ4T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55522C0619D7
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so18194037wmi.4
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9KL9HYXYgn6Rpl6BIijuJhUjr4NXdIWWmHfn/aX7y4=;
        b=uGY7fLW6qHw0et20UC3kHdd/8MYDxlSOWeQea54xURu68895NqIfNpQmb7zeDx2jal
         BmiDZWuiJCPY/VZmfubpUqLVnO0T3Yb+tul7GQODb1HKyfDZYhhVgDQtoUOTznE8TWSc
         eZggPH8MYF1UZ14ZnuOAa7P6PU/qpUjLaXR9oxCQDwwx6AvPeadxxoGS7680CWMDBcIV
         9iQoaCYJy918i0CcOWNFVJvBmnFRBZerJZOffW7GOLXYRm/kAzI6ECQ9+TcVqmt43rRY
         58jPPxGOl6Zn8kf63cwptde45XH8vb5uxq+thHdJFhAi495FjquGtGjXoCZgiaB0z9K9
         o3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9KL9HYXYgn6Rpl6BIijuJhUjr4NXdIWWmHfn/aX7y4=;
        b=o655yx7zXHd6cmhu03pXcQ2CF45xrLCYUB956glHMPTpoai/djsxO4Jzt7t7wIN2iQ
         mxmKQ0fsZnAB6O4ZWzK2WMZKnFOMP4nXzCjooz8fxxNfkBWnxYwVy9nP1yqAbj5nENvw
         0NbJ7dyIcV1oIkJ9M3C4hA0E0OmugRchiqsfvkyg+ZQnURh4zeX+y1WJNBrKDgq5MQB9
         jsaqyP+S2iNlSY4T06nj5JWPr4vhCHjaIoSUEvd7YuPqhSa/LP6Snp2k/YbJNiqGcLlC
         w3M3AR6K7w0AtFJVAvsLgNpdTf5mylrv0U5ljb/h0zb39WOSoANm/U1D/d3df4EqiLeg
         Gbgw==
X-Gm-Message-State: AOAM532vM5YyQpDFcFoPepjqm8G+d5OaJLz/D3hgSQ9XCsFseQaI5dzJ
        PZIb75/IkRB4F8eZ69yDTkrmKw==
X-Google-Smtp-Source: ABdhPJwolaFtALJ8b06cyO8m7AqyQP6KwwYk6G75p3joMVOgZdxFOGPzU5mARmnYEYjb71TVU+u7tQ==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr10870067wmu.52.1595004978069;
        Fri, 17 Jul 2020 09:56:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 17/30] iio: gyro: adxrs450: Change ordering of compiler attribute macro
Date:   Fri, 17 Jul 2020 17:55:25 +0100
Message-Id: <20200717165538.3275050-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc gets confused if the variable does not follow the
type/attribute definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/gyro/adxrs450.c:79: warning: Function parameter or member '____cacheline_aligned' not described in 'adxrs450_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/gyro/adxrs450.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index b00c0eb442493..e00b97e30cf9d 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -73,7 +73,7 @@ enum {
 struct adxrs450_state {
 	struct spi_device	*us;
 	struct mutex		buf_lock;
-	__be32			tx ____cacheline_aligned;
+	__be32 ____cacheline_aligned tx;
 	__be32			rx;
 
 };
-- 
2.25.1

