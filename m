Return-Path: <linux-iio+bounces-24022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5330BB5546F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579EBAA8212
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4431690A;
	Fri, 12 Sep 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YNmnI7SX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C83101AE
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693216; cv=none; b=edVo2Cvhx2n4VOMKMCsvAa6EI2HNJGW0vdy6lwNejEL7jG+bWnsUmmQQ+xbxU3U5ipTmHQGLUTq1q7eYZ/PSHKZUWt82OeiSI1RNq/NntGias48NEUDRZlAX6tOZyHevpvcmKyr12DnyLMJo83rJaX8+fdg1OWJgtrbJ6YKxW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693216; c=relaxed/simple;
	bh=HnuQ+TkaU2snLpnK9vKwpR+SRQ6mSUlBuodkaXdQJ0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SaZPaxJ5UVPFUL65B91KUXg/M+/pq/Q87r6gihZIrHZ1H2gtC3aNq+Xn5681K6hElLLiVXeIS87wXdOeH651yArGEVo19gXc4L+qj0UqCOito5Tx8YnA4bbcl11agJb3mKQPSUufgXmhqTQrX4Zm5VmT34DKKON1VjLJvRvl60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YNmnI7SX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-439aeec33e1so1553303b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693214; x=1758298014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVWBEP36MuutXOJ2sHz8OS+ojTXGpyXc0pw+qLA/60g=;
        b=YNmnI7SXGzNKvi/ISkAv+RSVIhDoc68SfTmzdwDYPF9us960C8IwLuHvcnYSsICB20
         lxX/L9NstrOepo1Tz+aAcoVwW1uvGlp38eEYDcahKfEo6J4wo4WiLa68tfLnOWJZ8FJA
         LRgBvTYuzonlXzDw8+T51uwi8/3mD2NMXaEtaYRmtpL1kCvY5Bz7v2IdQ2i+CpbW4GWW
         IAembYlP9mcYTVyTgL132eG7EHNe+u5Iaw+JrpxzKMpF/ev+IhhYcKMOD/hClttUxjdZ
         bnvCPMjoczIWLBUAXjgL0+iBjdyb4V4VXexoY1xhrDejV80vSeEmsO79gQ8FEwIafcip
         c1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693214; x=1758298014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVWBEP36MuutXOJ2sHz8OS+ojTXGpyXc0pw+qLA/60g=;
        b=D+8Vuz+EhxAlq5iGbldYN/9wike41g2Btz0SzZnaEiDpXHcRIgBwoJZsaRnpQVpVJZ
         CUxteXdVDXf8plneY7zlppO+hUUC4jb18BcEDIuTuvsyXdK5O0hjqiNQcPLKTBU8O0i4
         Por3WkjnMcNXIYSncPpEIS+/YL9lCfduHdr0YosIbq7LsF4ft/uq967Lq23yVyfbKzj7
         FSiRda1sMjKStec+aQQrR3+PipivEy1aL1hEfBihnH4OOaEbHqXIl4Gw6qSrA+U8EB+M
         5yj3QiV1J95Y/WUZ+8WdiKUUeoGsZU9OyLolmG6N5FFyx20Okqlz+r4JS8Yew+g0WeE1
         zPpw==
X-Gm-Message-State: AOJu0YwxCKq8NbsmnMsHwUNKXL0wG1AspD0Sb2dffsxk9tQVmwmoELZ2
	HRvPNuUC8yuganTyPi7khloUfAGwuAVQR1sa4Pun5d//z/xtEQfIGnsJ/aoPLMvU+nDHHr4u0yT
	9UKbopOU=
X-Gm-Gg: ASbGncuirO6I3lLnvKdchQYvC+N0DkcTQuv68cfPg/r6vQNBk/a/tinGRrkG3T9G8fN
	uQPctZLEWsizIco5bpOKFtUiw2dr1nZR68gsaUcmQ6MJ8DdIyUxSgkt2Dw+RWvYS2QJAfHpJ+Du
	GzEJsuFIgRm5biEn8E8P5l+XmDYxefCnqFkT3KE7Zy/ADpqkY6SjBFMeW6WEXuM828dpI6ucchr
	npriZszNdaOjyADzfuoIMIoc1PEwCzeu4/X0np8RtNIMcHVBXA64rgX1FuhUt099Ja0hor28Tzw
	VOT9I9lhRJIKgWh8t7hgmJgI7VWe0Xe2URlAjLXgZrR5Hv6zcf8899HpiMSt5VTcgBfarBap1LO
	muFtk2hZfNN4ha5jhTEBWdg/ZxL5/
X-Google-Smtp-Source: AGHT+IGeM+CYMUpEcZ24r4ZKd4sVaJiF4l6pF+Y+dXMOaA4zkK9SGuAO6TPmM+gZCQqUURx0Ga/Syw==
X-Received: by 2002:a05:6830:608c:b0:745:9769:ea51 with SMTP id 46e09a7af769-7535b3535b6mr2051528a34.9.1757693213913;
        Fri, 12 Sep 2025 09:06:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:52 -0500
Subject: [PATCH 1/7] iio: buffer: document
 iio_push_to_buffers_with_ts_unaligned() may sleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-1-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HnuQ+TkaU2snLpnK9vKwpR+SRQ6mSUlBuodkaXdQJ0s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxETp+6md8mJWssX1SSdWOWoeoKGUIt3kiNN1W
 WRFFP+wto2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE6QAKCRDCzCAB/wGP
 wHQDCACCdxTb4qkaDzQzvAtqHBw7OqjnneQI+T8fuZqQSpGhl65KizDftuHhsHk6RWLBKe7AGdR
 av5/QYyoAc4HP/736f0X061nBrCjaIAt01UemyzbgxfSBIwJi1IuyF2IIkhcHhcBEfLFceq6t3K
 1HVjSIHECRdldlpsYdtsjFBLlmGC3Ljtaz09ePNfpYB/jVYt+bfhwPx1/lmQKUWOQcJKXCgyZZ6
 j0c62LNUvokHnaojUkGIOqNPsqz6EkHk1GGJJHwIjCsiDW9T4q41j1ktlsONwEACNRLq9T9WZaQ
 zRAJ4l/LRxDZxsmg55rnFbprvUfkRe+dqUcRJ5xwXPA7kSpO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add Context: documentation comment that
iio_push_to_buffers_with_ts_unaligned() may sleep because it calls
devm_krealloc().

Also document Return: value while here.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a80f7cc25a27109cfe22ce447c4117fc94bc8310..7da43a1f2f75f32dc93b9a5fe903378a79e82fe3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2401,6 +2401,9 @@ EXPORT_SYMBOL_GPL(iio_push_to_buffers);
  * not require space for the timestamp, or 8 byte alignment of data.
  * It does however require an allocation on first call and additional
  * copies on all calls, so should be avoided if possible.
+ *
+ * Context: May sleep.
+ * Return: 0 on success, negative error code on failure.
  */
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data,

-- 
2.43.0


