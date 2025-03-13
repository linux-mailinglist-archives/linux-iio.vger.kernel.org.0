Return-Path: <linux-iio+bounces-16758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE63A5E955
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E392F189CC4B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22161C84A1;
	Thu, 13 Mar 2025 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bowf4vj/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05919E83E
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828592; cv=none; b=XsZajk7QYttPSW7a72yn/iFcgDz3qV2AMvP8X9VLxDb/Gr3Dg21xWn/DgLCfU8SWvjanQCXQ3TJgd9wIJPn7pVF1kYX5YDzK41V5k3iCYuQz8ogL/jUE4SgGRcbNv68k5oDFkfH1Q4Lh3i6wW9giZEYsOAECjqT0TV0ewbsW97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828592; c=relaxed/simple;
	bh=6WgP3e20Vf+cIoXFBzeYV7N3cHhALzd0d4Tp1M1tS8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4qZIRBSCfnABzGXZNmTT1UVqU4OZGbaILufDpsL9WnGTB58g8cV9yWJfRCnHAr9tgl1tC6jlP1Bf81UvFqDCcjFuJExbp1Bn83Qa5DukdAoi1D8o2gx/Z5aSYppRZFVJ4LZiPyAZKOM/u0cxO2HV9Y5oR5wIabVvHhC5jRD7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bowf4vj/; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fe944a4243so110669eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828590; x=1742433390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErtaCYUzf6VOfPJiLrhtMgArALjNBXZLULBJurS3Qis=;
        b=Bowf4vj/EGwqTS9N/awdyDJMNg7NOla9xLUSO4gabN8yU0GJMNhFq4BPgE9dlgOpJR
         XkuxGoiMAbppbAobURohct+gNNYSJ5hdqs0Ny6sNUlwkTSbXXz6OXe7y5D0M71eOHPHt
         W6YvvovTs5F2ywWIBqXzls51tpa0Z1XMzsQGKbEy5HifC9T8xF/vLpPoiL0TEt4SBJ80
         m/ay9Egi/6gJGpzsxpNxlDxEegC4DIfYQWdUqur+Qfpw3jHRsPy1pPUu+m+OM9tbzxYX
         pr5Vh8y+lou2DCdwP0ZvkyaSURDXYkfWjJ6V8Imd3qGrG1PkYskRMgnVuxgp+lhe02G2
         ETJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828590; x=1742433390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErtaCYUzf6VOfPJiLrhtMgArALjNBXZLULBJurS3Qis=;
        b=ClW9yjSX0gK7OUEGLQCzlrUmfFqjMdmNztgLsqACgdIanM5Iqyx24RAgynB9d6TuPb
         MYKajOMcMv79rzT/qa5lKqXLPkiimiPwV/7dbkQ45DwGnmKgkN4oh5q6ZK9cviSB5GS1
         gbjuz98p3DAkVBRP98/faIZvfVWmuT3HFKj/OFM22ylII/wj8XMjLqr/lIMccQm0FTiX
         ZYOnG0I8jHFKOKZAjLpYYcZanRCGpfd6FpMOX68u0nd4q5RDJuCIMKAZgCSHU6/IXK9q
         wqRtRrA3lVA6ZNJWMGhqDWUjOrFq6TPYkkcgnpKBZAmtSNlFwilr0MAVwWoz3hK+Iz6F
         8O8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK3Uf4xHGUDWEug6zLiR4tkdS4E5z7LPazK1GK00rUGUik4i8cRRn3jQd6rXvK5BA1CCEVLlb/JSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLfGgVIVgiPEfrHo5vjHw7jDwyF1hWkYd/8R4jpKQm96sLAztU
	o3smqJ7s+d6l6Pyv5Msi5bIQmMM7n8xP7Hw7rFgvb2OlsLYzZCVWwcsUjreNP5/jgz04cVrYxSh
	IuOU=
X-Gm-Gg: ASbGncsDr+8jdUbz3hfXdYSJJB/d7+lQcWxqhBFWExS/ZiQ0inFmmCOLRL7y1vWbX6x
	yLvv8QfR/4NezTz7GEODPymMgcRN7hBA+1gw9gjliD+uhE/wA6+beOntL/JXBjtQw4+4H38bLM2
	d5xIFEpmsFOyE/HwmtWT/eaYHyaKWelJ9/gdRdW09rPaKwtW77ToWZFlYiYiRCp2cYJgHmZpFah
	PD7+FjOGFGqJ0tMxluY2bdFVVcSgSqgE2W4IfJWSqOO3fL2s15C7v8jMVYh7x96iJC/A7Cf5XXL
	g4Ij+Tcb5rt5PkelVY9C7Dl77J13m+uCBjSEv0sLycCuZVuiRguLBny6Ja8/vt7OpTD5Xnk5WqT
	g
X-Google-Smtp-Source: AGHT+IHoAdzySyGHyMSnxU+r7QqcX1SngNEfBkIN1cJf0TkJIJMv8JrPq0hyqg/4AjRj50PnHQyC4Q==
X-Received: by 2002:a05:6820:1a06:b0:601:b7e1:9233 with SMTP id 006d021491bc7-601b7e196cfmr6703137eaf.3.1741828590059;
        Wed, 12 Mar 2025 18:16:30 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:46 -0500
Subject: [PATCH 08/11] iio: adc: ad7606: don't use address field
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-8-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6WgP3e20Vf+cIoXFBzeYV7N3cHhALzd0d4Tp1M1tS8Q=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHbWLD2czElTLNIrJ6BtKxyNlYORe8dOeTi6
 REervvYzkKJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2xUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPTChAAiQ7bpcSspWBg4M0tlM+RuSGLLdkW3GZjlnwqkAA
 O37XMILkqJ3uMIb4SFcbyrSb/jRJ1+FTRQySEllPng4H+F7s0cU1W87JmPDhH5busAZzk7dZzZg
 NmxdH1wy2k7wNMD3Rk7WlipJiWVvWEcnahPdv1u9+N525Ko1LJHUo/V/ATfIrozNGLsiD4ydoUk
 81+E6EbIo1lO6115K/W48SQAvPh9CilgHoMsxfydf1nRZ82qjK6hbse00mOK+mYvxshzdXEkAxE
 u0DwX1/uZXo9fC/7HU4+LlVBDjW4tj94rE7vpg2ueP/1Cpa9/qWbk9xn6bzXxtoaR//BvCL2xfs
 jR7Q6pATgAaZ29CSfgkF661RNmFcUMSZhOlZEK3Sq3v5Uoc9HUPkiM4AQTo7CnIQ2RKB1XilSMk
 FkfVCUXrpRyChd+6fPoTs5oBA4T6ePCnuajYGxpj6fMpJkevBkKJfatFCthb5Y9lr1kDsJ/qds2
 ZGdQhIca7SC4NVvoEqaSKm/t72J8vQJSxEiC2EsQCCkKaWHNPnOu9cQFC3+xc1G8JYr9w5KzNc4
 FstO0cUo3DlLlc4utpTpSbaulYOThnfd7OXGN+/R2rk2IjgEVtFSwhSJpazQq91tF3ZEPv0uTp/
 DKZihplvEkPzLcfhT4zJdBE7RKafBUBvmhgL7y/eHUAE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop use of the address field in the ad7606 driver. This field was
duplicating the same info that was already in the channel and scan_index
fields. This is one less thing to have to hold in your mind when reading
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 drivers/iio/adc/ad7606.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f190269ac8ddd859e94eb24c26f5f010d0951646..02ff4be3545d45f0e10bbea7251862f4e3daf97f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -776,14 +776,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
-		ret = ad7606_scan_direct(indio_dev, chan->address, val);
+		ret = ad7606_scan_direct(indio_dev, chan->scan_index, val);
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
-			ch = chan->address;
+			ch = chan->scan_index;
 		cs = &st->chan_scales[ch];
 		*val = cs->scale_avail[cs->range][0];
 		*val2 = cs->scale_avail[cs->range][1];
@@ -865,7 +865,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
-			ch = chan->address;
+			ch = chan->scan_index;
 		cs = &st->chan_scales[ch];
 		for (i = 0; i < cs->num_scales; i++) {
 			scale_avail_uv[i] = cs->scale_avail[i][0] * MICRO +
@@ -1072,7 +1072,7 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
-			ch = chan->address;
+			ch = chan->scan_index;
 
 		cs = &st->chan_scales[ch];
 		*vals = (const int *)cs->scale_avail;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 01b0e2fcf343a77631fbf20c12ac9d02c80c3455..f6a6c89dbdc708f4e25e3c9ade9e9e614a7f99b1 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -45,7 +45,6 @@
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
-		.address = num,					\
 		.info_mask_separate = mask_sep,			\
 		.info_mask_separate_available =			\
 			mask_sep_avail,				\

-- 
2.43.0


