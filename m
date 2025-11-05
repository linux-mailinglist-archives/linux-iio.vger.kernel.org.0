Return-Path: <linux-iio+bounces-25907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC1C34FCD
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 10:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FDFA4E2B7E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7A6309F0C;
	Wed,  5 Nov 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbX3g38o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7B30C374
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336613; cv=none; b=myg8Sgjy1NlDVl/xTcm/pht5w4LeEldQ1jCmzvUWIUcevxdj3OY3iyMRtO0V3YnfzbhGRCUZCleqf6AQWhBwhvYAayclApx2BDHMSi5J55MSRfTg0UZSbBJ6Ym3SNBwcyEpUFiaiOpzZ53tCObKLowqHmllZ/XJWiFqzOK66PzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336613; c=relaxed/simple;
	bh=uhtPyUARMh6iqTL6T+FkCm4KL2BKQJC1wSSAlBNThFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqbK61ESqOkYe0lX8n4Va/65s4uNkQGl6YMbgdrgS5RsL6xj7FW8GCZ/ESwKxp5eycpz6DjLClGSkRCmWEPti3G7Uq7M+iKKYobtUy9nST8gr+UUXWhMUZeJZ7WFtcs1C4mVPqhcqxOsYRW3N3WcWO6v1YFyM+CsggeC0r26xAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbX3g38o; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso2317364a12.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Nov 2025 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336610; x=1762941410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=IbX3g38o4MXh/ekiru+AyASGtD9LzwWr9rqRBYu59cIgSdr+PXQahKBDYXb1dYIdeC
         QY9XqjFgJwmBvEzNHB0UqGcFeBiZw3EX8p5hbGjc1RxcVo1XU4qsdpwrbt1B8t00Nv1E
         AuB7+L9Dl5DAIqg03b/BU9gzZTpR0Z3JTCSLzZ7MrGrpthS0fnrvGs4+MRQslEt49o8A
         ZFj11QekNKJAwG/LWI6sRpRVrYxGTkyPYh21wOfZgLGgv54a8PWNjsjeP+bqKA3OGCTW
         4m7VutICknd1LehaVvRyxOIXJf65JKJ3RcCxdNPjO5OeiWUPGAQtapLI35Qc5dwLwyyf
         gN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336610; x=1762941410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=XEOU1b0/WHpEe8pwkcbsFWy9sDW1WxXDM9nbm7C3uetPQWLH+xRse1Fj3W6Lt9qiRI
         QG7fDlmzpmdJj5Gi5KG15ebKrYOAXNTC4F0MJGrgI7AHdP11HT0XSZtBquE/bpSm/ed2
         OLKNMVC2YFt44HXxTkvEqASjAIppTzBzAwnl/dL1BJzKxCnwOdKdLjA5b7rarT7hEeih
         sRXzvlkVwOCJ/Yc9uLVKLQhMPp3zfLch6tXVp/L4sIk0uOk8CJGFwsIqQeDqtUEvWmvO
         OkdI0TEHbtQsLkh6QMYCYJdHn1GJYjhMekGWVbQr1BAV7WgyE6tBrHBLIYCc9siQJ9Zf
         +hDw==
X-Gm-Message-State: AOJu0Yxke0c6kNYCDcQzQ74S5ahDOYsuhpP52obCeMJ3ZcL9JLE+CCvI
	lB7qjJGRu9FO0r+RVEatOajVnWo6LejMaVWaxTAQ7KDilwl3uvbI+/lxfL5tXQDr
X-Gm-Gg: ASbGncte9kfzFVAXA8GnlY/b2JNeYVl49gdymTuUKlUskXDVvmIi0cNuVSH9YaH4yGS
	6r3rGlSeYHguS/bLxKjojRdw9J51037zreVmL4AyzdllLqacbAGdMIYYZ+WMPoqYxEJyO3Gf2/O
	n/bdrGkkgAM/Rtnsjn8nRosfHE/qJMTih6FSjf9ExkXGvgyVJyGbovObt4qOzfg5fclBr1Ccbri
	vF1SNq0jZoi3igd2D1vtMSAMupr8vzDDyJ+/IGMwezzLjGKahDrCnixYwVFEwZy8/6a/+Gab61N
	G7O2jwLhCvi7TFAP2x5IblG7XTEUeaGLwLImKaLW/pDSuZzo8kmAR2vyAT6i6Xy7F8usGvTDHgl
	phHCmGjUKM5nFmJ4zZd8gWtBjtj1GQBcetohwghlMqIRfw9xI69KBOBzPONCUbX7ubfROg2JQPR
	QzneAhuwfS0eprbqBJXZmrfDXe2X0=
X-Google-Smtp-Source: AGHT+IFQTND/jr+bbPyDxEQ0kqsa49/BgX2lBGe838P97ni4aXWpdvc+e2txxEZO/Dgut5ldnfdwGQ==
X-Received: by 2002:a17:907:1c1b:b0:b70:5aa6:1535 with SMTP id a640c23a62f3a-b72652a221amr254518466b.18.1762336609662;
        Wed, 05 Nov 2025 01:56:49 -0800 (PST)
Received: from localhost.localdomain ([78.211.196.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm440266866b.60.2025.11.05.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:56:49 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 3/3] iio: ABI: document pressure event attributes
Date: Wed,  5 Nov 2025 10:56:15 +0100
Message-Id: <20251105095615.4310-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105095615.4310-1-apokusinski01@gmail.com>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs pressure event attributes exposed by the mpl3115 driver. These
allow controlling the threshold value and the enable state.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 352ab7b8476c..5f87dcee78f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_value
 What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
+What:		/sys/.../events/in_pressure_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.25.1


