Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B4DD8DCE
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392261AbfJPKXm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 06:23:42 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35599 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388923AbfJPKXm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 06:23:42 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CAB1124000F;
        Wed, 16 Oct 2019 10:23:39 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert+renesas@glider.be
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: max9611: Defer probe on POR read
Date:   Wed, 16 Oct 2019 12:25:20 +0200
Message-Id: <20191016102520.124370-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The max9611 driver tests communications with the chip by reading the die
temperature during the probe function. If the temperature register
POR (power-on reset) value is returned from the test read, defer probe to
give the chip a bit more time to properly exit from reset.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

---
Geert,
  I've not been able to reproduce the issue on my boards (M3-N
Salvator-XS and M3-W Salvator-X). As you reported the issue you might be
able to reproduce it, could you please test this?

Also, I opted for deferring probe instead of arbitrary repeat the
temperature read. What's your opinion?

Thanks
   j
---
 drivers/iio/adc/max9611.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index da073d72f649..30ae5879252c 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -80,6 +80,7 @@
  * The complete formula to calculate temperature is:
  *     ((adc_read >> 7) * 1000) / (1 / 480 * 1000)
  */
+#define MAX9611_TEMP_POR		0x8000
 #define MAX9611_TEMP_MAX_POS		0x7f80
 #define MAX9611_TEMP_MAX_NEG		0xff80
 #define MAX9611_TEMP_MIN_NEG		0xd980
@@ -480,8 +481,10 @@ static int max9611_init(struct max9611_dev *max9611)
 	if (ret)
 		return ret;

-	regval &= MAX9611_TEMP_MASK;
+	if (regval == MAX9611_TEMP_POR)
+		return -EPROBE_DEFER;

+	regval &= MAX9611_TEMP_MASK;
 	if ((regval > MAX9611_TEMP_MAX_POS &&
 	     regval < MAX9611_TEMP_MIN_NEG) ||
 	     regval > MAX9611_TEMP_MAX_NEG) {
--
2.23.0

