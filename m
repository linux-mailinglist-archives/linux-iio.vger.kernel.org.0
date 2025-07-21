Return-Path: <linux-iio+bounces-21830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF95B0C72C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F154E254A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE022D29D6;
	Mon, 21 Jul 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYkgTp0x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22119DF62;
	Mon, 21 Jul 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110227; cv=none; b=Jb0YC44LqlVaQp8uDY5XgSYfziUa9BCXWhut8t+rpxNH10y0J2ivkC8BUp3h0k+Bf+ab69jk9xkXKr0a193bkakWTLi1tAGVE4gHYyx4I7nCkk3TcBa8nQWwwHUXna3at24LwFWhakLdatSlFP6HAnpZ9VZWyvf3ePq6e59BJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110227; c=relaxed/simple;
	bh=sLQ0v+qSfqEceezMZuXx3FC96Rh9DQ+K7dTaxDzNaRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a27BypgJbJKQcDkywQb1SkaU/2nlISz9NEUxhodoDxeQ0rX9FiHWYGtMrCDRVXIF5n24a+IkbpYYFdUZdTYtVMAFKGLPa8Vim4dZVk4tE0Y9EyDLJbeS8hUjSbj22uuJIU+Q/dYoLOc82kDqRWsM89L8QtrJA7FvG2SjruvfKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYkgTp0x; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so722480066b.0;
        Mon, 21 Jul 2025 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753110224; x=1753715024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYCIxA2fKKKIZVk28gAD9jEo3Ziv2IfX2lxXhfepHEc=;
        b=PYkgTp0x3dO+nimQkPTWPOV23qAoMMCRaclxUTNfud6pW07pr+4+fjdiMWjybdGANo
         StL6Q/Iz46kMu89cpKg4cGRCRQeKaBZrCi5zSg8G7Q4LsawAjENH1N7gpa7qQR/X+GRt
         RPCGvHTs5CXCX2AlXE+6VJ9JDObVZsSyz0nLlvXfqOJmx/2kaDrFbVUnt+QwpTehVcuu
         LQpE5yEymCrjvDAmVciynavba/+nEnD5lbzZnSJG+pf78zbp4aAZ1LENFg6swD/h5tVF
         QyoWYgjJe6yzldv7eT/Xd7gVwxqrv8+VBFW21pMjUJTELxl8s8HCB9jWqYB5lFkl5UpW
         hJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110224; x=1753715024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYCIxA2fKKKIZVk28gAD9jEo3Ziv2IfX2lxXhfepHEc=;
        b=FcgMJqx+rKBUSAtEkvs59ndO4hbtEEg8nftSS3S3GiVbosze17bn5UG63Y5nSB7Ww0
         dplkuy4WOmuVXB4BuvYngsKH29stuyUCB0iSjftafSi8UYWCab/9jABh0R9HGoeVWa9t
         ptyjqi4Ma1kBHOuV0+9hE67T7NjrCH2VWEDjgOjBBtRUsf4pUowhfHrT7074GOzkU8jp
         Z+XKX3rpwdZZKJ6cIVWCPbJs0Q1LGJ0gnIKNHZ/dYUkRZsnHjTM2a4pa2GoE93HFtqsS
         qULWPzhGG62ELVl/YVCK6BzQ7Zrrmp0EFAt7rDrOF6kjlPrFGLl5/49HYSpEqaoZwg4w
         /NuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSlzs/qUcXOfrD90OpuJKQErGq1ix13B1WgsP3f8N7Cf9Gdb+CFCciXiKXQW1l0EvQx5m4dkIhzDUlgV7o@vger.kernel.org, AJvYcCUkUhPl/+n9rFTb136xUg5jTygoSG6a1uhO5rnrReCWT0L8TQWlbxLxXWArflBWwbUJzVFWsoxR7B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVaGc9PmuotG8gS/keEaUKsthUiUb2M+083sohKmkAjG2KgyuJ
	0pcLKYEmGtx4TipgqQxToalu3Cvz6KTk2GDbuCKgg9IWkOvSCL2/d35+
X-Gm-Gg: ASbGncuZR/qaJ1zdCNaCPB9w7a2d4UDxgALYELwlpZ7t/YsbSGiy7LudnbL//wg77yS
	wdxPGNf9UKmntwsH+jj69kcJDEJ9MmsSB/whK3wfqcHtOuc/I4osKrD0//Z57m2lyfniSFSKuwX
	lIngf3/GLrrjZr4NEQmD9c+E7LnwnDVBGt9m6etrdX+uHZjbB0YbQ2m60h7OkKF7JuWG+2Kb/sD
	RcRiW2JKBgY8JSNBcLp3YiTas0Zdt1W5S1U8Ft9KsByuIMvMBG0INCC/tppnF0Na1B0Y4NA3jc9
	P0euGEe35idsc6MHQdrargupQZLnavcdtVXG7svigb5e9w1asefb6kxRqvVxqlS7k0vCGTqlLvm
	joaMzkj1+f9coY+6/XoVJ
X-Google-Smtp-Source: AGHT+IFwOAb07D2i/QIPv2fknIMkkE5elVRJuhetZPLIOd0ezgq6Y89BJdk3N8wV66TTzWvYNRBuNA==
X-Received: by 2002:a17:907:1c89:b0:ae0:ba0f:85af with SMTP id a640c23a62f3a-ae9ce193a65mr1994716266b.51.1753110222765;
        Mon, 21 Jul 2025 08:03:42 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aec6ca2f1a7sm689398966b.91.2025.07.21.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:03:41 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: light: vl6180: remove space before \n newline
Date: Mon, 21 Jul 2025 16:03:09 +0100
Message-ID: <20250721150310.2601679-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a dev_err_probe message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/light/vl6180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index cc4f2e5404aa..38706424089c 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -722,7 +722,7 @@ static int vl6180_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
 		if (ret)
-			return dev_err_probe(&client->dev, ret, "devm_request_irq error \n");
+			return dev_err_probe(&client->dev, ret, "devm_request_irq error\n");
 
 		init_completion(&data->completion);
 
-- 
2.50.0


