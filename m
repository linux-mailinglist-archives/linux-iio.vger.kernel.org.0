Return-Path: <linux-iio+bounces-24794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87BBC048F
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 07:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D9C3C6324
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 05:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4C23BCF7;
	Tue,  7 Oct 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NymTIX3z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBBC233136
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816552; cv=none; b=XqoDzFU/qZ8ArQAthAKwAciRH2q0qiwTFmCqJVsKJnnNBfeJ2I9oKq13NKxcV7k56NdsPnFD0nmrLRBEFApXXY0p7c3V2cxw36AyfaC/i/pkSmJst1Rua3gdCUehd6vGT97npMYMJ4NP8AzELQsJ22mYLsbHAa0JdtDekbuGrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816552; c=relaxed/simple;
	bh=Coxv9LkBZ+56ZqgTTagylAjun+Rfk90LFEZcv328N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0ixwBOZR+rlkA9hD/9zEBOGL2JHLNDN0oMMxfA5zRYi/1nTMtY8tMXcysRiMfphA5lJ3JdGGPGkQ5PQL7MmV89XblfpP4OYWHogJE2qNhpPbIFH9EGN6QCNI68Fkano+QfVo+9NzrMHWi2SaupyPVraEbjGFQyXLkM0ev5C0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NymTIX3z; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso4908094a91.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816550; x=1760421350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQsI6ooSHKXCcKpweqSzinWozKmIkvvbAPQL3qXw8Wo=;
        b=NymTIX3zD0fNRDQHo6ItemKgH+0Y0tYA4jAC4jCYJcWUWKbfTlfm1yo9OkDtEWFBjx
         XJCCbcd58iwKAtFzcH8lJO1+rWNGZmaXjOScSxkzdZr/I8nluXvTKIS5ABSQ173q6ul9
         2nM7EcJzuWZfgugkOeBSVO/AzP8zLAlTKwOw7DrmIz1L6706vJtC3rj35jCc6G87y/e5
         3d8YYbpE1jCxSLmrDOZuwZv01WObPJCyThGVOqqOiirGA4RlAM4x/Z4O9SXRxrR2WZDT
         IavmOnA8HjGG90LvXHmng2EPnWHOzZxeRLSRBWLsSzz3i7y5K7euXnVrl0nWr3uj6EPG
         PArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816550; x=1760421350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQsI6ooSHKXCcKpweqSzinWozKmIkvvbAPQL3qXw8Wo=;
        b=EFfHk5U8YATZfc+0PIP/pVwKa2iViqaFicpUXuBKjm9pLrJSWk/KPFZyIkn5awot8s
         5xv0zCj1CwnKFQ7GsUxbMcydHEhLxh2809hxjompLfRGLqMNXSeK3GoJ3u9eqUTFQMS7
         lhUZ9YRokPlLp/qHPueptXCTouQVXQN/HjBnB31WnGMgsxYBKeWhDGoky1xFFA/y1HVp
         t00ec9dlv/tVa6we4iNx/vG9aW5hFAa5A444UzqIwj8Ab0bp6/tKk+6YFFfr3jTWUdUv
         iJoWDgrI0wSIUtE2hMqx+UtithitogY4Vije+qzFflSoDifT1ursK2rk4s/yuPCt8Y3t
         7LLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX33vNOSN6YHACuRMo0O2ZyosuO0QP2iK4b8ycTdiTPPkZ9x2DxJh8Ex9OQsDxN8SUYj1A+PVlj0oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmiHUpM1QseXGKqYdu55ny+WMcMaBAiK976PJj+oiFaQG2u+V
	EtHGCK3lwUl0PfPAZI6GzP/jGjUi3yCfIq4N+IeGyt1PRnU4re6wm8FM
X-Gm-Gg: ASbGncsDz7jxvQgu7C9EMA65oV8fnI/uHdxA0l0rBmlB8Rs1IJOdI2v8PDb63EETeZw
	Y8erhokdlJXlPMhbXp6h7JnHpIelEY4irQBr3LWub3nc14iPo2jCyKiHUE5LmJlc0+CGS+8NkPw
	HV2cPElR73GIIDQ/BQHld6qDo97OoE527+H642lUYq49tFI2TyDMNW+nIqhNpS15sZ4cdbXXdZ3
	tF+1xg7YoMuOhvxqgCPVtWzcBj+4vq/ZfM2RUfUTGD45IHxNV9f8h7pkSQZvGZThE6uoExFXhcY
	p0yH4f+GXquBOw4s+t29LJHAhcoq1uuWtqJwlApgfr1UDp8shfH7iKj02x+Eb2Jxf6vjwpuV6r4
	35udxeGJZZz1lSgYrXQLxQvt3VwPzxvDV+eA8+IeHZ0ZqfkqvyjZnmMNm
X-Google-Smtp-Source: AGHT+IHsJvBTZEKlMhO1eJwhW9FQ6KIKqanMRbgrxxnbVroNK28u90EbOtkZsfIwow+uPANEcbt0jg==
X-Received: by 2002:a17:90b:4f48:b0:330:4604:3ae8 with SMTP id 98e67ed59e1d1-339c2786737mr16896516a91.21.1759816549427;
        Mon, 06 Oct 2025 22:55:49 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:48 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] iio: accel: bma400: Rename activity_event_en() to generic_event_en()
Date: Tue,  7 Oct 2025 11:25:05 +0530
Message-ID: <20251007055511.108984-6-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function activity_event_en() configures the generic interrupts
GEN1 and GEN2, which are used for activity and inactivity detection
as per the datasheet. The existing name is misleading, since the
device also provides activity change and activity recognition
interrupts. Activity change interrupt is not supported yet whereas
Activity recognition interrupt is configured in a different function.

Rename activity_event_en() to generic_event_en() to better reflect its
actual purpose.

No functional changes intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 665c8df93008..1900965a1048 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1190,9 +1190,9 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
 	return 0;
 }
 
-static int bma400_activity_event_en(struct bma400_data *data,
-				    enum iio_event_direction dir,
-				    int state)
+static int bma400_generic_event_en(struct bma400_data *data,
+				   enum iio_event_direction dir,
+				   int state)
 {
 	int ret;
 	unsigned int intrmask, regval;
@@ -1337,7 +1337,7 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 		switch (type) {
 		case IIO_EV_TYPE_MAG:
 			mutex_lock(&data->mutex);
-			ret = bma400_activity_event_en(data, dir, state);
+			ret = bma400_generic_event_en(data, dir, state);
 			mutex_unlock(&data->mutex);
 			return ret;
 		case IIO_EV_TYPE_GESTURE:
-- 
2.43.0


