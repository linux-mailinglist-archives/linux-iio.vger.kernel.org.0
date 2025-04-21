Return-Path: <linux-iio+bounces-18423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0806A950E5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F10E188F17C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E40264A95;
	Mon, 21 Apr 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh6tgXAU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3B264A7C;
	Mon, 21 Apr 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238508; cv=none; b=BoexyAdhLe/GqKuyw47f2R4T+JyoiW+QVn9m2jzh8XgS5Ms81jyM64U97DSLwqVPpGMKbsCifm+ge5ZZeEkkJP54F5OL0JXwwybUOnN0PQ7Fg5W4K4hdUuPvwrnCqX6G8zLaUIVmGBk5nOMGoEF91CHyjojwcE7+6JP1isLEBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238508; c=relaxed/simple;
	bh=e+WN91nPHLRESKaOGAavp3iu6QDsieZbWsN29aZj1Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmYdwiwTSE9Kpe+gWrHj5hkdn61BmcmmsynMqcaFAVq0kTTWEbM7toPiGlICXrQ6FyPitXj10xBNwFKho9ZG5F3mpRDN68yEzHXbGxVajtZeV1WrtCfkoqhMwa7Z4AWf4i4gH2sg48xF2Q6JUYXTfbjugmVT2rRh8b0AmAUTw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh6tgXAU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5e1b40f68so397130785a.1;
        Mon, 21 Apr 2025 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745238506; x=1745843306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2wIp4O5aFba/VFIEdYS6vzun+UYuyoA/BMDFjUKnEU=;
        b=fh6tgXAUXMMl6ZjJsO9OFiNT104QZv7H9WE+bJwpFmdQNcYUbnAF/L4YqcLdqHJUMV
         zuVZzppcjd7af8w4pjJ621gTyRCz9HPP/Uadslgs6x7PprR6hxehxDRrUFxdia/4ZtMs
         kudmPOc/+Lj48pEEsBeUj8KJTTqVgFDnvQXO6FlBMyrnqJZ/4PET9tJPTe6x0en1cAG6
         SRwA1XGkS6QvPa7UVd4h0aNglfoNAHumJdMnXMxdfdnsUUvwaryjGKC3WdTre/kQ51tq
         JAAW3z0mATD7TSyIerOfXQzWhz4kAb+uTV5l9gBnVKbJ/xmGfMfhbtGOIQtFnBJIQsP3
         tP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745238506; x=1745843306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2wIp4O5aFba/VFIEdYS6vzun+UYuyoA/BMDFjUKnEU=;
        b=FUmBmdslWnAxci+bdSrkZEKC0RXkmlXHxk5DUH9o8kjYnEv5wizaRDVMT8DrgEcbtQ
         /3HFsEW0Ib/TMvg4+C3zJ5dz3zFBOiYCE2HnrEb5p4/GDZwX9Pws9kbXlPXN95XstPnQ
         Js4kyv60EubElICPJ1ONX/wkVQ0hv1S+Kqij9nc4BxVLo4pb9INaYjnws4Jw9xI5wP++
         5D19dcvt9wYAxely7KrIwCI7R4RN46UBnqfDGtoS5ARk4Pc+eMQOiTtOj/apbvwiXyLE
         DzJi5QFW3CfHXvNRtuuCdD2fqm+Recyh6QQObUeK6Y9SymbhwIoRi6gAiriZvhQntp9L
         yPaw==
X-Forwarded-Encrypted: i=1; AJvYcCVJevFjRkRraLoRCP1eJIOFmuyJAcYpOpjfAjHhr4q7lq+VLctTnjLK2ZEJT/9Z3pjsRsdDDKFV@vger.kernel.org, AJvYcCWL+aSpR1HYm7FAqSxmdjITv+bNIRFyzOVywza5S+VN85XJqAyR11xP94antbrSqAYiCdP1kDfgSCI=@vger.kernel.org, AJvYcCWU/NSugFcpL0AJjQTFnUWJ9JCvZb56BBy2Yh+SxOXlpcWkN1egdUpTlVtsX/tsBTCy6Q5U+V4wzxY9OY7D@vger.kernel.org
X-Gm-Message-State: AOJu0YxGI9swJrnUsIZGWJ1joRzOz7z+dAOcorLNdsb0QP040/RUrobq
	CPrsQ45vTyXi0fz2p7IaIG873kS1YTNj0EaTYy2+CtU05oNtBCoo
X-Gm-Gg: ASbGncvLUYMuFsI2TU1MGnzE56MrU8JlXFnKYsGVHl4Q0LWhXfvO7itL4xZAmE+lWxl
	RLB8ZvY8j8u6ouhz2zM/FeJ4s4/9Ea4QB81ajC4f3EsCpH9zM7UCO6lMyAkZvrxcZTfYeiK5OFU
	LLBwvuJUqAIS+sNrgIM0Qou/q+xwcNFoA4AyMtMFs3hAX8EkV4mlNO/4i46FITJg68Y6Umso0qV
	LPNkIF4X6keoIFC9BB8LvE3Z9mxwPqdspE5jcAZDU7fCyBBwF0mz2Sfn+2iPgDQQgzh482JVuzQ
	VUIhtJBWPbAZrguCaHNTJwoT1LDcU7O0SiCtnsl2HGD0184FChHoh+nvAzY6vf2e5lHUEabf/65
	Fh5x/luS80Bfzcjjsmyo=
X-Google-Smtp-Source: AGHT+IFiW3P7e10p3XKaEoJEdAV43qnaCDOH2uR8uU6ICsm90RmKmXLfKhA2kcISDnvAu8nqURfE6w==
X-Received: by 2002:a05:620a:2911:b0:7c5:4d2e:4d2d with SMTP id af79cd13be357-7c92805fb68mr2053018385a.50.1745238505835;
        Mon, 21 Apr 2025 05:28:25 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac2f27sm412267685a.54.2025.04.21.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:28:25 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@suse.de,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] iio: accel: adis16201: Use IIO_VAL_INT for temperature scale
Date: Mon, 21 Apr 2025 08:28:19 -0400
Message-ID: <20250421122819.907735-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a leftover from the patch: commit cf96ffd8c2ed
("staging:iio:accel:adis16201 move to chan_spec based setup.").
Initially *val = 0 and *val2 = -470000.  However, they were later
changed to -470 and 0 respectively but their return type was not
updated.

Use correct type as -470 is an integer in the base units.

Fixes: cf96ffd8c2ed ("staging:iio:accel:adis16201 move to chan_spec based setup.")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/iio/accel/adis16201.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index dcc8d9f2ee0f1..1f27386edcc4e 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -125,7 +125,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		case IIO_TEMP:
 			*val = -470;
 			*val2 = 0;
-			return IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT;
 		case IIO_ACCEL:
 			/*
 			 * IIO base unit for sensitivity of accelerometer
-- 
2.43.0


