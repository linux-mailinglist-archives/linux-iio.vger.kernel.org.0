Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CC3422A2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCSQ6W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCSQ6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 12:58:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D39AC06174A
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:58:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k4so3239324plk.5
        for <linux-iio@vger.kernel.org>; Fri, 19 Mar 2021 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amwYW5kcWHNwFy1h/kG8xoj/Mpb8Cd0PQb0wWJh698E=;
        b=mNUZf5SAG0+7JrB+M1ZhiMD8TG7S1b/S1BCBJgY09te/Oa1SIgIr+IrqC858/T2Yh8
         lc/lc2sI0rZLs/eleqZs9LxHaEP5Iwr2yQdz2KG3oApsCETqLjAHaK5Bskwwp6+deuRE
         dlzEmJnCfbFB2nT8f9MI9azXep7RS8L2X57vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amwYW5kcWHNwFy1h/kG8xoj/Mpb8Cd0PQb0wWJh698E=;
        b=ThruyNhfhDBOhAFkKKC/Tl4az/iFggo25wEAh2GVl09mq/WY9refYh89QOPt49qCk4
         9sq1A3d8WRgIbRcbHWCADqE1HkMHPmJcOk6kfhmJxGIgAyd16TGAE4CGltgPDi8mJbqg
         AwFOM6jFme37ptZ/2KiiYHYWBXDV/QpvWHUnTshzexYGZdmSJJQWHk4lpixndHBbL4gM
         NXwOOY7mA+TQZwt4oLw4/KvCQY3x8DmpuH2zM8of4N7u9pYgBgt31ueTh3c1+WSsN54d
         KPyAsvSciRMsxaE1SwtVNx0rkBCyd8fNpW5VXSlPKEiw77UycJ2VKIc0lys+CA4G8LUY
         MwZw==
X-Gm-Message-State: AOAM532TYeu2ddI6sVnTCnsdVl+DNKiXjusQkWqEim1uyMyXpTJKfykf
        oWLMp1UcK0gVakfEuoXHSr489ND0iCLLnA==
X-Google-Smtp-Source: ABdhPJxTMt7nqlLEvoeBUVBqo+M+xnhGONAe8vH+guWIXXYGCWneAp7/BjN9mhivfrWYmp/Cu1rZYA==
X-Received: by 2002:a17:90a:4e42:: with SMTP id t2mr11072062pjl.38.1616173093222;
        Fri, 19 Mar 2021 09:58:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:a05c:c77f:8a41:973d])
        by smtp.gmail.com with UTF8SMTPSA id gk12sm5825790pjb.44.2021.03.19.09.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:58:12 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 0/2] iio: sx9310: Support ACPI properties
Date:   Fri, 19 Mar 2021 09:58:05 -0700
Message-Id: <20210319165807.3639636-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Current sx9310 driver only support device tree properties.
To be able to use sensor on Intel platfrom, add support to read ACPI by
converting calls of_property_read_...() to device_property_read_...().

A bug was uncovered: if "semtech,combined-sensors" array was less than
4 entries, its content would be ignored, as of_property_read_u32_array
would return -EOVERFLOW.

Gwendal Grignou (2):
  iio: sx9310: Fix access to variable DT array
  iio: sx9310: Support ACPI properties

 drivers/iio/proximity/sx9310.c | 56 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 22 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

