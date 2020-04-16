Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4021AC501
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 16:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393526AbgDPOJl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393229AbgDPOJY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 10:09:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCAEC061A41
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 07:09:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m8so8013545lji.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2cSkXHmvUNwPdGeVkj60CCBpcqm/zp0JNhGGEDa8e6c=;
        b=wft9es95d/UBAGc/gHlKWquJct6ZDPlxhqz8XVNlsJgUyYYFv5npGT+B8y/gb2HGy0
         aArvOQ8QLLihF6z+o9Mr1VbiSkeCZCvx6YPqd4Fx+SlR21QJ1yIJ71LoUwwiJceqk7am
         Eh1Vg5VKyxYOU3DuyC2r12+snGkI1UB9FWjWaONhVSHoNV5VcxFDD03Q6vN/XdkXAp8n
         PNrbIkJCbO4h6tyu5T85Ga3rUXQI5+nV5gMZh8g4u++1ST/Va2e9SGpuXWxP0i4KXXBi
         0KrveZGh2BzHhlx+MWOPz1dSOLDlippk34ejEelLvwpPmR3ZhlkoejoKr4wsTYzgWZWv
         W7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2cSkXHmvUNwPdGeVkj60CCBpcqm/zp0JNhGGEDa8e6c=;
        b=l0tikINNEMNU9KNWp9DmbYM9Lx6/ue5jc8MdpWOay4uh0OnjqEd5Ztb/ArpP3XIxFd
         M0wHcFhD5xSjgCbPlIqioq9fYVfypQpp3s9tB6iAtwy2bC48N6/eEmTfQ/7+XNuA0lLU
         /O8pZ/ywTtzJXVla4ljqNhGz0QcSXfwjPMv7XmsHxJ3lhKULhC4CthKHsIVa20Q08Dw4
         XQn/lE+52m249HclzKURrMH41PD3kmHj5SS5fRDDr3SxMDGGoaaXxJDJFB1XnpkkrxRx
         nMUn67W9YxJDwCYgh3osn2aatPN76edCSag/1g3mfbCDQbK1HLfsD1fxuYu8G67gnFJW
         yJcA==
X-Gm-Message-State: AGi0Puah3U3IIIxSiFdvJOwwXcZNCmMNjj3E3T+85ghhKOAsuoJ2LAJm
        aem5pix7FnDXsHDx+pDskVV9qg==
X-Google-Smtp-Source: APiQypIZv2NDJQmoyhSvQfPxfh+Eajh9UXVOuik6AHjDW0mBW1kGCsTWSVi6bzeVb0uVVVgXNP/Avw==
X-Received: by 2002:a2e:3a0a:: with SMTP id h10mr6137225lja.54.1587046162057;
        Thu, 16 Apr 2020 07:09:22 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id v12sm9744045ljd.85.2020.04.16.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:09:21 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2 v2] iio: magnetometer: ak8974: Provide scaling
Date:   Thu, 16 Apr 2020 16:09:17 +0200
Message-Id: <20200416140917.8087-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416140917.8087-1-linus.walleij@linaro.org>
References: <20200416140917.8087-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The manual for the HSCDTD008A gives us a scaling for the
three axis as +/- 2.4mT per axis.

When I implement this the biggest axis indicates 0.59 Gauss
which is a reasonable measurement for the earths magnetic
which is in the range of 0.25 to 0.65 Gauss on the surface
according to Wikipedia.

Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Split out the measurement refactoring.
---
 drivers/iio/magnetometer/ak8974.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 5361647b9054..effcdd93e650 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -603,6 +603,18 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
 		*val = outval;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * The datasheet for HSCDTF008A, page 3 specifies the
+		 * range of the sensor as +/- 2.4 mT per axis, which corresponds
+		 * to +/- 2400 uT = +/- 24 Gauss. So 0x7fff is 24 Gauss and
+		 * 0xffff is -24 Gauss. To account for the one missing value if
+		 * we multiply by 1/S16_MAX, instead multiply with 2/U16_MAX.
+		 */
+		*val = 24 * 2;
+		*val2 = U16_MAX;
+		ret = IIO_VAL_FRACTIONAL;
+		break;
 	}
 out_err_read:
 	return ret;
@@ -667,7 +679,8 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_SCALE),			\
 		.ext_info = ak8974_ext_info,				\
 		.address = index,					\
 		.scan_index = index,					\
-- 
2.21.1

