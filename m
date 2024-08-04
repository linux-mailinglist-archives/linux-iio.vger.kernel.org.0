Return-Path: <linux-iio+bounces-8231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46D946F10
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D49B21161
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B03F9F9;
	Sun,  4 Aug 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnqIhbZK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1041CAB1;
	Sun,  4 Aug 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722778970; cv=none; b=e9EgR6VJQfs4ERQOJqnkIBpLYg/nciLkao5RXtuLIP8YaMCxBF3EeemkIji0+FwvctHCH0E3GzR0FQCOKT84hEOGmt57Ag2emWncgY9EPNfsIN5MLouOFsGKwGw93lwfKJHxuDLr6G53rgdhtTsTjgUqt80x4TVqbVkTXvrZuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722778970; c=relaxed/simple;
	bh=hlxlR9HR1E5VluvsIJoolsStH46FurIbmVRxA0+GAGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPMZkRTXa+2wm2ICJypt3LUqdaLc/h55XfaOmMtpnCE6aIjPNT2gSmM/RaUpKl34/0MX0pz3Veihd3/KHzq+8PdX72wDfPA8bhVXCVN3l0/b0HgP4SZZjvdVIE/pKPg/TrcxiB1AJ0eM4F6k5o3c6oRx7dUR1tsALWpM44e3fBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnqIhbZK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fec34f94abso75582905ad.2;
        Sun, 04 Aug 2024 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722778968; x=1723383768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfin/4dp61zzDxl5crYl/BVEUBuZzTW2qrUfeZLSyeU=;
        b=CnqIhbZKqwDs0O+G25716dZrHBXw+EZ29GQnijeRwy4U39xZd6uJe0peJWUGdqoQ7A
         s+ykYUiAmZoYbF2A/iAkpbnfRI8Cz67JctX5YNUOHT2sSAM/jSZBwhCp9ivOBw2IaQKE
         tkJ7kgYfwhuaHEa9C4NOfqVIKnBu8qo8lLWEvBSORA4Y/VrXWH7ESLvXeqJ1GOBCxZP6
         6ahv9aPYztA4b00Qs3kKRzHaqMVrFFtGca1+QLuYXfTILTaZsW4NLqyOu9RLOBIYXxnS
         qQyfgPXaAn1idvPHpCA60uKO2i8oDdvjzeTWfUEaj5VwnX3t+6NtWwMAVln5Cdg3LYhK
         NLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722778968; x=1723383768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfin/4dp61zzDxl5crYl/BVEUBuZzTW2qrUfeZLSyeU=;
        b=ONQzQuV/O68y3A03RGtKufMk+3VJlFXXPecuq9C+lYc+uIHpCGh4L4FZyniOBH3oPf
         ZU840LvGYWUz7U7t1meeHKNCdbp5elaRFQPOqv0WZAiXnH/cL9VvMR86ya95KWFsslOm
         T7sLNbxKJrBSTPFFYxfZtW9lH2yyUxPcnkOsGeJRRlpzsH8hG8O8Zbl5df8GyRfN9DpX
         4Hrb320vwQJN+2N9qpsiRzibmr5HDkW+If47rfVBAG0VwhyijBMl1IKJNACxwz+vqzJS
         2SEwGBXoAigbV795FSn62FyvCrbB8jygCtkqioOqfw0sEUx052LsGd4EtI9Uyiibr6e6
         8D9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnD1K/861jS5GQ/cdMXblrgGt+z5Qndk1g0ExdX25JL00vQIle0k97dVhARdyvbxPyI8NRbqYeruJOyGIRK8dKvWQc4ZRo2Kbn77dT
X-Gm-Message-State: AOJu0Yz+VA61Z6eiwMXZ3L6EGTzkMpArcAXn03F/F7+9OekNk/rYoRZC
	kS1MiqIkcLqcnylbb6tnl221ZW14NOHe/To3s5XDluIS/koEiKVA65P/S5n5wf9uzQ==
X-Google-Smtp-Source: AGHT+IHyX5AJGDbiF7wu4XwvuXO2HoPbNXNzR1zQHAuicQwX3KdHaAAR4yOv9w1C5ovNAdEnA5P0fA==
X-Received: by 2002:a17:902:c408:b0:1fd:9420:104f with SMTP id d9443c01a7336-1ff5744bd43mr97346485ad.53.1722778968039;
        Sun, 04 Aug 2024 06:42:48 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff58f29d7dsm49521275ad.46.2024.08.04.06.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 06:42:47 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 0/1] Offset correction for apds9960
Date: Sun,  4 Aug 2024 19:12:11 +0530
Message-ID: <20240804134212.51682-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patch adds support for doing internal offset correction for the
proximity and gesture circuits. The correction value is written to
the respective POFFSET_x or GOFFSET_x register depending on which
direction we want to perform this calibration.
For the proximity channel we apply the offset to both the DL and UR
directions. And for the gesture channel we apply the offset to the
respective U, D, L, R direction.

Changes in v3:
- Some code refactoring based on comments in v2
- Link to v2 : https://lore.kernel.org/linux-iio/20240803145836.4e372899@jic23-huawei/T/#u

Changes in v2:
- Used IIO_CHAN_INFO_CALIBBIAS instead of exposing custom sysfs attributes
- Used enum to choose between correct the offset registers
- Corrected the formatting and style errors
- Link to v1 : https://lore.kernel.org/linux-iio/20240707171357.709d9e35@jic23-huawei/


Abhash Jha (1):
  iio: light: apds9960: Add proximity and gesture offset calibration

 drivers/iio/light/apds9960.c | 55 +++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

-- 
2.43.0


