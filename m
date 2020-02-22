Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E3169078
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2020 17:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgBVQuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Feb 2020 11:50:16 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38921 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBVQuQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Feb 2020 11:50:16 -0500
Received: by mail-yw1-f66.google.com with SMTP id h126so3121298ywc.6;
        Sat, 22 Feb 2020 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CEtPQwqb2jRT0+JdcJwq9ByMA6NE9XRRq10JDdwV54=;
        b=fov6amsMb71SraLpdll6TXLXhCsbsUDPsGPGict5Ib4uEKHqaG9PHoVbXgGaDbpcuf
         5RcGJJHZ/7gDwRFtfjQexAH/AYfCI9AdrjDtRogEcRckbLs7QC0TrUTivyo7QwFFDtnA
         N797tBSmOPt2AnuXPdc7j9oXGzSoDssszcVGMjI5be+ioKslIob9r3IUfQJLBOpF9l93
         S7M2TPVODqo1cktkfrz/uwZ1JvrrqYgWss3mWArICThlLsCDfQTBNfEoziwy9ewA558t
         8tzID89xnXTjx1g7EAtH++A9AoxE4/UfBwR59P3fAAngvAbIOWPbHrKIZDG/eyh69jPH
         lF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CEtPQwqb2jRT0+JdcJwq9ByMA6NE9XRRq10JDdwV54=;
        b=Ejj4vwOxvJykT+YLXijDwlsCVzU1eG4Pq/Is8MQ+8MxSizlzbchN4GUlRsMoHT+csT
         VuX5W1xa0x0RffAZFgSgAFHG4kr7akI0fMorlhmJsDDhJGYfA795uaOc76V3Has3UTZY
         smBy2JBQvcQBP5L7D6a3RKGRZ+PFXPloePVIVnIVendlKIAxB8sbq3duIs3griZuMtsa
         o2uSku9gyb50iF71QJa9hcDqIUbPylK9PohVeR9x1Lbohx6JQoEAUmyGjrOSogL/2VPF
         egly16DEoL0gIAEY4M+fCMStqFp5/FrBjwWfMl7BaxhDvI/q9TTseFVGawriq3p10lmG
         G9qA==
X-Gm-Message-State: APjAAAW/KXFv1vu0RZWy5kNMj2RVzAJf9ZLU96SG4c5nIMHA3xghsZrl
        G1g+qsXhsEH4DuwRyTJuZ2U=
X-Google-Smtp-Source: APXvYqx6ZZYFdxmQ/GlIOciTe2UWdxrHrhPWQmtMGP/bnwtUjCFzk3NCQGw3D+/Msys4oStUCC97eg==
X-Received: by 2002:a81:a189:: with SMTP id y131mr36078889ywg.329.1582390214706;
        Sat, 22 Feb 2020 08:50:14 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id c84sm2997249ywa.1.2020.02.22.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:50:14 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] counter: 104-quad-8: Support Filter Clock Prescaler
Date:   Sat, 22 Feb 2020 11:49:58 -0500
Message-Id: <20200222164958.105288-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ACCES 104-QUAD-8 series does active filtering on the quadrature
input signals via the PC/104 bus clock (OSC 14.318 MHz). This patch
exposes the filter clock prescaler available on each channel.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |  7 +++
 drivers/counter/104-quad-8.c                  | 61 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
index 46b1f33b2fce..3c905d3cf5d7 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -1,3 +1,10 @@
+What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Filter clock factor for input Signal Y. This prescaler value
+		affects the inputs of both quadrature pair signals.
+
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 17e67a84777d..0cfc813ee2cb 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -43,6 +43,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  */
 struct quad8_iio {
 	struct counter_device counter;
+	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int count_mode[QUAD8_NUM_COUNTERS];
 	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
@@ -84,6 +85,8 @@ struct quad8_iio {
 #define QUAD8_RLD_PRESET_CNTR 0x08
 /* Transfer Counter to Output Latch */
 #define QUAD8_RLD_CNTR_OUT 0x10
+/* Transfer Preset Register LSB to FCK Prescaler */
+#define QUAD8_RLD_PRESET_PSC 0x18
 #define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00
 #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
 #define QUAD8_CMR_QUADRATURE_X1 0x08
@@ -1140,6 +1143,50 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	return len;
 }
 
+static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *counter,
+	struct counter_signal *signal, void *private, char *buf)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id / 2;
+
+	return sprintf(buf, "%u\n", priv->fck_prescaler[channel_id]);
+}
+
+static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
+	struct counter_signal *signal, void *private, const char *buf,
+	size_t len)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const size_t channel_id = signal->id / 2;
+	const int base_offset = priv->base + 2 * channel_id;
+	u8 prescaler;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &prescaler);
+	if (ret)
+		return ret;
+
+	priv->fck_prescaler[channel_id] = prescaler;
+
+	/* Reset Byte Pointer */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
+
+	/* Set filter clock factor */
+	outb(prescaler, base_offset);
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
+	     base_offset + 1);
+
+	return len;
+}
+
+static const struct counter_signal_ext quad8_signal_ext[] = {
+	{
+		.name = "filter_clock_prescaler",
+		.read = quad8_signal_fck_prescaler_read,
+		.write = quad8_signal_fck_prescaler_write
+	}
+};
+
 static const struct counter_signal_ext quad8_index_ext[] = {
 	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
 	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum),
@@ -1147,9 +1194,11 @@ static const struct counter_signal_ext quad8_index_ext[] = {
 	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enum)
 };
 
-#define	QUAD8_QUAD_SIGNAL(_id, _name) {	\
-	.id = (_id),			\
-	.name = (_name)			\
+#define QUAD8_QUAD_SIGNAL(_id, _name) {		\
+	.id = (_id),				\
+	.name = (_name),			\
+	.ext = quad8_signal_ext,		\
+	.num_ext = ARRAY_SIZE(quad8_signal_ext)	\
 }
 
 #define	QUAD8_INDEX_SIGNAL(_id, _name) {	\
@@ -1314,6 +1363,12 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		base_offset = base[id] + 2 * i;
 		/* Reset Byte Pointer */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
+		/* Reset filter clock factor */
+		outb(0, base_offset);
+		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
+		     base_offset + 1);
+		/* Reset Byte Pointer */
+		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
 		/* Reset Preset Register */
 		for (j = 0; j < 3; j++)
 			outb(0x00, base_offset);
-- 
2.24.1

