Return-Path: <linux-iio+bounces-15923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41537A40107
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 21:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99FA701A2C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77E11FBC90;
	Fri, 21 Feb 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX2kMFZn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C11DBB38;
	Fri, 21 Feb 2025 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170039; cv=none; b=iOx7paOkTI+VIKPIHcboCyNkqRB5+3Cl243q+NOMUFBOAPHdbKmAxHQPxf0aFPpya4+9F/HxHPAduNQXwfQpLV92yxDIz1HfFIKyZ0FppqGYmCOarNjkph9dSqqyQd3DfrNXy5cYEQCGb86ir1hsjMv8Zwbj7LvgOIFA6CLs3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170039; c=relaxed/simple;
	bh=SGJF1WaTrQu54Q1JLjAtOPtPqnBhEh/2HLQ2WbBAyPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f70n9sq6PeGkBav9Pee9PH4vpNLihencU+A/rqVhjrtH0b774BGN3bTOR4bpgItkEe9T/t2Gi9ZYE2ddvdxOS8bRqwhVzpQt3wGFwe2jjDq59uJHGLQ+5kVaBO4J6b6P/fakL4GAG6TUZ5F3cjUC4ozi6kGjN8eeRSorW3Bfrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX2kMFZn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb9c8c4e59so41670966b.1;
        Fri, 21 Feb 2025 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740170036; x=1740774836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXqiCl9VoNeTiKzzhckskFwH1mJ+qY7zPKI4q/4FUBY=;
        b=GX2kMFZn0uWD9WTNpv9BjcyWQyFExXgMvgXjLIWuf11XVPxdxZ7ZxVB7E/7LGQfUCT
         MvSbJnySHGAWLhLIEUGluYCb6PUZ/5p0pGU6ohQ5C/CUl1ImU/2QsY+hlfcjXwnEEfoE
         TQu53EN9NUyvGwPrwpaixXTVgokgf9eJ9f2Go5ZJK0UgO/AJmUjz8erACz1adeEM4G9U
         2jMacneFqtVo8b3ty7uWgfQ1Lke0O6P2QIEDFuDJ5yeuTTAu5EmpYnz9ieW4An1YE7iX
         QoS9IWBjNsJezvOelEXwYKkQGhc/NljQNEIYHkIqyGiO4us++QcAkt8UUbNamfRvOz1O
         0Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170036; x=1740774836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXqiCl9VoNeTiKzzhckskFwH1mJ+qY7zPKI4q/4FUBY=;
        b=mqjY8yHXQTDnF271eQRdQ8ZlydAOKPZS/v/2vNmHAakqNwn9hvnUcOvQ+TnQ72+9Jl
         aYlb2pQbrkc+6Ay/VnbBD+nU4UaYvoQ0xbH/hrywEtqvB8O4gxmJ/4fnHzImwej8zsuu
         n/WRJNfMYyjflHw0YS4VlowbNRdgStHszPNFiwON244PEwUqGhiPU9BrRZIHUf3SiGQe
         +Q7rifK/QpYPUsiRsIF58KUZGi7AZWYiVpi0kO9Cf5aTG0FapCxNyi5fQY/WmaCTdkxX
         zfhi0QLGgK9qE4hjDQCR3UOrbGjmtN4gkfEP7ibJpvEHJS6Efwpc26mXfqyTeWCzqlsW
         Te6A==
X-Forwarded-Encrypted: i=1; AJvYcCXoZFZEe4LvKHBlBfQ2qLsmDNdxuVnz7S1fVicBCW0vxkI0NHazz/1j0dFGU6LN7EJhi1TyH+hIIWq8UU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1hmd6aas3PN1vvTUX0D7hn/MlHtySPOTKspjJguPpRSnDaZq
	9UYU7Ohbb83880RSVfhx7OqQTsNFYh4oJMgFBvSPT+eWoyuXffiGOWnul3bI
X-Gm-Gg: ASbGncvfTWjNa4/FNbLS/Mfh0OcvUkMyHI/dt+wszkfNHvlyXM2qqAyv5VSdIqKRFxY
	NU2JnRbFPGp0/sjWt7/VlT3mQXuWV7uYnoyNDdFTKdSpiGBNUy6sOkHUKshsqkdG7zykbI/u9ua
	J0mzkQgztARCWKcAce/sELUh35G6qgcjgmjGv2QbPnz3gYV2opL770rIPlHgKUHMnhzD0tuZNpI
	uo4zjYXQ62vQsP9/n8nYb18rhZ6Fco7x6kzt8ROXfPrEN8GA/HtnPTjG5uR5696NwnyHdb6y0iV
	Kwxl0F5Zcg5FM4MFdKgR0LNcmew7F2ZMrWjjJoTrRqnHUIG+GiYNVZaLkeDFf2zklEWLhdNrar/
	UIICf
X-Google-Smtp-Source: AGHT+IGQZu/s6vEf6PhksUkDJYXiIMp3cj69yoi4Sys1W31xZ+3q+D9lhalRMVuq2/EWZGcPg+PxSA==
X-Received: by 2002:a17:907:9713:b0:ab7:f92c:8ff9 with SMTP id a640c23a62f3a-abc099c6f28mr197105066b.1.1740170035895;
        Fri, 21 Feb 2025 12:33:55 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532802a1sm1708666066b.76.2025.02.21.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:33:55 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	cosmin.tanislav@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v1 1/1] iio: accel: adxl367: fix setting odr for activity time update
Date: Fri, 21 Feb 2025 20:33:52 +0000
Message-Id: <20250221203352.41941-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix setting the odr value to update activity time based on frequency
derrived by recent odr, and not by obsolete odr value.

The [small] bug: When _adxl367_set_odr() is called with a new odr value,
it first writes the new odr value to the hardware register
ADXL367_REG_FILTER_CTL.
Second, it calls _adxl367_set_act_time_ms(), which calls
adxl367_time_ms_to_samples(). Here st->odr still holds the old odr value.
This st->odr member is used to derrive a frequency value, which is
applied to update ADXL367_REG_TIME_ACT. Hence, the idea is to update
activity time, based on possibilities and power consumption by the
current ODR rate.
Finally, when the function calls return, again in _adxl367_set_odr() the
new ODR is assigned to st->odr.

The fix: When setting a new ODR value is set to ADXL367_REG_FILTER_CTL,
also ADXL367_REG_TIME_ACT should probably be updated with a frequency
based on the recent ODR value and not the old one. Changing the location
of the assignment to st->odr fixes this.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl367.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index add4053e7a02..0c04b2bb7efb 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -601,18 +601,14 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 	if (ret)
 		return ret;
 
+	st->odr = odr;
+
 	/* Activity timers depend on ODR */
 	ret = _adxl367_set_act_time_ms(st, st->act_time_ms);
 	if (ret)
 		return ret;
 
-	ret = _adxl367_set_inact_time_ms(st, st->inact_time_ms);
-	if (ret)
-		return ret;
-
-	st->odr = odr;
-
-	return 0;
+	return _adxl367_set_inact_time_ms(st, st->inact_time_ms);
 }
 
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
-- 
2.39.5


