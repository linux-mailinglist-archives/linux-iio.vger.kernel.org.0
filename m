Return-Path: <linux-iio+bounces-25604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF4C1710F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 22:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8B915088BC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 21:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727D2E0904;
	Tue, 28 Oct 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcywpJ5w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A52E03EA
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687269; cv=none; b=ZnuLIYrVEUvJ6gBAnPCMa6sULR8mQozTrH68idrAZSgIAWBe8amiBo5gx5ZEieqyK8xi1DWEDRnZXH7o4F5jGcDckLsZ4NoGX8hF5MRph2M2Q4ralXfmwvlbKwsnPMIV1xqbjb0OnOnZfrfGgD9vz2TB58nJ60G9WEie/Z/Yd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687269; c=relaxed/simple;
	bh=fSoDX+QWdkPQKwwwC25/FSkyezQzT4MNTwKjc3pdxOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFY5jEaEPGGsBeZCKYv7okkNjqyue6TeE1/1r8EtTfI43SF+z/dNq5Ua0QqW6b/M5g9wNSykf8iOubZ119S9dDoGoxj/W/R6EcrtZKtPBR/yMKzPJRw6RBlgHhkZjqDx+0eQCSNHJBBRF5wYYy/YVJJNp9/+lnR19L/iv02Llok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcywpJ5w; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1227918966b.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687266; x=1762292066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNeIjx3lptZuujiNnKEUW6K0BzRaMu+x9cOk++i6hWg=;
        b=fcywpJ5wXoMtU8PUiShTJD4vfSAozVSZBWRwUTL0+gYY8DDpJz4AX+91GD8QRJehu9
         YJxmEbk2KreTjZGfZGNjJFa60SHOwjMeABUR6AbieEJokvkG5yzGoane0nrh92BMo0L6
         afWvxu4oQWH1uPSQNnC8azEFtN0eZip6RHryPBEZ8ubLgglUAmqLRtOHt10+Dj+8EQZA
         3Yc5qv3+k/tjQqlJXfXerM18HOl1SF0s4xE/2Q+gqvRk2597a7MeIMoIN5dEa5wg292S
         PEqfuhw8y+6/1TutfEC5caJTf0bZ2gyMLY3pFY2gtahrNeG4o2E1HVeIAmAYEeIbc3Hc
         n8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687266; x=1762292066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNeIjx3lptZuujiNnKEUW6K0BzRaMu+x9cOk++i6hWg=;
        b=O5lmwRxFDCgNg2jQBRFlDoCXZGSeLxRhR1hEcYlUFtgfIuxgKNFK8jiq31SeaxA/vq
         w9rGVoBQvxG8pMMLYc5MYJzcIRmh06tqm8fOyqaV3/lCLvKr8ZwjJPhKpnkvOXrN7r8R
         78BI+0xA1GNgvF3Yk25nbpKXBuoAJzOrYGNxt0SzmUh4xywdnw/p420G5kyDmiLeM1Sc
         j8uMPNMoJLzvY/cs2ofXGu4TVyYsjwDMULG2oWWrRMyRnx81e32eEaa82SlBkXlayXya
         YNC1zqMIAv6Lwfds633JFSHM4NKK4HU5XuY+qlXhZvdc8FbLM59P2hT5TrBcUXz/1Gu3
         14JQ==
X-Gm-Message-State: AOJu0YzespoRtKGq8pgV6Gx6jdXrszv0HZ1wltN4BzDiBZ//9GkXahKl
	/WzYgwSp/47AzboUYjR2aaWiqThyahAzXa4zHWB1zdQe4IEU9i0EuB/T
X-Gm-Gg: ASbGnctSEZ3BmHpKYf0eI6h3cT7/5u/fTN3WzSR0sA09V5AgIqwQOPF4MRcm4KyxkAR
	uP1WYQoTXMPxGfWeZxJPRcf6nwf4wHrUTkPiip3SS7oskkze1D/alEX+FgGO7zdlS3zwZ8R9IZ8
	gCtgP0Uj7RiBt6hEZbEWgcGwIdxLa/7FtzjHh9h2nYlVMH4NS6na38MupCQHc8Tq1ATKWPkB5Gt
	OjvKFNUho8dRRxVPvT/InaBYQpHK0lyrvRGpRbnyNYAM6DbG0lz9fwTngu0r4Lb4tz0zfw3hMoF
	5YIDuTZrVPvOcO18/Ehg6doXn7sKtLw/x7dJ0f9YzODCL8imNDFa4/2VA+bm9PaIVcBW+aiwZR+
	iThSsBmnAdDd10m3XsTG9EW2ayNgJemRDUacESqUKlcseotNXIPWRl3RozP8osnEk4HTnUrha2I
	mF07WgFigtZkecniS24BSYhE7Eyw==
X-Google-Smtp-Source: AGHT+IEyYqq65Dt6k7rhFlOuIQ7JykxsGjnM09MaiEHl+ci+PgMQWD+VL54JqHbfcGxpMotOd4fWEg==
X-Received: by 2002:a17:907:7253:b0:b6d:2c70:4542 with SMTP id a640c23a62f3a-b703d4f7dfemr44439766b.30.1761687265578;
        Tue, 28 Oct 2025 14:34:25 -0700 (PDT)
Received: from localhost.localdomain ([37.161.59.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6db9b86c80sm451303666b.43.2025.10.28.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:34:25 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 1/2] iio: mpl3115: add ctrl_reg4 to mpl3115_data
Date: Tue, 28 Oct 2025 22:33:51 +0100
Message-Id: <20251028213351.77368-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251028213351.77368-1-apokusinski01@gmail.com>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache the value of CTRL_REG4 in the mpl3115_data structure. This is a
preparation for adding support for the threshold events.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index c212dfdf59ff..4cc103e20a39 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -83,6 +83,7 @@ struct mpl3115_data {
 	struct iio_trigger *drdy_trig;
 	struct mutex lock;
 	u8 ctrl_reg1;
+	u8 ctrl_reg4;
 };
 
 enum mpl3115_irq_pin {
@@ -376,6 +377,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
 		goto reg1_cleanup;
 
 	data->ctrl_reg1 = ctrl_reg1;
+	data->ctrl_reg4 = ctrl_reg4;
 
 	return 0;
 
@@ -390,12 +392,15 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mpl3115_data *data = iio_priv(indio_dev);
 	u8 ctrl_reg1 = data->ctrl_reg1;
-	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
+	u8 ctrl_reg4 = data->ctrl_reg4;
 
-	if (state)
+	if (state) {
 		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
-	else
+		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
+	} else {
 		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
+	}
 
 	guard(mutex)(&data->lock);
 
-- 
2.25.1


