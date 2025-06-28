Return-Path: <linux-iio+bounces-21086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F5AEC9B4
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 20:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471DF189790E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6098B24E01D;
	Sat, 28 Jun 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0OX1+OIZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259F1E04AC
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751135052; cv=none; b=L1q2XlSbyK9NSn0nYfO0B70pqj08My+5oLgmUczTJKFhC6E8eRskXUk39mdVmkS6JNC7x6FHhZ2s0LeCPhHtAn14jqhHfKWL+/hS+JrPuizxCIJMIUW2QRar5UJR/Y7EkdT088aes1eWlC7RR8whNtkdUsSLUrtkqCDeYyOqM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751135052; c=relaxed/simple;
	bh=gOpaFFvBcVRFK1v2PGxkijtRj5a265XWkJQRwynhLR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XTA7cE/2s7s/JJufIx9GQNtQr7TuerlRmqchMcGdpfw+NSjU849EzS2PL5xSfpFLeXoTThVEoTAy69PjYWObK5AmgBHCT8gdL8CUPimjpYHwmuelr2xET+mUGd31lOOXg6MUM0RkENedBGl9yqdjwUdyCyKMjcbJTCMiCmYMCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0OX1+OIZ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73afbe1497bso875785a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751135049; x=1751739849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1s9sMYij456vvbKT0E358QK5dyjHY+/6micxnPVYVY=;
        b=0OX1+OIZr+cI4tsjQoyb1KM7x9MpgPuze1PcgiMNlLeygWp63nDapqIRRmwMRNGvN/
         89E20NkJppjw5SZyjCe47GySZl6kYuEgVSgh/ImW6ij+jwCYtoJ1RsEmAGTjBt7RHlm1
         N92zPUDgPm8wsQBU6kEu0ewcVzE7LWvyl0PwNe4N07/R9nyI2B0vwmaQXyyqurpayWfK
         pRPzdX1fivdl+PbNfaXuc9/+SWq9QHgluSBWbKTMFuKm6sH52/Xl1l9OMTa6EiQARMev
         uDCCNsS8Yl927/mdISoXYbndD3G2JrV8ls5N7lfCRERm76RJSa9ksCGjyR/5KUiudExi
         51Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751135049; x=1751739849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1s9sMYij456vvbKT0E358QK5dyjHY+/6micxnPVYVY=;
        b=HEgxE/FAeROeTxJ603U7Deexzie23o45LPa2fVaaGnqCCmhzeZXCkkHYSb/0HXmfqU
         DtE1bR66TZ0O6EM3kYheglgOB/TOQgYlR1XvgJC8qyFKLRe8ZNFPbSM0rs0rJJIzOgag
         MFlrtztIcYizXnlB5jXxpCJF6q3c0TXvvotvFGCz+WUhqopNt+fwNtXNCFD5PwqQubEi
         zEGTbHxcj3DA36CDUMzg3HXh3hLswQe/ioPEmVO1wz5Ma0+3BhA30lZ+1W8eNAvBFncP
         4rnE5my3ilsNhaq9eGry4QT1nDqTt9rdEORE24RAsHrrXs0q3xEYBtF7DUFqOx5ivjQ8
         OiQg==
X-Gm-Message-State: AOJu0Yy+xFt+NUrdBgBC/3n1F6XlEZtjuTN6IjDARuxUQCdm974hprku
	l5JgMIiML/tdVxR0DzdzE8ipxO4jVPlBIm6d/jAzqg4dQCUTz0QmMTkrrJm/rXLgPKLH6n9G33C
	gknL2hzs=
X-Gm-Gg: ASbGncsyT003XpyYwRfokOmagDbjLx5Rm1dhDZJwKi2iwqrci/j0WLsLUQjNEEF+eJH
	gWfwhNnYWRouF7TcUnR+X1kL2/m0RgLqJHI23x5d/5vovvBZYiBWjv+XCCluM+X8XOvi6HZQ0m2
	DsvORSHOwh9S666qcwzMIL1ZUjWJDQ6g9yOTLraeCJsOQFYSBey58Zt3PKGM+PtVzmy5pzvxnVw
	2kQt2U64x+5Opk8/ZBP9U5vdhkZMVkc9QDZArhu8Ow81p31zqgYB7L1NRljwFueJhmhTZRIiPT/
	h/Nf6/DGGqkyR2XN1AtspdUvIw2cM7gGZde5KbqoVGEVkawhRTeonRDizhBtt3MxuKDd
X-Google-Smtp-Source: AGHT+IH5OYz4SKEt3ZBcOmmb9hP2yDRcYRG22h14b6ieh2r1YBWcyczxB4Ki7xB3SIcrrPidDfb3Fg==
X-Received: by 2002:a05:6830:6111:b0:73a:9158:fb7e with SMTP id 46e09a7af769-73afc6b9358mr5829357a34.25.1751135049355;
        Sat, 28 Jun 2025 11:24:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afafee682sm902248a34.1.2025.06.28.11.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 11:24:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: proximity: vcnl3020: make vcnl3020_property const
Date: Sat, 28 Jun 2025 13:23:47 -0500
Message-Id: <20250628-iio-const-data-25-v1-0-5d99cf17790e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQzYGgC/x3MQQqAIBBA0avIrBuwKaO6SrQwnWo2GhoRRHdPW
 r7F/w9kTsIZRvVA4kuyxFBQVwrcbsPGKL4YSJPRHfUoEtHFkE/09rRIBltDPLSmr5tmgdIdiVe
 5/+c0v+8HpAmQr2MAAAA=
X-Change-ID: 20250628-iio-const-data-25-452e9458133b
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=665; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=gOpaFFvBcVRFK1v2PGxkijtRj5a265XWkJQRwynhLR4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYDM1uyUQKI0+xWGenKc2Eh1OJQY5nLOq6nHdD
 Jm8y9n9eCmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAzNQAKCRDCzCAB/wGP
 wLqXB/46MakgXfPNFbFgpa0BjxaBu7efCBS0VQWU13WBIBCayUW+x78cwcOOmqsttmDVJPenr1m
 tucl7wAfd30MbQFOJDmhxfAiokuUF0w8+P0VRvQ2PT5SY/q0rudFGWkipteDt9JmghZwxQ0dOUq
 S7PYNhGr2IZjpHxPEe7keXtLj22uspjKEeUmKuB8fwZGM3M6ammhZomES+xNGj4ANh/tM1C22XK
 WXNOkpt+OEsOMPPvT0/rPERF8xiQyWStBYTXUhwNXKCoG1tVNFXOpRYE/EgNzEzEF/l+tPxmXkR
 FX0lm9kdW1h2MT7fYwSa/iugQEJ+cQGbTwDymktuBHfHnXqW
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

We can make const struct vcnl3020_property vcnl3020_led_current_property
const since it is read-only data. For this to really be useful, we also
have another change to pass this struct by pointer instead of by value.

---
David Lechner (2):
      iio: proximity: vcnl3020: pass struct vcnl3020_property by pointer
      iio: proximity: vcnl3020: make vcnl3020_property const

 drivers/iio/proximity/vcnl3020.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-25-452e9458133b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


