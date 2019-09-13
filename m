Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B686B269B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 22:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbfIMUYS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 16:24:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54971 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfIMUYS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 16:24:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so3989493wmp.4
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2019 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lI5cXCZiltcOw32i5tTxJXg+1eYdV8rjXZUK1YMYhec=;
        b=tt+/4RCTW7bvOoJpuR3i4DUpokh00nWyCpg7sLlz6Qjd4gDJ/lAMBjYRomujhGc0P/
         zydYKMOwKdnfECN75kThWbdvZP6GZXdKycuGdFZyaCnsqPCEvb5h4Z9y8v7jqzxczpCh
         BSPrUwfiVopk6ql4KFuXcEHQXGfpHElKNM8pmkKKkUJ2Cs6UHiYiU7KmaOE3MMGJWPWY
         AlRonpgFfwlAU4UNVmR7wbd7VGNmMfkcBm6VFpz95vGmrja1Aq85dcckMwZIK/1ZyA1h
         WsmTWA+XfB0buBAVFjhamQo1PV0ijeDO13dYynYKLUYlSMFYh/wcFT1HyVtFUX7VZNHm
         I9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lI5cXCZiltcOw32i5tTxJXg+1eYdV8rjXZUK1YMYhec=;
        b=PAMnStT8oPzujLQI5AjM+VrL81Wtjn3A+lfFq6HF3iok09BaSa5ENfKh7A1m7ZvySC
         hqiTipySPGss792aiIoOyRHFhjBxedItNtmpydJIaj5zwHwGmEFYcpSkQ0M6SQHYEo+Y
         48HNiDWY7eW9ryOaTA759txOfmawJRja4/zR03eh/Sy7d0ZbF2nxfRnT/tfiiinGjeKJ
         EdEwnr63BaVNR9mFvC9I/+EaIw8aaq0ykoQJdq/3tLOiC+T7cL2oHcWFDYEgYft8kJsc
         FWVgAwF01jGqkZFXUdDXFbmVMSLKr6whfYYaainh3FnYeRfkadYQqCbWDDove0hR2jPj
         BikA==
X-Gm-Message-State: APjAAAWzDWkXLeAWyaXjmpXyoZElSYRyWTb5we1mPYMoePmwIidM81Pv
        IEejZ0Ytqru40s5DAhdwNWA=
X-Google-Smtp-Source: APXvYqz5e5SonAnOyXfVlXTOITnmGgiO1putKP9A1x5EHimwq/lKll3hPKOkXoVcUKzoySnwGHQsOw==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr4456335wmj.37.1568406255663;
        Fri, 13 Sep 2019 13:24:15 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id n30sm3174054wmd.15.2019.09.13.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:24:14 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: light: bh1750: Resolve compiler warning and make code more readable
Date:   Fri, 13 Sep 2019 22:24:13 +0200
Message-Id: <20190913202413.3034-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910203814.31075-1-kw@linux.com>
References: <20190910203814.31075-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Separate the declaration of struct bh1750_chip_info from definition
of bh1750_chip_info_tbl[] in a single statement as it makes the code
hard to read, and with the extra newline it makes it look as if the
bh1750_chip_info_tbl[] had no explicit type.

This change also resolves the following compiler warning about the
unusual position of the static keyword that can be seen when building
with warnings enabled (W=1):

drivers/iio/light/bh1750.c:64:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Related to commit 3a11fbb037a1 ("iio: light: add support for ROHM
BH1710/BH1715/BH1721/BH1750/BH1751 ambient light sensors").

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Changes in v3:
  Updated wording of the commit message as per the review feedback.

Changes in v2:
  Made definition of bh1750_chip_info_tbl separate from declaration
  as per the review feedback.  This also makes the code more readable.
  Updated wording of the subject and the commit message.

 drivers/iio/light/bh1750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 28347df78cff..adb5ab9e3439 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -59,9 +59,9 @@ struct bh1750_chip_info {
 
 	u16 int_time_low_mask;
 	u16 int_time_high_mask;
-}
+};
 
-static const bh1750_chip_info_tbl[] = {
+static const struct bh1750_chip_info bh1750_chip_info_tbl[] = {
 	[BH1710] = { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
 	[BH1721] = { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
 	[BH1750] = { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },
-- 
2.23.0

