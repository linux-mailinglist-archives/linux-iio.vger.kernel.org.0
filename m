Return-Path: <linux-iio+bounces-21263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D2AF65D5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0051170BF2
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF82E498F;
	Wed,  2 Jul 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvlasr2x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36028FAA5;
	Wed,  2 Jul 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497420; cv=none; b=EUkGWnfbHc6T7ufv4S44THEGIFNbB3n2Jgrg62AjXLsI2YMxn9siXLqmUC7JyC5wBO0I0QHHyMatezin++GsgEkPpJV/mzAvxBMB8Zb6L0NMyzxP+2xeSVMqba4CT6hVnuZi0zAgAkU+iJLJ7Kr9NWADglXw0rkJ60R63DJPwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497420; c=relaxed/simple;
	bh=FZ8nAIRZea4IRVMadLwfjOygtqx3FeLY5GukWqYb5Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGZbJSp2OmAht8uwQsduHjgtXcnIj0VfULPbSZ1j5AsOtM3QjuyYmuGD3x+9bfdX8eViMby7ajp+TTYXJiHfBPllmEZEHBzeMxVYkEx9lKH9xkOCoel5YV4Mytdn1Uygo7SxfF14QMOMxynb1iLkwdWcZ/16DnMKk5d1hGeTabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvlasr2x; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-608964359f9so1357712a12.1;
        Wed, 02 Jul 2025 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497417; x=1752102217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyPCkouOx+sPBLrp5JL6rT7I/AtUdrpj+SkokeIMDj0=;
        b=Bvlasr2xLoT2rtCFMSr+Ys4mcdRm+GrZDT6KwqWrjEPrJPcg5algAUvXtVbxzE66bl
         48SelZuYk5mf6nuOAUYEZOp2HaDj7+aHJrP1cILnZOxQlGSq22jXYrjpOCq9viQGat2e
         71rj4agpB/WJSb2MfkCVp1eaOVXLvJHCfk4cCyvOEd06HsmBzPXLgEBz1V3yF5OO9IKi
         SgiiJtkg/E1aF4skQGSkBgjOALMFT2UUbCOUxSedTGGG7rEiwj6FfTfzrm+b0pqkZSnB
         RkoIPwauvxQvp4Sr1YFgD3NVG4ouz96UA0p6uyzhbIfc9gfS3wMvXvetujjwbCGUtz+d
         GCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497417; x=1752102217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyPCkouOx+sPBLrp5JL6rT7I/AtUdrpj+SkokeIMDj0=;
        b=gXjEbEyvfXreqklW1d1PiofQXBY8Z9BeOw6zykaGD39ALXEOWPDGqA2WFQqie7b+XD
         g3FSkYlBSZ906giaS60sQDHZhVRKihuVt0SMv38K6F9o5cv7N0R429LRDeTAcrc4M4/g
         znu2XQkKN8RiFLdncr18gZUsy2C2pNqVvifTKeLo/NiEKEFpOoQlwVNKEO/Qy9NClXlI
         /hVPb81kZu0B25nWdTgAgpr9L1zrZ/uT2WjnHavZ5uyAwPdRY2vOy3Skf0SBEMX/b3mv
         D4dDt908clFf6yKZdAkFZUEGw0c/L3lnV71YoPON8Xq165GTVWPgMDoAaW09DOh0DNIC
         DiPg==
X-Forwarded-Encrypted: i=1; AJvYcCUG5HpoJOdotyyHIHumEjbTsk6cP+kqBX0IqchCq8vgmjAiICyMl2RtmEFobNZP2GzEBW3aLMRqj7F+Cnv0@vger.kernel.org, AJvYcCUP8IcUhBKuKtyqp1g5qmkBAKVIv1AGM3bQxVoNik3BbWz+P/IIo7znjm3vRo5ORfECSu3lPL0cB8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YztQQ1uylWhXy+cIDup5DbV2ME/uphh/N83LDwmqSJgM/848fCo
	ZDax5fjKBipNbAd6juCGTFRZSsNYeor6dyfK98/Cywu0iBMqNQsP4DbO
X-Gm-Gg: ASbGncvYlCi8+bg/Ifu+3rGI2+rKqFzJnbycdkKv/CHdj6drW3b6ffSHAV7Ri0kGULg
	x9+EcMa3DQ4fK7GUoZenPQBVY7kaDD6U7yezLVF9DWgm/WcfTU1maoM22h/MFtSgS2enJD+2xVI
	pE2mQXYaQD2RLdeMNyHfm7pno0Wrn0/VIk+IzYsR6oFuu8PWDYtCx9Ti2JW/oDSFC3vU66Y+lqS
	goQrFH8bh6Onr+DmVjPDpN9lZI5vdZ6cQAwqxvEMouLWtofwwV1Yw3P5lLCkyGF2HVgle/1Izf1
	xKgJCh2e2T0ulJL9L7lpejV54XFTsNJH5ccDg8jzadsyKckPXEW5tvfR6rrvn9TKovb8ghTwgHW
	YR7vKy/vHev3+ghNWZ0lyJ10pIWXzyi30
X-Google-Smtp-Source: AGHT+IGvn8GG5Kba40wjzQLQHEK7cnhfCnXzNg0OoH7aQYig77GIwzAxYjSou1YJ5+L/wylvXCGITg==
X-Received: by 2002:a05:6402:3591:b0:5f8:e24b:c8c1 with SMTP id 4fb4d7f45d1cf-60e7451c9a4mr96466a12.9.1751497417277;
        Wed, 02 Jul 2025 16:03:37 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319e706sm10031469a12.47.2025.07.02.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:03:36 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v11 2/8] iio: accel: adxl345: simplify reading the FIFO
Date: Wed,  2 Jul 2025 23:03:09 +0000
Message-Id: <20250702230315.19297-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230315.19297-1-l.rubusch@gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bulk FIFO reading can be streamlined by eliminating redundant variables and
simplifying the process of reading x-, y-, and z-axis measurement sets.

This is a refactoring change with no expected impact on functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6c437d7a59ed..b7dfd0007aa0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -885,15 +885,12 @@ static int adxl345_get_samples(struct adxl345_state *st)
  */
 static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
 {
-	size_t count;
 	int i, ret = 0;
 
-	/* count is the 3x the fifo_buf element size, hence 6B */
-	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
 	for (i = 0; i < samples; i++) {
-		/* read 3x 2 byte elements from base address into next fifo_buf position */
 		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
-				       st->fifo_buf + (i * count / 2), count);
+				       st->fifo_buf + (i * ADXL345_DIRS),
+				       sizeof(st->fifo_buf[0]) * ADXL345_DIRS);
 		if (ret)
 			return ret;
 
-- 
2.39.5


