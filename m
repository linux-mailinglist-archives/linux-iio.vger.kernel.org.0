Return-Path: <linux-iio+bounces-24673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BEDBB4EA3
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 20:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE96B422DB7
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0EB280305;
	Thu,  2 Oct 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+thbIqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510327B33E
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430543; cv=none; b=uPQzsNozfbVm5WEVge9efXX52B2vMTDLX3eZCjYkJutBIIBrCESfGPOfFDB4YQArQavzT6IongEDAfjhaePJ9JX1DGXzEIsQPgb9c23oU6VeiT3rWrXsKjgsR9W+18ji9WVZLKUKa/Rp7kzYEXUbJAXCqlIXmBJP7zT96WiIpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430543; c=relaxed/simple;
	bh=HhCHFa0EFtA8AuRvrj8xtXesClEos9CJZT5NVSJ5C8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCf6CUhbEZWoZOGf/oN1H9WhijObfvWfmIZ/VBcdQz8eYh+2bjVUhoDjZKcXxVsEUbnaxT9EKu1N7ZCubuVi5bT1gqBbT3k+NIajEn6KQgOstkIbYvJs/zz3Q0/3lKuTuEnIqiWGF238UurNPyyn89tY4rIhrJB73CRX5pB8jyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+thbIqr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7835321bc98so1487214b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430541; x=1760035341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qPjlv1lJ8MR6fVmoY/AaU1ujSOHO/r4FwpJCh/Gigc=;
        b=P+thbIqr9MS/sGnKeKRgJJgjqpy75emZGNeRU97cH/xtMH55/m9veurh/SfDTjnlEp
         mUD25J6wBpPw1hc4AA/fqD9SO8s9i/uEq5bB+2zJrNgO40DPdT6zRgpax0SP9fyTKEND
         q/qiuh/5BsuvsXuLkLhYen3tODNKaQapsCu6RSSTq2PQRGYAC4UaQ/Sv2cTOT2XJQGt9
         ifGks+HxLUHy2oJetbyPpTsBtyQY1N3011am5vO+3MdwJkyew/JjgqemEwqR3d6B8tCD
         jf+F0Ck+IrYEklYTlUCSTot+HqvELTu6TpyYVc3ZMAx6PKd+en/UUk2RcPwkkc2VZvyB
         o6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430541; x=1760035341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qPjlv1lJ8MR6fVmoY/AaU1ujSOHO/r4FwpJCh/Gigc=;
        b=Z331oayDxY1acaFqzVOl2gsojW+u3xmrcH5vxUYvdyk/vcDx5gKeWmSSMQ6jbzbt9y
         MKEQVhRo7KQBinDLVvpLWInYve1e3l8/SX5z/UyPj6OMYjz6D9kIGK9gulVZG3MZKaMd
         OAnHTuqJJ54FTmKP35hmDylGQ9qOfT8SYE9ZPj0k00iyESpqdL429d5UMZR2/dB0MkI1
         qiu1JiqgbO6F7V0BiQcPibGrMIJGDqF3vzRV82pNcmn18tkma6u+HC+cfEo3mSyXgXM4
         x4y+GKAPntEAX0PspZkkJlFMPqLRjIMwahEugbuhFd/X4YHa41S8/q+DLSVrXI4PpzYG
         RGsg==
X-Forwarded-Encrypted: i=1; AJvYcCW34NIvKzXxFmXU5M67LlloAFdIoyc+lxInXVaNO2SZoZYtvDSKstmliNndn+F3FGWVjPHDCvVlhBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgUM2VtE4NJQ5GUDX1+9WuKfFGb2DVg29ghirDlKyqa9e/2FA
	9+CZh/XlxoOx+ygnOHhdcLA0dd6UVbNLxV0BOWju7gCPj6HBhWH+7du7
X-Gm-Gg: ASbGncvXvcsC6RgOkJg6Z5X+Jl00hGlzk/o37ZLLaldM4fs4h/GIyLoEdmMhtBfMGip
	a8YMyKM6uhxQBXF7pS/ISfm3kpk+WSZ4DtSlfghnUoFlh6YxLyuo7VNdEz3S/bNMlSg40YLgpa3
	6T1ZlZii2beW5URMUWZhdmsjT8/UXoBqTZkSVQk62Z86qU1TLDcdjcHxkBH45eIZXthBNTaholV
	DBiYQS7Uh60h5mNM5r5Cy2wGEY1KVXq3g1msHNrF6zF9i3vrZF6nQieUtMuaYSE+P/MTUuOGp3S
	Wyu2SGZ2noQIoLnzVd/39/cWKptKo849PebDqe2k/esL7xy3d4qP2EN3q0ohdBpDReEplbPA+QP
	Tl8EgVYNr4dLkLzbVVee+LKRpRnmPmDFdbmc+pa96Zktqf6UtEU7gsW+Y
X-Google-Smtp-Source: AGHT+IE158JkUSIaEaS3oXYZ4vFl7nu8N6VKeXlcYX2Ca7DdlwgbiaYwME8zie6eNvnBRdAOll7WXQ==
X-Received: by 2002:a05:6a21:3396:b0:2f6:9592:9065 with SMTP id adf61e73a8af0-32b6209567cmr471844637.30.1759430540647;
        Thu, 02 Oct 2025 11:42:20 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:42:20 -0700 (PDT)
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
Subject: [PATCH v3 5/5] iio: accel: bma400: Add detail to comments in GEN INTR configuration
Date: Fri,  3 Oct 2025 00:11:06 +0530
Message-ID: <20251002184120.495193-6-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
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
index 41e95291b36b..c42cdf0a1645 100644
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


