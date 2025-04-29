Return-Path: <linux-iio+bounces-18859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732E0AA12E1
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2797A6960
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF76215060;
	Tue, 29 Apr 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbMoqRys"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586421772B
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945947; cv=none; b=Wun+MbO31pf7HPcs8C0X0DGhjmirMMuceXjyR02XWTwwSzuc9SBICiXGPqVkCfaYB7BAt3Hqw10IagQEDvlZVtY0he2Pf5HK2AmzLMCCqic/FfXj6zIwC7eJJTGy4F5uCxUULAxufIeSYHADTeOwrXYWykwbW7Db4nv/qslQL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945947; c=relaxed/simple;
	bh=trmPc8uygPxAoD4x8A9V6O2tSephr48QIN45QePdx8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/+ATFDJH0TtYxH26takp353/a7jBpRp6sxq+oPyp4vd0hIG8xW6wpiIgjECh15puFS4OGbMRE1inPns5wjCaL9qNRkdwbCtKHHw+ND1c88cZyAGeUIMwnbXUcrJxCmpFJOSWy+ev0gFvJ2sBviNPqabRKf6jO1HPrnNPR3KLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbMoqRys; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c3407a87aso92681755ad.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745945945; x=1746550745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JluZzK0/mjZ9PU3uH2tcKKO4a75cfjz+q6G6KFVklKw=;
        b=mbMoqRysGJsjIDHtB2Jd45g7pGgNVQY3AhxIuOj6vYGYV+N7NGMo2oqV/2ZnkTcqyb
         8wra8HWlH53t8XPCvB2EK6ToWGhZWwjWiVY3fupOG3d5BgwbmPzPI8xyKGP4JG01FvkU
         PKNIK2gO3V6sH5oQCrEhIyt/M6NZ7TaZ6pyR3eWQNffcPy/QMLBfkrHb4Rd2ZvIXxVLG
         3YuB08PmsbMwv6imiHUCiG9faT5aBZlX+lkqkeI/8vkDLrHcI9BS/JEV8kppqQgjH5W0
         jfG+TH3WR4kT9RbSzj9PwQL4CMPCaga1MT3JoSJJx9+ZfCHlnle+AVDb3rcOU6VpkEBI
         CF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745945945; x=1746550745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JluZzK0/mjZ9PU3uH2tcKKO4a75cfjz+q6G6KFVklKw=;
        b=AIbVYig9ipCJgPr74MxuHvtiUIkA8cCTgb2D7tm6DE9bTs3wbav34EBVc1EvFAWFlP
         TQ5WClJ5rEz4IcZGasyQ/MVCO/UZsVLqq+HQVSdRdC3EtlggnsR0jxCo2nhGU36wbgzL
         0Vc4qtPeU5WvcuVyRVIQ9EbMit3/ekKJDg5OXBqHj6tfFLDJ5mdEiSFWLHEJwsof0y4o
         k2++QJPRlPpTLgzdIGpjD72PnnjB7xxepTYmJY2Z/4fzRDGMPZOUF6rX78O3qkJu9btO
         odEsiAim0LhT1pNnjXI9s4Dx6dq1hWfONzTETOZuSYWg17FGAsuCJzgTgnKQUvYLrLdL
         PWKw==
X-Forwarded-Encrypted: i=1; AJvYcCVXovvjiBm1kLxigaPgscMUSi+t5XUlX+tUIT/gqkPsiM5E4g+9lneg01VjxcXvTeQLusJXnICNsoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTMQaA69tK/y0m4kYwckeJEjLCI08Omtc1kUOE2d8+KZSnZkQ
	7zhl4SeXuJQwtQ0hZ0X1MxLhCLM7IAkJ1yD0FMJhqfpr/MpQSGpOukxExQ==
X-Gm-Gg: ASbGncungcbak7Cqv8xns4/pNej3bvBDeiK4nXCXYExrP6Bt8NFED9tgMDXAYnbZt0o
	tLQVPOSje2k65kK9Dsupx17yfup8HfzNIYa3wLn+An+YkVAtmerRGTwYBqKVAJQORMpuz1gp+1x
	oD6f0/tNwaG3uPId3u1H4CcsNSmQtt2jD4YirOnnoVIAI1MbvgLCH4fKcEUYXoaxtainhySfzTo
	GIEWLkY0ntptMowQH1HAbUID/45iZ+jM1JZgIzUF46zTVhlS6gTWyKFBAyY1k4UqRZO8vjts2kv
	de8o65VZAxRmlzlyx01t2dspkBWy8osfDlmZBQuw2lGOcyr3PU4H3j3rcnwmhY/KCDUd
X-Google-Smtp-Source: AGHT+IGDZoTkWzLhpWU9Fwne0npxJEHuRefTwVAolEF6oJsiNmZ9B3+MPR8nIzzf2EsvzzfkiZM2cw==
X-Received: by 2002:a17:903:2283:b0:225:ac99:ae0f with SMTP id d9443c01a7336-22df34a9f70mr1844515ad.1.1745945944754;
        Tue, 29 Apr 2025 09:59:04 -0700 (PDT)
Received: from saguileran-ideapad.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4c132b7sm105096285ad.0.2025.04.29.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:59:04 -0700 (PDT)
From: Sebastian Aguilera Novoa <saguileranbr@gmail.com>
X-Google-Original-From: Sebastian Aguilera Novoa <saguileran@ime.usp.br>
To: jic23@kernel.org
Cc: saguileran@ime.usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: pressure: hp03: Drop explicit hp03_is_writeable_reg and hp03_is_volatile_reg functions
Date: Tue, 29 Apr 2025 13:56:03 -0300
Message-ID: <20250429165604.67984-1-saguileran@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop functions hp03_is_writeable_reg and hp03_is_volatile_reg. Both
functions always return false, regardless of the register number or
device. They are used in a single place within the hp03_regmap_config
and can be replaced directly.

The HP03 Series of calibrated sensor module datasheet (1) document
does not contain any information about the register values to define
states for the functions.

(1): https://www.sensorica.ru/pdf/HP03.pdf

Signed-off-by: Sebastian Aguilera Novoa <saguileran@ime.usp.br>
---
 drivers/iio/pressure/hp03.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index 6f7a16787143..a69f6f5ce248 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -57,16 +57,6 @@ static const struct iio_chan_spec hp03_channels[] = {
 	},
 };
 
-static bool hp03_is_writeable_reg(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
-static bool hp03_is_volatile_reg(struct device *dev, unsigned int reg)
-{
-	return false;
-}
-
 static const struct regmap_config hp03_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -74,8 +64,8 @@ static const struct regmap_config hp03_regmap_config = {
 	.max_register	= HP03_EEPROM_CD_OFFSET + 1,
 	.cache_type	= REGCACHE_RBTREE,
 
-	.writeable_reg	= hp03_is_writeable_reg,
-	.volatile_reg	= hp03_is_volatile_reg,
+	.writeable_reg	= false,
+	.volatile_reg	= false,
 };
 
 static int hp03_get_temp_pressure(struct hp03_priv *priv, const u8 reg)
-- 
2.43.0


