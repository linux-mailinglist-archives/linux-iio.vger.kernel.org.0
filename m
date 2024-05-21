Return-Path: <linux-iio+bounces-5165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC78CB175
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7143EB229C2
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE921465A5;
	Tue, 21 May 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6CG0M1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C8143890;
	Tue, 21 May 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305701; cv=none; b=awmaQcyS1UjTfRPYjKNivYwm8f6uCE5Btb3U0tu4p3325hqSAJl4Ef5I7IC4cQmfu9dnMJKHI7C8I7rZD8yM2bM4HFPe63zUm7INikycEiM3ee7Bvnyx1kIa2M7H5EqdgWXvnPhaQrrcKxNxVhX2dOh885xP2C6VbU6CG8+STik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305701; c=relaxed/simple;
	bh=IhbufTRNj1fsqNMJmPo1i6lTZleZnqfHZ5ZVklTF00M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BI/Wa6vNBBYv/ahmkwlg7EQlHpOAZg4WzZOFwBuOmakpWfmNC+jbYVVFUBmc+9tspmSj5vLt6IfsOqZYqH9mYrgENbh87y14o72qiUO2jm4hsAaKIqD8s5x7rWl25pVUOJHkyHR85UGdKjj4l9smQWJrDZTxGFgztinmliIVsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6CG0M1Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4200ee78e56so31251185e9.3;
        Tue, 21 May 2024 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716305698; x=1716910498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3RuTPxmjmQFVuJzzTgJATCtyYrNLyLjxNXWjIoUyj4=;
        b=h6CG0M1Q1BPfxAuH+hKUPgNFnShaX/GzyWoWleENe2wVw53sbqYaTNptBuGL4EhSVF
         V6mS6O84XiQOEveKT6TXhv+U4o6NiD2TfcYj6mpIhVIHse1AJqdtG1wWEsSXMC3+3VBq
         ywMyieq8VX8MtW38mLHXrYc1C+AVcMIMLwHfjPlj9nzexT7XOZJEPZuXESPHWUBQlojv
         JClRvCdX74yZL7loVku6U43v617cd89aNRDrElqtuzgiillpCnnouE8YNJID/UdFHuCb
         OkJ+1WUX83r//Dt5rbPSMaxniPKtc9qjPTtz9xQtH1kWhEeiXdnjCmbNGrNzqjtc5Vev
         f5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305698; x=1716910498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3RuTPxmjmQFVuJzzTgJATCtyYrNLyLjxNXWjIoUyj4=;
        b=VYCT2X7icj0NJkftvEkIjkrhqRe+jxwLHYhAtIr0w1Pe/oQDfEPH5eHa2qeO21aaVx
         /IK8JN6kp4Jgu3HaQfjuLqJ2OJHLKqXtLT3iLDcAAzNvk2DQcFj5cXHO2flujokFSF4k
         P1I0fmwMoPHBFJhOVd1eR352dADWoeBKErogIoxl+xWNnSwwrpPffp7l3N4Q9ZIWJ2py
         oBoK/AxD7QgryFqh4p85lCDb+kqEOx/I2KR8vs5T9KSFabcLKQnHtVnxDsin/Gheft/G
         8zjdiz++UXzxK9Guxyu9AJ8gx707bRCne93iTW++Ngtx1HEKGcKHaEu2s6wYrwsmO3/I
         sH5g==
X-Forwarded-Encrypted: i=1; AJvYcCXEUUyWQsV5w1kJmLiNDYpP4GeGOeraveiQ6NM0jD1ZHk8hLLBg2CFW1dI76xRpYVdRmcRneNKREq+G48r5eSuMTE22UWP7tpBnS36t
X-Gm-Message-State: AOJu0YxTbpbdCZwrf6nfFJ5/kRMKSjo8Vvj2Gx+g7jEZyVAChYPZnlrg
	26poKge0+21rBse29UV62Im4/D86vos2AajBleDBcFYheMpTcZTq6DPpP7UP
X-Google-Smtp-Source: AGHT+IH5QKibLyDcTpAV+T6KJg6LGOZDcU+2pdVCXEiga1AgYpwzKY/iH/ItyXSKh1v2m6J1Ro+vOg==
X-Received: by 2002:a05:600c:450e:b0:41b:d8ef:8dcd with SMTP id 5b1f17b1804b1-41feac59ea0mr240309145e9.28.1716305698403;
        Tue, 21 May 2024 08:34:58 -0700 (PDT)
Received: from [192.168.1.130] (51B6D146.unconfigured.pool.telekom.hu. [81.182.209.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013c5fa61sm368737285e9.40.2024.05.21.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:34:57 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Tue, 21 May 2024 17:34:53 +0200
Subject: [PATCH 3/3] iio: light: stk3310: support more stk3311 variants
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240521-stk3311-v1-3-07a4966b355a@gmail.com>
References: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
In-Reply-To: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
X-Mailer: b4 0.13.0

Add support for more stk3311 variants like stk3311-a
and stk3311-s34, they are register compatible but they
have different chip ids.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/iio/light/stk3310.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 5b3fe98af9c9..2905c9feff1a 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -37,6 +37,8 @@
 
 #define STK3310_CHIP_ID_VAL			0x13
 #define STK3311_CHIP_ID_VAL			0x1D
+#define STK3311A_CHIP_ID_VAL			0x15
+#define STK3311S34_CHIP_ID_VAL			0x1E
 #define STK3311X_CHIP_ID_VAL			0x12
 #define STK3335_CHIP_ID_VAL			0x51
 #define STK3310_PSINT_EN			0x01
@@ -83,6 +85,8 @@ static const struct reg_field stk3310_reg_field_flag_nf =
 
 static const u8 stk3310_chip_ids[] = {
 	STK3310_CHIP_ID_VAL,
+	STK3311A_CHIP_ID_VAL,
+	STK3311S34_CHIP_ID_VAL,
 	STK3311X_CHIP_ID_VAL,
 	STK3311_CHIP_ID_VAL,
 	STK3335_CHIP_ID_VAL,

-- 
2.45.1


