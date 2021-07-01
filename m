Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D603B8B83
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhGABDZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbhGABDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:21 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF8C061756;
        Wed, 30 Jun 2021 18:00:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id fi7so1602852qvb.0;
        Wed, 30 Jun 2021 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqVmsQrj5gPERV46gGlf3in6+hs6JrqcUorTsVE2iLk=;
        b=GibRhms39S7d1sRjv0TgmrXaJVjb00Q7CiEk+VM0/Zd/YA/esNuRpDgOJpjy+PzhRq
         Lhkgzt2bnTFa/TPued0PN6p1yQsdK87s1Vq5kNZj1OTGa7lufSqo04vxAraWL0I/zawQ
         cBRndEMus/9cobFICHcNJhIoOvgNMWATAOWsdHQFqKWTetYJNbkqaI6LJ77lU4EPFeWu
         vqoDRVc9gFidHx2qGdjwkCE/Tu99fA8BbGdtzTbO7Uyr1c6XiiGSA+nbpylXAnuzYts8
         dG+ogQ4hsEUu9rp5CSbLlr0A/HLR4HmbQ1MdND6eT9JLPevilO9h94kvHGHGueRc6+cE
         5XaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqVmsQrj5gPERV46gGlf3in6+hs6JrqcUorTsVE2iLk=;
        b=dLugPW3O2EpEgse9cnauNkvMlkCzEhJYndez/ovsICgD/GzGrBCRmzXYC+GZzLCIEm
         DrseMtY8wIDcbgpdOcTR3W497wxQ61pkVF7YNKz6YpA+W4MIvka++wFRx9apOlZngdUU
         OSnKxcQn6xq5FCwiWQ+dCHFMuYX8qLVUtjpZvthGB9M+1ruDNItKyHCrS778w6i/X64E
         1yqsBvw+lBkiJTMDZfIoU2pzdfY624EEIfTUhWP495z92y9JqAO4gpNQNlIsYiACRu5W
         qBeRb9z719OEpsz89MlAcRwtTmRZTL/axWRVb4VahEOit7cgFw1/hTFqlAeCT48S32FK
         vg0w==
X-Gm-Message-State: AOAM532aurHsXmq21IOHvcD+0cJvlY4L8WUTvmBJSGmWY5kqerzMqnOJ
        ypb6GyOnajiFGQC1LG0dfW0=
X-Google-Smtp-Source: ABdhPJyxM9sBJltI9LfkzndGR6gJjfuoc2F+HF7lPS4O651mBthuFMjz7mObZJd9X89lFfdmsY6BGw==
X-Received: by 2002:a05:6214:1d24:: with SMTP id f4mr19821789qvd.56.1625101250082;
        Wed, 30 Jun 2021 18:00:50 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:49 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 04/10] iio: afe: rescale: reduce risk of integer overflow
Date:   Wed, 30 Jun 2021 21:00:28 -0400
Message-Id: <20210701010034.303088-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation with
64bit integers and looking for a Greatest Common Divider for both parts
of the fractional value.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..98bcb5d418d6 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
+	s64 tmp, tmp2;
+	u32 factor;
 	int ret;
 
 	switch (mask) {
@@ -67,8 +68,11 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		}
 		switch (ret) {
 		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
+			tmp = (s64)*val * rescale->numerator;
+			tmp2 = (s64)*val2 * rescale->denominator;
+			factor = gcd(tmp, tmp2);
+			*val = tmp / factor;
+			*val2 = tmp2 / factor;
 			return ret;
 		case IIO_VAL_INT:
 			*val *= rescale->numerator;
-- 
2.30.1.489.g328c10930387

