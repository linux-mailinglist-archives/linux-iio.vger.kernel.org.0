Return-Path: <linux-iio+bounces-18367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2773A9466C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A9817666D
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307611A304A;
	Sun, 20 Apr 2025 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNa8RiGS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616418A6CF;
	Sun, 20 Apr 2025 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113759; cv=none; b=j30Zd7QW252Mpb3hT4hi6G6JoJlNpRSbmC4b8oCnrsG3eV/dYY3h2IXVw7fjWZNIJ8K/lYltX5obuu0C81zu7QXTYcKQnKa6j6bx4lIwOykQtHdSYJOxjM8/mhZqt/k2k/TCO0HrO9FZEr7CXmyH7G7RVMJVmRNN3e2jUigswTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113759; c=relaxed/simple;
	bh=Ubbbw15hEAZ+J5L1Ub1FKSI3XNWrOXLdqS9DAd1ONgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTVEtMJTA+pFIW5Q27UOK1U2wBZGPWXjA4x35MhvTf7ek9FVSra2PKAvp513Y2cscJBriRsXIYXsPnImcTOIkA3dK6xbC2kPI1yCGOBB6QqSNI/F/q4tBJSmRVlM0Zok4JzNQkD8OiCAdJlUiDsxcXoSuFD8hZre+scSKiDiY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNa8RiGS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so27232986d6.3;
        Sat, 19 Apr 2025 18:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745113756; x=1745718556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXLzgwUjjblsXqDwVt3NWjFIy+rshNgbw5xBdqozz6Y=;
        b=TNa8RiGSFRbRVeAAaugxFk7kBrc0N08EmNoiHN7QXR+6cwJZr1h1iVHo591EwpSDib
         SLpjdaz0clqZgRRfSxveu9DPCqyuSERI/jdJo98doDPVwrgSTFOMxeY5g7QMZm2idAMb
         E886bpJWAMSOg5zGZ1atcw7eIK9AbCOe56n9Wtl+2eAmIisIqQKjbmZJ22bJ4uQdHQbb
         iBFAv9ziBNlKGiVzcX/EU9N3sgAnY4yEMQwQW8t6HwdGrs32BEWur0LfhdMzVDb4Pvol
         /0f2ijn4/dpsH+7lhu9Xev34idmKKtmPeqbKxj9fGQ0GvM0yFsh/XN6oAzj0AQkYmRz4
         YiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113756; x=1745718556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXLzgwUjjblsXqDwVt3NWjFIy+rshNgbw5xBdqozz6Y=;
        b=hOGsnkZC/yZu82eRkbxxzyK4CnrCFqSslCQyOozYp0B4NMEPPNunZ6P59IsGtxq24O
         FZ6qVNsE3wdhuIh2xe3VNJXiu+9rciytEkN1vgO55Ox/EkpyiukCVML4iUmqEDpPFUyj
         jpvxJV+Dt7izUAg+O/t8CmHJB1LkH77xdYxkbmzTvvmtw2rA6CWU1yh2l39kq65MpePk
         Z8P79hJTcI8u3SeokY4C6WJXXRomKbG/JWEuAHH/ED3lSHcR+uNytBNZP+RCC3Asfd2K
         TQFePXoZ57TESHZep2QtXjd9bZUAIsv4OH/YKeB9sJhD+eGMoCYZ9YNJJyb1ntnzzd3l
         Ln6w==
X-Forwarded-Encrypted: i=1; AJvYcCVv2mi9arTxE4vlImLhYF18HlURnw1YENFJW+3OOVhXORpOVW1uPAuI8Zh0Q1TVfHd2NwM+BVLZA0Mx0J4B@vger.kernel.org, AJvYcCXAAlvFaNlPuGN+TBj3MDwyGG5YXAYB4mhZnbwUKi3epXxJD2U2XFavTe9LDblh+n/UxJA/AJX2RoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjiVJAnAHhO47DB1V+ZMKoUku7jCpg0O67qf2Dbfd1ISqulJx
	Qaeq4/5C/QdxnLP1hAE3SCUYHOeGb/AsbZ1YA/sH9GWJZGIYqzmJ
X-Gm-Gg: ASbGncsNBqrZXTrFQLlWF3FnK8YqclUZCgBWihnr7gfW+iCVYqgdVIqZBYUUZYfzhWf
	c6vLI/o2hSLsklpXZYYDTgSVL8HQcBURLC/9EegjXy16AWgDX345oKXbvFtPgNVdKQbgT5uUtWL
	e9rGLHMSRD6dgrHuODQSteqMwVxqOUE5qLaIrOMl9dNgahO0MMwpKo7X0cjFngHJxeM6xHJKCIx
	LJFRui+C15Tq/XA5KfVlcMKFdiAsEjsjMCOEj01bgI/ws8t+V/WJqc+VneO1PJf8JVte1U7fy0F
	yNctubLR8YwfToHMgLkf0YjykraKypvFO5576IOnC81yTJqKhMHF7A9aNGOD02X+TLw6HHp+uVE
	+YUBWMxjI2jUdkLb/dAA=
X-Google-Smtp-Source: AGHT+IGEhBOvap/DzNCF2EzCoiO8omkKUAI0ZPVhKoS8sRTdzbQhZAp63l+GmWWg2+HI6/bVMrdXEw==
X-Received: by 2002:a05:6214:21e2:b0:6e8:98c0:e53d with SMTP id 6a1803df08f44-6f2c46a07dbmr109146956d6.45.1745113756223;
        Sat, 19 Apr 2025 18:49:16 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1283sm27583846d6.23.2025.04.19.18.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 18:49:15 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v5 5/5] staging: iio: adc: ad7816: Simplify channel validation using chip_info
Date: Sat, 19 Apr 2025 21:49:10 -0400
Message-ID: <20250420014910.849934-6-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420014910.849934-1-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the channel validation logic within ad7816_store_channel() to
leverage the max_channels field previously introduced in the
ad7816_chip_info structure.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index ab7520a8a3da9..7a59cfbcc6e33 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -204,17 +204,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
+	if (data > chip->chip_info->max_channels && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, indio_dev->name);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1 && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7818.\n", data);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0 && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7816.\n", data);
+			data, chip->chip_info->name);
 		return -EINVAL;
 	}
 
-- 
2.43.0


