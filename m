Return-Path: <linux-iio+bounces-27429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 699DCCEA9E7
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 21:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6DE1300699E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 20:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7A246782;
	Tue, 30 Dec 2025 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMV6p12K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5ED2C21CF
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126946; cv=none; b=HfqOUMlxk+PJ6BIMPSKOgOvPzor2lhEYbYg//wMlrYnH0wGuHlycVIYchxJmvFfP+QmLoKotF9x8R6HC1mLFjs9Q9M98NTorrpTPg60xZvGGvEgttLKsHvTcE1S45+iLTIbpVgzxSptv0rNetJYUoi5HcC3Lk8iH8ckUYKYylbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126946; c=relaxed/simple;
	bh=Jtdn53sO5xTyxl4ArPEzfhAa7SYwkzbyNV1kgWEy5K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYR19SDFsMdCbTl4rUWesiDl9RYKxFj3rcx6FFkIQEhcdR8Zbk+8OryBweyccs3yuYL04VeNjwN8bBisesYwj/Mf7tsmBsceRMYrQOO9RWHNSsDzaFAiBLZWykx58uM0Ca9qWiy0iFLbjGUYmKT56d5pkZIft70UOKQxC2ExLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMV6p12K; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso11075793b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767126944; x=1767731744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OOVo27sMdHzajJrTWUzpISPZpC3vx0/WhHb1JyWK/M=;
        b=YMV6p12KC97dqv72uP1a31TJwK+8XOJJFkTsrk/w0Mw19pxkjsco3MwwJzOsA1bSsa
         DZq2eIj46wNHMDhvl+shcDXhG4f77zJ5iLVXeVDNmTEpFk+3qkZ2QNaYjCs2ndsww60v
         yKj+lndXtvAd+lsEFW2gK4ReluQYu9t1Y8gZNplSLhOIvu/XWIoee7ybNIr3LgDcUBO9
         XYLSirI+CGqCilD63SWybF0cYU23GIEVkqWVAl8DRXtqwb0KvmLEKokENgsTr4xZ4A5X
         SpNBN7ihbFtEAw4PCzhp7ci9GeMVUisluVupwLe5HF9ErPSL5xFNF+vAitKgiLjhEy9e
         O04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126944; x=1767731744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+OOVo27sMdHzajJrTWUzpISPZpC3vx0/WhHb1JyWK/M=;
        b=WQe6gcryT4hM/FtRjtI0vBLexQWofD6Mm9Rjcffy5miWo0qkSNvDpnaWcOhIw7DRBL
         NpOzV81rUOXVhE1UnvwUpAGqxvhJU8oP6yP+1WiZnr/qEvuEFoXOkdeQw95JAy4jUbVn
         PT/+nMk7kvH80jy3FgHunEPWdDz+cbVlFx5SduR6hiUyClfVVxbhz2k6HGmYeiM6ijwa
         UOL2jxkSyENQHrgVmJxYmoR5gbpVdgGkeRMD/0MVkoLXal0frim9ZpHmnL7Pjdlb43RI
         UG5Lxv4nsOHJQvxC/iBz121Qumu6HvvU828ShQQQVM3kALu421cVuadkyG0QqKdosnS/
         QqKg==
X-Forwarded-Encrypted: i=1; AJvYcCXtrGL5GU0+2Ew/KhAG5O53kTFcW2c5JG84FwK2dWJf2Mu+3GkIvi5+HSOgfD4dEEv0FQ6P86IDc2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwcG/49l2SoAB3U7zCv0v3WWhZwu6h7RpYaXA4Ta97BYADcZG
	ssrZZKnXpi2EDAqg1aChuQfVn/NFsSV2BATVrWJuthYQ6isXCQljVro6
X-Gm-Gg: AY/fxX5OVj+pDUCGENiazWwrIaBrJ0/yvt3p/gfeSpDfWb6DlnNWSPOUToXu16V6+5/
	DCJO2A4799/0NqmKzhkihFv4szu+32ImqFOCbd7B4lxey71OoIO/FiCul/FcM4v2BYHu25+Hrrj
	CD9BIJin2NXVxCzHjzLo6vbm2mnqzMupLjk0Ylp9PqtX6u9KAdS+2pES3pHbDZfe/9sjQ/RRV8X
	RMtyIswFasI61u7WWCMtTeFoRFR6vviLsdPh1mnJeY8Q+jtls1V9jaLOJJREnQttmj8YrDb1iVF
	ZKZX4XVWDy3wubRWlbLW/R+vwiRkZY0Fyxms9rpPEVHLraWcpg48qg8fzpQl3sNCDPgAykH8KCL
	ApSV6Oqn8de8XdtYBNz4vGRzOH/59sJZqHmuXnATXktaAzZcGUr5nNfHPZr+MWipSFTFN8Q1+Sj
	Zc5XiVSr5nCmcJFCJSKTpnLbzuGbyFRJuyj+xzx2OHZVNCTCWI8M/Mf9xE71Hn/T4y7UjtFbEM2
	imstgeDxCKaIWPvdxX1slgsBND8iGyxcfQ1eOrFIKv/00JQ8/UiUASgfq900YJeg9oBCan4
X-Google-Smtp-Source: AGHT+IEf48DdE7VsXtXnbFcBm78wkH4EF5qNQu7VPO5lx/tFK8WMwAZgL/85b3tX2lJle4DBsUCaRg==
X-Received: by 2002:a05:7022:7e8e:b0:11a:c387:1357 with SMTP id a92af1059eb24-121722ac203mr31008621c88.16.1767126943997;
        Tue, 30 Dec 2025 12:35:43 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm128074981c88.9.2025.12.30.12.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:35:43 -0800 (PST)
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
Subject: [PATCH v2 6/6] staging: iio: ad9832: add sysfs documentation
Date: Tue, 30 Dec 2025 17:34:59 -0300
Message-ID: <20251230203459.28935-7-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230203459.28935-1-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
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
 .../iio/Documentation/sysfs-bus-iio-frequency | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-frequency

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-frequency b/drivers/staging/iio/Documentation/sysfs-bus-iio-frequency
new file mode 100644
index 000000000000..10627c19bdb7
--- /dev/null
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-frequency
@@ -0,0 +1,40 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequencyZ
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Frequency in Hz for symbol Z of channel Y. The active
+    frequency symbol is selected via out_altcurrentY_frequency_symbol.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_phaseZ
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Phase offset in radians for symbol Z of channel Y. Valid range
+    is 0 to 2*PI (exclusive). The active phase symbol is selected
+    via out_altcurrentY_phase_symbol.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency_symbol
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Selects which frequency symbol is active for channel Y.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_phase_symbol
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Selects which phase symbol is active for channel Y.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_enable
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Enables (1) or disables (0) the output for channel Y.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_pincontrol_en
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+    Enables (1) or disables (0) hardware pin control for frequency
+    and phase symbol selection on channel Y. When enabled, external
+    pins control symbol selection instead of software.
-- 
2.43.0


