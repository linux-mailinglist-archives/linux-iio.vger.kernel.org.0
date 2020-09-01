Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639EB2585EF
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 05:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIADAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 23:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgIADAZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 23:00:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC652C061366
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so1869846pgl.4
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dg6B3xUWkGoHTBLaDztTLUoPab25MweyPyTalvlE4M=;
        b=ZGQbvj4BJQjZIawJmQ8EFky5tBnbefbuil2cCcKRTl6xY1qBuhad2N1cLS4FIvMO03
         QrD+8KivioCnG14y0YVh8GwyYUVFcG3MjRcPHS3xjsSFf6Xz/nx8tzeCiRASkkwMnMNX
         qGX1T8Vv04V9F4FZYq6Hjsg4xHbP8akzTJNjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dg6B3xUWkGoHTBLaDztTLUoPab25MweyPyTalvlE4M=;
        b=tHVRdgaB5bn59vE2wzxGc+BJzOXYFDbn56+DSTa6e4vrJI3ALZVfDd+LHrEbbnl+V1
         a466NWxysWM2maSJlX1/fGz2CxwdjFjAH9OUyCPKjC6x7W7Z5Ywu3iIOCpCsBra35wfu
         a6UcR3BfaBLg3Cev5/cLAg3jkWJ7XVhV4D7JUiPQDJKvEbkps+aI9FbgxD1FOTpHuaYP
         NRcnPcrJuYLsfEfW6cCPFpTwKY0vrkoQ76dfVUwgaO39S3jf19VqzxE8mTmjPcJs2T4M
         JiYhyQlhnntifZcLVd68hU6sRlleopjBl01GME9VTB6tl5szcUxSdAni0zCDDUwHPk6r
         wqQA==
X-Gm-Message-State: AOAM532+wZesRwr1Zetohyozhq0Ak8Baal5eUpIRS8TZCQ1Q5QF68gP6
        eruPUx1xiPNWgysjPdw1+pjgQQ==
X-Google-Smtp-Source: ABdhPJyNvgrkPOQXOI8SZwZb2BHy5xoppzG/hqMF5gK2Uo6svZh70XDRAENzlSzlJWuSETQUD6dpxg==
X-Received: by 2002:a63:d40c:: with SMTP id a12mr3684705pgh.256.1598929224250;
        Mon, 31 Aug 2020 20:00:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id o6sm1018883pjs.41.2020.08.31.20.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 20:00:23 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, peress@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/3]  docs: abi: iio: RFC: Request to add event when offsets calculated by sensorhub change
Date:   Mon, 31 Aug 2020 20:00:14 -0700
Message-Id: <20200901030017.3221295-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some sensor hubs calculate offsets for some sensors, like hard or
soft iron for magnetometer, or drift for gyroscope (in addition to
factory calibration).
However, the user space application is not aware when the sensorhub
produces a new set of values. Instead of polling at regular interval,
iio driver could send an event when a new offset vector is available.

Gwendal Grignou (3):
  Documentation: ABI: iio: Use What: consistently
  Documentation: ABI: iio: Add offsets for some sensors
  Documentation: ABI: iio: Add event when offset/scale changes

 Documentation/ABI/testing/sysfs-bus-iio | 80 +++++++++++++++++--------
 1 file changed, 56 insertions(+), 24 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

