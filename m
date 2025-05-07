Return-Path: <linux-iio+bounces-19251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1861BAAE907
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E033B449D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2225C28DF1F;
	Wed,  7 May 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUckmC0z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5D2571D7
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642290; cv=none; b=cTuO/bfLfvn0by2DcC12vUF0gDvmfGoR2ANPIb9tbqaPsRSWf3V5mSjloEX5sGw8qa8lSXuUVf7YdlljhzvYk35vl1lWM0OUFb0oJ3pjwYIgnPRlPZ56daYq+TmQpyWUBLTRCCTptAZjfIhvwAs4Ase7AOdBXj9KcBrJGa/6dkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642290; c=relaxed/simple;
	bh=1T0ENfORJYSknqSuDcDSi+byqb5zegXymlCwnhvc5QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lx0c2F1MRJGfd018MbJlSFCWFrkOonPAvZZ+dExJ7VemO71O/VKTBMzbGnO/H6MpUl4qZ50yml2D/p25A19BFId+qveKPuueHBp8OxYzs5YgqA8EagRTJOpkqOv+rZceV5xkq2u5XowQif24rzv/jXrfdHIHHvPFqsRuRCMLH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUckmC0z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736a72220edso228528b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746642289; x=1747247089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KtdcqjlBF5kwU0pyBvBCZDYVEvieJivWW4pVejblka8=;
        b=PUckmC0zc9JXHjVhjPQamIJBrFczMNaiLif4OlxASKTWLVi+8fBdYQqd59uHtSGKtD
         YqFo3fdV8vCer7KpGdULHte4MdX2l+rIkmLwdU2K70sjKo0GkFbDt5x4+h1HJaW9eXX1
         IZVPN97gN66Q+b3OYqi+BYPMBwSBhIF0Gk0R1mdVShN1XNHo2jDxL91FU0xkZbmqUOCb
         1UQgFWUk6O6lSc7bSBLJnuw1tIMYzOUqLM4hHFG8NvswErQpysfv7FyQ1fm+f8Aqmb/R
         XKotEPrFDE5TbbkSUXUH63ckIb7gZOwi5AwrxVxLQTB4a+mbqzvXbH0BIo8c5KhSm+r9
         aK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746642289; x=1747247089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtdcqjlBF5kwU0pyBvBCZDYVEvieJivWW4pVejblka8=;
        b=hMxub+B7MXt6Qh0Hx9IO5llzKnLvqpnUXPbszWOefXWUJnzPpvKQceJkUEg7R+oEWJ
         AjQtmPksI1Q+0fO3PboDMywNYIhz7njDg/ljH2DTVv1dOCtTybp9DY3ZkrHGfKklpTBE
         Jv2O5KtFS1b0zwsqMmgf9d7HpBrfBcZiJiKzxJMXzwHG++0K5tzgCpo+Eflmz1+u/Ys2
         jRuHJvSt/cvw3wZ5IszwD+wXAtdblfo5xbNLzv0mYYA5tytqInitmUyy6Mxl2/XUzPAd
         Taib0QOEfX4Q56ytWXQooEimcPsOWe6lz5y9CGkTk2JU7I9c1ZlnYCyTj2TQv8qK4PB3
         u5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIEZOOoiTiU4R7iYczlyRUD/RFYo4RBOyeaHojf0vfhecP9VthyozQOPEb5uIxy+263jatPMEA3nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIYvclnvDWIgGoShm7ImurcDIki+7VApcCRKlAfTtipqOqP1Vk
	sK8y5eVbqmU267gv3g+CGKInv/AM/9aw58iEZvuNQrFe1O00TSsBgHObt95Q
X-Gm-Gg: ASbGncs1cs+vXXgPwgurJ315++02O0PL1/pqRYDDocy66cMaorrI4QRNEtJhPnxS0OG
	i+ga3Ri4FuL2CLU4XiLyEg314/tox4mFklI6DGqp8WU7Yuv7WBjOSQf7epacKkrXHp/oHfbc0MC
	kN3npz4pPn0TbCJi8PMdn0QBtYlnHt5PH2NjxflTG0NwukQ4F7NGgsJtZf1HvNwnIcMO0POYLxM
	8aKwlNQlm8cPmwbsGdlz/YmFJWvDKExNCumJdiOvdI3NXHbtK9hXNouCy9zLvdFX7fHogM1p05o
	L0Tij5wrqD4I8Cs3xWaCHKvNkucuvJ15ZwXn5/q8JfTLBYJMzQnIJ9WsDQ==
X-Google-Smtp-Source: AGHT+IFetaHThfP4mdBkml0csE8oWm4klD94uiICnnQHuDubGelmKhjSCVDE3AggLMl9MI456vXxWA==
X-Received: by 2002:a05:6a00:ad8f:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-7409cedc761mr5131419b3a.1.1746642288536;
        Wed, 07 May 2025 11:24:48 -0700 (PDT)
Received: from BMO.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905cff4sm11487668b3a.125.2025.05.07.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 11:24:48 -0700 (PDT)
From: =?UTF-8?q?Bianca=20Costa=20Galv=C3=A3o?= <biancalvao@gmail.com>
To: jic23@kernel.org
Cc: juliacalixtorosa@usp.br,
	=?UTF-8?q?Bianca=20Costa=20Galv=C3=A3o?= <biancalvao@gmail.com>,
	=?UTF-8?q?Bianca=20Costa=20Galv=C3=A3o?= <biancagalvao@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: magnetometer: mmc35240: refactor volatile and writeable reg functions
Date: Wed,  7 May 2025 15:23:26 -0300
Message-ID: <20250507182327.49068-1-biancalvao@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The two functions `mmc35240_is_volatile_reg()` and `mmc35240_is_writeable_reg()` implement exactly complementary logic.
Refactor by having `mmc35240_is_volatile_reg()` simply return the logical negation of `mmc35240_is_writeable_reg()`.

Signed-off-by: Bianca Costa Galvão <biancagalvao@usp.br>
Co-developed-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
Signed-off-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
---
 drivers/iio/magnetometer/mmc35240.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 07f58567e521..80f023eaba9f 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -418,14 +418,16 @@ static const struct iio_info mmc35240_info = {
 	.attrs		= &mmc35240_attribute_group,
 };
 
-static bool mmc35240_reg_check(unsigned int reg)
-{
-	return reg == MMC35240_REG_CTRL0 || reg == MMC35240_REG_CTRL1;
-}
 
 static bool mmc35240_is_writeable_reg(struct device *dev, unsigned int reg)
 {
-	return mmc35240_reg_check(reg);
+	switch (reg) {
+		case MMC35240_REG_CTRL0:
+		case MMC35240_REG_CTRL1:
+			return true;
+		default:
+    		return false;
+	}
 }
 
 static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
@@ -447,7 +449,7 @@ static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
 
 static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
 {
-	return !mmc35240_reg_check(reg);
+	return !mmc35240_is_writeable_reg(dev, reg);
 }
 
 static const struct reg_default mmc35240_reg_defaults[] = {
-- 
2.43.0


