Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129E4256382
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 01:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgH1XcV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 19:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1XcN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 19:32:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDCFC061264
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 16:32:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so1410471pfn.5
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xFAQrmhYdoX6dolO/dV/x1jRnJKxot5yKqFgxUbrpw=;
        b=OrPoA68/XG3CFfQ3z9rsuAh+oKpEe/GpxLe0LxEU6x8uaxdQUI3IlqIIs7H24eBvyQ
         H5mXeJt7A+imnx6fr1iWfR47/ZlG1rer64Ag2S9zMDZJrNtXbd0FK94a2lP8hpkiDzmz
         cxIZZFaNw7rMhQIbp//EB/C/40cFhEPfUEhno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xFAQrmhYdoX6dolO/dV/x1jRnJKxot5yKqFgxUbrpw=;
        b=qKDzbq45ruv9UI8v5QqtgWREJOZlNToZ84f2gwF1qOPFTMHTTVKa7Lrgn9MVzHRati
         x7FiEbqqVNj5dS5IiEW58KTgXVGuyBT6lY3sgNjw4+eLbMGZ23G3A5RNLqgGdU5haMqy
         luo0MgBX75vssvE4hX2Qg8bMQFmIHxvNKn9QiuYyMRnX5PErMM1tNdC9rFRpuW6nChjH
         UQQlrUKVIe3Izsg7ngSmqJa6Y+g+gzSNcHq9UcfxPqKz06CHg8vWIQsliMZXDuZgV3P3
         uasuk/SGFSWRuPrTwmqja8jhxXg3gxaqS95vlrzhTbjt+U9LLpFwuldJvqTVDu+UxQKi
         caOQ==
X-Gm-Message-State: AOAM531xXaCCu42/y235K69hcCuv4lYmTunjlVYUsj/cNV3Kjf1hSHIT
        TmmATxCoEDnGfMFvkJSLgdM9Ww==
X-Google-Smtp-Source: ABdhPJxJFqgIhGu5fYkYbgQx8WSnxnexvRS3fU0HzNB+ZA/U1rljMyYCx3UaA/Bv3mEqgmcJ/9+k2g==
X-Received: by 2002:a65:614f:: with SMTP id o15mr775410pgv.321.1598657532572;
        Fri, 28 Aug 2020 16:32:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id y196sm498198pfc.202.2020.08.28.16.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 16:32:12 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, peress@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/2] docs: abi: iio: RFC: Request to add event when offsets calculated by sensorhub change
Date:   Fri, 28 Aug 2020 16:31:54 -0700
Message-Id: <20200828233156.2264689-1-gwendal@chromium.org>
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

Gwendal Grignou (2):
  Documentation: ABI: iio: Use What: consistently
  Documentation: ABI: iio: Add event when offset changes

 Documentation/ABI/testing/sysfs-bus-iio | 81 +++++++++++++++++--------
 1 file changed, 57 insertions(+), 24 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

