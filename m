Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9347B3C7D1
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 11:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405137AbfFKJ5d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 05:57:33 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60623 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405130AbfFKJ5c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2019 05:57:32 -0400
X-Originating-IP: 90.88.159.246
Received: from dell-desktop.home (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: mylene.josserand@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 32F5240019;
        Tue, 11 Jun 2019 09:57:29 +0000 (UTC)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     peda@axentia.se, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com
Subject: [PATCH v1 3/3] dt-bindings: iio: afe: Add hwmon example
Date:   Tue, 11 Jun 2019 11:56:59 +0200
Message-Id: <20190611095659.29845-4-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190611095659.29845-1-mylene.josserand@bootlin.com>
References: <20190611095659.29845-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the support of CHAN_INFO_PROCESSED in voltage-divider,
it is possible to read the processed values directly from iio's
sysfs entries or by using iio-hwmon. Add an example for this last
use case.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 .../bindings/iio/afe/voltage-divider.txt           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
index b452a8406107..f7e1c7cb2744 100644
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
@@ -51,3 +51,27 @@ sysv {
 		spi-max-frequency = <1000000>;
 	};
 };
+
+It is also possible to retrieve the processed values using hwmon node:
+
+div0: div0 {
+	compatible = "voltage-divider";
+	io-channels = <&adc0 0>; /* Channel 0 of the ADC */
+	output-ohms = <47>; /* R2 */
+	full-ohms = <73>; /* R1 (26) + R2 (47) */
+	#io-channel-cells = <1>;
+};
+
+div1: div1 {
+	compatible = "voltage-divider";
+	io-channels = <&adc0 1>; /* Channel 1 of the ADC */
+	output-ohms = <47>; /* R2 */
+	full-ohms = <115>; /* R1 (68) + R2 (47) */
+	#io-channel-cells = <1>;
+};
+
+iio-hwmon {
+	compatible = "iio-hwmon";
+	io-channels = <&div0 0>, <&div1 0>;
+	io-channel-names = "3v3", "usb";
+};
-- 
2.11.0

