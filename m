Return-Path: <linux-iio+bounces-5947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7218FF6AD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A87B25F10
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210119924B;
	Thu,  6 Jun 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ino8Fiag"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E49199392;
	Thu,  6 Jun 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709039; cv=none; b=bdOCavXgXgK2ec93RZOoIAXX1Lipzf1rdVW6h53qDxidQWvqEu9H9HynMzCg6l4FeJcjSpUgjUowstpb1tGp0M/PHUv3blhRSpYlGb/QSKr5ILCwxuWtHqH0lodgcXXjduN26Phf0kpZlmNZ1Sh4YHd6vjIbcX8zdJmAwhsIkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709039; c=relaxed/simple;
	bh=Dljol5I7T/go7JkK7rwB5Fp4x25iV/GPuVNSd59Dbgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NuNeBTYEh4IInYEeQLAmw6vPip1Eo7MX9bTO/I2cPesiriUij0XQGhXL6x0Mdb+nogZnQCNWDpsTe52eGm9TgfrjL9Ixb2SF+xlV3TdqmPyz5mkq4ZgHs9n+m39L7/tSBpYhDI1duHh6+KmgxquIWHZ2f6ZNTXuiz697UOHacpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ino8Fiag; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b82d57963so1760900e87.2;
        Thu, 06 Jun 2024 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709036; x=1718313836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dGq+BBpr+rlxUS0WQliGQuIKZph55HlIZAdnOOG0UE=;
        b=ino8FiagLcy46SegtcPY8nb6y2jNEF6UVMleXC9q4cDfvIZWfgzRKXkn+BM5eTDcjQ
         mu8eoNrG3o/+N17225L1JT18MFxHD2enpyo21qoIuPOiLHlO+PJuRhcDIL+qNkoQSM45
         PCH9F5knMxtYrd5dlBQhlEGJwUubvA3H5rl54o6bTdM242Ybf/TKEOFEYCBlsQysZbJy
         6Z5iVCB8ARe6ryrONFAtvcBc25PmMirCn9cKR9ABAVbOctMpMJaL5EfzGT7aiRtSepC+
         vRe+JxatG2B0GyMcUPN0zOb79nWOg4Nr6SpvBc0uOo97FIvcuU1BJC/Px463kDSbrzIp
         8kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709036; x=1718313836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dGq+BBpr+rlxUS0WQliGQuIKZph55HlIZAdnOOG0UE=;
        b=FgxiCYk3D1FfNdoRKo9FvTGshY7aSLoC2B5T0QgXftfRfBbofHqi+STgwu2CaPS8Ui
         T8LZXx9IXYUTnztFjFw73lNhEnQCB7lOLxkcXxIKn6BJHUTMF4vlF+TOO8iKJB+eaBXg
         hVlLgcUjVPG6JUDyPTpGfcDg0dACO7/tVkbMOzJ3Q+BmgNoZcsH0//yS+CY70N9vboEM
         8YOyQNPfCrwC7Xw1y33olQJ9CbKfiYom9UuOHm6vGKET1pvAx/xKC5JrpFQh4pDmBEEc
         mTtDOpiAO2L6sWIHeop/iadXFbPwBcTK2RM2Sc6aY3Rguqr4MYksXbjNzS+/xNhkiWOV
         3LEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxemhawRGkbYQXrVAnvUCsIp4dMPeLaEhTveb4zSICa2VJoOIM/fxGs/UAAcVd+9/3cN7PO+FHNLckFYRYOZo3/P1J+HnsAW++uC5+MV0zz6ynXDVVR5Fdcp3fhsRL2+egbpjSmOm7
X-Gm-Message-State: AOJu0YzU057oeUAXE32vlyJ/6enCx2TZ4B0Uap6sb2x7vNVrJ8T717cL
	dXTNMln/VYYq8pzw/qHcwOaSWYFwY3gypeD+CL1fiJxKyA9kUzYT
X-Google-Smtp-Source: AGHT+IG2fR0i4Jjx3Hr0jiynNCushCg+9/YAUwMZQZl79/hqqcORmHCLbs9zUVPfHfqZ745ECsDDoA==
X-Received: by 2002:a05:6512:238f:b0:52b:84bd:344f with SMTP id 2adb3069b0e04-52bb9fc5ae4mr552041e87.53.1717709035417;
        Thu, 06 Jun 2024 14:23:55 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:23:54 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 02/19] iio: chemical: bme680: Fix calibration data variable
Date: Thu,  6 Jun 2024 23:22:54 +0200
Message-Id: <20240606212313.207550-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the BME68x Sensor API [1], the h6 calibration
data variable should be an unsigned integer of size 8.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L789
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2c40c13fe97a..812829841733 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -38,7 +38,7 @@ struct bme680_calib {
 	s8  par_h3;
 	s8  par_h4;
 	s8  par_h5;
-	s8  par_h6;
+	u8  par_h6;
 	s8  par_h7;
 	s8  par_gh1;
 	s16 par_gh2;
-- 
2.25.1


