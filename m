Return-Path: <linux-iio+bounces-27107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9DDCBF7EE
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 20:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F4873012DFC
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF9325700;
	Mon, 15 Dec 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3tIDFEq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174C32720D
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825723; cv=none; b=EqKVcc8Gpaa9FHQ//wzOcydlxEY0kMy++sk9B7ZMbPNuhBTmNtjP+XV9QhbJjNrDPiPtL94HbMdm5/p4ln/pK/fMT0vJTVczyba0R67fOrMbWl977CWgEdBWHmxMGuFJd9xfQkZpXV/7e9yLmhUFHfEQSiV0LfY3aS1/wKJnfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825723; c=relaxed/simple;
	bh=g2Fo+SKpC6PjwBCJ943Rk64IScfy97UhiSWsSJqf/a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecKDMrBdHkJOMG3K85jSnoIoyG2VWCahqGBCZEX69MhMcUSQhcK4/GEUaieJYz2GktEjW50UUYFhu6IJ86vi+hcvvlo0w4Bx6Sqr8UXwnCz5b4qKqB7r2B+VhkADd28NAYLwIe7R+imuBTwOHuK8s5FyOTjWKkVskrH1J9fGUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3tIDFEq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-349bb6f9c86so4947564a91.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765825720; x=1766430520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhOh34wHJYgJjZNzWKgXOXvukXHa40Pe75V9p09ZGls=;
        b=i3tIDFEqHTbh7pEfq0lC2aVexGmaaKFe5kD3DqxRx8uC5ps0CIXujOz9ZKTwyexGid
         1E7eD57vVjlstZUzKcXqZIaKRc/sG2OPLj1L7nEVXU+D0jJXTCXXwNbQYRdQiz44z214
         zzB5Pk8L2Iqi8cynuLW1zMhH1qH0V6Ed/0DsKkBCcSXZHejMdb2cbw0Kyc7AIDz4RxPG
         482TPfiFtnay4W7aor5POAVGMUWEjwub1M0LEiQq5CIsrXYm8Fco1tmKxqbzAh19bqX/
         hcnyW91yf1NQiiuWPnObEpXfgQbrbr/xNOFaQOpFSbHbCMeqTT8ZS+0CIiGYa+dFVMBz
         w/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765825720; x=1766430520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhOh34wHJYgJjZNzWKgXOXvukXHa40Pe75V9p09ZGls=;
        b=CgVXDTi/RZqpN+ny4SkNj4K5fzA6i4N6hveKgzM7QAPVCszDqB2MAK5XPsrOEFvngy
         vyEE0gUnwNdOUqcNQgGMg4GI9OV26BfxQjsJsgMPZpxznuBQprO2jhhDFt0MMCuViLVw
         YTSIf1I4sHeXsMv3+96TsNGbMWunQMF7ii+tHTVO/Rq+DpAIHbgVGIcY0d94GPoIgjMp
         T7dANs/BuV+3Z3eW4Gc/INKZ9l0Pk8RsOfVvMPNXcq8VZohFHuWGRpEYRs99muLQYUZX
         +AW6En4L610EKyH2XWivCwt8dE0/KXV7Rukofe0aNUwnH+urZuZ+Vpr+FYhCqWNMWsud
         6cFA==
X-Forwarded-Encrypted: i=1; AJvYcCXJYmjX32W/vO8MgmjuNfat8HKddSYlyRQi0UiR0i/tR9wcsCLqlXPyf/DFxzoizU9BRjfPYbQxb3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJ1mUS5sVBSGb3DCf3GL8JaDbFkSgOuiB36WDapSpgcdEF2vU
	kXlrDxL6QHRfbD1+gQtYecAIuX2xhbp8zIf7RKBwhjc8gbtVVeSrXl2h
X-Gm-Gg: AY/fxX6bfbz2KruggaUDCdyXY5xKRIEhecuGHD7ZV3DFZyEJRPxL6BWirxpTrW2eq0k
	2OenhnnhEzvQWoz7SRbCh3rbZONqB03dETBuPEM11tgcRcOnaeAMW0jofOtfe1r0qF5EA+DTNlY
	JHm81gHS62X8DkOmMz0RQQJbKbBOV8rk4N2oa1oaqFDVizcIddsKhyts/JS708oU11pv2F4sUEf
	mBsrU48HGAus5y/A4aP3y+4yYQEsOx9+HE2VshaZTB5+0Hdk/O9ft8o0icB7b/9Qfjpr/RFtm4Z
	uZ0nZBJRi2B+KLmmm1XfKBbLuDCT/k71+7GLaZLtzWM+rTS3yqGxirjww9fzN26+ocHdKkUY1DF
	MD4uhy16aV2TVgHrLI1nzKifwMz7riJwRBF2oAtwXXcmvnY6265UwCDwqC9XtOwh/7NioCVw3Dc
	YGycHehgt4DGibcVsM4cRQcJI3F2Ft6E/CGrrBgihgHR8NTSLUopJHlOWYn+L1mx30o1QCzZQqy
	1GUK7fVg8Ov68BatV/fW6MdwHfKdbC59yAks2/E0jKevG4jprSAKlXJRD0v5UO4NG9oV0bD
X-Google-Smtp-Source: AGHT+IE2X6oysUvapY8yh52OObO92D47oeQuQSx8EW1cTC7n+R31cQfuPy0gzfOE75F6exzqvWW5XA==
X-Received: by 2002:a17:90b:5287:b0:340:c179:3657 with SMTP id 98e67ed59e1d1-34abd7bae5dmr10401090a91.33.1765825715761;
        Mon, 15 Dec 2025 11:08:35 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2948d1sm9958875a91.9.2025.12.15.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:08:35 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH 5/5] staging: iio: ad9832: add sysfs documentation
Date: Mon, 15 Dec 2025 16:08:06 -0300
Message-ID: <20251215190806.11003-6-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215190806.11003-1-tomasborquez13@gmail.com>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs ABI documentation for the AD9832/AD9835 Direct Digital
Synthesizer chips, documenting frequency, phase, output control,
and pin control attributes.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 .../Documentation/sysfs-bus-iio-dds-ad9832    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832 b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
new file mode 100644
index 0000000000..5ceea57917
--- /dev/null
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832
@@ -0,0 +1,41 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_frequencyY
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Frequency in Hz for frequency register Y (0-1). The active
+    frequency register is selected via out_altcurrent0_frequency_symbol.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_phaseY
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Phase offset in radians for phase register Y (0-3). Valid
+    range is 0 to 2*PI (exclusive) with 12-bit hardware resolution. The
+    active phase register is selected via out_altcurrent0_phase_symbol.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_frequency_symbol
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Selects which frequency register (0 or 1) is active for output.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_phase_symbol
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Selects which phase register (0-3) is active for output.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_enable
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Enables (1) or disables (0) the output. When disabled, the
+    device is held in reset state.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent0_pincontrol_en
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Enables (1) or disables (0) hardware pin control for frequency
+    and phase selection. When enabled, external pins control
+    register selection instead of software.
-- 
2.43.0


