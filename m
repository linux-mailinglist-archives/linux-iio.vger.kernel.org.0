Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1713D071F
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhGUC0z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGUC0a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB25C061762;
        Tue, 20 Jul 2021 20:07:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k4so819851qkj.13;
        Tue, 20 Jul 2021 20:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a17Z7u+gpgZyFiipJt9rouvOOgmIz72gFFa6sOhMfEc=;
        b=WJUVn+yc178Asm5EjJ+CtVPNu8/yZSjqwfnZnRAyPb5HhYs+kCKbvLkynLlCYQ/ra6
         +oK5wAdZaEyrynEf/rVLhk3r4Hj1HHL2Cx+cHE8EbxZucE7nfBOQ3c0DJoljZ+sh3BJC
         eRxdzumZ1kl0LJ+oaomquB4tX0fo5uIm0AyUElHnPfPnJB68vC6d7Z6E4CcJXtRaCSq0
         zSKSDD8Wex4x7ep40nAKT2og/XPReNcTaCssO6Jb7Kjql8lmLSOTyqeCYI+eTKQf+P1T
         BmVgAOsEyBeLkJKp7uggy/dpO/nJv5VqaA4Hh2FgOeHfrraTKhkSXJen7M13p5MhEYwA
         xkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a17Z7u+gpgZyFiipJt9rouvOOgmIz72gFFa6sOhMfEc=;
        b=XhtmBpleCIAft1wTgUXe25ercaa/bG4DsUl7DtYjtNRg6ZjALvp3e8GBR1Z3z2Cyee
         FvFfMYTvhRICwiFG0rUS8s7zY2KMa2MG83ITOsU80AgoY4wT7lb9gCTZHIOXQoRP9LDo
         T5IYCxJ2DgzXsEbO5mWBKJE0QXrK3oeAtgoRJw1LCx19EHdLGY3p8F8SW7Iw1faGbAmJ
         BazVy1KfijSknreWG+L21LAlZnrVwDM3TlZYsOoUkUzdHj60/YlmTsbzw0rMGxpPwAxi
         qc800GPDZ3bh3Rm8MJlJL2HlRWHDe3Yg24VHcicrWUY+zBmgjqj7xWhkeAUZffix+F8p
         w6Lw==
X-Gm-Message-State: AOAM532AvFjhtOh1c9LKOn75WTo6+kR0TprZB7UVKDM15BOV+x3GatSK
        WLxyTJuFRWmR0ZwC102CJxc=
X-Google-Smtp-Source: ABdhPJyaTlCSmUrE29R9noJQBWuuRatVzqxH0tSmpAcGXCJY7so9ArADNagZ2+TbQd2en1Ycaoitsw==
X-Received: by 2002:a05:620a:56b:: with SMTP id p11mr31440424qkp.66.1626836827441;
        Tue, 20 Jul 2021 20:07:07 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:07 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 08/13] iio: afe: rescale: reduce risk of integer overflow
Date:   Tue, 20 Jul 2021 23:06:08 -0400
Message-Id: <20210721030613.3105327-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation with
64bit integers and looking for a Greatest Common Divider for both parts
of the fractional value when required.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 6f6a711ae3ae..35fa3b4e53e0 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -21,12 +21,21 @@
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
-	unsigned long long tmp;
+	s64 tmp, tmp2;
+	u32 factor;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
-		*val *= rescale->numerator;
-		*val2 *= rescale->denominator;
+		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
+		    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
+			tmp = (s64)*val * rescale->numerator;
+			tmp2 = (s64)*val2 * rescale->denominator;
+			factor = gcd(tmp, tmp2);
+			tmp = div_s64(tmp, factor);
+			tmp2 = div_s64(tmp2, factor);
+		}
+		*val = tmp;
+		*val2 = tmp2;
 		return scale_type;
 	case IIO_VAL_INT:
 		*val *= rescale->numerator;
-- 
2.30.1.489.g328c10930387

