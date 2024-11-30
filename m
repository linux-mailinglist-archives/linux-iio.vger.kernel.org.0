Return-Path: <linux-iio+bounces-12843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F649DEDD1
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 01:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2622A281C57
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BBA132105;
	Sat, 30 Nov 2024 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNE6ryQE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C033126C05;
	Sat, 30 Nov 2024 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926455; cv=none; b=DLLOyqKb5R1o7zMQbLGGpEmhDENic9K0WhInX2CLclfjRAd9moTWCll1r5P0ESrEyRudPHwX66SG5gs7q5Vtn1cEWvGnx+gGoDJEDwVAJebHoiS9sTCSaJX42PeZeLmDwD5i/zg9NbndkYX5IcRUd10+w/vij+GJG7mC7ahciQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926455; c=relaxed/simple;
	bh=XItfe9KGwwMzzj6U2t6Vp8rGj8ql6Tma3iAb4mAeMW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUoFqXp0lorThKSjBh6jtAy/pxALt+l85+PuEmASOk3dDkKUDwcmSe/pnuDNSSU/qOZdzzXbNBFpNRSS8XNHp/cNBQo7HmQJt8RgPLyCXCQQAGnWZ+xlOdMXohRr7crbPabx+tI/001jQpOPeRxObD6pcFtDHFgQ0huFE7TjhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNE6ryQE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso21738835e9.2;
        Fri, 29 Nov 2024 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732926452; x=1733531252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xspFG0Ip4WEEo+fxE9j2i3tI4tI3g61qtSN7CT4dO4g=;
        b=FNE6ryQEeB+JWA2253437Id44MS/Q3ggf96Ii74vUEf7VTRty0SfckrL3LUXCNvqEs
         eiFYX19bX/zFUT8pjGTeWBXldONVFFoBeDboeTQXBqwX2EYaSSTyTCK5bjGkxukFXF6K
         gclLqo98SvF6IvGZVFwDZKU3hXlh6/+WYffuIClxczt7m+YJ51a954trlj/aRrsM1g5N
         vMkZW3hKQZVJ2yrvoSZdDqp2UaivjPqSuNm6plAKmqkRtSDjTifPs7W5bT64uypX2M6P
         oDK3JPUBzfSzSFVALGWf9htLKzd21EuBdg/128YcWdmgJHgQYE5vCOwYxpfmhpLClkpZ
         Bwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926452; x=1733531252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xspFG0Ip4WEEo+fxE9j2i3tI4tI3g61qtSN7CT4dO4g=;
        b=I/mWsOfptI8NxVw0+2wTPAbkVT2lJAvPcCOhJJWAfvOf7X8bJYuOZjYBPeTkeBWSh6
         440UlqXyExTD7maTUxxg4cXWxnq+kYewNLWRfYMnseFHrkxaJ6oD39mlUSuo1xSp9gve
         s7e2AobEuIK89szXqKBJUqRbeiSmUoep2w1VOHpHhHyHxhYTNiSDSSlOVQ0G1liWHJ9R
         TljVHaFGTBeb42hggygPvyhwZFUJBsOyDgLspYBzr1nQYfnfkeyBoMX4U4XCFfiJHPUu
         XFeFAjkgY9OvEv61uWiNlxSZ7DMRMeinKrC3AYWQ3a7LwBqFwGu9KnTDGkm2mQSiGXGp
         D8ew==
X-Forwarded-Encrypted: i=1; AJvYcCU7zCz/MBJU0M4H88pfHuPlrH0NmWFNk8l71dqBaWvgV9VEHoK6bcsxlOwh2QGypBPhhV97v2uLcwc=@vger.kernel.org, AJvYcCXdZ2RhmCxtUcyoIvnsUD5n8Mgf5QavE16xntUW3wE6I8N6qU5vNNem6o7JPoAmn1gh2IPcxvHI2S8EeFof@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUmV3idEJOUCvNfmSGaWnbPRBGxpM+uAqgzMKqR2M6X3Ao5Mc
	iHKKG8qY6+/82fuWOKXbsgQswrpSOs5eTEOpnvv+6O0bQGagZvck
X-Gm-Gg: ASbGnct+1evP+DdaxQOUL7N0U6ZHj50Vxn8C4DrLpIdEqthoKzEEzxJGH5SzdsURaFq
	u0DEiMLMnTsX0mxPsfUxF0b9VY85AK2NXT3EnfO9aOAobmLdW0PqeQCl+zDbdVuVHVMRy222mmI
	9+3k33DTBlQRiD7DLyQrlL7BAbs+fVDDwJbOn4hmVLLMUFhrLkbg1S5JMK/J4FmJxGIbEnjjVMR
	HT/ArPGzfzIv3ASJyWQGWG+Ufmz1cisgspE2frkSS7v9QJ5i2QCcSqmxistQA==
X-Google-Smtp-Source: AGHT+IGFokx7HlnJ17XafWw0ijsuOtCf8i/bAErUtuBN/+8/PpZbqpN2X1ZFgn5EbEe9+hLXnK50dA==
X-Received: by 2002:a5d:59ae:0:b0:382:2d59:b166 with SMTP id ffacd0b85a97d-385c6ebf097mr12106322f8f.31.1732926451592;
        Fri, 29 Nov 2024 16:27:31 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm5873345f8f.7.2024.11.29.16.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:27:30 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH RFC 4/6] iio: adc: max1363: make use of iio_is_soft_ts_enabled()
Date: Sat, 30 Nov 2024 01:27:08 +0100
Message-ID: <20241130002710.18615-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241130002710.18615-1-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the iio_is_soft_ts_enabled() accessor to access the value of the
scan_timestamp. This way, it can be marked as __private when there
are no direct accessors of it.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/adc/max1363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9a0baea08ab6..57d9aff729f4 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1473,7 +1473,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 		d_size = numvals*2;
 	else
 		d_size = numvals;
-	if (indio_dev->scan_timestamp) {
+	if (iio_is_soft_ts_enabled(indio_dev)) {
 		d_size += sizeof(s64);
 		if (d_size % sizeof(s64))
 			d_size += sizeof(s64) - (d_size % sizeof(s64));
-- 
2.43.0


