Return-Path: <linux-iio+bounces-21083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E6AEC997
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 20:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D356A7A8AB7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE01F542A;
	Sat, 28 Jun 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RshAk85S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47331A239F
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751133635; cv=none; b=KBiLTTovnOF4upENDqNtH26Y8uehokKwJwFaCUkrJsgfnK6mLQYVGnq8vyASKyKsatwqQWQksE+OBLBZJy2Y6bewsamAiogRaNslXFgYxGKTooG0hcqzVH/dolnFZrApUCi2mHN4xdJTcXp56ia4B9CoYLSW2L0sUNZ16joDkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751133635; c=relaxed/simple;
	bh=Wpd4062Hg4zs8I/RrWFr4ghaFslVhjOJfaz/6/aD9RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NndcCo9Xfy23Zz9/8M1jfEXnitk/GWJS8ADSO3U/mVkW3sz9KmqP9vHdBAWXv2FidhuDgpIHnSHvMGcxCsRZFgoOiY2XD76E2B3lsTQDlZjBzKpyaNLHP73SGXRNHw8clegmHtEaM1af1byrdGJhveeQM6RR2odQFEt5WSe/9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RshAk85S; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60f24b478e3so458994eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751133633; x=1751738433; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWkzZlNmYBpQdzkeKGqAYEk53GZizX7PxwwGKL+egU8=;
        b=RshAk85SagWUKXBebRzW9fKKTggl1DYSPtYZfe14dt8e3PwhF/lSqP90KbUhSIS6Dh
         Gmn/ERyUFfivaWPrwUIgUWXBeSSSzrpNFeKJMSsBvNlKpchwxDwoYQD92dj3gEefRkob
         JJza19Qp4qnGZ4gcTU0VD03zhfvo1XZdHorzltg/OMphalrSoLbD1a/Z4gT3UKS60R1N
         XdWWbj243nZJtvYOcx0Mj6nLLz3yeBUZPvryfs7sJRzzE1L3/MFJQR30EPPwkHIdstCp
         Q45UDe+iL5gFCtxVgvnMKJI8L9ZMegqB5Gv0FcthB38ZuDn0ErRVP4l9a1csY91TGr2g
         d7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751133633; x=1751738433;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWkzZlNmYBpQdzkeKGqAYEk53GZizX7PxwwGKL+egU8=;
        b=g8jYsGfc5TDeXW8TSjpoR/FufUuy6dLbZpYbPv86DM2LrsiuWGrM+Y8cdpQVY6qrdL
         KsmSs/mEvDnPMxE0c2+X92RO3JRjGsUfVPLpxPJEP/OdFF8LvBRCA77TcZcxO81sDeEx
         R8YapNAQN1q09IjFGDN/6U5oIdI1yQ9T5vuuuajbt/AtOqWjyHTSgQ57VFHuk8GLPlVV
         4V9yQD/KJ9XbNr8wQH1zX2oAtWNT1F1DbKc4LvRu8pZhMNTpTwnzz4uPHPttHdw998PG
         P3/WPIyWpXgMDxNuB8cie1sy7gaEctEXaLU/gghgpVZpvsko6BcDjRWUYQkWg8tbKpR9
         57fg==
X-Gm-Message-State: AOJu0YwrPX9IArdJoWYPb128wLyrisv+yPQs411QSmyBTVxmEiBQ8u3b
	zxEke+9XwcX79LcS/7AEKMgAGSiaXjmItm7PABPFaRZyKrXd6lUXENT6PhmuBo9AUDw=
X-Gm-Gg: ASbGncuhou264UYifpvC/b4C3ncjwVacOsi3Dj2MBUfwIuPWlP2ZmR4zaXm3zZk2ocw
	CUt4duCyFdG8hbo1VF1ZQ9tXJu59/6OjFupHVQqvFHzDEa3xnrDF3ydo0alP+FTOUlPa2NP9JEw
	s4l8q75Lm7Avg+4aq4Dtkc+CvIuzUxUhtjm4xn93SUOW1Q+kpzotMONY1aLd8yHeQz67VsF6F5n
	QCwDahgvE4fwW1B80qm8k7zfcdZIhLyP4kdXoEuBrr+h7AxwoL+TlhfiId85yvAz9AnG3im6jxq
	HcvXZL/FH6d54veNqabWpneFZ+vAXO4lhP5DNRhseQpWdZhq3qZQW/OSeqpAqHeUeDP2
X-Google-Smtp-Source: AGHT+IHeIbhJ0VPsfz11jfIB5EOVE52kX4SaHdgM3QHa2Q2CssMf5SeFCoEo/FbLnt8TxnhDGw3Fkg==
X-Received: by 2002:a4a:ee17:0:b0:611:b073:7c31 with SMTP id 006d021491bc7-611b9174eb9mr4656001eaf.8.1751133632662;
        Sat, 28 Jun 2025 11:00:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afafee2c0sm901159a34.9.2025.06.28.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 11:00:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 13:00:23 -0500
Subject: [PATCH] iio: pressure: dlhl60d: make dlh_info_tbl const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-24-v1-1-353b97281534@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALYtYGgC/x3MPQqAMAxA4atIZgMa/CleRRxim2qWVloRQby7x
 fEb3nsgS1LJMFUPJLk0awwFbV2B3TlsguqKgRrqm4EMqka0MeQTHZ+M1GHHVgyxGVfvoHRHEq/
 3/5yX9/0Ah7859WMAAAA=
X-Change-ID: 20250628-iio-const-data-24-4ace82a87bfd
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Wpd4062Hg4zs8I/RrWFr4ghaFslVhjOJfaz/6/aD9RQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYC25C4ncZ9vs5sMtS+5XdGYUbbbz4B6fiWbZD
 fA4wL2gFEeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAtuQAKCRDCzCAB/wGP
 wKXTB/sFWxRKm1a4jF2//AQJMypr/dtiYhWX6ocVKuzfWqntCa2BBFTFG/4V1tcQ1LiARtcw+uZ
 FH5uuR5GZeOxb4iP54xhk6xSk4+QCvjD5dkK+9ZDS34OXXxuDF5pdxp0Fsgzs8/OdI9pBJqybGB
 X0MJtokqvsTSJE3Kf3/Y6a4+s3I6cCDIRFZE5gzARqW7PemwbCB3KEZEtNZQq3DtgoyjnYFaD5u
 k97OjESHgB4AlsxJuGylzYR4g2Iok9DG286AQQmVd7gprzxZqtEVzaeSLzFRkr20+9ho8NVXEwg
 CaG950y/vo+g8+iao1gsXGpt/IwLsK1g/KoPFDDKpTb92s6K
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct dlh_info dlh_info_tbl[]. This is
read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/dlhl60d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 48afe5c94000b44eb324d7631f3c0db8e3d0079e..1c39b873cecb24c6273720852bb13cf5ce15e518 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -50,7 +50,7 @@ struct dlh_state {
 	u8 rx_buf[DLH_NUM_READ_BYTES];
 };
 
-static struct dlh_info dlh_info_tbl[] = {
+static const struct dlh_info dlh_info_tbl[] = {
 	[dlhl60d] = {
 		.osdig = 2,
 		.fss = 120,

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-24-4ace82a87bfd

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


