Return-Path: <linux-iio+bounces-10270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B409992738
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B052C1F23940
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B718DF91;
	Mon,  7 Oct 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhEex6IZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E118CBED;
	Mon,  7 Oct 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290289; cv=none; b=r/ULRZrgydR3pGBDgVveKNJ9KQp7CnHyH0AUuXRO/CjytybwxZCWsZORpZXl/QwrPki7n7dOg8BwIAyi42CP09URS+6HMl03MgNKwH47B8TGhYLPrQqteh2qmJZqCYbyg7o4/R0CC/Eto88jYj2R1FIEC54dRa9+Dz4q/KTUvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290289; c=relaxed/simple;
	bh=nRhnNaDZCEdFpfuQY+d3PHGabxDhnUnJnKU7JXNt19E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LukWZePddPl5OrWDahB2Hl4HpGcgD7QYh14rq+ZLlPYI4jaE3Z5Cw2KYmUDIMaKSJGwmHLLLmOmMvFMekcEa/qkbqXQrMhp8uy7RKtJVyVi0jhmZpFYg1dR7hvJedB14AY4aNba1TknRU5uVuSC43YfKQE2W4IzqOalsZi33/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhEex6IZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398df2c871so4286580e87.1;
        Mon, 07 Oct 2024 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290286; x=1728895086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd1iJo2Ae4EEednioqk/xw+7U1ML6e6KimnctnEpL5U=;
        b=DhEex6IZTBuoL/h0TVrtYH5BkcLgUVB09RbBq6fIZ4KDw4YN3uNVWbd01xgxH8LgXn
         FZy53g9T4XifEtRYpzFDMYag/A0xafyEPYhRxNwVw8EhsEjOG8baYBEOam2ooWRIudlt
         9h8M+5QOR9gnM4Ui2dYU7zj2YcH6K43SePnkpvLYrkYQHBTMEZmg5mParisjggko99Xh
         N2AjWZHWGPExRbYNK6Tk3RpbSrBfObubno4T+OmBtIWSzPFBay7G3a6/w27XOz6OPPlI
         Gmt1Y0vHA5AzYwA43AVLL4Fj5t9XU+HjxvXNAD7oSOGjTb2b8q6CQBSEtGTzMoKImSQ1
         mK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290286; x=1728895086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gd1iJo2Ae4EEednioqk/xw+7U1ML6e6KimnctnEpL5U=;
        b=kRG/59G1AWffZtTPh5fqWjPcUEYON4pnrZvu5jCCsM9/muypz8SuZMeHph+pte1IDl
         sJTrebAvr+RBHuqYRvt3IOfo3N/vZC6ylDVAtG0XEwHiHY9RxdGqg++F5ik8+0RM5OVt
         WAqSh9xvST4gTZVLd8/sTAB8FctWdtyfCb7RDDUKf8S6H4AD+oM6FIj3DXO4i/v6XHy5
         +foy8pOEldbOhOGeAW1PPGW1jjFDyZHsxGyCPzuvO2RauPHu150uIFYrNfgF973WjQGc
         xVtEBCsp0OVLjnxzwTc7rcHLEsitVhcnUWFfXGAECqdRwNJkHEzemvO5v0kQDWUFmvZk
         FbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5GL6wZ4htqKVvRbShwiZIr4UsevKlPwPH8eukiUXHm2gHNWZ0ZE/+/2rR6VqFIVLxdGFxAA3aTv8=@vger.kernel.org, AJvYcCUmKVSqXbnT46ub9dSmt+Z8ZT8wU4/4MkhSOOL4udpFYKKAiDKdCEsXeFAi0yaJBUptpnP+f7mBmL1k9g==@vger.kernel.org, AJvYcCUy2tdtKNxM+fFTZx8uiIh3s6hDx4RZ3EMcNlzfov/9SyQf9JDphxQPpXt0LhMOdmc8g3HGeta60IaCf60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6e+/9zmlkO2MLaS7l92XjzCcGQViunjkNihToxTixT1nZrtia
	yJeMiTxk4XLx3lhiWorma0FUUoAH6ME2HYvDpUeX3SoBD/S9y3Dw
X-Google-Smtp-Source: AGHT+IGnQ5d4feQXUX2RxM5Jec9R7d5ot/8bGk0KvZl8H4Q1K3oqOrca4l99vrGw2QCjarcKNAgaXQ==
X-Received: by 2002:a05:6512:12d3:b0:535:69ee:9717 with SMTP id 2adb3069b0e04-539ab84a7cfmr5334883e87.3.1728290285315;
        Mon, 07 Oct 2024 01:38:05 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a7e87sm2921949a12.24.2024.10.07.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:38:04 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 07 Oct 2024 10:37:15 +0200
Subject: [PATCH v2 6/7] iio: consumers: release available info buffer
 copied from producer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-iio-read-avail-release-v2-6-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
In-Reply-To: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

The iio_read_avail_channel_raw() inkern interface now allocates a copy
of the available info buffer that must be freed after use. To do so,
free the buffer in the consumers read_avail_release_resource callback.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/afe/iio-rescale.c     | 8 ++++++++
 drivers/iio/dac/dpot-dac.c        | 8 ++++++++
 drivers/iio/multiplexer/iio-mux.c | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 56e5913ab82d1c045c9ca27012008a4495502cbf..78bb86c291706748b4072a484532ad20c415ff9f 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -249,9 +249,17 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static void rescale_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static const struct iio_info rescale_info = {
 	.read_raw = rescale_read_raw,
 	.read_avail = rescale_read_avail,
+	.read_avail_release_resource = rescale_read_avail_release_res,
 };
 
 static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 7332064d0852d979620f90066fb027f6f68f8c95..beec76247acb5170b81058d28a71ed17c831c905 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -108,6 +108,13 @@ static int dpot_dac_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
+					    struct iio_chan_spec const *chan,
+					    const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static int dpot_dac_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
@@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info dpot_dac_info = {
 	.read_raw = dpot_dac_read_raw,
 	.read_avail = dpot_dac_read_avail,
+	.read_avail_release_resource = dpot_dac_read_avail_release_res,
 	.write_raw = dpot_dac_write_raw,
 };
 
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..31345437784b01c5d6f8ea70263f4c2574388e7a 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -142,6 +142,13 @@ static int mux_read_avail(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static void mux_read_avail_release_res(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static int mux_write_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 int val, int val2, long mask)
@@ -171,6 +178,7 @@ static int mux_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info mux_info = {
 	.read_raw = mux_read_raw,
 	.read_avail = mux_read_avail,
+	.read_avail_release_resource = mux_read_avail_release_res,
 	.write_raw = mux_write_raw,
 };
 

-- 
2.46.2


