Return-Path: <linux-iio+bounces-847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51B80E066
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 01:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373411C2144E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 00:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C8839B;
	Tue, 12 Dec 2023 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inrg7juA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237FA7
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 16:42:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db547281f5dso5355418276.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 16:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702341774; x=1702946574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wieanvmnd3ObNfpHSltL/XlVJFDJjSL12LZUtqBpsps=;
        b=inrg7juATPiXPa5xxemaIB1+gm5sMp+ehcSByHAzXt3i5GxRXVSqopvgCrgRJ5h8Yn
         kLxkD1SQAaJmr9AZZV5PhNkuBq30dnEiOmCfo1/HzkTzHYTXk/Rj9PEueZxetmwtCooa
         OnPMlLWZZS7FpuWkr5hG0uHTDTsFg5A5fcix8WltSyke4SJSy/gR7dFfQnw3WBc+OAFf
         UXLlPCQc4jOEhOz4qPjcq8paGsmjSoaNN4WW6BvPA5hRcba2t41U60souoBd0wboWSa/
         4aCiR4itY2qnqo+MJ8mEJyOE5rvyY1VVXb4bpb7hcUa3hSWsZnqYtb398enVx7dC2ybM
         T4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341774; x=1702946574;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wieanvmnd3ObNfpHSltL/XlVJFDJjSL12LZUtqBpsps=;
        b=ANYdGceO4B9yvdNELYlNXIJYi7G9RAZ8gCGdWqghsBHCgRjkHLc4T7/6ig2zRs6djo
         D9b4Fu7/FOTpqkskutAZ2a8IuzaFMgo94AFFUAyPPRwLre9edcxWbhhrgRrF13Zp81vn
         6+C30ySMGCZjDnx+VZcZWzioo11qL7O6lYZWi2etne9GQZByk0BczJCd4sA+/wPHLC+M
         E2SMSmV+e2J7JrLN84H9DE1KME9o7rnVh3mGF5vE7QJ8q3GadiYMlkb2jC0aQ1uwj6kG
         NIgQ9CdCUTrznFKJP/SF+LRrzfLXqoyPrgJYjRFkNjrDS+i5VuTOJ8NBrJuEcq9Orxno
         xZ0w==
X-Gm-Message-State: AOJu0Yw2U2zvc74B7BFKSZdyaYaFiuxxv9wFKdJhkmR0htu1iozVwYsk
	jjUnQJDsxHsfTdx34DMqd8PyvhhSXRMCy5aEpQ==
X-Google-Smtp-Source: AGHT+IGJ46dv63nI3qdzSHv/NQjZkOw15eRnmPpIWNSUUXJLGOR/QBvvFtDUhVsW770u/hORSxoZqhScVHI4kudodg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:5088:0:b0:dbc:b125:2949 with SMTP
 id e130-20020a255088000000b00dbcb1252949mr13392ybb.0.1702341774309; Mon, 11
 Dec 2023 16:42:54 -0800 (PST)
Date: Tue, 12 Dec 2023 00:42:52 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIusd2UC/5XNvQ6CMBSG4VsxnT2mP9iCk/dhHLQ9wEmEkpY0E
 MK9WxhM3HT8vuF5FxYxEEZ2OSwsYKJIvs9DHQ/Mto++QSCXN5NcKl5JAXEMvR1mcIEShghEHob
 gJ+ponCFOlZIFWCitKpTRRnNVsYwNAWua9tDtnndLcfRh3rtJbO/fiSRAQIGlk2XtBBp7bbxvX niyvmNbI8mPK7jUP7syuxZR49k9Deff7rqub8IFges1AQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702341773; l=5459;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=KhNNLMz44VJH+SMkWMDPM/eP4tCUdfa9dI0bKvoxV1k=; b=zpVS2BABeC8dYIUeeu3AhJj62yGiXiCxGsX2m2w6vLIFwGE7jfG0UQ7Vdl3iK99mGrFj1ecjZ
 elt2HgweUHrD/jm5iajOtueL4EGyLuVXOgKLtwWl9AY1e/9TuMZOnVe
X-Mailer: b4 0.12.3
Message-ID: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
Subject: [PATCH v3] iio: sx9324: avoid copying property strings
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

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
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
 drivers/iio/proximity/sx9324.c | 69 ++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 438f9c9aba6e..e3bc30b57b19 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -873,6 +873,32 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 					20000, 2000000);
 }
 
+static u32 sx9324_parse_phase_prop(struct device *dev,
+				   struct sx_common_reg_default *reg_def,
+				   int idx, const char *prop)
+{
+	unsigned int pin_defs[SX9324_NUM_PINS];
+	int count, ret, pin;
+	u8 default_def;
+	u32 raw = 0;
+
+	default_def = sx9324_default_regs[idx].def;
+
+	count = device_property_count_u32(dev, prop);
+	if (count != ARRAY_SIZE(pin_defs))
+		return default_def;
+	ret = device_property_read_u32_array(dev, prop, pin_defs,
+					     ARRAY_SIZE(pin_defs));
+	if (ret)
+		return default_def;
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
@@ -884,35 +910,30 @@ sx9324_get_default_reg(struct device *dev, int idx,
 #define SX9324_PIN_DEF "semtech,ph0-pin"
 #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
 #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
-	unsigned int pin_defs[SX9324_NUM_PINS];
-	char prop[] = SX9324_PROXRAW_DEF;
+	const char *prop = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
-	int ret, count, ph, pin;
 	const char *res;
+	int ret;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 
 	sx_common_get_raw_register_config(dev, reg_def);
 	switch (reg_def->reg) {
 	case SX9324_REG_AFE_PH0:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def, idx,
+						       "semtech,ph0-pin");
+		break;
 	case SX9324_REG_AFE_PH1:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def, idx,
+						       "semtech,ph1-pin");
+		break;
 	case SX9324_REG_AFE_PH2:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def, idx,
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
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def, idx,
+						       "semtech,ph3-pin");
 		break;
 	case SX9324_REG_AFE_CTRL0:
 		ret = device_property_read_string(dev,
@@ -937,11 +958,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
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
@@ -1012,11 +1031,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
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
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039

Best regards,
--
Justin Stitt <justinstitt@google.com>


