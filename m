Return-Path: <linux-iio+bounces-21047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBFCAEC86F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266177AA30A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C24221F3E;
	Sat, 28 Jun 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xrAHte3y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFB20D51A
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126420; cv=none; b=Aquzvy6fYKfQJ0gCKkqf9MztlgtQrOKumk/DGjGOWBaFo0ncSqHSmI2ppPAImtTdo7J2EWTTYNRO8waGJyT5/6OHll7MJtWzjcUZkYIjAJ54Fvb6N41G8UVfcnKeaFvPU7ebGG+ijIC0NfRMEWW+l/kCI33wn0qTVmnQuUIbG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126420; c=relaxed/simple;
	bh=IVJGIak5i1lqPUyqPDqlGVJI5zTZBXVeYZ74KjBQj6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pObP/+W6tduLdHS0z8RAIi750B8ljL+XQZi1sughTbbblAWl8sATlBrUz/LeK0tF5FLg4wMollrndnzwvD9neDooOR4gTJ8fLKXoU+7EdnsnrY7fW4qzbbmYYIvpoT6dBLYNJpC8yj19X0n1pMWXqZyNd8LL4cOACzGKQThhZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xrAHte3y; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73a8d0e3822so1608233a34.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751126416; x=1751731216; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyLjvDKvqspmdjT3FpklSNY0+sdEyvNzdK0N2B2mPeg=;
        b=xrAHte3yghHyDS4siaK9OdZOQC+3v2plAZJega2/FbRkKxrtkLCXxE1CEWhcLHEe7j
         ab8WhiGu416lGzdBFxzGLHXJ/pD5O3pKOyuVdge1sxfwGpuzUezHx7weB7u3h2UZ5d6j
         l7q0L+csy+M7WiIz3w5a6LfPpn3t1900ebkp5vqE6CVM/0/ojyniIV5ro9x8SFNX0Fqs
         wbeqZxHR3pe/eZEjSuAA/4h/Y7ocdQXzDk0aM9Xk77CubcG+g6+R5YCHIoGr9Pf5wCsN
         JTaedSs2UpWr9pbPklaqncPGBstuV3j2ybuql4kWZYdPeEPxjyYHIsza285GDpauvGcg
         TtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751126416; x=1751731216;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyLjvDKvqspmdjT3FpklSNY0+sdEyvNzdK0N2B2mPeg=;
        b=rtILWmmy6EpjKaKphf5PBQf+Ou89ehiR/F8buVsQGmfFTk/CF+tPL7abA4Sk1ZD10I
         lRKOpAZRJ/h4FlWCVw3ShNx6eUbkzLJ19TDEDvdGyp4sAtp60gLkTYtvkakNzF1vxYPN
         eERaSGsI8J2XrtWbN4iAK5pBqJUjHO50mb1TrYG9FvI36zGbdqU/JdbRP2+QsB5EuJS5
         pSMG6bE/qzLwi3CxQmQnAjurnhZqKdtIm4pPlArwBVP0Vo0DG0MIkUGrAnEdcTHnsB0m
         WVj2naoBh/EQXg1r3ykgYaclTiDuXm2DR/X9jc2A3CJj4JbF4m06c04rXLhh9U4Lt0v1
         C8OQ==
X-Gm-Message-State: AOJu0YyrCt8sqZ4Bo9F0cFVsJKWXmEtk363Qu3ZQdXQWzYfJLbXxzS6W
	4pBL29CPbQjNLjV6pj/+sHtp/eCrSNmX6rGR85Vkfm7Xi4VXS/vZN5VNhjEONlNfDqNvasVJWgf
	mkNZ9+sQ=
X-Gm-Gg: ASbGncsZqXFrwX0uEvcmlLluaBT3gwQPLea5cPbP70eentsZMgTghgct3EmvoXPn6uc
	jSHbqO/mKTwyPsv8PWGEd/xsNbw8JlJzu/f6eMoFQKiExVNpW/4/0n4n2fpZUjEv7kkmQCnbmyS
	DUNF89sFTa6fnD+R3ev6ovXj4SbuhYjCfY/XcHve8ApkWxgAGfSGpEs+fo8V9lK77a8NWi74ISG
	P/mnu6F739Y7tvP1Pn5iZv76YCyJ/xlmOL56rKmJnvYHRpHsyWXzcdUKfSC24XbCRQSXqP8rlwO
	DueovrPknduEOHjj7i93zgjtfl4KEpTNIOWIibF6iTp0ZGHY0APuDlszuUjQ/7thFZkb
X-Google-Smtp-Source: AGHT+IGCQ29Ecqwd6tMQskL/FRmQkOakxzutOmMQV0OJAEWQqc6XI0yI6ppVmkAzyhHD6J33g8MgQg==
X-Received: by 2002:a05:6830:8104:b0:72b:7a29:d680 with SMTP id 46e09a7af769-73afc5db063mr4086697a34.10.1751126416505;
        Sat, 28 Jun 2025 09:00:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb10091esm847348a34.46.2025.06.28.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:00:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 11:00:07 -0500
Subject: [PATCH] iio: accel: mma9553: make mma9553_event_info const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-2-v1-1-a61da3a0941e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAIYRYGgC/x3MPQqAMAxA4atIZgMaUItXEYf+pJqllbaIULy7x
 fEb3quQOQlnWLsKiW/JEkPD2HdgTx0ORnHNQANNw0wKRSLaGHJBp4tGwsWR9sbw4pWCll2JvTz
 /ctvf9wPc001YYgAAAA==
X-Change-ID: 20250628-iio-const-data-2-7d2afbbe7f88
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=IVJGIak5i1lqPUyqPDqlGVJI5zTZBXVeYZ74KjBQj6s=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDISBNubBC9H31+ozZLN4r5sxuTyXYaym25ME9R6s+SKe
 lhsZuPVTkZjFgZGLgZZMUWWNxI35yXxNV+bcyNjBswgViaQKQxcnAIwkRgB9r/SbR1GVZFnY+93
 5k7ZVq6gJLXqVVPVB6+fdu+Xb3dSPJeRv2WnXKDJc+cOrbgtccLtGVYZPJcnN+oYzF0lWrK1gkP
 ZubBCOMB/rVTU5YYrnBoBTheaX6i3XOpUehIcbv9D4Y3Fa6VnxsJpLxavFfTuYRZ9+f3gwXfpWz
 58F46drn0myrInMOLo2aDnpr1eOWJi5kreE64VBDFV+t1Z4W6QeV9v9ZkWocOPTOZOcrIz2uxkk
 L6AcU/fYtNsn4+z+Bp/rJ34/JHR0ktq/Gl7D5z3yrZOWMpn8dXmaN1qgfuVzjN/iTYo1vIZK4Yt
 VO/alLxY9LTYrB87Ngr8+i92rj/KoFu9RfGT5NGv/gaeAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct mma9553_event_info mma9553_event_info[].
This is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/mma9553.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index ffb0d6ff37124e5f364168c5c4f348a02d28842a..f85384a7908f253f9ed55dae4e0a41a39ae6016b 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -97,7 +97,7 @@ enum activity_level {
 	ACTIVITY_RUNNING,
 };
 
-static struct mma9553_event_info {
+static const struct mma9553_event_info {
 	enum iio_chan_type type;
 	enum iio_modifier mod;
 	enum iio_event_direction dir;
@@ -152,7 +152,7 @@ static struct mma9553_event_info {
 #define MMA9553_EVENTS_INFO_SIZE ARRAY_SIZE(mma9553_events_info)
 
 struct mma9553_event {
-	struct mma9553_event_info *info;
+	const struct mma9553_event_info *info;
 	bool enabled;
 };
 

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-2-7d2afbbe7f88

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


