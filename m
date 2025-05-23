Return-Path: <linux-iio+bounces-19837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45EAC2BC4
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D900A9E2EB9
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB22147F9;
	Fri, 23 May 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClR1lgf6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E11EB1B4;
	Fri, 23 May 2025 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039756; cv=none; b=qT+sa6+taocKIrXXvpCibILlyXCOJtJulWJiwTNZskuPxH0qalFhKSHf2T86vu7jtxKbKlpa8Y0TDcfoZxUFtTosmBfTos/iTtI1mPwjlMGf0xyJeL8ilszEtXJWZGKHvIMGaGRyf6d0oBDWY8vKtd706AUMtg3Y5sOIGqOjFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039756; c=relaxed/simple;
	bh=cKE0WSkFCIF9Brh/SnNokfm5fFpy6Et8C8/qKo9CJEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvhH9NoVAkDq4cvqCnL2KMKCOpcJlTDnSFNHTFFcHnn90uligeHQ7lLr3qQ/CeEEkHuObwvdxUdWg6qG4Bt0zxN15lcrt5XcKLnSfcrH7M7NCCs29f3JsSDqxrEdpnhaQMn3/bBexbaE9TdlBawRiPjUrXXOOlLhpciXOK9SZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClR1lgf6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-444582310e3so47205e9.1;
        Fri, 23 May 2025 15:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039753; x=1748644553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=ClR1lgf6sT8gg/FHFWI3wlarp1Yj0sE42Cgpn+02/V7x3ffs8LLux3JoEoVzX8Yy22
         pE8rrOtG2N55SMzWaCNIb1eFZuqGY1NKHblopPSHN8RFSW4ktuEUbQSrbuZZ2nauzoYf
         72XX3U3XMrS8eoYgEEYe2vv3ElIOaDTcBODiNDYHsdayoG8cAM0oLaYU3yZbiiVmx395
         exEPhIur14zJwrTMGsSDci/yMCFDsL1IQbXyKtMYUevC8orsZ8+v4KdpkRG8IELvMvDN
         WO0fMIAa4OcNDXPUI3WGoM6WBcqf+9Z4UCzqietx9n66l0r68F+mkj7Lc1encpbf8qAG
         tWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039753; x=1748644553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=hdFCxxyx8aBM0ZmMAA/G1aoTtYUOSDbEYyEgD/iCHj25+4GksFWJRBTheW2HjR2a2L
         WJtcVXM5LJjoZ2tkCPh272+AflhxiVcfm1DspeQ/fhOR23ShV3dDVyB4jbW8EETT5t/i
         q0JU8u0Qj72sL9vlZcwiN+vHiVfdKDtFWcpK/wGYhxFCqlMyeRs7EwsoIpIxZ+jYXZeN
         vkDgIlGw+mRwNjhPX/wa2DvnX/NiaQCIBdI7Vl43vu4pH1wNjJPLOAAPl9Ei7sIxBczW
         R0n4JFXHeP22hW7DmALrHRBWdL2Wwl8YZPnH6NVzQp8y7PMOyg2kZ+3eaZzMU7DbUl+5
         1s5w==
X-Forwarded-Encrypted: i=1; AJvYcCUM2p9174eR/zrlig05S3J7Pw5v7K2M/lZchxl0ZiWb3oIr9HA1PVoilw4wO4bRftoj84fXyC42y3ibgiap@vger.kernel.org, AJvYcCVRhwYL5Y39sQjGulOmRWXJtWtGxEc7Njyr2vtpJ0UWGfXOQkGH41Oda3OB6I3Bf7yUj4I72g9Z0Euh@vger.kernel.org, AJvYcCXcF3FX+XDP08wzZ+fDHXGLbr15Pwm5j55OA9uxpfVJDEK3MorAV8hT6Hlxshnd6kp3s4C9aNJhQ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFV5d/0rOydikJnDUpSDd8forD1gtwG7rwqHvPiCzzgJ3AJIUv
	7zU4zAiFGgJH+QbT4w183dcmLYZ97iNN1roZk74hwGNc5+e4FJ7pNKC8
X-Gm-Gg: ASbGncsdnahlvPNw/qq4sbyvPdnK25aXjXldMm0rT+2/pq3O2lOBVtIDDGaCgXPhmxW
	sidVf7TZeFMNobMKwM3PE30vlPeovDYKxcnS3lBEnQOagxHJHVu2fK8sBFmacZs0oQ9PRaeD20r
	MhVp8cjbu10JlS4fB8WDyDtLsv42g0j1f391BbWEElVan2e+Nek+yGs1lZCm5sSzdLRi0odFemd
	hAE77iktQZX9WNit7/wq89cv5DJkK4Qa65JbEYXP4evSZqdtOiMKkoXP8b664TnPdZTQJG6SEPf
	cKHgMmrfcoLaMJQrr8w1IOIwDTyXjJXYjG6OevJ4fI0Y6lAiBeEcKNmebyAjCfljV9njUuYn0Nq
	QIulDAzywX/0hp4eioNbfkDfCk3JLU1um
X-Google-Smtp-Source: AGHT+IG1o4yWWB5Fw52JHWv1Kou/EzWQD7AN8o0Qka9g/sOOpB+XSk4Vt0T+YITd+D0P6v+BLjwStw==
X-Received: by 2002:a05:600c:1d0d:b0:43b:cab3:1fd1 with SMTP id 5b1f17b1804b1-44c934e5f3cmr1953025e9.1.1748039752599;
        Fri, 23 May 2025 15:35:52 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:52 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/12] iio: accel: adxl313: add debug register
Date: Fri, 23 May 2025 22:35:12 +0000
Message-Id: <20250523223523.35218-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iio debug register for general sensor debugging.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 4de0a41bd679..2f26da5857d4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -321,10 +321,21 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.debugfs_reg_access = &adxl313_reg_access,
 };
 
 static int adxl313_setup(struct device *dev, struct adxl313_data *data,
-- 
2.39.5


