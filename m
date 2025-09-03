Return-Path: <linux-iio+bounces-23673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B961FB41BD1
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 12:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A4C1BA5268
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144392EF677;
	Wed,  3 Sep 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiQ86Q9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AED28727F
	for <linux-iio@vger.kernel.org>; Wed,  3 Sep 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895284; cv=none; b=V6mDbJV2ByfTCa7Bob/RCisrSZRXU4yKywwcz98QV/v5zzLdSdzVP+e3EXe9dZl3U5BEWp5wocPfb2CJhGjewiIZeI363rCenkKowlQV4IHUL610V/s71PyOyz0FDgg3prwSlLbDZfIqL8J6rY7cmh+/SV9JCYqj38Ikk0Kb+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895284; c=relaxed/simple;
	bh=le66QlMuZE7hH1oOfQ5HrC4Y1Tp6IgLYo/j2eYYGOLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRpgbCe5mwnn1yPFHImavAtpiuKw9aIDzogmK+a5MbL9QeQ6q0vb46x/MrChBr83s1ZypcnW0GYJzjQWKwlHKNqPQZbDoKL0qEXD6T0042KBK+eZi2BI4SP7dCMOhau6zR0vTWeJGhhVsrjUjyB8zPi370wfD/ntA4pf2Ihf14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiQ86Q9T; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so277966f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Sep 2025 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756895280; x=1757500080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1WQS2V0Aq4ymgCMCBADFQC3VfxKGm3mbnfHsQGlDKY=;
        b=OiQ86Q9T7E4GYTCLRDAUAmriq+r22M+C47vmvBnvkMX0CKzPO1AGokAPLEmUEtmyAK
         vnLXIrs7jVxYLNZytHx6xNfBXGUpspUfmrMkPoopmyqLr+Y2BkUZhcvEecn/Jcp9u0y5
         +OmabEP68JmE+bLBYUDbLNej3ArhaF+6fTEDH6axrjFKZE3nZuaOTUOztjxrouCXROnS
         4hLLOG535ljYscVDVVteq999Gk34Ka/X4XuqyEZVB+dwzmvDNfHbImO2MCnkv1bYIDzb
         YB/xFFUTNRTkf9CbEjOrrSLVvQBSctUw2R3KgrLCbPG1n3vQ93NR1s/WhTd/ontzznIw
         6lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895280; x=1757500080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1WQS2V0Aq4ymgCMCBADFQC3VfxKGm3mbnfHsQGlDKY=;
        b=W1FlmEfK8yzVUW3DprPBVd2A0fgthZPRenXdwJ7FBPhOzSuk8CfNBqCxpIHl/9sasa
         ZZMNVHpeHrVU1xlBfscbIs+DRacwoHGbjZ2A6cq+hvQPsKN/jrs4YDqvl36WJErDl17o
         6K28Mk++mzECZzJ437jt5EDQtr3g+hgyE4X41PYlZLFwBWFe/WWc1svSXJlYmdymc4DT
         Ytgxs5j/4YPUMhnF4xdFAVsqpeDFBC+KyiARe6BLjcNWqkzqQRnVDfT9lIl0gtbdOpt3
         tQrTbDzIzfNskQ2ZT0ORv5VlKPzRqDlHdJg/P07A8AXh5yj1bpTqN4y8bQkUBlONnIhk
         Lefg==
X-Gm-Message-State: AOJu0YwVQqVOHL8S758gy1lvjDV5Vr0n4rKPVp3Dyf9WJHEViEF8ppbt
	ipAVf+D3RODavoyytlFLvjmn8A5cHaqWGtqL78wE5xofQPzhIltSfLg3qRpViBWA3Sk=
X-Gm-Gg: ASbGncsghHNkW1Fsvb4SsvtBPToDObPbhKCJGUXIG7Tf/gaB6t2nz+1Lhc7WW6vAqQM
	VbK0cOfSXU08hMBxEveKuAFroQ1JKPS3EOf8M70shfp1kRSOYviF1wA+gSLKRDH8j+/uyCU7MkR
	VI3A/f7zWM5RFjYRn9WbVAfqtTKmjGq3a98nxV0JyqHZlr5UQNCGxkyEA6H+yiW3iC0ScVmhKY5
	QFBx54gWMoho0sr3u6yUDn14Kxx3/3J1K65/SA7tkV8F1SQAC7l7deiw/x8L3YacBaNvZwUbWg/
	Poj8YyaBCDQTTLaoOL76xxCUKfgroaiwMnTBi1v5tgvJEUOZyLe4cavAt3VD51nmXbdynVz3jP/
	0vgRY3JyHq3EmHhB0wwKZGH4PvqPANGaKUbFmti0QQbiEG/oRDAVXpA==
X-Google-Smtp-Source: AGHT+IGUUt/nsQbBtMP9pzpPTBYBPoasAKJzS5Dkyri2rpl0+/sHhf/B6Fxwr6gUabi0H0wXSYBQiw==
X-Received: by 2002:a05:6000:3111:b0:3db:c7aa:2c4a with SMTP id ffacd0b85a97d-3dbc7aa304amr2579469f8f.42.1756895280034;
        Wed, 03 Sep 2025 03:28:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2a30:223c:d73b:565a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm55992855e9.11.2025.09.03.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:27:59 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v1 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Date: Wed,  3 Sep 2025 12:27:54 +0200
Message-ID: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 platforms have a couple of successive
approximation register (SAR) ADCs with eight channels and 12-bit
resolution. These changes provide the driver support for these ADCs
and the bindings describing them.

The driver is derived from the BSP driver version. It has been partly
rewritten to conform to upstream criteria.

https://github.com/nxp-auto-linux/linux/blob/release/bsp44.0-6.6.85-rt/drivers/iio/adc/s32cc_adc.c

Daniel Lezcano (2):
  dt-bindings: iio: Add the NXP SAR ADC for s32g2/3 platforms
  iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms

 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   |   68 ++
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/nxp-sar-adc.c                 | 1046 +++++++++++++++++
 4 files changed, 1128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

-- 
2.43.0


