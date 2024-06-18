Return-Path: <linux-iio+bounces-6507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6C90D58D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6674F1F21D60
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6028F166315;
	Tue, 18 Jun 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmIxqMhZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAD1662EA;
	Tue, 18 Jun 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720542; cv=none; b=afInIjyugpbrbt3vXdLGIdSYzrFit5X+D6G9u26RnOgXpdsdfsmIUTVhI60oXLq5LxRA3DrFBIYcb484lbHKkV3cZmGbYCIkZ9yO7D+bi0R2Qbr4jLWCa4YllREJ6RsxL5KWOvrDULSaeBSCve7NkQZ6ibkZpyGetIO1VPKo26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720542; c=relaxed/simple;
	bh=9nWhS3qqdVUR1DFfHDG1/D2dWJpNJex73LEgHHCjB+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmuRT3O4Iut6dvlRfclc3Ia1pIEXJq62y4dKSBSWJ7udCc2CjTYxDYzmfOORkwCxP50nSWlEQAQGl2FMjY7JqDXf35GzNikiqaulWPjP1mdZqeElbwOX8hx31Pmd3O3sb/rJ4aAWWiGBcfBljOnKc59Dzt0yQeOyUR8CPpVUf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmIxqMhZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so648613266b.3;
        Tue, 18 Jun 2024 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718720539; x=1719325339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd4fMU4XCRVdn8w+boSaOOLeFk1GxpN6I8ANgWZ/Utc=;
        b=PmIxqMhZ7Vo39IiVZt7TEiwSj75mNhs3aMz/oTJoc3wYdlZuEUh7YTx/UDacMKr9qd
         vJmknkwdDdIbMfjJy6DCvOUmKQIkPDvOiU3RDGo2gx3GZFMH0RiFSnHw+vJguR+AVUUh
         tt9h7MRyxhv8r0p0Lhf7xT+Lz0ZrF6OpsJAGGiMS+WzBrdjj6H7MNoE+FWxGH6NKDVJG
         xkoLn7tM9+dZIdML9nmNC4tFZSusglFe9U0QSSFy+BWzrfiQ590OPFW5wAXZvaWd34CY
         eS85ttU7Yh/0wzayrI67lFud3y8zGzjUXnhSAbgQBSAvRXojTrhEkE7YUukVSRTLgX7i
         Q/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720539; x=1719325339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd4fMU4XCRVdn8w+boSaOOLeFk1GxpN6I8ANgWZ/Utc=;
        b=nlcaDEbkCepD6Vr3b7/JFgSPxfiECMcglI28JuVAmaIWzK+mYwvw6mjDGyUx47YrVg
         3AoRPmkcULSUX6o6nMNOCNTYrde8PTuRkNXEo+/s8QlyP258iMXYdCaikShbmYjDkXP7
         o6z+tRdjNYnv1Of9V/mz+vMN9foji71soO1Tj3rOfbhTyVWXXDtakVo/goxvKOY8Cfcd
         eMGznE3Zn3Z5PmKskz9NT3spUKQONtYmiB6RpoW2RdCeOo8QQh9WypVzQb4roOho67Bk
         B7TF9wP6JNI3IHQiE0LVSHPUqPiKBdsLox+gORgvWUegyByqsDdmNGXJrvkdVKVIhKCe
         auyg==
X-Forwarded-Encrypted: i=1; AJvYcCVhySqcaiMtl7xUPXaXCALuwV6kjr/xbin0tMN3a8Ojq3cYWPuO5R+E5z5wh8mJ7TuoNOZiiImebMRVl/07CEci+ANvLwOI91x2U3EQdNDO+7koVfYfRXV2jQz27tJya0zVW9vQeo/rh3QnJjgBeQ34LzLTDoOVk/Vcpi8rYTcr8Fv93g==
X-Gm-Message-State: AOJu0Yx7UEi2eY3ZUwaTwWWUYNYMwz6WErFA7X4STR8sdym7Yx9IMPJQ
	QgZNJqWC32lnXAYzMOIsNKUNa9DNdNQR7xrgJUHZD0fTiUjbWy/I
X-Google-Smtp-Source: AGHT+IGw8nTjb4FLe1ZvAWgDgoIVGkZHYVCvXgSPLf9KAfjt31/ecVatUcUgK02e1NOE/vUKq35u3Q==
X-Received: by 2002:a17:906:710a:b0:a6f:10aa:9c3f with SMTP id a640c23a62f3a-a6f60dc8929mr885088966b.54.1718720538818;
        Tue, 18 Jun 2024 07:22:18 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6dfesm618191466b.87.2024.06.18.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:22:18 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 6/6] MAINTAINERS: Update AD7192 driver maintainer
Date: Tue, 18 Jun 2024 17:21:38 +0300
Message-Id: <20240618142138.520192-7-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618142138.520192-1-alisa.roman@analog.com>
References: <20240618142138.520192-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexandru Tachici has not been active. Also the email address included
is not reachable anymore. I was assigned to work on the driver instead.

Remove Alexandru Tachici and add myself as maintainer of AD7192 driver.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24d372f7653e..d4a958b4341e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1217,7 +1217,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
 F:	drivers/iio/adc/ad7091r*
 
 ANALOG DEVICES INC AD7192 DRIVER
-M:	Alexandru Tachici <alexandru.tachici@analog.com>
+M:	Alisa-Dariana Roman <alisa.roman@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1


