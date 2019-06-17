Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFFE48041
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfFQLKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 07:10:40 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfFQLKk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 07:10:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFb38-1hqXBM2ZJe-00H9YY; Mon, 17 Jun 2019 13:10:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Fertic <jeremyfertic@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: iio: adt7316: use correct headers for gpio
Date:   Mon, 17 Jun 2019 13:09:20 +0200
Message-Id: <20190617110951.2085648-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cTNvSQ9TaXGrz6GNYn/l47SM2aOEl9ewVkuzYHttzbQ18FhJ43p
 XbN9BwodkIHe7auBf9exzPpX8+XLgvTH0lskZMyeAenvZIHswz3XX+WWI/HSZDipF1HT4m5
 +350Y5/T+jrkz3leY7UMJfO/q8w8r3WBf06lna+Lp4989vU93D9IYu+l7mUwiYxsfENmgwK
 ucyY2l2PxMpaYqqMvJYSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V5BTVesWKOo=:2cXnZF3aZ8tbG/yPkPAQM4
 gxfPEl22HrRSJj6PwZC5Mc707yi5tWA3AVHPm9Pe6P4oGnr55t4/ucVn+OqL4Cm43bR+JMgez
 CMMZV0bG3J0s3TVgTtsIB3wt1wZMc/PJnelZ5+aiqDX/AoUin7FdA0QT2atsJTVPgoDZcFjEx
 5IXX9jOQPvdXaC5PqauYzhgA3lbrKIhDz+X8/ewBMMLPLfsF5mrZd6PMzP4rPGwmH8TeDofH+
 9CYYoOARCCnZxoNpn1rUk4POaCRobviaPCfeEJJuM8H64CewD/UkoaQtA28Ido0VO6bKXC+Xj
 rZA7iOT16yy+KJDKO0CgnH9DNNyq+F+sOrrhcfB0MTFjvfZIYgYb7qx+QZ3/U7y83DamcrRel
 qnx/l7e0j8pF/kOfHoHbLnRlRvBDZlXmpa0cZi/hGD+pxkHN2+FLE5j/9SVFo4Z03oBkpStHj
 k+sqDO3czfdaMLujhR+83Z44IoRwA2uueMI8C/ixZRIJ5dzuDD6aTp/jfRhcvk92Y3MI1svZs
 CKn+Go8wNfN+kJMY1HKxOUZwoUed8HGKep6WKgqidaEzbQ0YO1sgFEoftT3UauT2wDbbKlixy
 bg+nZtwn4tXS1RVUN+YvkgOc1txR9dql4Cxtsihecfq6sjWLfG1vV0xmlbtDP6vqI71Ta6fRX
 sdF/eBvyc/tLtRJTYdY1zWBn58SOPU67j/wm8NoY2zI0R/ECVFKmiWRh2xf46DZ7MfWX+Rdue
 bHAGGNwweL3jnWPJ7YRS5yvyM0fvYK7s2aFNpA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When building without CONFIG_GPIOLIB, we get a compile-time failure:

drivers/staging/iio/addac/adt7316.c:947:3: error: implicit declaration of function 'gpiod_set_value' [-Werror,-Wimplicit-function-declaration]
                gpiod_set_value(chip->ldac_pin, 0);
                ^
drivers/staging/iio/addac/adt7316.c:947:3: note: did you mean 'gpio_set_value'?
include/linux/gpio.h:169:20: note: 'gpio_set_value' declared here
static inline void gpio_set_value(unsigned gpio, int value)
                   ^
drivers/staging/iio/addac/adt7316.c:947:3: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
                gpiod_set_value(chip->ldac_pin, 0);
                ^
drivers/staging/iio/addac/adt7316.c:1805:13: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror,-Wimplicit-function-declaration]
        irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));

Include the correct headers that contain the declarations for these
functions.

Fixes: c63460c4298f ("Staging: iio: adt7316: Use device tree data to set ldac_pin")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/iio/addac/adt7316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 37ce563cb0e1..9cb3d0e42c38 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -6,7 +6,8 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irq.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-- 
2.20.0

