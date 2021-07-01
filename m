Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5943B8B80
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhGABDY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbhGABDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:21 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C5C0617A8;
        Wed, 30 Jun 2021 18:00:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h18so2159020qve.1;
        Wed, 30 Jun 2021 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmky5l0N9TXo0NTQ1YrbAaaRvC+qKWRHhjy6j7fXuAs=;
        b=ntCMWnr+mb8qqz6COldcm7/FWBgC1yCjxPE+nUWSbipTWh7Or88qx72riHlmwmnYnP
         q8JKAhCPnGAr+x+1Xh+/ApFRzS0jWq6O8EusTI59s2XJHNAbPfM+WT0wNwTwlvsVQWiI
         lPer1AZjPb63rVxMMvqChIm94rNhdKWCqYsRg8lNdMLdeSJv3Tkr2xcgNW2wWZqsN5Ik
         YktpAsTgq+Hw7GLWrkQFXTowubqzSP+pDWy30siSP5xn7W6VcgwRKZrC7YyjQBgxUEZg
         wMtbEAaMlyHsA/NMYDNCes1EdcWgQG3Su3Gcvas8Vp2xRhLyf6D9BTuO87nj3qs1zGnM
         1wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmky5l0N9TXo0NTQ1YrbAaaRvC+qKWRHhjy6j7fXuAs=;
        b=DOqSV3yuUWvYRgLc1pP/yh0vIIoA3UVAvH9T7yCGTwJvlj//sBJS4S+Y9IHUPqfc3R
         kxG/Qv7CNrs1YJqNl0lhfdVbjpINjYTWBTwICqO+ddodYFOnjwrhVfDPgk0TEOn0z66N
         qKLovv1stZNsZgz7h/ODY4D+36EEjva8a4nT1YvwcdgCjj4F9qehP+SHQKblAR8VU/KM
         OypVCSnyPPmKzZGu4GEKGiAkm0DO2wmKW3vLnAUAAqY0Zb6bVnRRloiq6+z97Nw5IOuV
         gcW8EXKS6DIOWerxIxjbj/csZMgbwuiLN4O5lIEEAhv80h51wheP/lVumaFbOOpicZHC
         9/WA==
X-Gm-Message-State: AOAM533p7XAZm8psaeSXafVeWshMqJoqx3IHSIAAvVs987HKXnVhDUIC
        3Tgm127rzE+d14vMI6rbGCE=
X-Google-Smtp-Source: ABdhPJxsz7LB5Lxi8wCWyoP5YMPMlkBGDlS+IKSfR2I6DzSP4o+3RcKmYE4c2pyN15Ah43m+ndzscw==
X-Received: by 2002:ad4:58d1:: with SMTP id dh17mr35648261qvb.16.1625101251014;
        Wed, 30 Jun 2021 18:00:51 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:50 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Wed, 30 Jun 2021 21:00:29 -0400
Message-Id: <20210701010034.303088-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
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
 drivers/iio/afe/iio-rescale.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 98bcb5d418d6..8f79c582519c 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -87,7 +87,16 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			do_div(tmp, 1000000000LL);
 			*val = tmp;
 			return ret;
+		case IIO_VAL_INT_PLUS_NANO:
+			fallthrough;
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

