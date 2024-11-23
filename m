Return-Path: <linux-iio+bounces-12522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412529D68D8
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 12:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A53281A83
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C5188736;
	Sat, 23 Nov 2024 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0T0sXwV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131FF4FA;
	Sat, 23 Nov 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732361295; cv=none; b=R3oUQGLu5gBaqNI4gnSnt/JrTyyflFy0CXo+8DomcjXwoUtIKLnBMu8upJzfWM2f286174HX8GC0lRLBDbdiKHh6viSsw/T8T8PKEtD2v83+ICAs8dRzfxktx3dHHAB5qvb4FXnpq8Hdclxko+LYIF331rvnF7W90BEKnyefCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732361295; c=relaxed/simple;
	bh=6/Ld9f8L7VslcnYOHVLi3dRtQSGDgjrivfqEn/LytIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LweSuZWmVX7/thI4SqnyExB+hDKxLp6btD+jMutB3KIXIXAJbhITD/7qLKHXGD0Mj7aiyjmDUFiX33EgL4Jc1F9LJ7K1NVwW9CrdEyCUz+L+p9YIGt2OHXCuq/qnCyAFr/GbOCHUgd3e1BZglfWuG0H7pl9U+/NzDXNc/QTXTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0T0sXwV; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d43134d574so18293886d6.0;
        Sat, 23 Nov 2024 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732361292; x=1732966092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nW41neqocy6fXKAssHg8G0smE9BKy2Vr7PCjJvIyTyA=;
        b=a0T0sXwVXM9oSwAhuRLdSoz3gi1MI3hm221Y8n1jmVoYrSXljrGJPD8VFNW14hg+R+
         xx8clfJ5VtKUBeDXVlkkNkPMFPzhj7iItnp89j1Pa8XHDX//04yrk0WX4DUa/9zZtSqO
         c3ShvVPEYiGb/p6ZfJc4cwjdo3LWMwJ7RFBH+Kuz11qFmfde3lJwStY0u9tAq0d9UM32
         CQLQkIv8MORKqFhsEjUZXQ5oLy7ElhKuAygbHw9XEGPrQ0mkm586LChc9JzT5pecpPIM
         nnXjI3P6jKJ686hs2B36Re4Y6O+gzhbiP/YWeOAXCJecca91Z0+CauFPgfH7huhPtpel
         Wfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732361292; x=1732966092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW41neqocy6fXKAssHg8G0smE9BKy2Vr7PCjJvIyTyA=;
        b=eVzSVeoYv5snaeg1GixOJd2lLCPEN3vhkceCvfqvifHG/dBqZ/UEai1Oe3Tb7gXr8c
         xdkvaRhixEux9WLKnC8OwPf1mDFGmU0/OVLU+5eGk4hyfWY/VsasILSOv/J3KrLjFRyQ
         Vllpn/EL1ibZz2+ndLERndXmp3T7E18vjkaDsmUiUkVKTdsodErzx4BlnvUroVc0eaZv
         CV6c9xe6bCFLtzAgHEdnUA6gM4kZXqO53QLmB/L8pJjiZknBHdnsN28FQLL3l3TBtgyq
         ubZEAwPmCACcOsCuOMTNBsYB1qFYok7mURL3fMg95kRp9iHZWlvQn2Tg8bWd0xp5Fede
         lg2w==
X-Forwarded-Encrypted: i=1; AJvYcCUkqAvWvp5OBILfmzLYPm1+PSak2jkLPpL0InBoSi4WrtLNXEuNSCYXoPLjlHgI6izVAqPJfGympAMAU9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6QDqjDLiUSI9jw55/tU8S7tke4gZmZddRdjeMPwsQjKBqVwxs
	YQLZcnPi1Nq57BubMuvmn6D0EdCVCWhPQ/p8EJyzT8zG/KICGgct
X-Gm-Gg: ASbGncvfi+e9IrF+dCeYFPU2lK1IyM8Q06ktAH3rPEo/VqAOZ7OvJ7NUJYWjf2H7dKJ
	gklv0pu0QRxFUo8BxUnEWwO2Y/18HLMq/leiCSUGLbMYnj5ARhLUdSuNbQDI2wQHZbUKt39looJ
	rJLlRtEkFLTBzYZxG2WpEpQg3bIc9qtL2/UL47eQVbRmcyANdBL9bFuXP6kma2lHgkmjv6zqDxa
	lNSfMElzNUhUBP8wPWTnmZHAzLPTplERowQ0O5l4d7Za/f7JaYXfoXVtvZXb4gJ0Go7Gaq9hhxf
	Uplc/H3TyLHdtNuzHyTdLG3q2A1AEP91
X-Google-Smtp-Source: AGHT+IHQ7+9Q9GPOTQdK4h5WW33bBxMaJz+2EEngjB4L+PBJlHnrNDRPK7UyEprkUM1jTdhIud7XyQ==
X-Received: by 2002:ad4:5aa5:0:b0:6d4:10b0:c249 with SMTP id 6a1803df08f44-6d450e87220mr106668566d6.22.1732361292535;
        Sat, 23 Nov 2024 03:28:12 -0800 (PST)
Received: from ip-172-31-17-125.ec2.internal (ec2-3-80-66-87.compute-1.amazonaws.com. [3.80.66.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a99714sm20696336d6.35.2024.11.23.03.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 03:28:12 -0800 (PST)
From: Kuldeep Pisda <pisdak79@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuldeep Pisda <pisdak79@gmail.com>
Subject: [PATCH] iio: adc: palmas: Fix typo in threshold calculation comment
Date: Sat, 23 Nov 2024 11:27:57 +0000
Message-ID: <20241123112757.63928-1-pisdak79@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the GPADC threshold calculation documentation where
"paramenters" was incorrectly written instead of "parameters".

Signed-off-by: Kuldeep Pisda <pisdak79@gmail.com>
---
 drivers/iio/adc/palmas_gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 203cbbc70719..67d567ee21b4 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -456,7 +456,7 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
  *   raw high threshold = (ideal threshold + INL) * gain error + offset error
  *
  * The gain error include both gain error, as specified in the datasheet, and
- * the gain error drift. These paramenters vary depending on device and whether
+ * the gain error drift. These parameters vary depending on device and whether
  * the channel is calibrated (trimmed) or not.
  */
 static int palmas_gpadc_threshold_with_tolerance(int val, const int INL,
-- 
2.43.0


