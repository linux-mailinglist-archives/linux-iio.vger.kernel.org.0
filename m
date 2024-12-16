Return-Path: <linux-iio+bounces-13557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB19F3AFC
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E850B188848D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB61D7E42;
	Mon, 16 Dec 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="afZKyLTf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F861D63EA
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381480; cv=none; b=fehVEtRMK1NI25kB9utldKVGniRG6afmbmN7I2tTCdEHu3/B07eI6kadmjtczqc8xOJT4uWDKVHrR3ruJ6+C7ZP3j3VjurLLdSdmZAm16EXHKvWOcFs7ZvHz9sbDkVoA9+9OeX+BqWvwxd9c3iDBQH/ZDlr8X7rRyKqdqz8H5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381480; c=relaxed/simple;
	bh=NE1hPoXTfXueSL8XZoeJtAxIwg82btucyX54UoYPV6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wyzuh0xhx1kwAcpkIvb1OAeSJuiKYaQua3V7WDOsKZiNtk8uTZdboww/wRkCC2blYEor4wofOdEb6bVOsjFP6cJduhIrN5NPDTtfdiWBS4dsUKSM2xqJoTbSCavRE8L+7kYub4y0bjh4OSFPSERGjFobKxmFlFWAoPvxAk+rAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=afZKyLTf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso28296795e9.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381477; x=1734986277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1a3TocO4QhOHi1hz8sskrSgMQ+R9urFgqr1JgbH+cmc=;
        b=afZKyLTf41m9Jcp7cEpU2bu7qhLVL+mxYDu+XbDM/I015qns5+3RcI1hxQOn/6CPCq
         2XkcF0CoAdjaKq2s9hh5azr6SpJ6788CYlxxpXjVcflOT3HM4CY/0Lsu8zxKfLKgvPwe
         mgWQTMx7Iy8bJ6sIpvRRiF3OM/53FvG6mM8lTnfo5jUKvnG+MDaJRhJ0b2GQGenNiXry
         ngoIqHcKiwUk4toBAl2VhxkZ2kZ4u6bfiRWSCOX5EogQehv/1dj5ZZuHRGK7ROa8c0by
         OgsLgBY6ZCys7ImqUKpp90iNY97lZ3h2BXBbxTBg+x6F6AomIdE54L9nPwlaLhkYnXWz
         hbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381477; x=1734986277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a3TocO4QhOHi1hz8sskrSgMQ+R9urFgqr1JgbH+cmc=;
        b=NWwZHlQj5ijtbMQ7yG5nOMxi4GyXWrMivYIzYB8MI9nds17QEHOXBM7k9rnkHjcXiA
         Mfy5pnqfXWJolebsVXcohErJ8cQukDC1Joe+HtvJYgNhl+gY67Jy7AuFoKVe7vwUwnja
         nos7pn4MKYUz0Ys50l4M/ZQRTn4ssjNANLv6mkNAgJVb4N+P/46eXMMSrJIwpp7YJSzq
         h1pizr2P5TBk5bk2+4PNi/tN1cOUCdMlPGLCmz0GggziRZBrLsGoln2xhT2acrXz/Mgs
         FHHNt+wZtTxlrfq3OA9M5pkErBXQAu1u8YkQKntDPVY7i5yFzT0AVqh7ty8JLqgvrgpc
         h3iA==
X-Forwarded-Encrypted: i=1; AJvYcCV1x55OB9EeICzWkV2BdCb8UNLM5W9D345aNwCsYp3HZWxT7uk6EU3fIXsH9fKosxhbNttkB/7i1FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypw7PPJWV6gZLPEiNzTWnf+C9voa8Xq/rbcf/edDPvJb/wJ+T8
	+nOtntZEkOmkMXkR265iyLU45oPuk64w4OoK7cksBukwLNyuYrZ+CKOopYheMjM=
X-Gm-Gg: ASbGncumLYo3CqXLc6iZWLoToowtziCHWN1pfzm2AiP9KYZSBOE41yLNKYpARVZhc22
	lFyU94+WLqpLgvi6QffhN8eojFQiyu/CrCX/H2gI+jaD+yx9YV5aHVGZtaAEZ+Lco77o0GnaHA9
	ZoIG02k7MNLtVnoYkB12pSvvv5R6mYuvrAaV7i5pUaczB5h1FSsqGLKfsxmJk2BfBqFXW5ZzhEN
	FPC256AnJ/LlhCvkKwvhMns48ag+b0e8NQ9B2kfqMjROK3NWAKXZnVh7Ifj1mtOEmBUM7treccS
	JRfM8xjJ/RUKa+SQtEbZpRv42HzixIT9Rw==
X-Google-Smtp-Source: AGHT+IEj9m5GIAzgaSe3uUW27R9P1c5HFte/OIInIFLiV1U287XN2b9dm1z75fJaFkFxOA7MZKYrNQ==
X-Received: by 2002:a05:600c:6b12:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-43648138c6bmr6465555e9.6.1734381477029;
        Mon, 16 Dec 2024 12:37:57 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:55 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:26 +0100
Subject: [PATCH 6/8] iio: dac: ad3552r-hs: exit for error on wrong chip id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-6-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Exit for error on wrong chip id, otherwise driver continues
with wrong assumptions.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 8974df625670..e613eee7fc11 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	id |= val << 8;
 	if (id != st->model_data->chip_id)
-		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
-			 AD3552R_ID, id);
+		return dev_err_probe(st->dev, -ENODEV,
+				     "chip id error, expected 0x%x, got 0x%x\n",
+				     st->model_data->chip_id, id);
 
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,

-- 
2.47.0


