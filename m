Return-Path: <linux-iio+bounces-6434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0459890BD43
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF141C20E00
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA11993B4;
	Mon, 17 Jun 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeBS1noT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0F192B98;
	Mon, 17 Jun 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661964; cv=none; b=PgK4SYBbdvDh/0Lt+f9ctc1j4aHRSFIEkX0zSkW13G1rYLTUvJYSurRLo4lncE1441o24K6dqtHbyNHRbrXnzME3RwSOeOwe3qPnVSmTDyubLES9TBX75XpNp2DCGYgJqeZ/zSMbkGZSw821ymwsPsxrHrMygClVCmyFXQ8gBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661964; c=relaxed/simple;
	bh=g7SK16z3EUsEncjRhzlqTX6KiMzpqs0fmUG3VteIg2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klymEcZ5vjGej0uBIC3YT3BRJF5faaJxW2JANOcGk9bIKV6Vgtdikr0864dp+9mDlMBnkIyyqvwmDx+erUON25fhQz1sdzODUTuFKnSHaXSr8xW9KuAcNAfnb96JGSvaVAjaMu98jeiSlZG5zNQi58hp+6ljdL5bh/Yf1TKxNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeBS1noT; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6fd622e5d2dso558468a34.3;
        Mon, 17 Jun 2024 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661962; x=1719266762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJEcEGbw3swKdFCLUtr2n8Y6Tlc0pU3Bhk1KNMQfJkk=;
        b=YeBS1noThFHKG1ouoROxNXmY94MaCGSYdvQ/fV2bYb4sZVTtKs5uk0k+NQmc1iS8TB
         lTLU49VQfKqEsRSdCjJNeLIVLDUEyVrIl1bll1TFc4W2gTSj/6iD0jlO9rxYvpdx60vU
         XlWzCr9zDBzVMqu0aZ2aU/icNPF/oj/rKjXVO3W9HejDUrZcZZG/S0KXSCXrXwQPsmwI
         LyO2Zvt+eSiSVBaOpB2LFK2leF0FkDBxbrBHsvux+uHFy3M0NYTIIU+7gn35LO/FmaKT
         7+FmLCfHvQYbrNyA8/LdGMeVL7B7ubf9KL/ONdtj/zHqkzRRaH8OrE/p48jBtBVulipF
         1uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661962; x=1719266762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJEcEGbw3swKdFCLUtr2n8Y6Tlc0pU3Bhk1KNMQfJkk=;
        b=PpoGC+9PX4YEO/azujKs76A9oEs154FckXudYJwyBSOFDmEORfXSXlhDScKIjG75T4
         13hxUsniH6mi7oKR1gcPvppHXwpFWmXNdYKiBqqSEs8mJ470n5wxBIngjOyv6mAsRKbk
         2wQbwVye7ICM/6Kwh7SzaR3BPTmCMW9lqE6grJGMvVrtrXzd9F0VqasPYE0Ge7cgiqq8
         z0UKVDrSoRsQBbW9s/c5VrWH8f7xbycSOWDYTLHMPsM4MAZBxe255Sx43L+7c9lirwJU
         pp1PNHN2RI/S30OvmJ9xVvPiQv+CtPEqsMPo4dWya3x/oFSF3KntSsqNno+DaVd99opD
         InAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnB0+HT4pv6W3DXQpyYGLqSTWzI9lPtCzzcemVddKhNUsu5eFN/t160MHLXPjs6CabZVF0lrRGp/w7oPE1Y7f0RW4l5ITBOsZCW1Mj8zBnhS4mJu76TYwakEUuSTnzDlxJ7Wo8wg==
X-Gm-Message-State: AOJu0YyrT79IY0YhCqPtbB2LRfEuI/PbrmkW+/jr+0hITD7Jf7Z9pGsS
	1R1zAZMgIK2+o6L4NNrn4Cjvg+wmhDMLdI47NQfEODAC139Vwr4P
X-Google-Smtp-Source: AGHT+IF3ufe30O8vIgO/leV+i/sjcoIYX8wYXPEpQkLumyd/BX/GT/GpBoDit9t8oWl6BJ+tvkaNBw==
X-Received: by 2002:a05:6870:b618:b0:254:c617:a9a0 with SMTP id 586e51a60fabf-25842c137e7mr13481515fac.50.1718661962037;
        Mon, 17 Jun 2024 15:06:02 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:01 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/8] power: supply: axp20x_usb_power: Add support for AXP717
Date: Mon, 17 Jun 2024 17:05:29 -0500
Message-Id: <20240617220535.359021-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617220535.359021-1-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the AXP717. It has BC 1.2 detection like the AXP813
and uses ADC channels like all other AXP devices, but otherwise is
very different requiring new registers for most functions.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../power/supply/x-powers,axp20x-usb-power-supply.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 34b7959d6772..e5879c85c9a3 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -26,11 +26,17 @@ properties:
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
+          - x-powers,axp717-usb-power-supply
           - x-powers,axp813-usb-power-supply
       - items:
           - const: x-powers,axp803-usb-power-supply
           - const: x-powers,axp813-usb-power-supply
 
+  input-current-limit-microamp:
+    description:
+      Optional value to clamp the maximum input current limit to for
+      the device. The supported min and max values will vary based on
+      the PMIC revision, consult the datasheet for supported values.
 
 required:
   - compatible
-- 
2.34.1


