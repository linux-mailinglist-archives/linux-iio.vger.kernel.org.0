Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A0343A9D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 08:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhCVHcg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVHc1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 03:32:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F7FC061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:32:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y200so10348868pfb.5
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACW7b1QSSudkM7qVIA/RWClJU3QOuBaD/F1iBpYvKBE=;
        b=L9gnUuWWE0qUdZCGz/ZUvkbNoohjO2SWa5MU1ZtjHnZ2tEoeJQ93N5FbNgDi1vIG+K
         3kGvoY7MxO+ZB00EKyoVRwJz9eqRrkAaq41M04fxbSRFwABsHLyRcVp0LPDlT1kH7y+7
         eSpk3li1QHQemaTEWUko5vWzL2B+H7AxfNNkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACW7b1QSSudkM7qVIA/RWClJU3QOuBaD/F1iBpYvKBE=;
        b=iz/CySOPRFiqzJUaVjNyRtufHb/Sb0nADa2VQGCwKMo6ZgWfOjZb4ROlZYdBaR1JTu
         r0dIMwFB2y/Nci/Yt5Plt9//EOptToSCPSHMPALpMWhB2Sz+9IHbbzLsEmAq6Yz28iq9
         RseXnL0/4xdCJWPbCHhTbjk4NRQeEXjYZuf4/HYaJyaELzbRXwJfx6D+tKuPE4AVuHpd
         8m7zdIc3W3HLTR3CUt10t9kd2kzrbhYohhgjNhmUBzwtQDklLuZ+W95Ine60GlBEWycH
         Tm7/sGDvsfjoaFbvYRENGyEmtcPVJ11qX33TFX4kzya//RqlvhdVTHPFipKmFwuJogFw
         jURg==
X-Gm-Message-State: AOAM533o0RK4NyJV9GvjhIvsEbYGYd46VwlcF+NJ4pUw/xrClD0Woftp
        2uqKCpUglMHfytP1tU4nfiMu5Q==
X-Google-Smtp-Source: ABdhPJxxYmEh7z1zyXdIdQbAWELzpGnCfkk72HAIOiwAqjx30KRE7QqylQHaDIuqFsB6PuCD1Uw9tw==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr21788720pgh.396.1616398346945;
        Mon, 22 Mar 2021 00:32:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:90ec:f36d:f115:8c9e])
        by smtp.gmail.com with UTF8SMTPSA id c2sm12953690pfb.121.2021.03.22.00.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 00:32:26 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        campello@chromium.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 0/2] iio: sx9310: Support ACPI properties
Date:   Mon, 22 Mar 2021 00:32:18 -0700
Message-Id: <20210322073220.1637117-1-gwendal@chromium.org>
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

Gwendal Grignou (2):
  iio: sx9310: Fix access to variable DT array
  iio: sx9310: Support ACPI properties

 drivers/iio/proximity/sx9310.c | 56 +++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 22 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

