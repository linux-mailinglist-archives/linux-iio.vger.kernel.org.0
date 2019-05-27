Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDA2B6B9
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfE0NnX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 09:43:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40599 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfE0NnX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2019 09:43:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so15883142wmg.5
        for <linux-iio@vger.kernel.org>; Mon, 27 May 2019 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCiJ2Da6Bdx0f26fODvp2y3M2kismC8wC26JqfeJQ7M=;
        b=OU+HYJGUyJkf6WspzAE2MO/L7hPgR/TCD9A7gpk41fnqGWvDnS/2YYprGRmbtyXVlM
         WAK4BRaMdlleBVdPjeFZrLYt36k5CksvpLzZ5nYh8z/jnxf299e47VaP68Ipsex+X0qZ
         0KRhfIZKEwMPvSBZ6CqW0ZxgMpXilxkJdI8GUyrUmyqZoV2RtDblYlaPpf+BrUFUv2Dr
         3KA7YjSSTWmgnktkfBTtpz1FB6Dy7Ufr+qaGnOO5Uj5hNZJcn8dvXt4Om+7tSbPnxKZ2
         +y5VQAiOVWzpdty3fLHtZHHUGzqFGuZQ2P3yog3VojGIlkqZ8HTVXU5t1YWKhcO9yK4u
         4GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCiJ2Da6Bdx0f26fODvp2y3M2kismC8wC26JqfeJQ7M=;
        b=Jfc1+77JkHa8fNR2qlRpgivJT7ICdzwi5UHKM4527t5cwf6k4EUy1kpjRI4B10t+uC
         sQYoChD98Ouuvvw1ts3X9FP0rmtTq9ZfGW5YfiLR7XIN5wZmZ+H012snqc9x0YxOTGYd
         QrLncfQxBqLAqyS1RIVyxtv6FSFAgP9Z9Io/CQ8YsoJKpZmwvZar9HP6iYRmJgFqs+ek
         S2T2dliUJOnvDrgi0Y/Kcq/2w8TNuCJlC1wYC1zN5nKfwz2GI/G12q/enHQ4hpLFdpyk
         /k8Je5Sca0VHzBFesQLI5ptywEwDRhODw60Bkn25AUq+dzwsRj98gqLXEFaOrIAf3RnE
         fwTw==
X-Gm-Message-State: APjAAAUN+K0Ft9Z1YaEfW0T2kJNvL27Of4FtpIEallbOfePApTJcuAm+
        /9NtBXkkOw2kTbwqkFhUVNSVEGwbjdcURA==
X-Google-Smtp-Source: APXvYqyWGZ1o+3JoKtMfo50PU7d32A1d9yTM0bYrWBeHwltd357tf1/9T5MWMWeTFOdN3r9igxK68Q==
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr24714908wmb.36.1558964600694;
        Mon, 27 May 2019 06:43:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n4sm12965536wrp.61.2019.05.27.06.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:43:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] iio: adc: meson_saradc: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:43:14 +0200
Message-Id: <20190527134314.4340-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- Used correct GPL-2.0 license

 drivers/iio/adc/meson_saradc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 510d8b7ef3a0..7b28d045d271 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
  *
  * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/bitfield.h>
-- 
2.21.0

