Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39010E789
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 10:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLBJSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 04:18:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35589 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBJSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 04:18:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id r15so24393556lff.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 01:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXQpm62OdNe8S6jM4uDDEjsuAbyudOulu0Fnf3UJZ4U=;
        b=ly4odl5/AX4KqoSvifwgS4VdZF2BGwq0wsO0t3tlld1gV+u/9B+FNvktaaV7PIN6Gt
         5hMZkNom9B3xSl4mn7U+QGWH63VmrKCGsGUdpz2FZbSPGD/kfuZ8rNtxsmE6rcbdk+d6
         7A9BScKoJqLu+daadN5G7titkraa0NDwnaQoX7FQMZKZs7iJWEkk8pOgDn+jG8j21lMW
         it7JwMr6NWdq9hudhKJZpMX5qkZ4whs9DukEZ+z895PbPbFi7VHGZTZtazJXHGcXpfJ2
         K5P/Fgn86uKu2eaOJgu276pqwK+htFAZOfzMBvwiBxE7Sf9+Af8M7BRtY6UDq2deXyWu
         N95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXQpm62OdNe8S6jM4uDDEjsuAbyudOulu0Fnf3UJZ4U=;
        b=RqeY3aZ/WDyXxz/LaMHXNLzG56bLJ/kPb8Wg/ig6DgvVg2/iIN6QNvIjT8pb/2IrWd
         kwq4vCKVY00a1g3QkJfdhwUBkPmEDhiLtxR+5/ekDiXqkE8Hchlx3qt6YkZhFYZGUpN7
         9T3k++/E7az8Q6JlDZH9Ve8bhBwMBzxB/h63/uskYcvlI3+xWo7OxhQUDMydzRjvwmjZ
         TU/dAf1AxSnMXacXMJ2PswNrX20qqEAufTU/8OV0m8+Ilo0ewdrGhSjzrz39SMNfM5FJ
         8alR6zip/9TkrL3/vSo2DPHKKZwH5n3R0hT4XMc1Zx3e4+hXLrmSv/Wu+Ov7OxVLWN9Y
         AfZQ==
X-Gm-Message-State: APjAAAWDhIVCzMmpZYZaXwBc00czT06wbB2n9ICvwJSXSUS6YpZh/5Wu
        IRbr08UAx86Il1JBKiQmTg7Bwg==
X-Google-Smtp-Source: APXvYqxR1gARqvLOnJxaoUwyL5Go8zfNwqFRYi9rOz5HQFMn0+M/WDbTSJRtIuDbZceOgFCFByvUeg==
X-Received: by 2002:a05:6512:518:: with SMTP id o24mr42698644lfb.134.1575278321590;
        Mon, 02 Dec 2019 01:18:41 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u3sm889191lfb.68.2019.12.02.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 01:18:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: atlas-ph-sensor: Drop GPIO include
Date:   Mon,  2 Dec 2019 10:18:37 +0100
Message-Id: <20191202091837.82150-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver includes <linux/gpio.h> yet fails to use symbols
from any the header so drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 6c175eb1c7a7..b7c20c74239b 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -14,7 +14,6 @@
 #include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/irq_work.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
-- 
2.23.0

