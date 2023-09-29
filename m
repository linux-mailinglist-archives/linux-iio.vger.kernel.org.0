Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE57B389D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjI2RZw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2RZv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:25:51 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34F1BB
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:49 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57bbb38d5d4so4906428eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008348; x=1696613148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKHIiAEIE2mVS9nRK2qrqb6L2W/l1AsQzObZva2M/Qk=;
        b=j4PQqsf2TA8TkYJ+C8KvefTKjDPFlZvpI1lokxnsLrQs4lzDlByW6WJVdZZAqgEAOs
         1r08PgUMG2N/OU4W5TBEnGYs4OInjBn8CvnXFowv2wCITrH5pSS1FjVS/fzllZaU+dUN
         kp+CTnbscvLpBFg0zFokBWDaIeJ4q/KpLhDeK+F3lFtxS0qresUnOsefaterSltQZNwH
         KcWNaW6/eyy14kHOGExsveguQy/WeFKmexiO7OtGw+o7CkP/3wsNhMSdpEuy655gDA/e
         ABCESi/JjxeNxiJoT8dYaZ8oF5f4/e8eF4ZKj1tPTOa8ya3UyA6qf5gL7EqD1yg+N+ma
         QlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008348; x=1696613148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKHIiAEIE2mVS9nRK2qrqb6L2W/l1AsQzObZva2M/Qk=;
        b=p9QRS43Nu9U64z1Jxd1DInJ/ogk5XjcPF2JBBT7KhIhDlvvZWB8RoOhnjbFX5hTx51
         mx4e8I8ztkbg4NnN22k/QBF7w2KuIFQBNGz+qCFNVIJUuC226NBuLNUWTahzMjZbV3g2
         //Q1Db6Qce19HNWCBbcP1Jdig+k0bK8B30Cs+OX8BYE+TcIdfQxHlh4GrjeZRJmTvUK0
         1ksKsNNyqFhH7fLkx4+WMOwK1bD2nY8Cq51IzzUPRebDTaWtYaNkFw3rG03cDTkv7SX3
         gx7bz1IUZ94T4kiPHs2s38ci3sXgVo5Y86Wopmr2L1wf9fwuDYrtKSYEyNKl1jWHiyxu
         UZ6g==
X-Gm-Message-State: AOJu0YyO6eHzwTwK3lpr6RIHYX5dzNx57DBsAoN9GPaRbAPQTNsdo3wO
        DsbIDnkymLjSqxHnXs82HsNoNneLrKO4PmRPXhLQtA==
X-Google-Smtp-Source: AGHT+IFylFVlQBDPI884Fz3s36mtqtFzBQzs0lhqAdNGptX/DuoiScazX4S3FyYmEUS2TjtVMukB/A==
X-Received: by 2002:a4a:6f49:0:b0:57b:5e98:f733 with SMTP id i9-20020a4a6f49000000b0057b5e98f733mr4812423oof.3.1696008348476;
        Fri, 29 Sep 2023 10:25:48 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:48 -0700 (PDT)
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
Subject: [PATCH v3 02/27] staging: iio: resolver: ad2s1210: fix use before initialization
Date:   Fri, 29 Sep 2023 12:23:07 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-2-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This fixes a use before initialization in ad2s1210_probe(). The
ad2s1210_setup_gpios() function uses st->sdev but it was being called
before this field was initialized.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* This is a new patch split out from "staging: iio: resolver: ad2s1210:
 fix probe"

 drivers/staging/iio/resolver/ad2s1210.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index f695ca0547e4..3f08b59f4e19 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -658,9 +658,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	ret = ad2s1210_setup_gpios(st);
-	if (ret < 0)
-		return ret;
 
 	spi_set_drvdata(spi, indio_dev);
 
@@ -671,6 +668,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
+	ret = ad2s1210_setup_gpios(st);
+	if (ret < 0)
+		return ret;
+
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;

-- 
2.42.0

