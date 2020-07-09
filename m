Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D921A37E
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgGIPWt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 11:22:49 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49467 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgGIPWs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 11:22:48 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D6818C0013;
        Thu,  9 Jul 2020 15:22:44 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v8 3/6] IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
Date:   Thu,  9 Jul 2020 17:21:57 +0200
Message-Id: <20200709152200.10039-4-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709152200.10039-1-contact@artur-rojek.eu>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
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

 v2-v8: no change

 drivers/iio/adc/ingenic-adc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index c1946a9f1cca..89019fb59d48 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -400,6 +400,21 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
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
@@ -409,6 +424,7 @@ static const struct iio_info ingenic_adc_info = {
 	.write_raw = ingenic_adc_write_raw,
 	.read_raw = ingenic_adc_read_raw,
 	.read_avail = ingenic_adc_read_avail,
+	.of_xlate = ingenic_adc_of_xlate,
 };
 
 static const struct iio_chan_spec ingenic_channels[] = {
-- 
2.27.0

