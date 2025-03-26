Return-Path: <linux-iio+bounces-17266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313BA71729
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 14:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3DA7A4865
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE31E1E0D;
	Wed, 26 Mar 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7keVYpY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8A1B0435;
	Wed, 26 Mar 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994828; cv=none; b=UNhqBrSyANtY2MpBR/pQjcFgzMcxRsKQnhx96AWLWnrdKxO+T+GAIv9n1tofunMTXk1oD4Jtydwi+MGg45OudrN/yNRURxRMj9pVnk5VknVhgL25Ie5QC9lH5BXtieo06ofbfkMlf4fCLHgt//svzOIT/UfuX7AZoo+4v7lLRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994828; c=relaxed/simple;
	bh=E+bCT//FoLXOZLmdv4Iouw925tTRa3ZfBhLAVQexUbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lx410okxSG4xuJUc0gR0oAaYb+TpnRX2St6QvT9b5tOn9NmOyea6Ng5XOC057dyyJ065IJkmUZz0JHZEQCCRsvyrAYAyRoIbbhUJGgUdK9WcC7Dycnx7LADbV5w+Q5Uf5RMt8zvKGkyikbK7+T3M5qZJwqXk/YgaMuWtUIVmfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7keVYpY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30384072398so548036a91.0;
        Wed, 26 Mar 2025 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742994826; x=1743599626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3yvLsBy83apkWOi47GV7xH4xs4WujWrUpgPa9E4Thfo=;
        b=S7keVYpY0q7SfwoMdug1q3mz+5J28ol4Ferq2fWuX0OxqsZqsDHpMRRCzXt2pHq0iZ
         c7ALxqNG+Wne348yyV2KPk1K2NaJKVAfRBG4GCPW5/gWPSd31KdpO+KoOHS9GIu74Mbx
         oGqGYmzqe43a0xqLZdjkMwpmpMqskePKGYivL64tZzbA746CLWJkdbcq0VClqMAp0eFH
         wQeMci+9KYevGymXlOtYuh7UX+SeTLDasIRnpEFA++ayiCkzH1a5+tw6cuzJnto5mdOn
         U+AFUesy6eawFeTyZULt4cRXGlUlntFWTY0TI2t0e3tKDEJrY/OpRqDEoxKggcL1tBT2
         OEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742994826; x=1743599626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yvLsBy83apkWOi47GV7xH4xs4WujWrUpgPa9E4Thfo=;
        b=R3Bpvmb3sq6tXe1rRco+HVoRpsnjtLFsxDOR3MsY6CyEJWf7MDPb6BeSDchO3nJFKs
         bm08ahJAfcUVYI54iDlD0v8oDMvJT4/ix9aCnOyu53UazjXrKo9eGvWt+7YIUhJddA+v
         yD3RHAgf9IOw+PLmzTuzdx0jvPu+zCTC2MKrZ07A0hkCmv+M7G8kuRpE6ouN//tr4GhR
         eD5OBPi1AcmxR7JgYICFSY1egi1W2KXVhl8/GGg9hlm2fuzAlmXbjPJatRFLjvNgavdc
         jI+0kr1W5w8lcRk6rdywutnRnABK9i/f2cXRNJRM3L5Svp7vH5IVghcQKiZk/gki590U
         y9Lw==
X-Gm-Message-State: AOJu0Yy1qNhNWaZwHaw9hepuAxP6zkZ2VWGKX1ApPqh7O4wXUKhtpm/h
	+uMGX2SDahKxnUuzQxs2pHkbNAEvE/S59D9mL2iGz/bBoFZy3ab6fO6X1HW9naKgyg==
X-Gm-Gg: ASbGncujA6m+ar+JsFc9xe4wLGFxtS6i9BP/qjpdXtO4WkzYyYai85cYKZ3OWcsF+aK
	ORSeIflrLJxUkaWkn+gXTlQa9XHCGIDsc0c63e2KSsbrQ1zRX77Cf4ntSSLcGaXD5EmRiLO8jzY
	XWWnBNS51vsQrUeM+YsSjNDmxu4zbVwpS1UN/ZLMpVOyg5zcWg1j+NWbIpefzm9AuK6V3jeDl9o
	oiNaS0H2pvlTT6Pq/s/IGTBzd6JboIaWNcQsyjSZzSJkvF3bcVj90nSoRoKZh7GUSt2lXa6GNf/
	JyE/D/iecquA1/qNAZpR9lHhwDay0eVwyh66dUODmD8UaiVgSCN0qtngjtY2+YPSJb4=
X-Google-Smtp-Source: AGHT+IEWBkKSWzApdTr0MVmRaWZeVxk7RItkZYRuhvEBSOeMT/OMOk1H16+lPFpTvmfRXpkhR+VBpw==
X-Received: by 2002:a17:90b:554f:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-3030fe94313mr38929560a91.14.1742994826172;
        Wed, 26 Mar 2025 06:13:46 -0700 (PDT)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039e60f1f9sm108696a91.47.2025.03.26.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 06:13:45 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	marcelo.schmitt1@gmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH] iio: frequency: ad9832: Update bit manipulation macros to use FIELD_PREP and GENMASK
Date: Wed, 26 Mar 2025 18:43:03 +0530
Message-ID: <20250326131338.21309-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update AD9832_PHASE and RES_MASK to use FIELD_PREP and GENMASK for
clean bitmask generation and improved maintainability.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 07baa574aa46..1627b0d5de8a 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -62,7 +62,7 @@
 #define AD9832_CMD_SLEEPRESCLR	0xC
 
 #define AD9832_FREQ		BIT(11)
-#define AD9832_PHASE(x)		(((x) & 3) << 9)
+#define AD9832_PHASE(x)	FIELD_PREP(GENMASK(10, 9), x)
 #define AD9832_SYNC		BIT(13)
 #define AD9832_SELSRC		BIT(12)
 #define AD9832_SLEEP		BIT(13)
@@ -70,7 +70,7 @@
 #define AD9832_CLR		BIT(11)
 #define AD9832_FREQ_BITS	32
 #define AD9832_PHASE_BITS	12
-#define RES_MASK(bits)		((1 << (bits)) - 1)
+#define RES_MASK(bits)	GENMASK((bits) - 1, 0)
 #define AD9832_CMD_MSK	GENMASK(15, 12)
 #define AD9832_ADD_MSK	GENMASK(11, 8)
 #define AD9832_DAT_MSK	GENMASK(7, 0)
-- 
2.49.0


