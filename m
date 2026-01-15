Return-Path: <linux-iio+bounces-27827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D430D24771
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF353083C49
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489B39448F;
	Thu, 15 Jan 2026 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cPCveE7m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F039526A
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479883; cv=none; b=lKtxnP+9gdmb+RfdtUv6uVqATVBxHM/ar1xZKNQs/+WTDY2gH+u6Uv09+D54u+vNjVWbaj3r5tIG+hE+MlbelXWeDDwr+ENyici3whrX69sper73zp/PltylJYlssnUmJYcEV5ONuuB0d4AXA34pKCdXKLz92rx88RR0eUTe6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479883; c=relaxed/simple;
	bh=qWSzczDZjcHADdh7F0nneO0NUahbOExMpfsP2Gn6t7A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRJmoxvVwRyLoY2Y702G9HVW2Bd6yhZRT7TMx0ZOq2JzWBzXfzaToiNjzywr/bQX6xM5JiEmG1elC34vcgIZIJ6aP2bMiS8TkunydPo5baUr2BX8jPhPzqlhO/na2K/PUNxOuT+gqOlhVRHem1EConpwgqWbre3o8kIQCK0VBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cPCveE7m; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b874c00a3fcso141285166b.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 04:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768479877; x=1769084677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl7MdD+eDM82jopyo6YY3oLEVekS1uwuMay0GKT/rzY=;
        b=cPCveE7mP5iRZbP55LmdzrwBOAp9LP352eITXqdHmn/HN6G8+i8aiaYq5RBWx5I5LO
         b+3GKwyvPbsE33JgWFjerXJvS742W+d8/++5lhYFNjHFftcVvgk5INyDvbLgjdqMTqBk
         T6NNBKB4TkbMYErvBj1++JwVKvsX9t7oeexQRI1ksm9+aPzFiQuaKOhjBHkJ9QV4mijU
         cmU6weiDlpPLqVWxvHWVjM2/SvVbditlnoXVtSuzfgMTnNONKKXD+JJGU5p7YI9we6bg
         S/jJIo8+3usz2e1qtRn8Vt7nNaFZnW+j+kT9pdSxSSLVbDvG3QLb9akntuRDJWmDHqq2
         CeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479877; x=1769084677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pl7MdD+eDM82jopyo6YY3oLEVekS1uwuMay0GKT/rzY=;
        b=fvVCSIasnO4oAfn9ITj3SvRG4hfiHeWgGr4OmUyCDVerVtIlXU36WPuhig71hEQVc7
         gla/6/hcwdMRIPHER0wkK/rTMwR5Z/shz3vF1WR938OtsdCZSseEN04pNlBa4BVuhCKr
         KiDfAJ0xSmttj7NEHiZHWXhHiSklTlqGYurixSHaCoe5lsHhp0RP+M4ffOoSYRRGjDrN
         wa8eQaCGBz94/UcmOZenp9mrNxR4GzD2B7ADL+jZMsae+lTVJKoJR0JZpo5DEp7/pu5T
         CCf3WD82ij438MuWpuSi08SrBbg/YIzSoMsoYWS7Jps6gdx2vgn/fWktT8Pn/yTI2iW+
         9P2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg00uDqDLU1qc4tOUYkHy1YftpWn4XzMaQKWd7B5ut6NMGfGLHoNinMWBkEMJdO/9WW8wh7/g9iuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8RI58XQ4ORe4I9fdPR1cNQkxoxieexDsYCFqy6XaRCEtSNM+w
	Se0fKoQcEGddHWdZPnfON23dUiKerHUVKzsP5UmVSLVlsKV4uB0+kz4ELVHHVMkqIaU=
X-Gm-Gg: AY/fxX40wwXNuuJO5AMSEfGluc/5usOaGE0HQCoigz1EoqAQ73mp4GbS7qkz3JcHOwK
	LxZX4zPrVHgS2ATVsi/k5xBXXF5hAl+Q1ZTwxvz5KTPBP0YukVbpkmdBk4xgPaNMEFFOtwJB/lV
	rK230zEVnDjDgY8uMEAl//x+ekerBWnJjIZHcIZ6V4Cwo/CUsUDzqEe5GlzqkfAFE+S+FAYjlgB
	uquuOeA/x2VsijzlRppb9G3aH06UzzCLXJdS+TBvwJ+WXBA/wXUABqAJtosXeuLxtkKEQsAkt0P
	U+D7IpYVwHTLMqkEoXjf7a4qaDuKjsvkckCSMXO0pK90dfcNyltY8TO3pa6QOomGLDT4QQi+1Sb
	pmax/TZMoYdoolWWOMnAbeW5d0orpCuXvzjcXe8AdGug7bpx+8OFlLK9XhA==
X-Received: by 2002:a17:907:6e8d:b0:b80:2b9b:39e4 with SMTP id a640c23a62f3a-b87612af6demr531623366b.55.1768479876688;
        Thu, 15 Jan 2026 04:24:36 -0800 (PST)
Received: from localhost ([151.47.157.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d1c6csm2696436566b.39.2026.01.15.04.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:36 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer only
Date: Thu, 15 Jan 2026 13:24:30 +0100
Message-Id: <20260115122431.1014630-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260115122431.1014630-1-flavra@baylibre.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=flavra@baylibre.com; h=from:subject; bh=qWSzczDZjcHADdh7F0nneO0NUahbOExMpfsP2Gn6t7A=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaNxlpv437N4QVb6m8Faki+PE65JDHu+70R6ye 0wyqv5/48KJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWjcZQAKCRDt8TtzzpQ2 XwZhDAChyQPoYHmlfvyiL64ebtVA2ufpzNmsLFkWO2Dvchs/07PTiOq1ayxS4+NMjAaI23xOUpV O/u4rvzkeEeg+XDBtZQpUrPP26zKLYfn2tjDc+VlQLiAXJjhrGnvUhVBanRXfWLb9sFk6NNf5MC QX6wycFcMs1im8al2xqBgey13GmP3zX7Z0suDvFNLgsPXVJuK+MsCU4dvkGNl1heQfoc3pdtxgJ X9HZfDuTh8fuU+ZB0Kyq8wHaFNEAXgJe08DfItwH+pDOAjaijB/pMykncGYSro/YoQUwvgKQzIE RsotOINVzpqeUlxrl604aNNnjwex1kVdQitDOj2BxgAeY0W8VyMGX0/hwvBWBCHAczZcBUy6WpS I0W9leFEHqBKkGfZMLiXmhC39Njy6q8LLFdIGcjYGVocVdjsai0OYlwGcOzyeZwvdltq6RoXbSP S2SwHpNHLBeU1nQ9kvA6Kz6a2K9u4+PqeYD3/zkLDmNZ3oKm+mV2f3+cfH8zHK1cqczjM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
writes the buffer sampling frequency sysfs attribute, calls
st_lsm6dsx_check_odr(), which accesses the odr_table array at index
`sensor->id`; since this array is only 2 entries long, an access for any
sensor type other than accelerometer or gyroscope is an out-of-bounds
access.

To prevent userspace from triggering an out-of-bounds array access, and to
support the only use case for which FIFO sampling frequency values
different from the sensor sampling frequency may be needed (which is for
keeping FIFO data rate low while sampling acceleration data at high rates
for accurate event detection), do not create the buffer sampling frequency
attribute for sensor types other than the accelerometer.

Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 1ee2fc5f5f1f..cde29b2e6f34 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	int i, ret;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		const struct iio_dev_attr **attrs;
+
 		if (!hw->iio_devs[i])
 			continue;
 
+		/*
+		 * For the accelerometer, allow setting FIFO sampling frequency
+		 * values different from the sensor sampling frequency, which
+		 * may be needed to keep FIFO data rate low while sampling
+		 * acceleration data at high rates for accurate event detection.
+		 */
+		attrs = (i == ST_LSM6DSX_ID_ACC) ? st_lsm6dsx_buffer_attrs : NULL;
 		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
 						      &st_lsm6dsx_buffer_ops,
-						      st_lsm6dsx_buffer_attrs);
+						      attrs);
 		if (ret)
 			return ret;
 	}
-- 
2.39.5


