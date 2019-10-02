Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660AFC4A1E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 10:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfJBI60 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 04:58:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50406 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfJBI6M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 04:58:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so6285232wmg.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sb6XXd4XVveOWoqAO2u1k+xpQz65b1SxWMC6fwbGnGA=;
        b=zbgQRRhyC8p8+iQ7xvNZFW0vTinqDURlrP1CWUQ0C7fm8v/YfZFZpvZdIoqFPW1dYu
         0prWnjaAQYC7EyfCh7nLl6Kwj8NtkvYCCUhncleY8zy0THpyP1kIodTCugLPLLNj7j7y
         +aAZN0CRZEK9/eBqW/sPhgF7F4puZibPPqxf9KB8+QiKbSzTSQoi7JG/A9dUCg/zqTlb
         MrJPJiFmh1ityoOd8ZB7BBUdv9Lew0WDaNo1y2nOreGBznLymPzCnyEnAyqx4MA/R4hM
         s1uvw6p7LVb5NWf9q3LGx0xDlO60FWMuEIdqD+PxfVPOiCDp95UTDSTkcRSK1wahRfDD
         N2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sb6XXd4XVveOWoqAO2u1k+xpQz65b1SxWMC6fwbGnGA=;
        b=nXi1owAiDIevekP/GSufQXDTON1bqFVamw20qXFut+P6ljPt2eJcdeMsH2DBF1rzbJ
         W3pZ/8RNyDZ0kq6x5NyMqDkyE4S6b1qJOqOp+gN5+KDutL1uprueQjb3gFGDBhZ0KVtS
         8sVwtSV/IgiCOulhjvZcF0FmB9/3KEThTpcnybg2KUPMgVhTuqIZVst0/F7o3v36VtmQ
         Ye0+jpq1A8+UBe7F4Lgcz7v6h7zofN5MTfzEDPdfVf4JyksVddr+r+cHiXhpvQriT9pa
         T1JN7Gpp6B6g3d/hyq/1wVbrme33eDLGOWvRWA+TkT437CznbM9IMxf9w4LSyXGi58qu
         Ocww==
X-Gm-Message-State: APjAAAUeNORQCDvfKsSKo7AP0n7PbvqmEUp4I1ACvMCHbCuSRLu/0njt
        XIHkaJLu+0Q0vhbNwrABrZxLtw==
X-Google-Smtp-Source: APXvYqxsuNTI27IKNGHkstrfZxf44n78Md97rHT2Oac0my1+Y4r/yzcwURifHWM9QO2sJAQ3qjSOcA==
X-Received: by 2002:a7b:caaa:: with SMTP id r10mr2064638wml.100.1570006689870;
        Wed, 02 Oct 2019 01:58:09 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b186sm10115616wmd.16.2019.10.02.01.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:58:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/4] iio: pressure: bmp280: remove stray newline
Date:   Wed,  2 Oct 2019 10:57:58 +0200
Message-Id: <20191002085759.13337-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002085759.13337-1-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a stray newline from the probe callback.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f22400e1e98f..fdbd3bc27921 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1131,7 +1131,6 @@ int bmp280_common_probe(struct device *dev,
 	if (ret)
 		goto out_runtime_pm_disable;
 
-
 	return 0;
 
 out_runtime_pm_disable:
-- 
2.23.0

