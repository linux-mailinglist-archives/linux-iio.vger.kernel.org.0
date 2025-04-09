Return-Path: <linux-iio+bounces-17897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89823A831FE
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 22:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DB5448225
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0D21C16E;
	Wed,  9 Apr 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV11+kga"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDB21B9C3;
	Wed,  9 Apr 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744230601; cv=none; b=S1hVVCALkLO001bDUUkziz72FSe7PT36KSXk9IDsVOfUGYAHKTixObkn6Kv4vQ3PwSAJn0SfbyF1oS9CxMU8BME9rsedLq1Vo/HBxt1isunbPpiEzLO/+Ki8SOxWTQIbi1ES0gW/NwZBwbqftu3AJ1U2aCdEli0vckizMf3EM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744230601; c=relaxed/simple;
	bh=mM6GmBObjPqQnuCfgx4fhtNNxK7FGrp0trXSFwWq/bU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ht9+39cT9GdxcXwmiwSsjyF1A92/CyyHD2Zd9CYvaMCKUq3ggdIRh9onj+PS/+xhe6a8PPZrqzYW51LZGxXc4mZENJaf8RgGhe95hvT/NgmEtUasMK9xJZ8ZfJspdHDEurSt/tGjSrwZfGwRrBBkQFxsvjzScOk0QLfpjc7EmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV11+kga; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ae727e87c26so93991a12.0;
        Wed, 09 Apr 2025 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744230598; x=1744835398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzlIX+xzxyYLyLoGasAP9j4LEnzMkotTrielfXAc04o=;
        b=XV11+kgaceSHXedaoFILZlCj3Gx8NoZB+Omfte7gwq3RfQswA9QEJ0rhX9UfqztlHd
         J8LjsoroLQWvV+G2L0J8tPWhCo5V/TynsJuS4dgamBNx0EuYF1BRR05PeGY6wEsUaF0t
         B/yt4u5+NxiNPb9bnw9imNbzAuu+MFayjNWK7rC4ViNM3stoEBt96ObpazTIBbP7Rlww
         ItbYNCFsZ+LH5WJVswAjdCT/EhAvZpBj1AO7yURZOVUsmnnwtBtI6hPUCjUxgGerAPIy
         MInIq7NP7Qs8mHF7a3tuzFg6k6Bso+Oix6Dkpcx8NYNAf18BPJRtI0KhUPTDwc4V8WoQ
         SUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744230598; x=1744835398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzlIX+xzxyYLyLoGasAP9j4LEnzMkotTrielfXAc04o=;
        b=RjEZWgNAiquhE5lQHIIN8rE70WMJWfe42YdhycSz+vKZ28SrrkL5blfGw2DiWEDs+E
         4feOct2k6YqMjHqIFG5RnqcawzFM0z0IbMMh5etdYSRhuY+PFVNNybtDT1+Bn6bOxcGi
         Fs5kW0+TJ8VExgs6ed1Z/JuLyxpSvFPw29WrICYwzIuziPFNw31uwwH759r7G0LxStAQ
         ZIjMvpRU/Xw+Lo6Yc6hbbYojvYEuAWX2h5Hee3btVN2SyICibJSDltc4/Tcz+0oIp5Sm
         q4+nWGLRiV/deSy8CERdEdcdoJLz+Kaaq+y+HvAzX+Of/pMLhccWkC4h3rzueiZsEfSe
         9Qag==
X-Forwarded-Encrypted: i=1; AJvYcCXRve305CMSkapM1g5JiWjHNR6/Ds4f1uzbRp4XeX9dMak3zS0GgRNw3E7nZgPwWejSBH9K//Kr+iOMR+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf95PDXLtlk+eQvHejjAEGTPQZehpDV6/ammYfh/JuZJXBGeW0
	aOudXaRhNjQ47hFLF7yTaXqzrq+ULA7nPmt9mexZ/v/t3qCnYm4U
X-Gm-Gg: ASbGncvzgmN8ANsB91Pfvjxl3CyptXlWpNyXO1ULOCRtE7zPqY1w+liwmsDa9BZPGFH
	eoSgMHIPj9lgN3mA5F8kp3dp6WflHVTZ9j+aXYX7RzLQfX3m2wUaJOASWeDSnj5Lox7Dy67fXp1
	CycOiwn1ouUfvEhMuio2ob1wHleuPqjXgRuByS9iFtsS8K9ylMym5DnjQc0IGui9JeTUkh2F3O9
	B5547Ok0ijr0/M2Aa9ehw13x64m/UJl3p6jksyl/dpbp+bhoCs0NoIpmtVTwUSG74mPR2n87yAc
	L2pG9GkVKjnHduQdepKvAGhfBhHMN+nccI5JhJnqFltz0GixjMhw6kYMxnyPWbpc/Oq75bFjyQ=
	=
X-Google-Smtp-Source: AGHT+IHMXC1iKyAmZS4EWmnHPmfbsE96VrMUE1nHXIiST8LQxxxpK8DsksMjruABZ6IRME7gCGs5gg==
X-Received: by 2002:a05:6a21:4a4c:b0:1f3:36f7:c0d2 with SMTP id adf61e73a8af0-201695fb5a8mr740772637.41.1744230598044;
        Wed, 09 Apr 2025 13:29:58 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:204:a537:9312:7e1:b2cb:ef99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de8926sm1447388a12.30.2025.04.09.13.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 13:29:57 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: cosmin.tanislav@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] iio: addac: ad74115: Fix use of uninitialized variable rate
Date: Thu, 10 Apr 2025 01:59:45 +0530
Message-Id: <20250409202945.205088-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
drivers/iio/addac/ad74115.c:823 _ad74115_get_adc_code() error:
uninitialized symbol 'rate'.

The variable rate was declared but not given any value before being used
in a division. If the code reached that point without setting rate, it
would cause unpredictable behavior.

Declare and initialize 'rate' to zero inside the 'else' block where it is
used. This ensures 'rate' is always initialized before being passed to
DIV_ROUND_CLOSEST.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/iio/addac/ad74115.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index a7e480f2472d..26770c68e5fa 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -814,7 +814,7 @@ static int _ad74115_get_adc_code(struct ad74115_state *st,
 			return -ETIMEDOUT;
 	} else {
 		unsigned int regval, wait_time;
-		int rate;
+		int rate = 0;
 
 		ret = ad74115_get_adc_rate(st, channel, &rate);
 		if (ret < 0)
-- 
2.34.1


