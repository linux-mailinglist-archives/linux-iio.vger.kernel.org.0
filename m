Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7047EFC6
	for <lists+linux-iio@lfdr.de>; Fri, 24 Dec 2021 16:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353052AbhLXPIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Dec 2021 10:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352999AbhLXPIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Dec 2021 10:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640358520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VANKkwXTML/2/9ot1sh770YbPivcKWxATAmwzqHleQQ=;
        b=Gg+mhdgfCarVZ1A9Qg6RTt7a0wZ/dvoc3TCEIiHEjW+iI1WMHMuE6DC6yOGzw70C+JcU0E
        r8qAhcSJ1tkeBVAnUnyTKV54T3Su40YU56j1HwVgqtQqDCBw8bRfDVaUOHrkipj1jDNH0r
        fbyrDY1Chp+wMg8EtjREJ18vjY8ImY0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-dOET9ozjPbCKR_76QKBMuQ-1; Fri, 24 Dec 2021 10:08:38 -0500
X-MC-Unique: dOET9ozjPbCKR_76QKBMuQ-1
Received: by mail-qk1-f197.google.com with SMTP id o4-20020a05620a2a0400b0046dbce64beaso6892579qkp.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Dec 2021 07:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VANKkwXTML/2/9ot1sh770YbPivcKWxATAmwzqHleQQ=;
        b=BE8BVgwPNYYljzjpHtYNfZ+jf6lOmDzrjCYrQIIG6wI2HtCAnLWvHkA3F+VACj0ZNe
         ED1uvQgD1QcWDLKgt1PYMfyPLhvcJeJvxCFVbjR8ZvD0oHfecske3K3cIL5/V1jYhn1M
         FlP82vhjJPpcQxa5pJSfnb3khWsiK24czLhIzwuWnDhCOs6vIu4V0aatj+fGoaVM/qqW
         Sa5SIDreoIvpqllsZOEPfzNcA9wqxovc+Y5G1NuGeFgHDXC+QpmHu+ZdYs5FYrDdidmL
         /M/nj23ZDTfZpwjAl3vGixsrDnLyRCmnP5QW1QAlyTVtHaIkkJthjGYJU2ymfKwLFl/n
         bDiA==
X-Gm-Message-State: AOAM532USgVvzCsjuR2UDwwyKQe8gqecTL+CEHrxeQHLrA3XLiwN6GT2
        k1isYCi6BijRDS9S5oflgTafmst9RU4RKvnCVegCK6uR4eYj/k7t0hA4ly3R3c9cDR5q4kAgwbg
        1o7cUBmk/xEUtSD465+Zu
X-Received: by 2002:ac8:4a87:: with SMTP id l7mr5860366qtq.310.1640358518543;
        Fri, 24 Dec 2021 07:08:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKkj/oUpZ8SgPSGh8spTXveLPNfIswgd7mJJYvqRjSeHCVzNFqxnzEZiIsSaW0BbAzrBkQHA==
X-Received: by 2002:ac8:4a87:: with SMTP id l7mr5860343qtq.310.1640358518355;
        Fri, 24 Dec 2021 07:08:38 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b11sm6512248qtx.85.2021.12.24.07.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 07:08:38 -0800 (PST)
From:   trix@redhat.com
To:     jacopo@jmondi.org, jic23@kernel.org, lars@metafoo.de,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: chemical: set val parameter only on success
Date:   Fri, 24 Dec 2021 07:08:33 -0800
Message-Id: <20211224150833.3278236-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative warning

sunrise_co2.c:410:9: warning: Assigned value is garbage or undefined
  *val = value;
       ^ ~~~~~

The ealier call to sunrise_read_word can fail without setting
value.  So defer setting val until we know the read was successful.

Fixes: c397894e24f1 ("iio: chemical: Add Senseair Sunrise 006-0-007 driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/chemical/sunrise_co2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
index 233bd0f379c93..8440dc0c77cfe 100644
--- a/drivers/iio/chemical/sunrise_co2.c
+++ b/drivers/iio/chemical/sunrise_co2.c
@@ -407,24 +407,24 @@ static int sunrise_read_raw(struct iio_dev *iio_dev,
 			mutex_lock(&sunrise->lock);
 			ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
 						&value);
-			*val = value;
 			mutex_unlock(&sunrise->lock);
 
 			if (ret)
 				return ret;
 
+			*val = value;
 			return IIO_VAL_INT;
 
 		case IIO_TEMP:
 			mutex_lock(&sunrise->lock);
 			ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
 						&value);
-			*val = value;
 			mutex_unlock(&sunrise->lock);
 
 			if (ret)
 				return ret;
 
+			*val = value;
 			return IIO_VAL_INT;
 
 		default:
-- 
2.26.3

