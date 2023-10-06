Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028027BAFC6
	for <lists+linux-iio@lfdr.de>; Fri,  6 Oct 2023 02:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjJFAv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Oct 2023 20:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJFAvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Oct 2023 20:51:16 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD21FA
        for <linux-iio@vger.kernel.org>; Thu,  5 Oct 2023 17:51:12 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dcf357deedso1018549fac.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Oct 2023 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553472; x=1697158272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T7BVSnCg1/cUl4wXGqCN8/b9YuCnpkLFlG0GeZ+BeA=;
        b=CWkfLtW0BrkmLT3IPjwX/SiayxAbBIfssF7paw6fDIO0KRATUOeoxMpwa42uvmnWHg
         PsBjJaznJi3MTZmwfvrDkIS5glkYUInZr47mA40jbD7jG3Hdi6gjHyw05cCO5dIYIv2Q
         w00uq8pI1tJVnvECzfTaknUK6mo4WihxpUgwGazHPTE8eF8uF88xS28oJHj++ibZNVGf
         tLmHoOWXnXbrFz/bK2RhHaD05qGUIg7ae+G6LS6KQ4e99hcsPhnkj6woykaWS6rSr8Bq
         Fwdv9IUMpaqKeAje74fxyg989FNNqb5X7ufFg3uQ4qU780KDvsl+oVOnCy8y2xy4KFxK
         Is5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553472; x=1697158272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T7BVSnCg1/cUl4wXGqCN8/b9YuCnpkLFlG0GeZ+BeA=;
        b=UQ9XTz5pe8+052p4bo1Fbe7YcopOhLk1aKw+gAz2OGY2eMflu4DEKk7l116dvvtXsi
         X4k1TMMBTbviXDoLYNmB1h4CO8Hu9UQAAW2qYoGpYmAaClcQ+q+kxCrPhbrvB7z5NKX6
         QM539fdqsg4ZksQ8T8D9NZjRrLBD+Qjz6E/6+BCuKxprhcbAWhRabyc11zKgxbcgGk/8
         tOD5OGcXymifPUKxD/Y8uFsfVLIHQGaqtKhRVDYXy8oVvNeIC7QKn7rnNPffJuS5IL2U
         /QYdiYqvhBrRg7wEdLAH4+hMdy6oZiY174iNN4WbieRusNdM6/ihvW6nsnJpYsv01gkf
         fBMw==
X-Gm-Message-State: AOJu0Yw7eYNoYBIqGrfWrvnW/s9ayCrUOiepM0cuDcE5px+Yi3Ap50JU
        TqzEwBu5FUryVZ/ALaD9iiorcivqK3nie1cVZvY01g==
X-Google-Smtp-Source: AGHT+IHpUBVPVzt8Rvv+Abh9RQQir5IRY2MQPcTfsEhJTI2ae1YBB0+HiXXH/xvlxbCVmkQnzYk3pA==
X-Received: by 2002:a05:6870:310e:b0:1dd:827c:e425 with SMTP id v14-20020a056870310e00b001dd827ce425mr7215769oaa.57.1696553471986;
        Thu, 05 Oct 2023 17:51:11 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:11 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/17] staging: iio: resolver: ad2s1210: convert DOS overrange threshold to event attr
Date:   Thu,  5 Oct 2023 19:50:26 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-9-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD2S1210 has a programmable threshold for the degradation of signal
(DOS) overrange fault. This fault is triggered when either the sine or
cosine input rises above the threshold voltage.

This patch converts the custom device DOS overrange threshold attribute
to an event rising edge threshold attribute on the monitor signal
channel.

The attribute now uses millivolts instead of the raw register value in
accordance with the IIO ABI.

Emitting the event will be implemented in a later patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Fixed missing word in commit message.
* Fixed missing static qualifier on attribute definition.

v3 changes: This is a new patch in v3

 drivers/staging/iio/resolver/ad2s1210.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index d52aed30ca66..3c224bbeae17 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -747,9 +747,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
-static IIO_DEVICE_ATTR(dos_ovr_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_OVR_THRD);
 static IIO_DEVICE_ATTR(dos_mis_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_MIS_THRD);
@@ -791,6 +788,13 @@ static const struct iio_event_spec ad2s1210_monitor_signal_event_spec[] = {
 		/* Loss of signal threshold. */
 		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* Sine/cosine DOS overrange fault.*/
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		/* Degredation of signal overrange threshold. */
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
 };
 
 static const struct iio_chan_spec ad2s1210_channels[] = {
@@ -864,7 +868,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_fault.dev_attr.attr,
-	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
@@ -904,12 +907,15 @@ static IIO_CONST_ATTR(in_phase0_mag_rising_value_available,
 		      __stringify(PHASE_360_DEG_TO_RAD_MICRO));
 static IIO_CONST_ATTR(in_altvoltage0_thresh_falling_value_available,
 		      THRESHOLD_RANGE_STR);
+static IIO_CONST_ATTR(in_altvoltage0_thresh_rising_value_available,
+		      THRESHOLD_RANGE_STR);
 static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
 static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
 
 static struct attribute *ad2s1210_event_attributes[] = {
 	&iio_const_attr_in_phase0_mag_rising_value_available.dev_attr.attr,
 	&iio_const_attr_in_altvoltage0_thresh_falling_value_available.dev_attr.attr,
+	&iio_const_attr_in_altvoltage0_thresh_rising_value_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
 	NULL,
@@ -968,6 +974,9 @@ static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
 		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
 			return ad2s1210_get_voltage_threshold(st,
 						AD2S1210_REG_LOS_THRD, val);
+		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_RISING)
+			return ad2s1210_get_voltage_threshold(st,
+						AD2S1210_REG_DOS_OVR_THRD, val);
 		return -EINVAL;
 	case IIO_PHASE:
 		return ad2s1210_get_phase_lock_range(st, val, val2);
@@ -1001,6 +1010,9 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
 		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
 			return ad2s1210_set_voltage_threshold(st,
 						AD2S1210_REG_LOS_THRD, val);
+		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_RISING)
+			return ad2s1210_set_voltage_threshold(st,
+						AD2S1210_REG_DOS_OVR_THRD, val);
 		return -EINVAL;
 	case IIO_PHASE:
 		return ad2s1210_set_phase_lock_range(st, val, val2);

-- 
2.42.0

