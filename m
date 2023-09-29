Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E07B38D1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjI2R0X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjI2R0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:26:13 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B15CD0
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:57 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57de6e502fcso2661735eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008357; x=1696613157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIleoNt3McOityrbAncOn1e2uXvostp1PJRCN57ck0k=;
        b=juM0OS4v9Z3qzhmqi45kCjhxRbfDjT6LI0IEOqjM/XzhkcwOq5xqFd36YthYgZAKlR
         1nMveCZ2BmPnsWSUs/CM3gZu9kPfushr63GFM4IA8u7aOJ/BsK/Hc7BDXrzmayuvrCmZ
         JzGGMBMi63EEhVlJZwyA7+ZgIUewvGtuSwxl4UKZ3mjVjvAKRvg7sjGyKeczYC+I1rnh
         3dGWcS1IyPuDdfRRDBI4XzJ/57tkaYF53c6jQvllOMDQmkiTF8rq1M9TBld3+LySEAn6
         W/drXibQl6xI2BYaQzBqJurK+1lUZ6Z7bAHlaRXGZFClgrBW/8HHdbtqLl03EU6xiVYs
         kzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008357; x=1696613157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIleoNt3McOityrbAncOn1e2uXvostp1PJRCN57ck0k=;
        b=WlqykEe39qec+b/sPHy5UJmmXG281IFvA34sRnLG4ZuFgPT7SZBH6VjhI6QiHYInzc
         yQ8KFCnOabRKw+zfQ3Vhc8PXhzrLL/caBqtYYKxEMOwnMBlNAp76fa+bFgPAkHV/1wKZ
         3w6RoPAlFycA58gQtFpukdiHt+5ph6MCyFu1BfYlc+yWaDwjt7xW5UJqLOJTH6aci7O8
         3b4mUFa5vj769b+e098df0igRkEZfac15ptVPSzV2mlNYhSI4dYrs6eOJG5Cvn/tDLb1
         hW9Nh1R1VzbpYh5wUYBGvwN4Gu9i1gqZyE3NC5TY/jq/vJFXHaBCmuwvmky1mNdbV0+j
         6Hpw==
X-Gm-Message-State: AOJu0YwhPqYuKskoNVDLqofLZ3njhAdDcnC+xmOSjfFPfcC9gRps+ath
        Zj/rXZlvex2TDlW7/R6X70WS3jsMZ9ea8DJON9umQg==
X-Google-Smtp-Source: AGHT+IHLFf9v4qAbn38RSz6/N2MsDw9a72xTy6kMUQDUcQjaR4b3zXDVJNtTSV4old/0mSNpduMelg==
X-Received: by 2002:a4a:3c07:0:b0:57b:6f5c:c90a with SMTP id d7-20020a4a3c07000000b0057b6f5cc90amr4717947ooa.8.1696008356922;
        Fri, 29 Sep 2023 10:25:56 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:56 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 11/27] staging: iio: resolver: ad2s1210: add debugfs reg access
Date:   Fri, 29 Sep 2023 12:23:16 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-11-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This add an implementation of debugfs_reg_access for the AD2S1210
driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes: None

 drivers/staging/iio/resolver/ad2s1210.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0663a51d04ad..31415fbb6384 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -614,9 +614,29 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	return ret;
 }
 
+static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
+				       unsigned int reg, unsigned int writeval,
+				       unsigned int *readval)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
 	.attrs = &ad2s1210_attribute_group,
+	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
 
 static int ad2s1210_setup_clocks(struct ad2s1210_state *st)

-- 
2.42.0

