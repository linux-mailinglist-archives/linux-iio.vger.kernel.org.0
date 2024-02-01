Return-Path: <linux-iio+bounces-2083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3F846072
	for <lists+linux-iio@lfdr.de>; Thu,  1 Feb 2024 19:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A1B1C23650
	for <lists+linux-iio@lfdr.de>; Thu,  1 Feb 2024 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F984052;
	Thu,  1 Feb 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZffZxQSr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A617884FA4
	for <linux-iio@vger.kernel.org>; Thu,  1 Feb 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813714; cv=none; b=sGCDqPL+71BPhMs4CxlhVNHFoOCbdc3qWIFJ18JcpPpTqagBNYk/oItyNq6Jp5TUseFEW8pyBVSg2v84boDztpG5xFJNJ4p3ojBTSw+oyP3aNhf5DDUvrWpbC7chh9ADClTxRTlT9gHcBXquwVFt9OlBjf8JoDpiMTfKh3vIPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813714; c=relaxed/simple;
	bh=vd5V7jREra4SOCm+7g/vZFE+V7Vhl8MTNilHGLxx0Z8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cWOqqiSoo/dmNp2AofMTKAbrW5ghYUQFxcfqpyCJ0w4nwdbDVquGc90J2p9YDXjq0R/ynsXzy9h+TumWa0U+dSMb7l1Ul12P88/kAuqVSj4eD5bga8EOR7ssBG3LBRlXWf8pCStss1AbQxE/yRfUz9uu9ugBE7OvkMLpSYmYhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZffZxQSr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6c47cf679so2200271276.0
        for <linux-iio@vger.kernel.org>; Thu, 01 Feb 2024 10:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706813711; x=1707418511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4e9cZabz99wJ+RSzesn2rTrqziGwjfSXdxTMcPtcTlY=;
        b=ZffZxQSrSDowGw8ExcUbNaudz8Qokm61Rv5d+sxxGipM6HODVw4bVFG9qijT/bCmkJ
         qoppQdUyJJGE8ywe0pYFQSYGvrnIriZ966bpzLa+NJ33YiO705hnb7zCOHkDGVf+PbUJ
         tpAfKiFxE7RM4KZrmbBA3VNBtqsNtyT28N6hWpeFlZNwBP7oCgmcT8zOXbmKh2sVaQS9
         PPdBzg5jUXqhX0pAdBUo1GCwDGRYIBF3JQkJd6jMT0/YVg9S6bFhzy1VPyH5CQIpr7ZY
         nxPFPIuOpWnycXh/TAHHSKcMItZTPaf/NEXNJKl2skSbJ8MadNkECH2NTgtH6br/VqvA
         fqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813711; x=1707418511;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4e9cZabz99wJ+RSzesn2rTrqziGwjfSXdxTMcPtcTlY=;
        b=ha4zVf0L+LUONtDKqg9YXBobFjiTJUaSgA69dZQEIFoHbc3/6Z1Omq6KwGd9uvcFUt
         rGQn9RV/9pWOSCVo73HduvrSWyen66kmyuA9Fwq/1XZCdIzqj6RiCnObmYMT1YCyRPAR
         ag775NxNNP7CQd8zlKg6X6d3CZ4Hd2GGJeSEgmoYWPyiQ7pHKG1/vlu+z7EBIuTqWwJo
         L/D1yyOeQmtv5sOA37l1Ejs1Wy37NI+6fR9zMCR2aL/drBtJiDx8NCSv2hgt3XWKIY14
         lMHjfKf3pZ4VER8Q3FvXXsPopIKVCiE1b/ZdvSOzfzA/4ffN2qxjEKsQT6eGEIKks4Bc
         5r0g==
X-Gm-Message-State: AOJu0YxOavKja8VK8q1bYsDk121FfTqMfWhzfR/VrTec2my/PlIlbKps
	5ttZ22rnPDpO3n1S2cQKctiHBuTH9Ol09vCPpIA6UQi6um21tys9qg0e0A0vH8SnSf+aPi+uSAw
	YudU6KhlRUAurX+3mA1a+kg==
X-Google-Smtp-Source: AGHT+IF6dLPkfqPNbaKdOQOpiTCJ/9+4StMQRjO3mQNBKSdgyye1a9bXJXyhudDqBDQD+tZu0FacHcbQf29s13yV8Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1b08:b0:dc6:e823:9edc with
 SMTP id eh8-20020a0569021b0800b00dc6e8239edcmr123960ybb.8.1706813711710; Thu,
 01 Feb 2024 10:55:11 -0800 (PST)
Date: Thu, 01 Feb 2024 18:55:03 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAbpu2UC/5XNu47DIBCF4VeJqHdWMOALqfY9VikcGDsjbYwFF
 rIV+d1DUuxFabzlOcX330SiyJTE8XATkTInDmMZ1dtBuEs3DgTsyxYoUUuLCtIcRzet4CNnigm
 YA0wxLHzleYW0WI0GHLROG93UTS21FQWbIvW8PEOfp7IvnOYQ12c3q8f770RWoMBQ67HtvaLGf
 QwhDF/07sJVPBoZv10lsd7tYnEdUU2VPzdSvrr6x0WFu11d3HPbkcLetV3lX1zz27W7XVNcbyx 5tES2wj/utm138OJbJuUBAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706813710; l=6279;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=vd5V7jREra4SOCm+7g/vZFE+V7Vhl8MTNilHGLxx0Z8=; b=GTQykfLkcwpAFZktN4au/68GoG9R8G6Jt7olj8ZmrcJ2QQwpfVqpnlH2r11WP2We2NOcGgUOC
 jDWzPHoQYCuCfbcA6YiKSiOZFJaEqFSK396H5YDpygrp5Z6Taw73VTV
X-Mailer: b4 0.12.3
Message-ID: <20240201-strncpy-drivers-iio-proximity-sx9324-c-v5-1-78dde23553bc@google.com>
Subject: [PATCH v5] iio: sx9324: avoid copying property strings
From: Justin Stitt <justinstitt@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

We're doing some needless string copies when trying to assign the proper
`prop` string. We can make `prop` a const char* and simply assign to
string literals.

For the case where a format string is used, let's extract the parsing
logic out into sx9324_parse_phase_prop(). We no longer need to create
copies or allocate new memory.

sx9324_parse_phase_prop() will simply return the default def value if it
fails.

This also cleans up some deprecated strncpy() uses [1].

Furthermore, let's clean up this code further by removing some unused
defines:
|  #define SX9324_PIN_DEF "semtech,ph0-pin"
|  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
|  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v5:
- rebase onto rc2
- resolve merge with Commit 7cd11203d900("iio: proximity: sx9324: Switch to device_property_match_property_string()")
- Link to v4: https://lore.kernel.org/r/20231219-strncpy-drivers-iio-proximity-sx9324-c-v4-1-d49ed29ee952@google.com

Changes in v4:
- use u8 return type (thanks Stephen)
- remove unused defines (thanks Stephen et al.)
- tweaks to sx9324_parse_phase_prop related to defaults (thanks Stephen)
- Link to v3: https://lore.kernel.org/r/20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com

Changes in v3:
- extract logic into sx9324_parse_phase_prop() and use string literals
  (thanks Stephen)
- rebase onto mainline bee0e7762ad2c602
- Link to v2: https://lore.kernel.org/r/20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com

Changes in v2:
- make prop a const char* and do simple assignments (thanks Jonathan)
- rebase onto 3a568e3a961ba330
- Link to v1: https://lore.kernel.org/r/20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com
---
---
 drivers/iio/proximity/sx9324.c | 69 ++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index ac2ed2da21cc..b0403fc7906b 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -873,6 +873,29 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 					20000, 2000000);
 }
 
+static u8 sx9324_parse_phase_prop(struct device *dev,
+				  struct sx_common_reg_default *reg_def,
+				  const char *prop)
+{
+	unsigned int pin_defs[SX9324_NUM_PINS];
+	int count, ret, pin;
+	u32 raw = 0;
+
+	count = device_property_count_u32(dev, prop);
+	if (count != ARRAY_SIZE(pin_defs))
+		return reg_def->def;
+	ret = device_property_read_u32_array(dev, prop, pin_defs,
+					     ARRAY_SIZE(pin_defs));
+	if (ret)
+		return reg_def->def;
+
+	for (pin = 0; pin < SX9324_NUM_PINS; pin++)
+		raw |= (pin_defs[pin] << (2 * pin)) &
+		       SX9324_REG_AFE_PH0_PIN_MASK(pin);
+
+	return raw;
+}
+
 static const struct sx_common_reg_default *
 sx9324_get_default_reg(struct device *dev, int idx,
 		       struct sx_common_reg_default *reg_def)
@@ -881,37 +904,29 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		"highest" };
 	static const char * const sx9324_csidle[] = { "hi-z", "hi-z", "gnd",
 		"vdd" };
-#define SX9324_PIN_DEF "semtech,ph0-pin"
-#define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
-#define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
-	unsigned int pin_defs[SX9324_NUM_PINS];
-	char prop[] = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
-	int ret, count, ph, pin;
+	const char *prop;
+	int ret;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 
 	sx_common_get_raw_register_config(dev, reg_def);
 	switch (reg_def->reg) {
 	case SX9324_REG_AFE_PH0:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph0-pin");
+		break;
 	case SX9324_REG_AFE_PH1:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph1-pin");
+		break;
 	case SX9324_REG_AFE_PH2:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph2-pin");
+		break;
 	case SX9324_REG_AFE_PH3:
-		ph = reg_def->reg - SX9324_REG_AFE_PH0;
-		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
-
-		count = device_property_count_u32(dev, prop);
-		if (count != ARRAY_SIZE(pin_defs))
-			break;
-		ret = device_property_read_u32_array(dev, prop, pin_defs,
-						     ARRAY_SIZE(pin_defs));
-		if (ret)
-			break;
-
-		for (pin = 0; pin < SX9324_NUM_PINS; pin++)
-			raw |= (pin_defs[pin] << (2 * pin)) &
-			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
-		reg_def->def = raw;
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph3-pin");
 		break;
 	case SX9324_REG_AFE_CTRL0:
 		ret = device_property_match_property_string(dev, "semtech,cs-idle-sleep",
@@ -933,11 +948,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-			strncpy(prop, "semtech,ph01-resolution",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph01-resolution";
 		else
-			strncpy(prop, "semtech,ph23-resolution",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph23-resolution";
 
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
@@ -1008,11 +1021,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_PROX_CTRL0:
 	case SX9324_REG_PROX_CTRL1:
 		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
-			strncpy(prop, "semtech,ph01-proxraw-strength",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph01-proxraw-strength";
 		else
-			strncpy(prop, "semtech,ph23-proxraw-strength",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph23-proxraw-strength";
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
 			break;

---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039

Best regards,
--
Justin Stitt <justinstitt@google.com>


