Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB06029155D
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 05:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJRDRl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 23:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgJRDRk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Oct 2020 23:17:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C0C061755
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2020 20:17:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bf6so1250990plb.4
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2020 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ap55+k0X65QDFkUFbJaD0x0HZL0267/P8A6Qo+hg04E=;
        b=UvR0Keh20DwvExsmI1kJn1PE+XrVUrZ7nFBQkw2z5Xe3xMNlsgKPi+n/djf69X8XD8
         lNF/baQC3KxlkW7lPLR9z8/NSz0uOpLcNKthGGV4lYX7dTprm4Q/UC6/DSoXiebgW0xJ
         1rKbhcJ6kwWKrdzUk4yIU9TcfI0qIVGCGbUZ8ILQOLJ/UJ0byxhdiD8l3TUD6ytLAcv3
         ne98xzCc8lt93vwNr6jkVbBQ1diWe941x5mnG87sfL9w+fNTDq6p1pNnBqYPfFOdEMmm
         BTYx/cX1lRqt8Xd3BLL+uCnt/AeQDmeQwFNZM+TAHvBsjooH5dAgdDFzhko1J/6zkjNR
         FRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ap55+k0X65QDFkUFbJaD0x0HZL0267/P8A6Qo+hg04E=;
        b=sJYRYDqC/e93Y0ufi7v6KfkBpgkqUnu1MsLJETghHlvp2pCTnZOe/r4vKnYmEJP8aI
         nys/DYwchT6+q5wdP9+Ln4ZbzKZQxz5p3eXYUShK9X80y8Lb+i2X7r134Heqp3j3hiDo
         28DjT+/hilJH+xgRp+LwSDfPqvGTiNYRgJ2xZF6DKoZv+WF0k6SJqmXMfEKPMWXxf5fe
         PHMZGjHDNzPQst0k7v1Osjk3ssqjXk0dF0gs+7osSSNKp9yvW0+Je+oEgCJmogFqWute
         sHJyCzEWRCsPd8782UqUJhBnnOWypoHdG3JLhMTWtMuAbVIqr68FQ/vmF17QTJwolj/g
         s0Hw==
X-Gm-Message-State: AOAM533WL2s/g3d7/Oze51BHHhsIyXWPlAL/wU1TCo/u0fIOaTgXIzEZ
        HgwNOxQ7HBN7Sxj+KhzRG4jj
X-Google-Smtp-Source: ABdhPJyt6tarnmNiBF6KZgtHhZZo8v6bzh9VCB5fQfTD38VIABcCDRAVXJgkiioTHQC28xZ4mgbjNg==
X-Received: by 2002:a17:902:b68d:b029:d3:e6e4:3d99 with SMTP id c13-20020a170902b68db02900d3e6e43d99mr11577728pls.62.1602991058793;
        Sat, 17 Oct 2020 20:17:38 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id g1sm7396375pfm.124.2020.10.17.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 20:17:38 -0700 (PDT)
Date:   Sun, 18 Oct 2020 08:47:32 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: [PATCH v2] iio: proximity: as3935 change of_property_read to
 device_property_read
Message-ID: <20201018031732.GA27204@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

replace the of_property_read_u32 for reading
the ams,tuning-capacitor-pf, ams,nflwdth properties with
device_property_read_u32, allows the driver to get the properties
information using the more generic device_property_* helpers and opens
the possibility of passing the properties during platform instantiation
of the device by a suitably populated struct property_entry

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v2:
	- fix commit message
 drivers/iio/proximity/as3935.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index c339e7339ec8..7e47ddf89a56 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -355,7 +355,6 @@ static int as3935_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct iio_trigger *trig;
 	struct as3935_state *st;
-	struct device_node *np = spi->dev.of_node;
 	int ret;
 
 	/* Be sure lightning event interrupt is specified */
@@ -374,7 +373,7 @@ static int as3935_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
 
-	ret = of_property_read_u32(np,
+	ret = device_property_read_u32(&spi->dev,
 			"ams,tuning-capacitor-pf", &st->tune_cap);
 	if (ret) {
 		st->tune_cap = 0;
@@ -390,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(np,
+	ret = device_property_read_u32(&spi->dev,
 			"ams,nflwdth", &st->nflwdth_reg);
 	if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
 		dev_err(&spi->dev,
-- 
2.25.1

