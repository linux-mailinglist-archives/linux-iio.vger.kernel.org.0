Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1393695E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 03:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFFBn0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jun 2019 21:43:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41593 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFFBn0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2019 21:43:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id s57so872571qte.8
        for <linux-iio@vger.kernel.org>; Wed, 05 Jun 2019 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FiP6C8M+AnfQuXDwjbnSfrxZTIxdpkDsmXGsL6WmlFA=;
        b=YqxDo9M7zIi2MI5N1bOycEo/mhWeJj5HUaTAq0XPadeItKQ395S0IDNMsfkiXfJqmK
         W1BqK9gIjLg1rbdKNT0KoBgWc6rVhaowORpFH+LEp0SfsE2QV3IQbHalaUIKdvUw2cZD
         TWS7DH8/s/uxLIsbD7+sIUv80/aFdmnOPT2LXCC+e+uIbKlCZP1qPWV73oEFrRb4JfCm
         wEoitoPnQG0UdFvqZy+lK+bOOj/TKJ4FI2VaNvB1ir9HwD5i2jMjr8CSEwLuZ+o8XIky
         vaEdiZfwLp5HtFQE4HVuCQ0J4KRK7LT21IlCRbYztX2ephnS6sGt3GKG0wXdmiwNJQU6
         z//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FiP6C8M+AnfQuXDwjbnSfrxZTIxdpkDsmXGsL6WmlFA=;
        b=rEmcar8k+oJCefDBoLRDUFfk7A0RxGSJ+6Oi1JdrzMGqQ5bV0SHX2cn9PipCZ+XaUn
         5zHRlxE9hukDT/kDN5NX9cR6G2yUnwdjAfDrzRiq/KBCx7KOdI6y+WLMN91HfHoKhwdy
         cHgyFRfFWLS37MuPfSAJWxeDOaMbgTsh1yFK9i2oHvKixlf0GLxU1vLBGW+tSQE8TET9
         tmcVWcYu/U16dgG3jCF6scWlczKlMlNU9r81Y+bXH57CJH2oL752q7IwtN3bfIMGiHzK
         r8QhjkYqxQzQ0WC20PmWf0GWoRWoKy904xnGhJ33DnZYvsxwYqcw7T6IoDHYl6IM5wmy
         xdMA==
X-Gm-Message-State: APjAAAWD3l9EgbLN2fgsh4ldU0/JkegLmN/S0JUKJwe1Lu15OoWMWc1S
        rdNhUIBsWgHPL++jXB6zK5w=
X-Google-Smtp-Source: APXvYqzaGEdepNHjfYbwEQP5vNstVNj+mxP3oblEBeyG1DkIecVih+/e9+BlKOszBMyU3gO8HKPcng==
X-Received: by 2002:ac8:30c4:: with SMTP id w4mr36580131qta.314.1559785405091;
        Wed, 05 Jun 2019 18:43:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id p64sm174041qkf.60.2019.06.05.18.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:43:24 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        rdunlap@infradead.org, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] staging: iio: adt7316: Fix build errors when GPIOLIB is not set
Date:   Wed,  5 Jun 2019 22:42:46 -0300
Message-Id: <20190606014246.1850-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On x86_64 when GPIOLIB is not set the following build errors
are seen:

drivers/staging/iio/addac/adt7316.c:947:3: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
drivers/staging/iio/addac/adt7316.c:1805:2: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror=implicit-function-declaration]

These functions are provided by the <linux/gpio/consumer.h>
and <linux/irq.h> headers, so include them to fix these
build errors.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 37ce563cb0e1..5470a9c3f872 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -7,6 +7,8 @@
 
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irq.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-- 
2.17.1

