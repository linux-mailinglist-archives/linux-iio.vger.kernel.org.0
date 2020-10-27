Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCB29C9C1
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 21:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504879AbgJ0UJD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 16:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2444572AbgJ0UJC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 16:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603829341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=z/P9Z9C4PZYkgeQZNMgEmbQXDB2+FuX6dF3cY8iv250=;
        b=evyKLhS1evX0Jz06yLQ/v7sktAatJeWnhSlFblXH16LlJZwkVe6qua5ITlNutM3i5/1sv7
        0Kxx5cN5Lhln25tLJ4YQrFHpqNxHoZoQo6/l15v0S26ac1jjoPe+fNGbZ8EadLPjHqmSOk
        UJVvgHJBsBHkn1l625w1tOdGa3gsaTs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-cIO-A2y5MNmwMQdOx7uVnQ-1; Tue, 27 Oct 2020 16:08:59 -0400
X-MC-Unique: cIO-A2y5MNmwMQdOx7uVnQ-1
Received: by mail-oo1-f69.google.com with SMTP id 4so198850ooc.21
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2020 13:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z/P9Z9C4PZYkgeQZNMgEmbQXDB2+FuX6dF3cY8iv250=;
        b=Ijjr7Hqb7KLV6HbMuJRRwAyYj+ky4yCkjQDi5Y5d5EZSujhvYMvCg41z+O18n3p855
         fqr5zXm8JnIlVaUCk/Rl/hxxOMrSMnEKnv3Af4PA1w6lh8srdk/hjM0UtX7tvhWCkRlH
         1gY8II2HQF7owG6pdBNovpiJNb3dzyAw9wOE89EQQyLJSwfQ2H2Cqwk/2AMs11sfEaN5
         zbIz5DfWMwgrfZ3go3sunCw6LwCFiCrNQyDuXEfLpsosBLhoE2pGOIgjDPL4bo7/9Dld
         xdtiiWFS1yKyPcxnQi6p+p9IxPmzlUGs5CBn72fLEgE6GwcsAEpQWw29LBRtMA6lJT7v
         eaHg==
X-Gm-Message-State: AOAM531ytmFrD8u6njls6EpuQJks80BPddY8fH6s/ex4ywKxi8ppktl1
        FCsTURaDpDgEgmdryw2OM1gZTIP16iczOIx6mQckDvQ81Jbo4GMOtkh/DQ61/jy1u5ailp5Pvol
        8P3eBvXsob9lpzhmPol7a
X-Received: by 2002:aca:f203:: with SMTP id q3mr2607475oih.148.1603829339028;
        Tue, 27 Oct 2020 13:08:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmZlAqkfP+7v4p/ymWn6FF+T+HagSo905aTYq4mMxXC7QSKxlykrccxT4DOK0XZZxlvlgsig==
X-Received: by 2002:aca:f203:: with SMTP id q3mr2607462oih.148.1603829338877;
        Tue, 27 Oct 2020 13:08:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u186sm1921539oia.30.2020.10.27.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:08:58 -0700 (PDT)
From:   trix@redhat.com
To:     eugen.hristev@microchip.com, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: adc: at91-sama5d2_adc: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 13:08:53 -0700
Message-Id: <20201027200853.1596699-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index b917a4714a9c..56cb9a8521be 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1472,7 +1472,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		return 0;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static void at91_adc_dma_init(struct platform_device *pdev)
-- 
2.18.1

