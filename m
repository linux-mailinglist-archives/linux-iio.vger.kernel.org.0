Return-Path: <linux-iio+bounces-12656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526BF9D8DD8
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F9B25619
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC91CDA0B;
	Mon, 25 Nov 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8DdotXm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5751CD215;
	Mon, 25 Nov 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569389; cv=none; b=dw5YZr4/JXWPh/43mwNTfkVHim65mGOkLkg5Zq5bvwuTU8RH0SovAy1BKE0SWUX38Ij27Rkp/MZdaIoa2uUpaugPPuOU27wzYvmdKOddZd8nDJtyV7ZW8+Ud02V7e9hcBkDlBaMYrHSTzZVNSHIEPLNWeeAeBAN6J9BQmGxF+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569389; c=relaxed/simple;
	bh=ZQJA+VLURMBGAdorLGZr3GynZ4Vpg5VPwIUKA3mZWZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQUJeFnBkj4Gsu2FUbAYHYf6qWj1qxHmBA3lgGnajWK/Hzbc42jypSSeUa/fj3tynLW0B+hU6Qi2Kux308LrdrO4HL9UBUyzkJZDAAJ63j1Hnbpra/miTG/SuBcMqKjsrI/dqRVyNHXW2UN/KevTGZ//3udyX3sK0uJhqblKvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8DdotXm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso61927465e9.0;
        Mon, 25 Nov 2024 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569385; x=1733174185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3RK5b8spIwxpFrRxaAWCFkLvJ3+B+yqb9aqjOjmHyo=;
        b=c8DdotXmEoHSxFulV5ZYPLKhPoVTtiopa3GP5tIa162qiWWnw0zepvGuO32/KG56eO
         GElQ1vG9BamoBo90Z2owblajZBq1hGb0S7QRlYZi7c9Ks6N5LutLD1FaxQo+H6ckS0dl
         Ac10mjet+/Kfv6VOzzu7oOlJoRhztT2bFs+T0AIw/IqBY2+2hP3kqB5b/AG25kVimsdC
         SKeRknJH66xdbx4uFxF24IAGXH+4SP753rT2jsTtppV2whCVG3iBh2+HlMK5bXLvz9d2
         YE2zysIIJQmF36Gr5HldFnJyobBmvVWxDDySf4ALOfdwUFVHqKqS7rOVxtRLS+GKCb/c
         ARyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569385; x=1733174185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3RK5b8spIwxpFrRxaAWCFkLvJ3+B+yqb9aqjOjmHyo=;
        b=TKUc3u5NJmLsrMm16MLgU7IDXgpJKchb7AtQzVhwM0oZujkx3wUHBwutcrPRishFUh
         RNepU3ZtaGBtkrBgZ/IwbfaK5vAZ45gTTA56vlp+AQuYNWjLg7PXgN5U5L0kYFqZ1fm6
         SFbvyaTNRYHqpuJ5e0NPBREN1jJixk726Lwm7tZ8JZTTcALCI0X+qXyh51RoEntn4LIZ
         BVnfDA4YOmHClLPgTSmHG1364+cwfA3F9mS0mod+Hthr7t19gcdWXWnnt80CdxHFbBEa
         1Sfr927QpfMgLxMseRxuorymaEqZsRcdjSk/63vQ4F0oAYxQSgwzAPeJSDryjuuRDCP+
         ph7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4KI5/lxPB1bP070DsS7Qbr0Ma4BLBn27+joTPwrzBn6i5kFT6DopE8qFOFDh22SSknBO5czxnYUPOes19@vger.kernel.org, AJvYcCVzp/JtNXoTTJg2NpUYmOVvB8NoVRX/2IhNnoZG0MNi1q9Vm1Bsndq159q5xW+MeH3gS/juLhSYEdY=@vger.kernel.org, AJvYcCX2FmM+Y7pi+TsL7RMa3XDpijWlJqJn3glQ5PI6M4DtSf3Z8NBLVSQDtL0wM+ZtmU3RieV0ear9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AtUYA2+p0CXx6HfLiINcyfvByBjnioEtDQHGVoWFC+QELRvL
	p1C9Y9rBTMNPyFB1kFKClD+PCEXVkpY1rqmFv3EtokdZwZ8oEWEFWj8++A==
X-Gm-Gg: ASbGnctmBSDd7g89OvFM7PcVLg1x2jvS9UKdn9fg+qbPs0qICQQXJZ7/iDm3CN/C2lu
	mDh/rsaJkv3vWQzUwrK2X5kyzqOXomuYIV4MdQ1bg6F2mprQ50Ti9itjKaoTmEQzhCAwgXblj9C
	3UIGPimZxe6Qss3ngEoWZ9vB1A2xTWO2q1eT7wQcgefCpO/mCTtoZYeiQsvxZD0GHq+9shyfK2l
	MQp6bmGiIYiYHpwBouApxU5NyLDRMNnL9hYWR75N4RGDH5hAB4q2XpbMtrXTdi2q5tIvVcUk9JI
	BoaGvhiJzWtw3GxYIElimCzseSc8b/NeLrhySDDkkBKLAzIAkv0s97tjMSPLC/hXECBZZR1C
X-Google-Smtp-Source: AGHT+IHmoubDW9P2ETjDqsC7K3qF3hmFXHw9SUkYHnL5xErfM6jx1YI+AHtMsN6kaEW6V2VQEqXHUQ==
X-Received: by 2002:a05:600c:1381:b0:431:557e:b40c with SMTP id 5b1f17b1804b1-433ce4ab227mr146124715e9.27.1732569384715;
        Mon, 25 Nov 2024 13:16:24 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-eff8-ad65-1bf6-3f21.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:eff8:ad65:1bf6:3f21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm75236295e9.33.2024.11.25.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:16:23 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:11 +0100
Subject: [PATCH 03/11] iio: pressure: zpa2326: fix information leak in
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-iio_memset_scan_holes-v1-3-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732569377; l=1140;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ZQJA+VLURMBGAdorLGZr3GynZ4Vpg5VPwIUKA3mZWZE=;
 b=9/hfzbRch6K4vfgRHsXMjdh9zovBJWpiH1nMqqsxXysG/ftsJn9XywxJCRiuWrA/sDCkCj2z7
 AJkzWm52iy/DoSLL0pNPxmsoKtcS9YCI7rW3CaU0pAxCNBP/0GXGkqD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'sample' local struct is used to push data to user space from a
triggered buffer, but it has a hole between the temperature and the
timestamp (u32 pressure, u16 temperature, GAP, u64 timestamp).
This hole is never initialized.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/pressure/zpa2326.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 950f8dee2b26..b4c6c7c47256 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -586,6 +586,8 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	}   sample;
 	int err;
 
+	memset(&sample, 0, sizeof(sample));
+
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		/* Get current pressure from hardware FIFO. */
 		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);

-- 
2.43.0


