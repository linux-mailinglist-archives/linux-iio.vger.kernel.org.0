Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFF3454EF
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 02:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhCWBWm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 21:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhCWBWc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 21:22:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D8C061574;
        Mon, 22 Mar 2021 18:22:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x27so9690506qvd.2;
        Mon, 22 Mar 2021 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oy04/El40Ne1ubQawCjKO3bb/wFTwFt+f7NEOOoONMs=;
        b=qZ620LGPTtlsTf367eU1NiqWUBhP+Ym1FqCf3JA0vAZicZKnNgbAYQDtH9okaEO60J
         PxZpDselVxLahdpOf89Thr5mvrxGTVS1Y7mXKqD/2NlPryruPXk6ixwNPTj1rrA8tgDf
         Gp9e36zVhpIhGukhrKAG8QTkopYE2c5FhcI9AdEqmC+/cfFBr5/Mf2OVy9fLQQVWL65U
         3S7o1lJ76vaMwiDbxJUJlhb+SBWDwEMq8qc+TdDuHiQwLnKFTsJZ29HeydMDwFDTzDjV
         d1HyXIC5Uvvnt6Qlrv1EOIcelG1tpeyz4J73WnIHxnHxe/ofVugh3zGf1O+W25v8a0G7
         nrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oy04/El40Ne1ubQawCjKO3bb/wFTwFt+f7NEOOoONMs=;
        b=EG3FEzol0M0Bn6g0zhiwTZwa6iMY1d7oH+71urjO2L5bcsl5CcGnXDQSmbM37GoNME
         RYRn0VjVUjgqQxRaITI/PqYbCvJA3LpCBgUgufLaGyxpGFURootnKuypiO+qTlJrx6ax
         chw9g2UHcoWUC7gpWVUOx+z5UdWM2HKIJxgdmReLg16oj8B1H6acw1VihLC00oWuXNRh
         +DfMpOEk0CunnYsStXWQUROjPgPBGlXZVrsI1zFJn1XJrS/eawPtyNRNdUQnSUPyb0hn
         +mrDRzNnh/XhbEnoeTnZ4iAoPA5/FBNsDCPEaeIOkBFnFAqm/3bgxF/K9qmafI/Gnmw6
         GS4Q==
X-Gm-Message-State: AOAM532K47QiHHJ/tfRmXu4jO3FIR5RjwdOkm9TnStj+weGVwROA4ntm
        NGa6oElx/xymZ5qyPzU4p48=
X-Google-Smtp-Source: ABdhPJwjLF3vW90pqxpmz/cYw4RaTWr+fSidr90ggYnLlnntadiyfnbsk1WZp9kZApKyiJwXhniM4g==
X-Received: by 2002:a0c:a425:: with SMTP id w34mr2601728qvw.2.1616462551254;
        Mon, 22 Mar 2021 18:22:31 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.117])
        by smtp.gmail.com with ESMTPSA id 184sm12439706qki.97.2021.03.22.18.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:22:30 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] iio: dac: Rudimentary typo fix
Date:   Tue, 23 Mar 2021 06:52:15 +0530
Message-Id: <20210323012215.451075-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


s/concurent/concurrent/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/iio/dac/ad5766.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index ef1618ea6a20..79837a4b3a41 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -89,7 +89,7 @@ static const char * const ad5766_dither_scales[] = {
 /**
  * struct ad5766_state - driver instance specific data
  * @spi:		SPI device
- * @lock:		Lock used to restrict concurent access to SPI device
+ * @lock:		Lock used to restrict concurrent access to SPI device
  * @chip_info:		Chip model specific constants
  * @gpio_reset:		Reset GPIO, used to reset the device
  * @crt_range:		Current selected output range
--
2.31.0

