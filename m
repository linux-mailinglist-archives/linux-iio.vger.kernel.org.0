Return-Path: <linux-iio+bounces-22914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBDB29DD4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F8B18A789A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10530E826;
	Mon, 18 Aug 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiWRfCJO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CFB30E0E7;
	Mon, 18 Aug 2025 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509277; cv=none; b=cqNDKxkHgU0rTIc7WN9CJl72XSJL7xHY/ooVWNehW1gvqQmZmITTDJBeenz0Gco3vvSzDl5my9JZmqRZe62qq+w3QnG1rPj/ml4dOf5iyX5OCSlq2C8TZtgD2rADF+pSOLzEXv8JcnyP59RD3P8lYXa9X6YRg26BreUkpGpXhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509277; c=relaxed/simple;
	bh=SsweBBtZUv2LS2FtC0yZUSERM6werVTswQY/gAL2IVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIQCw2MMat0pez5BLg4xkNnNiq/av5AC0iofGk5kSyw+3WYDS9Ye9VvtXAn9bkf9jZzvHQRx9YSnPMmK4FgsG5cmPxfLYwAnaUfohJTew+mrtf7LM1hSY6+OKQNxTiqzOco7lIgueBr3FfYGV1dCu/8wXlztnTW7p3ZuAdUcbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiWRfCJO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e414ef53so4143118f8f.2;
        Mon, 18 Aug 2025 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509273; x=1756114073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/01Zc2rYpbbM04bYxrElHCRG4JbigDNTQ6sNzeWqB9s=;
        b=AiWRfCJO49yRf0bILIy9lblOpEej3MRHR2ScGDousn7t8BciLRnYJwyjarAx3s1CNV
         BUo1bZfCHJO5Rw51mef3z2ZL/xyBqAs8UB1Dl+afP3VSMVYJqyulmssy1aq9Fm+F9dBk
         x1L89rZ2VhBif2bBubeEBG+Gq1vr2VgRK1dlugiDLWpnoGTd/44+O2ynljgP3MhQJyk9
         dwaKoj6sdmwWUYzKu8dOCVn9a+uePPTEer6rP/Anl6EQlD+O+fr3bi6cPIR4VHMlbCOo
         ITNIo4uCo5HsyiGjOhLc6YaH8+E8nMD9LWGvthM3f08lfifobgIZVKXht44xkks1c8Jf
         TbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509273; x=1756114073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/01Zc2rYpbbM04bYxrElHCRG4JbigDNTQ6sNzeWqB9s=;
        b=MPkPS29WsNz/gEulnQcDCs3s4AluidjkFyGHECLfoyMI4RmwWjcN19MVAhj8p436Bi
         RMIfXvzZuXgz1hmUhoXFF93sv79uwsBGxJDZvenJqCKLYjwoJHYf6evKP57DNUP2UeNa
         uyjzyWEkcc9nF9t1y6CPSAnbSz4CkzGe78ivaw0Rl3V2XSFsT76Ng5DLb2lPQr/v7PKu
         7JfaTsA9GdGnYv68eUTz5VMnkHXwihjbTBVfScFlJdRg3O+ZME5jZ8b/k6CwXAXXBlvM
         fGAgAM5vNeEcNCSSkSnCny0WZr1ELm+H17Nz4OD248II2TA6u3xZHZxzgaCmY3Rg4MWl
         jXYA==
X-Forwarded-Encrypted: i=1; AJvYcCVWEVD1Z4hWrzYYxeAOdhsIJIMH4UojjrNka9p0kfW1Cemo3x9ep7fauap5C9Gy8F12mZNwp0jpUX5QNdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJzgUypUtBmG62dAifle6iO5xvnECIuzLnIeIywR8FtxhIUO1
	IZl+GFKO3i3HwVj4fTE+EcVycME3Tan35QThhMfc+tPlIzUvsNJNfBEHBdcx4g==
X-Gm-Gg: ASbGncu2hWDIaQVg3XNYCeU6j6FJVEkevksu4UqLFpPl1bZY4fi04+tsTTmXzC068Sa
	TJgSrehmJ+9eTXfTTkyFnp/m1xDP0jUB3ZfELyhls95pKCF7QiAQAih9rlF5guOL5DDFx2vkznt
	IVaYumCizwV7/h3+lSGiycTlQD2XnZROXsc8B3isyoVf3IkloWHjfAe+xk4yiWiXdFRH832y2pB
	DxAr1Fllc2EGgWz6y1L7Lw++fSDDEHQa+NCbdVsCia9R1znqaC3thszZjU/vl8VqDgAUUR22Na1
	sO7Mm0kFcoSBq7g8BZM/MjV73R8MNMiaPEuU3SjzO7pbwKBcV3CKlP5jP8cmWKDE32PyWcsUH2F
	td1YtwF8xCrCjkB992j756n2puDbBqgL/AD0y2qdvb3gciQ==
X-Google-Smtp-Source: AGHT+IGK0S/nBcnzOnqRgbHqbh3NPTEdejp5Cp0EWkpGz87FhnsujE1+oFWE7f/lrhB8OkQmUWnvMQ==
X-Received: by 2002:a5d:5d11:0:b0:3b7:810f:6caf with SMTP id ffacd0b85a97d-3bb68a1874amr9425206f8f.32.1755509273492;
        Mon, 18 Aug 2025 02:27:53 -0700 (PDT)
Received: from localhost.localdomain ([165.51.41.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be10esm173793365e9.3.2025.08.18.02.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:27:53 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Markus.Elfring@web.de,
	salah.triki@gmail.com
Subject: [PATCH v4 2/3] iio: pressure: bmp280: Remove noisy dev_info()
Date: Mon, 18 Aug 2025 10:27:31 +0100
Message-ID: <20250818092740.545379-3-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818092740.545379-1-salah.triki@gmail.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `dev_info()` call as it was considered noisy and is not
necessary for normal driver operation.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6cdc8ed53520..1f0852fc3414 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3217,7 +3217,6 @@ int bmp280_common_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
 
 	/* Deassert the signal */
-	dev_info(dev, "release reset\n");
 	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
-- 
2.43.0


