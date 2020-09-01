Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43C259B96
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgIAREY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgIAPTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2020 11:19:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6DC061245
        for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2020 08:19:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v196so297463pfc.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5dyfdcxsLFzsVNr0u5gT5EuEw5CBY0e+onCAlz+mSE=;
        b=Uhg0AGCWZP0J1d3Tmwb/SBoSO/BKLuzoaqykqd8SqpN8k6h5EPp7DGfIF4/VovOsGY
         tu1X4zLWl7H9QE5J/rI/0FXoGHNZ24sfO8OejjyxR0ubCYUZhCrYatzsZb+smmDxXNvY
         PUJmuAe5N52oPr4zgPvLyBkcwHMouDvh5jDKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5dyfdcxsLFzsVNr0u5gT5EuEw5CBY0e+onCAlz+mSE=;
        b=d2appc1j4kl4iFbRiLUgQ0WhTo0iUuFtSBYkS8atQcmmVRw9aIa6yJGmP+qZV6mFmk
         EPS1AaPQiIqPhiARmD8o2OqUED5JxlmMfZv18cVHjd/ZqOJY5CKtyMSqrCV81+DxPyS5
         44P7YDzjSMvzZBk1hL5irp7ai1YCL2KXVohUSADw7VDLPjmi8V11W6xqJzgLNWmc3DUW
         XopDvMidflwHh+9KGPv6WN0i1eBUezNJVCnIqTYoXNZlMHBM4k1tO5Cs6F202B2CZPQ6
         EwLCVJS2TTi0xP6+rKmLGFNFaD7o9hYOOJxhoHxRTAAvwqKZQxFGYOvXcMqgd/x7XmcF
         qs8A==
X-Gm-Message-State: AOAM533KDdh0mf6Wud5OKd3t6pBQwx4HQKoUYZ/XPSKShl1TKCvlVLsf
        yjs4qJs63ee+mGKQr27raap88Q==
X-Google-Smtp-Source: ABdhPJz0oBbcKmWg4W+h+GHSNp7GbwrluQt340XIS43yWmSsaUM9b8QjpOJk9M+QQ6FIZWy93DuA1A==
X-Received: by 2002:a63:ba49:: with SMTP id l9mr1985721pgu.101.1598973590734;
        Tue, 01 Sep 2020 08:19:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id a24sm1885478pju.25.2020.09.01.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:19:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: sx9310: Prefer async probe
Date:   Tue,  1 Sep 2020 08:19:43 -0700
Message-Id: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On one board I found that:
  probe of 5-0028 returned 1 after 259547 usecs

While some of this time is attributable to the pile of i2c transfers
that we do at probe time, the lion's share (over 200 ms) is sitting
waiting in the polling loop in sx9310_init_compensation() waiting for
the hardware to indicate that it's done.

There's no reason to block probe of all other devices on our probe.
Turn on async probe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Updated commit message w/ details on why probe is slow.
- Added comment next to flag about why probe is slow.

 drivers/iio/proximity/sx9310.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 9d72d08ab9e7..6d3f4ab8c6b2 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1056,6 +1056,13 @@ static struct i2c_driver sx9310_driver = {
 		.acpi_match_table = sx9310_acpi_match,
 		.of_match_table = sx9310_of_match,
 		.pm = &sx9310_pm_ops,
+
+		/*
+		 * Lots of i2c transfers in probe + over 200 ms waiting in
+		 * sx9310_init_compensation() mean a slow probe; prefer async
+		 * so we don't delay boot if we're builtin to the kernel.
+		 */
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new	= sx9310_probe,
 	.id_table	= sx9310_id,
-- 
2.28.0.402.g5ffc5be6b7-goog

