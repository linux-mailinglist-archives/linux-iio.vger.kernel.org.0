Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E503BDB26
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGFQMv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGFQMi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:38 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86111C061766;
        Tue,  6 Jul 2021 09:09:54 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h18so10012165qve.1;
        Tue, 06 Jul 2021 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zI0GRZjgYwyGyT21DHgJgd9yo+nslisk5YT0YJaOSJg=;
        b=CV7UzfOrE0x12545yuQpUUo87//GT87T/tKj7Pclrg3Zf+dpmQaZlQQc5sHh0S1FjP
         H++bsf3k+bq/je1yRicDjWax4dRzbvxplBNfe+215Ers4FV+AeMx/jcDzwI5tiV3VxGT
         QrZj9sKywQmQuhkmPsXYxRSoRkJ32FbVXIFPoY2p9jkwKpXZRCG7+xxY8S+wixYS1R5Y
         +lGa0zeUzXVBcOF5ZDnvXzVOsS38HRh94cZba+pgsqLt50eG7na82/GoyNUErzlehByh
         sd0D4cFdbi8fs0Pe7CGJcCfBGCgIq7FFYvokoKsPnnR2dPFdhrhpU7haBZ0x4ghM+p1Z
         a92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zI0GRZjgYwyGyT21DHgJgd9yo+nslisk5YT0YJaOSJg=;
        b=jXm0aIcVkTf4fayK4QysDBMXcd1e0Q36h1e0nMXkXZEDV+Ii+vtaX22zsXbWZmE4aB
         Y1FeB/svyy4w3gdUSqrJq6Q5la+NI0Hx8xBRJX1J8lTpcTRmpSUV2IDa8hajmlqoCntY
         pjrneaLTC1hSslj3NhXyrN3KA+SaavP5IATPL85N3uomcfoWginS0i8EKjZGqkrXh9cf
         jruytCRoUKkSOacZJJeeIgz2GKmXWyIlttAriZwc1G5gRws8MnCj1MrJ68/QXDx4DHOl
         9Oew/R02Wu3aAxRdvO1U2FRUT+O4HkSdL33sAds1ALmdkgRKywT+nXZ4/wz2iUeBYkzw
         meGw==
X-Gm-Message-State: AOAM533InsuZk3JqQ2Mwdsf2g9poXVD2EQs7orrLSKUAQAspyDwiYcxN
        HShVzpB/wZmKSf2kz1BBsgk=
X-Google-Smtp-Source: ABdhPJwB5CRdWLIPy30DVZcv/AAM4rKoR4nBjoKoO88G4h37aYMOqWvnK9LVO4M4OUXyheCQEVyx7A==
X-Received: by 2002:a0c:a90b:: with SMTP id y11mr6273129qva.28.1625587793796;
        Tue, 06 Jul 2021 09:09:53 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:53 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Tue,  6 Jul 2021 12:09:37 -0400
Message-Id: <20210706160942.3181474-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add IIO_VAL_INT_PLUS_{NANO,MICRO} scaling support.
Scale the integer part and the decimal parts individually and keep the
original scaling type.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index ba3bdcc69b16..1d0e24145d87 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -89,7 +89,15 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			do_div(tmp, 1000000000LL);
 			*val = tmp;
 			return ret;
+		case IIO_VAL_INT_PLUS_NANO:
+		case IIO_VAL_INT_PLUS_MICRO:
+			tmp = (s64)*val * rescale->numerator;
+			*val = div_s64(tmp, rescale->denominator);
+			tmp = (s64)*val2 * rescale->numerator;
+			*val2 = div_s64(tmp, rescale->denominator);
+			return ret;
 		default:
+			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
 			return -EOPNOTSUPP;
 		}
 	default:
-- 
2.30.1.489.g328c10930387

