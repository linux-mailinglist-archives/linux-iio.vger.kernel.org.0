Return-Path: <linux-iio+bounces-17274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA88A72038
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 21:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32AD1897C77
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E725DD15;
	Wed, 26 Mar 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8J7or5B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C82192E2;
	Wed, 26 Mar 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022228; cv=none; b=ql6DmvcU8m17BdwL9Pu5eHYlHvi0oJNTNVW1G88xjVsoN9dJlJDgEfdrP4HlSqMhsPDhDP6kiTvpCtTS/mpWeT0gBd13juFHycEm1G2/SvZWlUlk9WPx7sCI+NPTw+OvBA51z1fdyyDGQgSyPTnCckoHtqhuKgPZZzcY/0G/mPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022228; c=relaxed/simple;
	bh=h3EYkjw7L9UGlc3Wubv0gpRSL0eQmUMaB71c0nEDWhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+FJ4QAUk6zMXW4rl7UCpvLaO5HRmT66NP5gEAgS37NTEY3YFxuVVjyhyz+BBxrGzournkZkaQShp1tefnLrRq+rvybD9g62VN5EadurXQJ7vOGYRdMbQ1KOr1v90Q936yPBe7IdnlGIzfaVq11JtLaKOjKND/G2MSj7FrUm12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8J7or5B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2241053582dso8376855ad.1;
        Wed, 26 Mar 2025 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743022227; x=1743627027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bP6P38XoUK0rcAsKbIKLNxYLayd1+Nc9zo4Ms/5SEFE=;
        b=P8J7or5Bhg4EPKWqZIkhKTh+RgCbKEDdo5yzpvbSD77N3WCe1es6kMZsTkUDGpcbWm
         nXibilrwHyfP+OYUl3d4REDmdeI7FZyp3xEYKmE0SJYp5kJgt8dFrByd7n/iKZ4g211K
         ycntfpaAq21IkeKDvDi5PmWz4izgQ0+4TL2o/zXMLGENPv4k3S4z2FPDuoX4j2wY7GaW
         xqA9AjWpB2opTJImTBlsKjnhQmEnsOKjvW1w49Z5qyIKf2QruHhEuN934NXA5oLL4C+t
         b3zq8Rf7LVWeZXJlwx8S/qvdVwcEwm08jBChYjbMqbvenNHUarv8rLDX+X4JSt4BsNgX
         C+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022227; x=1743627027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP6P38XoUK0rcAsKbIKLNxYLayd1+Nc9zo4Ms/5SEFE=;
        b=nF+KeczH3SPuwG9yyiNqb1a/OY1pzqELFx7vnHoBIFI+9D0JJOx2uC6oRwj1I7Kz1E
         qwQaPCoa0kkM4sBrSRvs6xhDGNTOYT4Xx2tSXjBieIxDJpB205Xmq0qbmtFAou9KvLbX
         SnyX913q/39zGYjLk7jycPllwU7rxbUOJ5aTcJuCYEoSVNBDrrvEghtaQHKlPiA4TPR8
         W/4wZTxXawep3L+1QNVKeIesDuxGFttxpVTA+nYXR6PfbF1EbbdwPnzZ6FWbFFJVgS8b
         jOX0Mj006SlEMuJTn1VjTxaXGHtVacFRtAWMFohXwN9O9Yk2Q97OruLgyn2p+PNGNFwT
         lLYg==
X-Gm-Message-State: AOJu0Yyu3gzEr14RVf8Gj+s5+B454eAvj/pIu8GGUZ174TDRwyXBbxI4
	mXkOyPPT+djqWFQAzMCmrysJyz5wt/+3fTXvJ9jI0trzPfxE8cC0yB44gDHjP4hDAg==
X-Gm-Gg: ASbGncuUvQz+1QCsiuEQUWAxKmdA45cEjcyWqHizBkdTXxEY7NgTftwmNoaLXyBDimC
	NDepsW+ZjCV0B+JVs5301tIBSOcPeY2WDThNFa5GwPuxTyJbM1M2zgwD5yqYDvLVgJttzAs4gWn
	AK3v8IFrYK7eR6wESaJCQqnWE4f2oOawFwJ5XBHaPyrnPDHDVnIrEtTpk9ra/jJ+U19ViDx7nYQ
	qy1+mqM2e1/cUSzmmVy/TrecJ3bRx9YYvDy2K/8i459SeWkIpYbdkDhwggYfVf/6wzDjbNNtkqX
	sn+CuDI99wp20kXe3vgS59SqSUpzlEYCwipKpwrBOvTqfnhj9UDWAwz5Kn1aqJEnqzA=
X-Google-Smtp-Source: AGHT+IFlu0ktIlK5C0YIvtzx4DrdXYfKxDAoyXP1J1wg91+68H9IPtUSEvVTlnjABJd7uNAwixBmQA==
X-Received: by 2002:a17:903:19ef:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-2280481cc28mr17439445ad.4.1743022226379;
        Wed, 26 Mar 2025 13:50:26 -0700 (PDT)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f397a2sm115291155ad.48.2025.03.26.13.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:50:26 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	marcelo.schmitt1@gmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v2] iio: frequency: ad9832: Update bit manipulation macros to use FIELD_PREP and GENMASK
Date: Thu, 27 Mar 2025 01:50:07 +0530
Message-ID: <20250326204901.44337-1-simeddon@gmail.com>
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
 The previous patch would not apply cleanly as I was not working on a
 clean branch
 v1->v2:
 Resolve previous patch application issues
 
 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..6e463488462a 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -59,7 +59,7 @@
 #define AD9832_CMD_SLEEPRESCLR	0xC
 
 #define AD9832_FREQ		BIT(11)
-#define AD9832_PHASE(x)		(((x) & 3) << 9)
+#define AD9832_PHASE(x)	FIELD_PREP(GENMASK(10, 9), x)
 #define AD9832_SYNC		BIT(13)
 #define AD9832_SELSRC		BIT(12)
 #define AD9832_SLEEP		BIT(13)
@@ -69,7 +69,7 @@
 #define ADD_SHIFT		8
 #define AD9832_FREQ_BITS	32
 #define AD9832_PHASE_BITS	12
-#define RES_MASK(bits)		((1 << (bits)) - 1)
+#define RES_MASK(bits)	GENMASK((bits) - 1, 0)
 
 /**
  * struct ad9832_state - driver instance specific data
-- 
2.49.0


