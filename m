Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2334AEB9
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZSq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 14:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZSqI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 14:46:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F48C0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 11:46:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p12so566719pgj.10
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/pp0FM+VJ7htm3l1HKkchJ+G4/kW8CYSXK4mXq8RRw=;
        b=GOZVo75swcdWCXz/OX/FWTH85HVlasa0VLhOh8Le0GsB/rzZduZu8xJ9uVZqKJ1c+v
         N513KlgMAxISJqSEZnyI7UbAUNKqAKdPk9r2YU7EbwCt/Ac7Ygk6J5DPodESy1LXhKwc
         yBG3rC7RPaJ4r9q6Ar7PAXPoQz448YaIQram8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/pp0FM+VJ7htm3l1HKkchJ+G4/kW8CYSXK4mXq8RRw=;
        b=f8m9SvyXj9TG7dpTVKAFWZQoJr8XQjZ90YG3IZ6toju/Xy8lVp9wgJq88jsJGhZbrd
         8eOeAOh6hsPkcKU8H1be19rUjIDoyZnFh/QsMOkgLyMZ7LEpmBQa06Om25zy2T6oSgLl
         hDMOsUH/tqAO4qJlA5ItGUluu+plV6I5ywOUaYDWarPFw23L6cIsgV1nVVaND/7ixdSw
         yLSUzmIfNoEr3+Zx8uC5XzlP7hNW9bBkuQakTA6adVH4nqWkOGSDqVwv7hX1TTi36aeg
         JCK1wxZXDS1dVtfGI4eDEDKrH4EA6AlpSVRfkfdBjkYCRKA8OMnp4cKon3t+U3YW81iZ
         U9Aw==
X-Gm-Message-State: AOAM533DaXFCMi2pIuU2HGoDEs81YpgHVtctvkAVg2rO7yy6uDQMwj8e
        hZJZPzhKdjpzBJ7yr/dFuDSyzA==
X-Google-Smtp-Source: ABdhPJySHjQwpZsoTt5ocm9S8hHbVBk3SBUmXbL+YnIo7D8JiXHO8F4qYHbtE4Nm1D2M3DAECV24lw==
X-Received: by 2002:a63:1119:: with SMTP id g25mr13180503pgl.162.1616784368016;
        Fri, 26 Mar 2021 11:46:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e071:1f4b:7e7:f3c7])
        by smtp.gmail.com with UTF8SMTPSA id o9sm10627677pfh.47.2021.03.26.11.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 11:46:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 0/2] iio: sx9310: Support ACPI properties
Date:   Fri, 26 Mar 2021 11:46:01 -0700
Message-Id: <20210326184603.251683-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Current sx9310 driver only support device tree properties.
Add support to read ACPI properties as well by converting calls
of_property_read_uXX() to device_property_read_uXX().

A bug was uncovered: if "semtech,combined-sensors" array was less than
4 entries, its content would be ignored, as of_property_read_u32_array
would return -EOVERFLOW.

Changes in v7:
Used incorrect device object in v6 to retrieve device tree properties.
Fully tested on machines with device tree and ACPI bindings.

Gwendal Grignou (2):
  iio: sx9310: Fix access to variable DT array
  iio: sx9310: Support ACPI properties

 drivers/iio/proximity/sx9310.c | 56 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 22 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

