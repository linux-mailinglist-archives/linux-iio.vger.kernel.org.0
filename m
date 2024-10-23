Return-Path: <linux-iio+bounces-10987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0369ACB68
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97B01C21732
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69071B4F23;
	Wed, 23 Oct 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bi1jmQbS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BC12B71
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690790; cv=none; b=CKb8tK06EYo4fF+Rnjj/D9UoNqdDmtHTb7wrfVLS3dRe5ehHYzSB5fU5Js2uhvnQHHpRUYr0RnW/XKd7y2Zefkwsh5KnQJzaEl/OSazE4/F/M+Db0xc6vY6LAnWXoEnFhU+w/QmLLEeANRfkNyiGWCJu0P7bN6nhPEOqcWNw8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690790; c=relaxed/simple;
	bh=utKFdkdjq0xMRyp+lW25/4LBehAW3zy6wl4Q0VbobbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZGBSpmzpWZf2E/vscjZlcO9RSLZeX2n5VspzHqRhgzy6BSzFjLlRJKsagMd5mrtrrb5/tMpB8oZ6VL0nO1KRkQpQtzvlY+25ijcZKFAxQDwcWU6oM5+TXKAsQvqoq6hhArfv6GfbJ3IZkPWCE00l6UvJ5vXiYxFbawotnqscdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bi1jmQbS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso40825395e9.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729690786; x=1730295586; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUlJoqDYE70A1gpRbWu72Eu6LvCFd2GVUQe1MqOiVh4=;
        b=Bi1jmQbSl5+PJZ4eCKiV87PNu5xGFJWRuk5qiJOe7PazwttXnmT7KWAyNIEcp07ZQa
         F5mzbf7w7GDAZHbQoBdxQhrpP2ajrLPJkHDw4dtIL8D9/CSxMaT/c/7MxkA7itkUxzXU
         Na7XArHh6XLpDCo/JcYxy4lyH9xB7Swlo8t0dAw6al/2Cb4Rpre/t9O0BqjbWeCQuJ9p
         Y9saUOLeolwfLW7moCCoipNG6hw2bd/5sxHHX48fyOAcngyqWsCMqXI5zOHgUhc2q1k7
         OTzDErlXf6YG8Ty/LdXS5/01FKL3wkVDFa5auBGoGbSmbatHdiyKcX7eej+nqSc20u4n
         vXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690786; x=1730295586;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUlJoqDYE70A1gpRbWu72Eu6LvCFd2GVUQe1MqOiVh4=;
        b=Mk/qfL5kpbDAHbZH17bFBqzslfFH2q3SHd0sa6+Df5FOHlNyTrJ2KRaSvoLBpd60Vx
         sSXw31D0FlguSSGn3qibOIxQmmQnm3WPOL9PkkjC4Y/DceD3Xwl0o69kyVhoG4ea7ppr
         M3hQv6izBTTql0pcXF8Pc7DhAOjYXNJchMycYji777nf7fa8CYvzYYnG7eDTsZzMDJOU
         7fk8Mc+N/VKB1IXLEJv0SArRMGegYckNIChNB21oxMlqsiIkhboM2Q7w5Pig4lreo2H6
         wQPa14LRj6M0SBvvIuVNoOUQc2yfElkIQGT2rUSa3p0DCtaqSR5aWfQ34+/E68dOtAD9
         HCEg==
X-Gm-Message-State: AOJu0YyZbssWJVjzHVQBtvh0FMaxCFl6jEtWHLiD74Xkdr06Y//gkTfJ
	8vp3FaYuaWdpzp5orge/nZ9EWIm6duE0VT3hnZuFRFS1bTIHhvkBC8oDC3TbEvdOVDY4+9xb5O2
	D+nU=
X-Google-Smtp-Source: AGHT+IExswePHkNE0dR4iXJ9chlIEUNAaME1pWtSUYeDKO2T2oUNoJmlM9/XGeRksrNxlUpMxXvZzw==
X-Received: by 2002:a05:600c:1d27:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-43184189bf9mr22925705e9.26.1729690785563;
        Wed, 23 Oct 2024 06:39:45 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4ae36sm8949860f8f.43.2024.10.23.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:39:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 23 Oct 2024 15:39:40 +0200
Subject: [PATCH] iio: gyro: bmg160_core: remove trailing tab
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-gyro-bmg160_core-remove-trailing-tab-v1-1-9343c7dc4110@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJv8GGcC/x3NQQrCMBBG4auUWTuQxCLEq4hI0vzGAZvIpJRK6
 d0NLr/Nezs1qKDRddhJsUqTWjrsaaDpFUoGS+omZ9xojTuzSOX81cpxzvZiHlNVsGKuK3jRIG8
 pmZcQ2XpvxgTE5EE991E8Zfuvbvfj+AFbEbIXegAAAA==
X-Change-ID: 20241023-iio-gyro-bmg160_core-remove-trailing-tab-19904deebd9e
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Remove trailing tab

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/gyro/bmg160_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 10728d5ccae398d15c1d51e0380306042675d5c0..9ae03631090a4ac68ffab92726ee8b8e9c1bb401 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -444,7 +444,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
 
 static int bmg160_get_bw(struct bmg160_data *data, int *val)
 {
-	struct device *dev = regmap_get_device(data->regmap);	
+	struct device *dev = regmap_get_device(data->regmap);
 	int i;
 	unsigned int bw_bits;
 	int ret;

---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20241023-iio-gyro-bmg160_core-remove-trailing-tab-19904deebd9e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


