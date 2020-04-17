Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FFE1AE6A8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgDQUU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 16:20:26 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51365 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgDQUUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 16:20:25 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3B52840006;
        Fri, 17 Apr 2020 20:20:20 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [RESEND PATCH v5 1/5] IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
Date:   Fri, 17 Apr 2020 22:28:55 +0200
Message-Id: <20200417202859.35427-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide an of_xlate callback in order to retrieve the correct channel
specifier index from the IIO channels array.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

 Changes:

 v2-v5: no change

 drivers/iio/adc/ingenic-adc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 39c0a609fc94..7a24bc1dabe1 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -383,6 +383,21 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 	}
 }
 
+static int ingenic_adc_of_xlate(struct iio_dev *iio_dev,
+				const struct of_phandle_args *iiospec)
+{
+	int i;
+
+	if (!iiospec->args_count)
+		return -EINVAL;
+
+	for (i = 0; i < iio_dev->num_channels; ++i)
+		if (iio_dev->channels[i].channel == iiospec->args[0])
+			return i;
+
+	return -EINVAL;
+}
+
 static void ingenic_adc_clk_cleanup(void *data)
 {
 	clk_unprepare(data);
@@ -392,6 +407,7 @@ static const struct iio_info ingenic_adc_info = {
 	.write_raw = ingenic_adc_write_raw,
 	.read_raw = ingenic_adc_read_raw,
 	.read_avail = ingenic_adc_read_avail,
+	.of_xlate = ingenic_adc_of_xlate,
 };
 
 static const struct iio_chan_spec ingenic_channels[] = {
-- 
2.26.1

