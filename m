Return-Path: <linux-iio+bounces-7283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B579269F0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C574F28125D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C67D1957F5;
	Wed,  3 Jul 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNB3tlI/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71F1953A8;
	Wed,  3 Jul 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040720; cv=none; b=mS5ldfZnDx1eRMPhkIuzDJKAv8cqG9vZ4sF9NwY+Nnnn962cEOm4fwH8+ET00aXx91xKRWsva6xLmmzwo7nw899zgCleMps9Gu7wyOiUU1ikaOGe4deyDQhfMEhE9Bni6nyXc/4TQn/hPXVg3jnebJFkJgBIdvUhbD9VzUQjqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040720; c=relaxed/simple;
	bh=NbcbWIvsQrzaCBFIWZHxkGEsF4CypNL/kk+IHCezcoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/TpPixv8U5J2REv8INcfYKwdF5MygK4COmA2ySyDeXffu+YvSGCAtVh3VsNam9bStvmQ1fNMrj7Wy6pq5p34sNA2fES+9hsqJ2DZ0n//R7n4nUKMsFkP9iB87xQC6G1HlOKuSIEegoJQE5BAP0LWeFRkZtF6U25AFWtLiXnKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNB3tlI/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec58040f39so56824421fa.2;
        Wed, 03 Jul 2024 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040717; x=1720645517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRgzlP2UcPIrCp97K6UhN9/fp3i9cpcun18o+fJ4UXE=;
        b=iNB3tlI/8MZafoS3rAEaf9T/32CBl1NSZXJOIoIF5o2zp0nJma3DQ6+S8OrLxowZao
         uDLeDbiZRMFKPjNyCNUJB54F7AspD5oweZUb2LKprJt2BPJntGmhLQ0zIAiqEvC7Ke7H
         tlSnfC+e4rrSJ7QLtu0vXDgIP0hxAsyPytYtOIe5P+TizGqfbyRtOY9m/5C1Lm4PFKOY
         moI4Lsc7sqyI8kiawO4/1z6VpPjbMxh6JGtyJ/l9lLsxZJi2gaitElqXRaJVQZBqi7Lf
         DXebRjhg4AH1QNVsFAK4v03JR7yJcOqPC3EWX9jvO6iGMxQzbfI67mRNC5eCc4GFVDDE
         z7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040717; x=1720645517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRgzlP2UcPIrCp97K6UhN9/fp3i9cpcun18o+fJ4UXE=;
        b=b8M2XLYUD9KDwADG73bhV2rbuLIzmlq1HIDW2uPHaI1bvPp7EiMk1iG7Bc0/5N1mNy
         zPIBgxZMSGzgHLiM8tgYRv8szYdPv4FsnvL2DBrwNWl6vOhSHXCSfxalhwCEeripzXfb
         E0/8UmhY3smhiG3/X1Tyf+C900TDE7WsrYjN/aZecebO37O3o6s40aAeRAtSy+U+rbd5
         UIq5098jxLsZf9267/glEQc9iRXyebUH+2Xb7nuVpzqh/lo8kGNNPSMm1qnsfFaUu9ZW
         aFLfrSeVvYhzUbOjhnyju1NQXivJKfGYZY3qya+qH4CfsArVKcqQda1lYgWNQzCpRdqP
         BFFg==
X-Forwarded-Encrypted: i=1; AJvYcCWJRvYIgxGqZqdaPBeIu/UxR5wJC3gPQmd+5ykBfAgI0hlib1Dx7r+643kXY8FrIYbLiwhSyWKdOy52mDZEMLJrCS85SLfvaPYz45Jj
X-Gm-Message-State: AOJu0YyrSVXSnG2k/c7PE/ia2yRr81OcJ0uq5xYLntxtICKB2c8SSipg
	uQ/wKx2rwkdgDC4WqsqEdj75hVChnppFRQ0LkasE6kJuwWWi1qDasEw4mYXi
X-Google-Smtp-Source: AGHT+IFETK18+5iYyOF90xOIofOYcMVWB4wdE080wQa1e7W50VchGF+OBxVK2c95gtRi1YqnrE2DMQ==
X-Received: by 2002:a2e:be9b:0:b0:2ee:8b92:952f with SMTP id 38308e7fff4ca-2ee8b92964emr4294351fa.0.1720040717423;
        Wed, 03 Jul 2024 14:05:17 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:05:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:52 +0200
Subject: [PATCH 09/10] iio: light: gp2ap002: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-9-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=819;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=NbcbWIvsQrzaCBFIWZHxkGEsF4CypNL/kk+IHCezcoM=;
 b=KyYBQmFLM4bMQcpPgZPrNxNu0ZrsDOcpEf20pj/WZA9aw/3NKSF9/8TtHVHZbDK16awEhraMS
 BZWT30Swj0pCOznZO0bDMF60fGnZiyBgZoeXk+K8juWkGcXiwxqDIzW
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`gp2ap002_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 7125e011a38a..f8b1d7dd6f5f 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -420,7 +420,7 @@ static int gp2ap002_regmap_i2c_write(void *context, unsigned int reg,
 	return i2c_smbus_write_byte_data(i2c, reg, val);
 }
 
-static struct regmap_bus gp2ap002_regmap_bus = {
+static const struct regmap_bus gp2ap002_regmap_bus = {
 	.reg_read = gp2ap002_regmap_i2c_read,
 	.reg_write = gp2ap002_regmap_i2c_write,
 };

-- 
2.40.1


