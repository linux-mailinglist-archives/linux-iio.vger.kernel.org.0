Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB9512237
	for <lists+linux-iio@lfdr.de>; Wed, 27 Apr 2022 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiD0TQK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Apr 2022 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiD0TPy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2022 15:15:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A8D59B9C
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:08:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 15so2177930pgf.4
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxB/MmeSVV9Xa7hn2yUYNIv+Eu231g26lclc81a6EJA=;
        b=Q38ekWoNbZEacNduotzL5WJ6RkpGUcYXtS4SzffoG73jYMgc8Vu9opHzp47xeYlFg6
         pI1dfhiva4r3zu6cchc8booRLAQ2O4gpKWpZU6BDrZCgqeciP26Vsk2+GInZGtjLLX98
         kyc6/QLC8seNsCzZ8qWr5UO7p0SjvPTB8bleg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxB/MmeSVV9Xa7hn2yUYNIv+Eu231g26lclc81a6EJA=;
        b=MiEdIzzcQ9VOYlrzDrEWocVTLSYpj4bYUDbAVpxPB4ICHXMKhNEvxW3xo9GYrZmbzb
         VAKwuqqD3cJVePf9tPi+C++VZ2MUvvlZi7iATFGcoKN3hzC9amp7YD8emNOI+Ngvt1iO
         Pn4lu+sAJX0tNvka/ZqZdKoPJJ2hIYiqXwZhjE4XT9lp3jFo35nViSRO48na2c7/QwY6
         urTsIGQTbRM6DsL5vjFD/Yzf4W2kGYHa4axrHg7bYewZBjgik/vIHksNDt1FO50lGGdn
         UODKKhh4pppbyv9c9AmHl+MXhrPxitpRrqtdTV+f6irfuibdl8jBEGFaEfEF7dggojgl
         MkRw==
X-Gm-Message-State: AOAM530JZFr8w/AvbmgATy6cFVbWtc+C4/Z7vQZENmMz3Qb1UX5zLOoj
        rBloQhGLDzDIBke/PftjTici96oUbEmqsQ==
X-Google-Smtp-Source: ABdhPJxFEyOo2/b0KX9g/pyPd3Gg7CoiMTKZLOXXAYEftGbC77BWjYcs9QszKsuk+fYk0dKup+DXmg==
X-Received: by 2002:a05:6a00:13a2:b0:50d:4ad4:544f with SMTP id t34-20020a056a0013a200b0050d4ad4544fmr13677938pfg.54.1651086495994;
        Wed, 27 Apr 2022 12:08:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e71:6689:b6a2:6150])
        by smtp.gmail.com with UTF8SMTPSA id j64-20020a62c543000000b0050d260c0ea8sm15905000pfg.110.2022.04.27.12.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 12:08:15 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org
Cc:     bleung@chromium.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/2] iio: ABI: Add a new location label
Date:   Wed, 27 Apr 2022 12:08:03 -0700
Message-Id: <20220427190804.961697-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220427190804.961697-1-gwendal@chromium.org>
References: <20220427190804.961697-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add "accel-camera" when an IMU is location near the camera in a swivel
sub-assembly. These IMU are used for AR applications.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 changes in v2:
 * New, add "accel-camera" define.

 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d4ccc68fdcf05..3e00d7f7ee22b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -79,6 +79,11 @@ Description:
 		* "accel-base"
 		* "accel-display"
 
+		For devices where an accelerometer is housed in the swivel camera subassembly
+		(for AR application), the following standardized label is used:
+
+		* "accel-camera"
+
 What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
-- 
2.36.0.464.gb9c8b46e94-goog

