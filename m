Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4023B4E38DE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiCVG0x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiCVG0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:26:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227DF29C96
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x2so1105293plm.7
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4lnF6WH2JiFLQIjY9++AH603zbzpU8W6RZVc5shiIc=;
        b=T1g/4PCbOeYmnlW4ceWT2FHKLk9EkZYxsjibYXv4IhTHUUUfYMPHYr1RQznRraQXST
         NaFJJWSHeviStGVX6UFkLQ/E+hu+a+bYvPL6HMH3XAZ3cGawhmSibzartCUn/44U6iIo
         HOVM+PddS9CIe8vYrNCAs4KrAci7gENTlSdJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4lnF6WH2JiFLQIjY9++AH603zbzpU8W6RZVc5shiIc=;
        b=r8PxLTnmpeLHfMDmEDtwTyOUKIok/Om37snheJn/T7Lw2flQ9e1abKvMisoXS6W3It
         yfoKnrrQe41oDNkfMEeoP7l0tUs3VJInihnzCZNx5RGhbvblP0/P+0voUk3BsFvgqLOd
         gLZoGb1ptnmMFO4cFlffx0pEH7NaVCibfZV/JQhXgJ76VI5PiHsWa0/Z227rmiQnya+e
         VboftbTz2Qiw5kSrkTPx1t3hQucOhgPzR16gZOaDWOLVLKUoZpIo9Fk8Lsq1PV4wrPd8
         GmgfxB3HrgPzMna9b7UPL+vvDdqxyfgifZsDJCUibCGuQIHjbni0EPvIYhzQWCrTbBs1
         hmyg==
X-Gm-Message-State: AOAM531X3uYcUVKElqtbgIC/neyA7XSbrIDHiB7UP5Jzr/C5H4adhuKW
        DP4HsvHalEAV0ovOK15BzHRPBw==
X-Google-Smtp-Source: ABdhPJzyVhLalQoN68U41cY0djWlnNGWyolZsN2zI1e3B5JmW4E/ZEuJFaEDm3qktCCRsNu8XBzH0g==
X-Received: by 2002:a17:90a:e7cc:b0:1bf:5ab5:f481 with SMTP id kb12-20020a17090ae7cc00b001bf5ab5f481mr3109790pjb.215.1647930308666;
        Mon, 21 Mar 2022 23:25:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c016:a147:e7e:6836])
        by smtp.gmail.com with UTF8SMTPSA id h2-20020a056a00218200b004f66d50f054sm21294183pfi.158.2022.03.21.23.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 23:25:08 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, robh+dt@kernel.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/8] Add settings for precharge and internal resistor
Date:   Mon, 21 Mar 2022 23:24:56 -0700
Message-Id: <20220322062504.1019504-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For Semtech sensors SX9324 and SX9360, allow confugration of the
pre-charge resistor (9324/9360) and internal resistor (9324).

Fix register name spelling mistakes first and set default value properly
for sx9324 internal resistor register.

The 9360 changes are independent from the 9324 changes, but they are
very similar.

Gwendal Grignou (8):
  iio: sx9324: Fix default precharge internal resistance register
  iio: sx9324: Fix register field spelling
  dt-bindings: iio: sx9324: Add precharge resistor setting
  iio: sx9324: Add precharge internal resistance setting
  dt-bindings: iio: sx9324: Add internal compensation resistor setting
  iio: sx9324: Add Setting for internal compensation resistor
  dt-bindings: iio: sx9360: Add precharge resistor setting
  iio: sx9360: Add pre-charge resistor setting

 .../iio/proximity/semtech,sx9324.yaml         | 19 ++++++++
 .../iio/proximity/semtech,sx9360.yaml         |  9 ++++
 drivers/iio/proximity/sx9324.c                | 44 ++++++++++++++++---
 drivers/iio/proximity/sx9360.c                | 12 ++++-
 4 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.35.1.894.gb6a874cedc-goog

