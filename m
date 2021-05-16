Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7B381CB6
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 06:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhEPEox (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 00:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhEPEox (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 00:44:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38482C061573;
        Sat, 15 May 2021 21:43:38 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a22so2811743qkl.10;
        Sat, 15 May 2021 21:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFSq1P45HiPR4NysoTv8ztf6FL6VipMFTqP0o/F0J9U=;
        b=B7eefHeO2M+wKu7LgIeb76+aV8PvhiYMWPtRR4LmxPhQJwlNHgJPA4gPZCvb8c1nfY
         H+Oqmh0BQKRSZqe6SgOlNV17GS1bZ8OVysvxIkpQWOsLWcz7I6R65RjA92i4E5HVJ4RY
         T47uvCeoxoeQA3RdMG7uR1ZdgwSTeXs9bypOW6znUl7EtTe6e5O3egMhM8y7QZjDMyeV
         t4tqPkFxqcfrc/ldJ5j688uVqRODdr+HaP7svfZLdDsUk+qS9GAIR3NTWRs/UKV+qzJ1
         lLDbSwhpucY8/QCDHyFe456wg7cmUK8mHyWhst7otIKozpNVrgwHqH4C93E0mUZDwQUL
         oC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFSq1P45HiPR4NysoTv8ztf6FL6VipMFTqP0o/F0J9U=;
        b=kc6zki32c+oz/uqjQDPKDrKPMb8yzCqwJq2kOnXh0eH19555Nq8OWlsaMa+PhSGQ8I
         BYITHZZlHgMl+F5Hw10Gi/VfKYmTFJ1gEXdn0pGh+dqPiVh1YRdYXnt4Ds2XldnKcBzK
         O9vljo+PwPksdE352aMSjY+h4XcR1tasAR3E+YqBNZBcPPOsQJfW8FsenVFWMB4KOQqz
         z5dKmruOdNbaWz0PIABMEFxNcsAnexpjCGoYcYfBPGwct+c6rDMpMpwUOQcroW1iEkBA
         KtJ2Gk5d7VzldxCVM8K7dCCLuS+AQmHqg1nY2mRdJXF+73VsJG4cuLvUG3Xocav6YVvf
         l6og==
X-Gm-Message-State: AOAM533OY8XODiRHXX1V9Rl0NtXgiWNQN31TwAf5vtHOl7gYLSiglSNo
        S44jJmwvomQrh8EeGMnTFUQ=
X-Google-Smtp-Source: ABdhPJz7QDRWFlW/DnXfuIAEJ8i4GpPprNobXxiPI9hVjG06x9WfsrhTFc3X6KQ4ezDVSlyTcELxow==
X-Received: by 2002:a37:994:: with SMTP id 142mr50421667qkj.119.1621140217477;
        Sat, 15 May 2021 21:43:37 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j28sm7750980qkl.35.2021.05.15.21.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 21:43:37 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: [RFC PATCH v1 1/2] hwmon: (iio_hwmon) optionally force iio channel type
Date:   Sun, 16 May 2021 00:43:14 -0400
Message-Id: <20210516044315.116290-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210516044315.116290-1-liambeguin@gmail.com>
References: <20210516044315.116290-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a devicetree binding to optionally force a different IIO channel
type.

This is useful in cases where ADC channels are connected to a circuit
that represent another unit such as a temperature or a current.

`channel-types` was chosen instead of `io-channel-types` as this is not
part of the iio consumer bindings.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/hwmon/iio_hwmon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 580a7d125b88..365ea2359b22 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -109,6 +109,8 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
+		of_property_read_u32_index(dev->of_node, "channel-types",
+					   i, &type);
 		switch (type) {
 		case IIO_VOLTAGE:
 			n = in_i++;
-- 
2.30.1.489.g328c10930387

