Return-Path: <linux-iio+bounces-14030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CEA06372
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317497A3887
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0D5202F76;
	Wed,  8 Jan 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fl+bbM8v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2666201278
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357441; cv=none; b=E0GvqW+TXxAmuDXZPtn55Oeg4ckjIp2s4tH4iKBqS5O+H5YoGbd8CTM8RZISwyccec119XDTmI83bSV72oYybriV4GS4LFhnCmUfBxRsSA1ciNYl9AcKTvZAr2FgH9mhWZXQJd2VfIBuw2X+B6P9Ph92OkyfQFLkKjScowKaj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357441; c=relaxed/simple;
	bh=IuHaI/semL+Hv8JNr40Pmjd0RO8u7Ce4lu8w8B537I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4rsIWHHlvTl8f/eDefiJZ2COBhn6dW5vfI5Wz+6GjVqDVBg/9gnaqshZFxhItiladH3w2pLRdp6rf8/FIVXShlBBWnt+CWMRrPJWBjQBqbC9YZ3NgoYeP9unZUecRWvtfzrtHnHISQCJDHNvvMxpYHw1aXnRdKQ2o4skb3IBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fl+bbM8v; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43623f0c574so657585e9.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357437; x=1736962237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szKwztPhzV6CVF/0X9HGbGEX7Uh9TD9UOgptum5XTx8=;
        b=fl+bbM8vy1Ovyuhzmdz+qTWRxaNY/cD8dPmdfWFomZMLhk/jwr8EsYHhqsJJmEddGg
         +pKkrqoNcCMbQ7TPMIYnL/vSFIc26aRIIIeCe/Dgk7T+D5/l0vbtGINObG4T+8kqIak0
         fhmVedw6qeay4xb5L6LLn90vLHBMdkAeuL80eGXbhq3U89HWoQ9d23vgZLnvrrhc2JaF
         xforg/F03QKxJzgTYwr+ztEQ5JV4xTNy/lajN6uWhlupF4nXmXgqRAhM3dWQnaWPQrkl
         NAxff8wINBgrUouEmlP1nZvCwhYwhPvC07oLWM+fBb3Upd7eOYLCTCR3V2e5XM9EyJrE
         53iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357437; x=1736962237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szKwztPhzV6CVF/0X9HGbGEX7Uh9TD9UOgptum5XTx8=;
        b=lUED+CGsuamzNDst0/4gbtu2o4KIJgLQCXnVSSQ0ReNdWrdVOR868zarssNaWOFE4J
         ED9eT0tqge3gSgKPpClIgES/7DSeSj3NpjdBo+0TEcbQuKd4vdvHVzZ7fEYgqf7XaMnJ
         zbcqO8yIVlGbuvURAWx+1ppPiEQyjaVsuPNU3A+ivMpavOnB5zzQbFqzt94aUmYRQycJ
         QCKgMm7XuAtAEBjqEbKd6zr6LGx8BJZQx1kETFegmpm3p78kq5/8qM4TOMKVKuyISrFZ
         /aw1FNMgpHwUqnjRoaRLKjCgtnkYkcm14gLr/4YKZAr2BoWiTm8BsXozz6fvIAEs0yK3
         XqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD9hu20avoQ4Eaacbq5/befH0bQ4fzI43ugeL9d2fvMCLD0h8JSunHfsshhVeKjSR8Gyi0qqEYBaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPaj1Tn1lu2984Tnded4kM2hRbPuCmwVO4V8TXVTi+mrfSqr/w
	ePKrxhVHvYdJ3MIvDOTMvg3xUbbyYDt6+IRLyzdkFZEgM5j4AdBkG8ZCieHb5QQ=
X-Gm-Gg: ASbGnctOfiL/FElsZsTf9u0JkGJP5ICa32ZziYOz2l2ZSY7vIVhzn0GGM4E7D15Gv1a
	l8tygE6PHWhwiSR/XjUwl7TBh5wWEWfDsflfY98AR0nloptKR0lzAIPJNgm7qf7Aogy4sCDfhET
	CqeyGssAjnOHUJ/ZnkxDBQJoV+GTPiA6FMxktwTJWAzZzgR0+uzwhfHGXsqZvQLgTRKB99lflwX
	JmoMyXpmmB8FgkCpU6BUR1Db3/4OzVQVuaSpi3JMXIKXWJoFCKx+wxoSYo=
X-Google-Smtp-Source: AGHT+IHZQe7bqAuDCWH482pq2vJ7oArvpn5JDt8LHHWBYu8pE/3pqQpPt6ie/yD+qulq+Fw1RO94Lg==
X-Received: by 2002:a5d:64eb:0:b0:38a:50fa:d582 with SMTP id ffacd0b85a97d-38a87363364mr2332501f8f.59.1736357437339;
        Wed, 08 Jan 2025 09:30:37 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:36 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:19 +0100
Subject: [PATCH v2 5/9] iio: dac: ad3552r-hs: fix message on wrong chip id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-5-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Set a better info message on wrong chip id, fixing the
expected value as read from the info struct.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 8974df625670..27949f207d42 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	id |= val << 8;
 	if (id != st->model_data->chip_id)
-		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
-			 AD3552R_ID, id);
+		dev_info(st->dev,
+			 "Chip ID mismatch, detected 0x%x but expected 0x%x\n",
+			 id, st->model_data->chip_id);
 
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,

-- 
2.47.0


