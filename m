Return-Path: <linux-iio+bounces-25003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D46BD0957
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570BD1897D70
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230202F2918;
	Sun, 12 Oct 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwIyc7OO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759772F28FB
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292450; cv=none; b=tVYsQvpHfrl1MQQwdBrDxKRoyhI/8Cd9vJcqtyYf2PW49yNJU5kal4thq99Yx2lmSmGRUMGSS9fkDritK3mu09+wjcNMi8Nd8gzA8qscLkVnmD1ErmE1Hf08GMZjzLq4KdEOS4tfdCbkfU/MCNYAxmy2n4XuTFVGQLUmAzwW9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292450; c=relaxed/simple;
	bh=jg2NE16emE6/A9nnGAISOkOaG4gb4wO16wIq6mM5VFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIIITQYaGAmFREo8q+vt91DcQgz0zMXdaystDv1ms6RN/wqS6fqyr+S1Z31s2KbVTw1k/Jwjwy78WxHYMTA6Bwrseme1LDyigAXM7VjewSznb9l0h+wpqNMIgEezafQW5Hz1PSofheFW3Tx83R5ekq2XkqKaYZ7K7NorrFLxkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwIyc7OO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-794e300e20dso2696292b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292449; x=1760897249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4ud3JfniFPXrvZXNPpGJmhJ0NKwQUht98YQCdsaH54=;
        b=mwIyc7OO6NJwbovsJbrCto84mwQrRL5O5ADuPoTWKtl98q4mJThs327Uo+nZyGWaBj
         n0UcjQjl8QvtwiBBsPWHZuXpgU6QIbdLZiwv+GEl3hNc67qkb7AbqJZHUYywoPMln/g7
         2QAgSj/AKLtQRwWgUkPf3yC9qqFbSDz2okU+vrJKwSCB0nptbuA1s2ec1EnYtDNdHgxP
         ecBAJwlqE4ITgMO4NYXgxu9xtI0yzEvsqIsFHthyb3s+sJS4YWNnKBci9M4QMNiwvY7l
         K5gH5hrVbGjtFhUUkMav2YqMVR1QPDKuvL7BPeglsl4OvfUalYCEdV3Bs8qdZjR59V9f
         S9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292449; x=1760897249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4ud3JfniFPXrvZXNPpGJmhJ0NKwQUht98YQCdsaH54=;
        b=pJlx5LOfxY1szv8I5cnVUicnLXCkBd7zgA4RmYm/8UEmFj8pJcZVKnZgr3MCU5VlRX
         u3OJgLl9WnIAG3qHiSxujm8QauLK9ToyxYcbY1pL44Px59fxiqAl3MtQGQ8K5ns9/GZD
         akAXycX8l7/ndy5/sXSX50uiBfArAc0NTOcw6cSggfAax5jqAz1Q2t1rcO1BSm6X7H69
         fkAQgkhg26wahnTT1G76U+K1L2cIw0EYmS0zsglQNXi4XXNp+GShHQD58VnrYg0wo8Z6
         WUIrsQKcIyOHev8CwFg+hHAPp51ahIvUihukm809ffiEWjUhBh1Qun7B79GaIjTkDXCl
         i/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW1+ja3X4WmkvQsWvxMrNJfB172UNWD5XnO0XfHA7pPNMo5Ma3P8lQ8alM/uWhfLFK8Cg/AKPBP4hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygaRPZuaO08aVjjCo6zaqAV4Ix5MwJlyEctOTj194wLDBQaauR
	dPqF3Jm3OsnPLt3Z5csy/k80wOuRahI98J7C6pxRkBESU3apc/r1tTOY
X-Gm-Gg: ASbGncshzciXfruR8OnY8HGT/3nBG//5NYfWsAGVNym6s4/8b8JVTNumfRxH0MC3CZj
	zGpxP90Zn8JZBykxZ5uIRh3Jump1pH8sW68BDy4BMbSSpv436Tp+pOD5XSiip/9CzvDn/7ihyzl
	bffltXb7tt+jg1INFhZC/TXuQZO7+iBXsL2kWRDkcNoNl7ZDvSpRaLBM/hqfrUfLqbguinFOLmz
	hn07LYAsr8cTF852w1la2qK1+DQ57YRbfIn1cA09te9mHtDS9vJi3hI5V0znzWX7gs3QxWs4IUl
	/005BtOyC0fX2dTo15A3sv0oaoB0e6qdpCthtgxYQw6nJ84sBjL6jX+C3GOE5jDaP5GH9YXI1n3
	zzxnznJP7BSfUS+PYjwGzvDiSX07myZa0OJzdWd8r8OfTLZRRNP6sfzyRdQty1w==
X-Google-Smtp-Source: AGHT+IFQrrOSKTP+v5RJLdPE2qomGexJJnmalRps8ECs1c2T3X8NS+ECJAuU0t4ycD7nqvokir+lIg==
X-Received: by 2002:a17:903:38c7:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-28ec9cafcc7mr251834875ad.25.1760292448673;
        Sun, 12 Oct 2025 11:07:28 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:28 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] iio: accel: bma400: Add detail to comments in GEN INTR configuration
Date: Sun, 12 Oct 2025 23:36:13 +0530
Message-ID: <20251012180619.195244-7-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
References: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Append additional information to existing comments in the generic
interrupt configuration code to provide more context.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 840c4156ba60..05f72707f830 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1208,7 +1208,10 @@ static int bma400_generic_event_en(struct bma400_data *data,
 	detect_criterion = bma400_genintr->detect_mode;
 	intrmask = bma400_genintr->intrmask;
 
-	/* Enabling all axis for interrupt evaluation */
+	/*
+	 * Enabling all axis for interrupt evaluation
+	 * Acc_filt2 is recommended as data source in datasheet (Section 4.7)
+	 */
 	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
 			   BMA400_GENINT_CONFIG0_X_EN_MASK |
 			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
@@ -1226,7 +1229,10 @@ static int bma400_generic_event_en(struct bma400_data *data,
 	if (ret)
 		return ret;
 
-	/* Initial value to avoid interrupts while enabling*/
+	/*
+	 * Initial value to avoid interrupts while enabling
+	 * Value is in units of 8mg/lsb, i.e. effective val is val * 8mg/lsb
+	 */
 	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 2), 0x0A);
 	if (ret)
 		return ret;
-- 
2.43.0


