Return-Path: <linux-iio+bounces-14027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E9DA06367
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5101A3A6E0E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA658201027;
	Wed,  8 Jan 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cOfhaBSy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618B1FF7D5
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357436; cv=none; b=mabdElCrdKMLmTx/RoGeha7LIfqRj2MLYxGzl15dKne/6YLYz5UpYA/8c8j2Nk4YvRYuzRDEUECKhOxLdaAwWMwxUryC+5NX1Nk0uB/OjtUSTJwYA6ptHkhFtoYUpn3y21zFANAb6TclwdQelCzH2iazuocqqfoLnmm60cp/UHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357436; c=relaxed/simple;
	bh=nZkRgILfPdhIXSsrXa+Y4ye1ieetO/26xbBu55cEnj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQnnKdL6mCdRd/zdv6+KWx65C1KItJR6YQugSDx8ldG1F6Bd2EhkYxJuV9z8xT3tOOILXhz73jQwqMyMSrYq1StdYkgOurdAAkmQSctYZSsRgCpxW+3htKhEgpnj6hfCSKyclRf0RI/HmwgchrZw1X/GFhZU/s3mJs6SU0y1JQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cOfhaBSy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385d7f19f20so18767f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357433; x=1736962233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogqDcmpodmDQ/q56quzP/HOrrjeT0i3lFvLbU+LwsSM=;
        b=cOfhaBSyz2NE6KVX8ISHqWIz1OSfK9bg0x9FBQBk4Rs6xIASP7Map9QimXBni+uw3W
         EEIOgyoecLpRonqxNXqw3gWoN+jqKhVIJ9sKqyYLuFw3+FYXyPw6U+59SxzenlA80hqZ
         45blMQPrt1W29yy51P2gAL0nipMSN46occH/0c7bID7EQeiyDoOnJYfr57koguzoxl1S
         iefSqScbxOyA81St+0hQ6UAQmwJ6bN3pfU8pJ5+Ud3B3fRncI1keDwI9mHl+3tipPBnN
         kzwnUtGdaTNRZuMDpVuMedXqblAEMSMnZU49sfXb9eP45ffAgghbbxglXxxeF7lEuXbX
         U8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357433; x=1736962233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogqDcmpodmDQ/q56quzP/HOrrjeT0i3lFvLbU+LwsSM=;
        b=s4X/Of+GagzozefTUVZ/8pHVKBeIUT4SKCCMIxD+wze8khYff8BK2TsVMiz797ZyTe
         cX34/UaIlr+YmQhy4LsMhmimNwbwWk7u28ARtEayymT/NTOYtOB2DCzduAr7fDJbVitu
         IUmRbogODrvdOhXKfeDvAb6SYFG6k3kyvBz3AagwNMtiZnbECXtvSK0Q87UBt/7Davez
         ntb1tDvYQ4vZwG6idDtLDGkKvA3+sjYVD/eySjUKN1ahnl1Hqx990AvbG8ZYamtDRfVM
         A1jOhTC+kaSJclpAi1x0HuKmSqWQl0F6XM5BaWuZ+fzqUxVQxqxrXVt3ijbVyZEjkfJA
         2IYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF8FN8+hlIsyD9/3LfbQb9nAjAmgFr1njViqGQIRAKFTCcTOysV3ILrlljVwgzGy1cUFXMD5eNePw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt85VkQ7CMJ0pjj1hRALSqzHoz00vENwY9E79R9LxhNw80yGaP
	ibsBL9paTkg3LE9rYKxHYJ5IDp7rOfiwEPtfJ2s/3B1IIWtm82KPsqbYz3lw2Nw=
X-Gm-Gg: ASbGncsxmQJp1FUOhlmO/aRoD+BupMNN5cMezidi8QOAq9UGJel3qdGvv/MrfENApqn
	OzKX7Y3hE9c6imxDXIia9tZkBFjLIO9Y6bSFrMLa8RFENynLWUG0t7JMcDUB001yR5b381cCPsi
	LhIL0TX2VDeCnNaLUr3lEYNwjj9JA9ZAHmHwsUkW3Q+KTBiEgZK5N3gr+dfhru7ImOVZKrZSCL8
	czVgAeVCUDqrnOYeKGY+ARoO3lfQawvNPZqoPDteeSMFbxOzzBQsnWE1oE=
X-Google-Smtp-Source: AGHT+IHcmhJGXkysxn7bW+xCJxZmZYHBYQ+uQ9YZk1VUxnFMsUr5DpBd/e0GMjIuxB1CvtGZSm6LXw==
X-Received: by 2002:a05:6000:144a:b0:385:fc70:832 with SMTP id ffacd0b85a97d-38a87303cacmr3138373f8f.16.1736357433088;
        Wed, 08 Jan 2025 09:30:33 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:32 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:16 +0100
Subject: [PATCH v2 2/9] iio: dac: ad3552r-hs: clear reset status flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-2-2dac02f04638@baylibre.com>
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

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the
"Error Status Register" was dirty (0x01). It is important
to clear this bit, so if there is any reset event over normal
working mode, it is possible to detect it.

Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 216c634f3eaf..8974df625670 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
 			 AD3552R_ID, id);
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
+				      AD3552R_MASK_RESET_STATUS, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back,
 				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
 				      0, 1);

-- 
2.47.0


