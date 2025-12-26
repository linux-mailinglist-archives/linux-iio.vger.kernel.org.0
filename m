Return-Path: <linux-iio+bounces-27353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E8CDECD2
	for <lists+linux-iio@lfdr.de>; Fri, 26 Dec 2025 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8940E30062D6
	for <lists+linux-iio@lfdr.de>; Fri, 26 Dec 2025 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B20231A41;
	Fri, 26 Dec 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy4jMNg4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5C1D5141
	for <linux-iio@vger.kernel.org>; Fri, 26 Dec 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766763937; cv=none; b=nwZ2LMFILGjkNDvI1/vRE1yezcS3WxsKgk8qtfNehPKi31s1w+vmvX0gkNb7eeS3nr9mLrhMa1AvgdR9NHTaeKoV0Ktl6vUpVm1MRawcVhOo29vdlxWUJsa+F4hdovVOIYWnoiS0i968/P4aOh5MlVBiM+L3qaT3YUK0Djq1FN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766763937; c=relaxed/simple;
	bh=92s0poAWhmByfF4NbQljHP/Pa+X879XWvw5HSZCXnTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMo+e616CvOzr58DlE8WuO9W/GV9VJm1TczhEz0Z1c6ihI+x+pII9tc9hGzpl5WHPdrpX/ndwfQUvLrKTdt8VskjX+2aBz/dKYtglyFL/zA8BpkKOHo1bB60cRuFPkNk5Ae90TN2LjewdNdkUwaeNLyMj18PfzILfhd15p2XG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy4jMNg4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59431f57bf6so7319676e87.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Dec 2025 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766763934; x=1767368734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCuFh5XNCOf6TK0qsZOzU7NRLpcavEMRDgLiYccbL/0=;
        b=Cy4jMNg4KC4E+1p2BkYsFvNJB3+yD//Guqkwk71Fe1Tzk+d8kh6mk74EPPJZcttxYZ
         j/JNHRU1LJvm8H5ebobN2QWpOFv4EhXIRcHkaUN1WtEDY6HM8rjFnIjqaTaHbq9axICJ
         gNIo81Oa8sgkgL61Jr1ibNd+Ejtqv2flvHet9xgNVC/4EsRnTw1wHBZ7n6K7CVjTsU0z
         1oQvCm5S2f8ROvnEV1RVWzFm9Gabo2bB7uuDKoHfe5LAjEnlDBOvGfU1kWeiP3jUJNwc
         KdEoDAKOKIID7YgdbzNXLiqAyS0JMgHwrypS74UH7wLpPTs860akFWj33dXOrrQcJ8/S
         WpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766763934; x=1767368734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCuFh5XNCOf6TK0qsZOzU7NRLpcavEMRDgLiYccbL/0=;
        b=Rs/+C8vwfRtfCZbvcZQZJUwgIJ49cIt0Eo29fzu1kx7CaIv3YdaogYC8Ax4lVnBuvw
         VJtDrJB6TYkWCR0RI20ivSgDUmRv9nmp/eAlng37eeRz/sv8keNc24MT+f+tcWgMlQvk
         2WzzK8+vf1gtgbGDZ3UFGNLN/el+U3pBrkZcf0kmciJtB6tk06BZkCsfsk00NXmC8I7F
         b12JtyfG8QS9dL1J0lxVBKhBLlVSiTmt6mBiHuAMKzqjMO2jVazv/U2Q9gsJYndg7uoG
         48CF9IUHB58Ly3OWqrTEAE+lGi9fBU9XSzgioIs5Vw+4CSOhmPJNEzUQ01e/BnuCUEpS
         cRcw==
X-Forwarded-Encrypted: i=1; AJvYcCWZderuEpz5ssLKYcbfPeMbBh7V82PFoT1cn0D82GJGp99O2giDfWUHAqwZVQWICpdwQNYKWOufFPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyreB7Wob2PA4MsutX4xsgfJTRi72qOYAhWejhuge/kMFp1F77W
	HQJfQdTHiVagQeA6wD1ZrSu294Jc4Sra6USJy93PZWghBA8kk5i4Qh/i
X-Gm-Gg: AY/fxX4TsET8F4UrhEX02g5R2n+fJREQS1Ad2Bmvgb45VBZG++9DkJQGpiOJGP+E3y0
	7NT9GKgleHjwhxOQW054IM3VhslglQ0CFQHqbJbLn4YIzFdDFH3c3v4qcs9GrGBT1zC3fZucYxG
	GWuR0Io/jc+HztJVYWaEVWajZbW4bI+Hom5HGNJyDuUzap/ePQbM4yBN9QPkuWAlQGom15UZPHM
	dz0VVfSfmNt5xnTl1I6CqUE+JqU7aCeMvHUAvOq0saGFOcSiMOlsHKV671Corh+K8KUG2Npmf54
	ya7qgI4nrJp3hzbwl/8JUZkilyIVfQF18GvHVuC6PayBi/OdU/SuYfA5Swp9Sf8Mx5kK31wUIVZ
	MXKjCqNY74Cs8vP0XRAW6MRcPeiMeR/OaPvWQHE5o8xdttsUQ2nmfa0Py2LzK48nbHhDoBPXmHx
	fURULQBvOhfhLiGL7sIsbGulyo654=
X-Google-Smtp-Source: AGHT+IFJFt9lbtBZuOum2RmOHfZaMwSl9YZ98mzh/mswdFGY3IXr1/OrvP66pMdGRoye90GXXKtobw==
X-Received: by 2002:a05:6512:39ce:b0:597:d765:19f9 with SMTP id 2adb3069b0e04-59a17d057c9mr7534006e87.4.1766763933510;
        Fri, 26 Dec 2025 07:45:33 -0800 (PST)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd1e9sm6634506e87.23.2025.12.26.07.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 07:45:32 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: jic23@kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: gp2ap020a00f: Fix signedness bug in gp2ap020a00f_get_thresh_reg()
Date: Fri, 26 Dec 2025 18:45:21 +0300
Message-ID: <20251226154523.89215-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gp2ap020a00f_get_thresh_reg() returns -EINVAL on error,
but it was declared as a u8.

Change the return type to int and update callers to use int type for
the return value and properly check for negative error codes.

Fixes: 5d6a25bad035 ("iio:gp2ap020a00f: Switch to new event config interface")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/iio/light/gp2ap020a00f.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..9f2441fe8c52 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -992,7 +992,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
 					     enum iio_event_direction event_dir)
 {
 	switch (chan->type) {
@@ -1023,12 +1023,18 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
 	u8 thresh_val_id;
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = 0;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
+
+	if (thresh_reg_l < 0) {
+		err = thresh_reg_l;
+		goto error_unlock;
+	}
+
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
@@ -1080,15 +1086,15 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 				       int *val, int *val2)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
-	u8 thresh_reg_l;
+	int thresh_reg_l;
 	int err = IIO_VAL_INT;
 
 	mutex_lock(&data->lock);
 
 	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 
-	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
-		err = -EINVAL;
+	if (thresh_reg_l < 0) {
+		err = thresh_reg_l;
 		goto error_unlock;
 	}
 
-- 
2.43.0


