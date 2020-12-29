Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5C2E6D1D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgL2Bxs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 20:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2Bxr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 20:53:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A484C0613D6
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v1so677169pjr.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgX1vWmXsqLL2u5r8XIXzwJjTHAgdag+GB5T19oC7I0=;
        b=H2n6rnJq1BoIPMawMVGZsJR1Bc7aaS+f5SugX7m8XQnF+sesvWVV7LpkpVYVHj4hui
         B4+ANrnOHPRfj+JgYdFP/schle8cJa49bVoo2J2XniWxXZ4HuseNGBKRqNokt13gNAoX
         3a/cAduvVZ1N7fVMJYeIR7dwbYFbQyu/eKl7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hgX1vWmXsqLL2u5r8XIXzwJjTHAgdag+GB5T19oC7I0=;
        b=iiWaOcgprSWsBEXamxGUAbjKBJsBc0UiPmCoN1arIKE+T8iU409writXPwKFv19lns
         8QxQ/uycdeKJcM44BF6Jk20hz++EcqGyMjpuMD5RoaBeTPONT+YG6e6uD3C3b89ourGp
         Tku7yoF+lk0CGZJuJ3I01EtBpe6VOXr9Lyfwm8ZmJnG3SQBdYTY4rZl8PiMgLK1DyjSa
         HlpwI1Jt6x3FZjdskycsJUUlENN0M55SRNiop56f7IyFlTMYq7BDDBtV72eHeAISMh6U
         u6AQrkSUjhSNG3A+3dn7kJY+gmX9DgzgAlIRZZ+nRX82yTSjW/uJ1AZ5JYDtw06T5dni
         vDgA==
X-Gm-Message-State: AOAM533Pw5SgASGcQyomu+HXuZ86frkIInd52to2ZKkZgTx+YIIO5V1E
        TPTdXpHNjMj39mHiRGYXLfAEsvk3+iK4cA==
X-Google-Smtp-Source: ABdhPJxx5Q+eyJPHqjbYh5J/8VOKTdGSw8MZR/oBUESlvERsNsgN3sGlpJlwRHS9xWDamAPYDWyJsA==
X-Received: by 2002:a17:902:d90d:b029:da:5114:7275 with SMTP id c13-20020a170902d90db02900da51147275mr47844525plz.64.1609206786907;
        Mon, 28 Dec 2020 17:53:06 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id h12sm26012306pgk.70.2020.12.28.17.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 17:53:06 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 0/3] iio: acpi_als: Add sotfware trigger support
Date:   Mon, 28 Dec 2020 17:52:57 -0800
Message-Id: <20201229015300.3037816-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices (chromebooks) present the ACPI ALS device but do not have
ability to notify when a new sample is present.
Add support for software trigger (hrtimer/sysfs-trigger) to allow
retrieving samples using iio buffers.

The first path fully adds timestamp channel, the second adds a local
variable in probe routine and the last one adds trigger support.

This patch assumes the patch "iio: set default trig->dev.parent" is
applied.


Gwendal Grignou (3):
  iio: acpi_als: Add timestamp channel
  iio: acpi_als: Add local variable dev in probe
  iio: acpi_als: Add trigger support

 drivers/iio/light/acpi-als.c | 121 +++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 40 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

