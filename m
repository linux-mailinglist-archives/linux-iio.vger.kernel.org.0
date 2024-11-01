Return-Path: <linux-iio+bounces-11747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D419B8C40
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A511C20C6B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D527157485;
	Fri,  1 Nov 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mqPL/EuQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F18156885
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447201; cv=none; b=mhcd0I/k+9UG5fbBiVzqwOxrf8TZsiVbEYmTYtD/P5eYsGyuHBhYKzwGKYVvKdiY6ulXzS482Y677ZxPgO6UjdazDtrt5cMu0ramtc44wV4yUuQ5Q8FKyL7iHDQuy08Bp6BZ/u2hbaI7lO/LPUA33myxTOk62P7yFRXwnYUaE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447201; c=relaxed/simple;
	bh=CUtvkf+t59QX4prslptAVYmO9B9yIfrnRI6r3hKSoAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMLai8mzlB3Kiq/Onnxw14sbxb4qUnhEZlEPBXFR5ngduU/tg3tucjxBBBDpoAevsLET9fwR1u7nnxQEpAr/kr9nCyXcc4+o830IgccAMT/a401XTKf0BfMbsF5JZ2lywHA8utyV0ktg1je9JXgByHUILKtcbqPm//ziSecVF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mqPL/EuQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso10227146d6.1
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730447198; x=1731051998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adgmJOhHcaFkex36EFAe1BXPWl8Ng3rQHGIFjAA8UGA=;
        b=mqPL/EuQrfZnUTzjIOMPZHal32m+YGMJuOywQsjfi0JoLuc9mlooedb5W6Z1oTIsg9
         lVu5QKRh8j1z52tfPi3m4LjXc2MPIcKU5YheoM8kZNPigfpy3OXcJ5RxaT1U/We/oY2R
         g+KXU9xeezAWbEELqs5Jg1OwMcKsIMQa5Rag8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447198; x=1731051998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adgmJOhHcaFkex36EFAe1BXPWl8Ng3rQHGIFjAA8UGA=;
        b=rMjk5fGL34IsWaDhb97CrmEsliBoxryzcwE0WpB+miikhynHCAzus1lGj3b83vbTxw
         lS1fGuzqLyi4kamt7BGbDXSQBjsYCxL2rZ1Rj8GAlHx4I1p/hBXXZQgBehKNfYld4R5I
         y8Z4TFFqZZRm+maacFybowo50o+ftOl3cqKlKpi+gZ2goVxU1lGyAQic7gyCtxEARzhG
         dN5q637cPZP8WDfiw6I8xWMaIHvzE/fU8U7NPRCN+ReFrIzzS1oi1MmaLWg5DXF9pIsg
         bLTaxf/VpJpo38lpgf/tefXUCIMav7hz9uM1Rdil9uleGuhLrfBl2jUjuHgThxfQU4+L
         d4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWfLgJcs7IPSqw90TcIgd8iyGOab1TqjFN9RKKbK/BmyYG/nhS7LR5ZmTyl9gvAacmUefSpXA3SRLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdIww+EKttUOWKK2qvbDjHbNHWUfVUZ3Vx66QiY+yXZlcSkOp
	D1L+HZX7iiCyhFBau1qqqfAL288ro9dDfg+Jd9WQlOrAcHAzwrM2pPRjbdGR9Q==
X-Google-Smtp-Source: AGHT+IESbbksSKB95l0C8Ah+v/s+ywwV7GE+w0AJMTMGdTtVsJeriYkTZ0MfwWXgg+cncsRV1leGZQ==
X-Received: by 2002:a05:6214:2f81:b0:6cb:c9bc:1a23 with SMTP id 6a1803df08f44-6d1856ea81dmr255805576d6.24.1730447197931;
        Fri, 01 Nov 2024 00:46:37 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b1casm16444236d6.78.2024.11.01.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:46:37 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 01 Nov 2024 07:46:30 +0000
Subject: [PATCH v3 4/5] iio: hid-sensors-prox: Make proximity channel
 indexed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-hpd-v3-4-e9c80b7c7164@chromium.org>
References: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
In-Reply-To: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

We are going to introduce more proximity channels. Make proximity a
indexed channel now, in a simple patch, so the change can be easily
bisected if there are any issues.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/iio/light/hid-sensor-prox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index d38564fe22df..0f12a8a83790 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -40,6 +40,7 @@ static const struct iio_chan_spec prox_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_PRESENCE,
+		.indexed = true,
 	}
 };
 

-- 
2.47.0.163.g1226f6d8fa-goog


