Return-Path: <linux-iio+bounces-18190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBAFA91EF9
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 15:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EF38A213F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738E250C05;
	Thu, 17 Apr 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmVzUG5F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2648250F8;
	Thu, 17 Apr 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898229; cv=none; b=e7UuxQ2FDHa6pksTQtADwHG6S+KJtGAxkqcKo0ekt1ppfr7MbiharPjfqBhSKsRwTVL4HQm+tGGZ478ffi+inXN75m/28wV2HGGIHRblHhFhF5NM4KrxRIRrZiqPGj1ZwtCDvd/NIY/1Ea+TK5Cpi4DExxoYV1XAbvG1tONYte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898229; c=relaxed/simple;
	bh=G7cQA1vbU7ME82rND+ta8qnI8kBAvliO793si5bKvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMyZieCCK0nyuwiWdRIAqb7DDelmN8elvYaY1VyXqafVucVTYY332/UoYpyVDLg7cZ17Lbjpzkj4PO1h1sCOMhdXUkOYYlMdDva1IH25fdWYIRVc+Z74odyRY6EJVQgilGB+T0nOwBHxMzF8YdFAUPUCzkUf6OOT65RBLbP9FP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmVzUG5F; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476b89782c3so8630331cf.1;
        Thu, 17 Apr 2025 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744898227; x=1745503027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwMHB2nUwzNcRVsw3OgexWqiEt8JRdlA5caQ8STPGxo=;
        b=lmVzUG5FLO6vR+FXkBzI9j7O9C4z6avPpDQGsVryYp11dSpfcQNMIeKOgn+caYlaG/
         IDF0+Nzvnm3usWeWhd0ET872DB+qrjtHv/fjcuUe7zjbPikrHXl04N7tundIDt40Aoja
         KJ4Bg9uM0iD5zXInJuDoO6WC67PKQTI7JzSkYUN4joSF8x48aRR3VWc5VCeJcSOEBWmp
         BBj9fNO7zqLKs6n7/+UqzGUN1sJxePsWlMF/WM45hD4ZZyxDDJfQjNkW5zJR9ToQ7pWC
         VNC/EvgKzQrFK5fSJTv5BVGcl4bYrTcQassxKTplGCbT2DR15+lQRQES3MkqPZweea8Q
         /hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744898227; x=1745503027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwMHB2nUwzNcRVsw3OgexWqiEt8JRdlA5caQ8STPGxo=;
        b=tGNRJJ328nQoalJxZegMyY8i6vWTWP1BlFeKBpnJKzsi3Zq0DooSdL0yGWWmEHFzwr
         Hq4j0zNPxOzxpyT42NUDtXEsJ6/eppa19di0/xEYey82JOT3pxDON53aP01RStJ0wa6W
         GOd1QuPW6r2B0nSIkLhOvSUTjYICZ+lTi0MIN1pHbgokv9GyCXVZYgkkUKqXpLl/h+ef
         wjOQ4MfKByuwy6b4bnSiid1ohgIWRoGTNkgFTXte9MlZGejFcAG5VBlvrp6U4P75DxTZ
         HedHCaIxi080a0MKbGFZZJ7hjfGVumFFcfHHwvtX+bFI1IvDcG/A9p/wU+JmsOFbv3z3
         XmHA==
X-Forwarded-Encrypted: i=1; AJvYcCU4AUBdOt8dvzZ7SC0OuF5SgT8vfI+ZW5yC/+p+7RwKcXeYQlqz3CnE0UNX/uX01LvMrP52Y6ym900=@vger.kernel.org, AJvYcCXZFoP37xNM8XeT1UrxeErWTT/V6zgOhQ9gBWth7hB6v7+f3GZ5OcWNhX0EzRfDnl/ESdTrH8ByLAVKAO18@vger.kernel.org, AJvYcCXbsaETCLxFLy7QZ3NOxkht0ETLqaW+AVb/9Ayj+HgVYBe+ERFpak4D43Son1qBu9Yhj3ITbJJM@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfThJ8mi7p5al0FE5CUcvwTGO9tKCkbMO7uIsj/Hy8xcEJFUn
	dZgnSy3T/L2XffCTn126hkyKuZPRc4t/Bh5DFkwekEqs9vo1qBax
X-Gm-Gg: ASbGncujF3BK4mKqVju73MnWPpbWzHnWPZSFDDsy2nRKpHrWinGULkePnt5Q1Z3h0sh
	GOHeXoHyhvjwhVekRBco7F5fpI6KFRnMIESm7yITXgguuPa/yELtiIeMAO+xVbc7LZitwK/yR2H
	cpwLwP5NRu69oGZ3TB28+fuOaJI3vWeI462++aMykcQ97cHBErY9VBnGoPZN0ZcjD9UgN8fqrRQ
	PI3zlhRXoZaEz7irrTdoq3RzZ6Yu6siSZMxhPRyLvvaVQUPuxzHIr7c39nIcB9YBW0mWQ9/0LLd
	fic7ugztTS/fEFaOUa2Ddau26HUgIxUYo3EWviGAmqJZD9qwlWzMqrk=
X-Google-Smtp-Source: AGHT+IFpHKVkjhlZ2LiXbe/zb9N60JY4GEaQaJZQLQFFebUwv++hYDlp9uFWUHivYUzVd+h22h7CHQ==
X-Received: by 2002:a05:622a:134f:b0:471:cdae:ac44 with SMTP id d75a77b69052e-47ad816958emr97415331cf.47.1744898226511;
        Thu, 17 Apr 2025 06:57:06 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2b8dbsm123152491cf.41.2025.04.17.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:57:06 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] iio: frequency: Use SLEEP bit instead of RESET to disable output
Date: Thu, 17 Apr 2025 09:54:34 -0400
Message-ID: <20250417135434.568007-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the AD9832 datasheet (Table 10, D12 description), setting
the RESET bit forces the phase accumulator to zero, which corresponds to
a full-scale DC output, rather than disabling the output signal.

The correct way to disable the output and enter a low-power state is to
set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
the internal DAC current sources and disables internal clocks.

Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index db42810c7664b..0872ff4ec4896 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -232,7 +232,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
 					AD9832_CLR);
 		else
-			st->ctrl_src |= AD9832_RESET;
+			st->ctrl_src |= AD9832_SLEEP;
 
 		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
 					st->ctrl_src);
-- 
2.43.0

