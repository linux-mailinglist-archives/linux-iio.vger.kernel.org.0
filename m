Return-Path: <linux-iio+bounces-10895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE39A9A9043
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3FB1C22A4C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6B1FAC4A;
	Mon, 21 Oct 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGOeF8yy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E01EB9E3;
	Mon, 21 Oct 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540410; cv=none; b=mZRLiy5iXkZsl0WTqCdk+gXRWU10MCwiesBh45Jys3uwry5JHi2WM7V32t3yCCVm1lsU0jhgsTiKIxuWvjzfv96F1wKA5RZybI/TJi9gUrGSpq1Ut5YSg6Nb4+YgoTGHRvPcPg4j+Q/9U3pnOFGuEYsqXblgXe5BjEXlggZy8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540410; c=relaxed/simple;
	bh=pacgdWs+yQkE73J1SRknkc07WNnGfj7yD2J0MaFNg08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiiB0DzKmXATkjyent5wpeuLVpkqN/L8dArp4fORIc4NucW4dHfTHGcctLELV7hDF0N9LKAGGKYzBr5JyTSe/hIgjKG/lExqqKPN+e4ziijy1CNopAdHtSmBruGV3g626h6NkbDinzs2LKe9qk3opYE8xaf7in8wYQUtAfWIWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGOeF8yy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso1368923a12.1;
        Mon, 21 Oct 2024 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540406; x=1730145206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QJFX4ZiUvU/gkiEPA3cTN5cC96Exsyal6fVxhijVGg=;
        b=BGOeF8yy8aRlubFFCR+f7ollVhufN5s3sRTu4WmZLdCNA+OOkxAPRWJ2XdiaiiCg5n
         ypL5onfWnpQnRcdD8w0nwiL+BoRYn+flIAsyvk5j7wEZZmntRhi5Wtjohsuian+jcsri
         8oP8AZArBIEZhSRcfW//gs8HHQz5+6/oqg/hLdjI3idLFdJgidefRNeoU5hImLcIjH7k
         m5OOCv6T7jvNX6oXmX9LxaiTbmXfi+EoHZ4os7rlEsi2w8TUHx1iikuRoD+E5o6cGPvm
         wTPEgaxqekRpM1z7qlpkSoWspDUVtJghT8ryviSrl+XrOEzJK0Rud68Z3rDzIK4EkCW4
         wh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540406; x=1730145206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QJFX4ZiUvU/gkiEPA3cTN5cC96Exsyal6fVxhijVGg=;
        b=bzi6PcRXTbEkrc0wnXLhzuMmkwZe3ln5+iKQlag0XNn0YsuEry9rst92+A663baPRf
         soda9C8oRqPe0dguFoBLd3RT3DAY9SYDQsQSFNkzrtn9yRmFvhCcSqttn/FP3bd2gi8I
         X4D5efGIEljt/cjaBw0zdxU/+goM3TG0hgfmYqKHacJHyVRZZp3AYqlRfeztd9hKWHSC
         C4he7VhbvD7zqtHDznAa0AnY55bXJ1zvPbWNEGA0EWQfh6opmZf2HMin05nxHUOaxuKp
         T9kABoGY0m1hsZsRktC3/V/vNjn2RpNsTOKbn++r1+77mCRniVX4anWgI6b6I5QsrIJo
         m6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVOoqMyI1lcaPUqKR4mDQEM3Fq/cpwvxWOYG0UW4GaHfzFW1CPB4ApLTusn1ag3NycQK5iKJdO86GSpK3dS@vger.kernel.org, AJvYcCVUlNNCgWJoIO/cvgBrMRqCrFA2PfKaD0nQMvRPNx/AZAHX73ips9FSsTgdM+xpuT3Rz65V5Cbca23q@vger.kernel.org, AJvYcCXrawjmF+LqCTWgpqVBfJhXBZDZZmG7ndLmXvO8MkKfs6A9+L6NmIiO+O4TVXjqFATEc1KxguBAR8hd@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbWvy4LtMnc4T3e3WG63mFBfXFzTOdcLaeuM2i+omySlsO991
	A2pdZ+nR9aGvArtw64qrGQd+p2a4xRZUxeoWSECA7uVWDlfMgFrE
X-Google-Smtp-Source: AGHT+IFwyqbRuZ9aFFw17AD30AfocCUP7M2gHGfhoZMs/40pJWnaeeIEOI7KURZ7lhwkqAT4SVm19A==
X-Received: by 2002:a05:6402:350d:b0:5c9:48df:713c with SMTP id 4fb4d7f45d1cf-5ca0ac439c4mr14103571a12.2.1729540406326;
        Mon, 21 Oct 2024 12:53:26 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] iio: chemical: bme680: avoid using camel case
Date: Mon, 21 Oct 2024 21:53:06 +0200
Message-ID: <20241021195316.58911-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename camel case variable, as checkpatch.pl complains.

While at it, fix also the indentation of the array for readability.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 0b96534c6867..d228f90b4dc6 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -438,15 +438,15 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
 	u32 calc_gas_res;
 
 	/* Look up table for the possible gas range values */
-	static const u32 lookupTable[16] = {2147483647u, 2147483647u,
-				2147483647u, 2147483647u, 2147483647u,
-				2126008810u, 2147483647u, 2130303777u,
-				2147483647u, 2147483647u, 2143188679u,
-				2136746228u, 2147483647u, 2126008810u,
-				2147483647u, 2147483647u};
+	static const u32 lookup_table[16] = {
+		2147483647u, 2147483647u, 2147483647u, 2147483647u,
+		2147483647u, 2126008810u, 2147483647u, 2130303777u,
+		2147483647u, 2147483647u, 2143188679u, 2136746228u,
+		2147483647u, 2126008810u, 2147483647u, 2147483647u
+	};
 
 	var1 = ((1340 + (5 * (s64) calib->range_sw_err)) *
-			((s64) lookupTable[gas_range])) >> 16;
+			((s64)lookup_table[gas_range])) >> 16;
 	var2 = ((gas_res_adc << 15) - 16777216) + var1;
 	var3 = ((125000 << (15 - gas_range)) * var1) >> 9;
 	var3 += (var2 >> 1);
-- 
2.43.0


