Return-Path: <linux-iio+bounces-5704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3128D8872
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D16F1C214C8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241C137C2A;
	Mon,  3 Jun 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="A/EsvXdD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242C135A46
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438134; cv=none; b=QZseVv76VNrLgUF2PU2WGkpRp7hGw6Q6tWEZa7hQo7EI/1nRUFcI8NFKyHzx1balJZx22fFGONcgmB67XfnI7FvO+WFzjCi9miDC42UrOFvTn0UUU/V099yeUy1cqCabyoiP6BIteRlL1w/5vd5Z0qBHMs157D1hNpHOM3z7kTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438134; c=relaxed/simple;
	bh=luTdfy6sKpLBoXjaLPwr0uG5veHniFZLbNHB+TAySsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cryAnYBZAd1nNiFz0EPehNRPA4ri1FZJK3QeKu+KelUfUlSv4L61xyc4BuixoqJAP5FuHCnRxXVThY7bTPXDbYgxjNbkBN6uyD3GMyyDe2EsxS9muBXNQj3UE4S1OsK3SJmTKLAYTzD/ZbewyFNC5JHCdHAgTDHChK4FbE1UFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=A/EsvXdD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f44b4404dfso41338065ad.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1717438132; x=1718042932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QnxyApbFpsfeddwm7SZRHJYhBcPxd4u6Vyq+8HPgcs=;
        b=A/EsvXdDSQopQoacoKKlFLZ7mbMQzjpCkWvnwzi/mwDHC27YL0qIH5/la3cjxFDvsp
         gbR8D5iRsW5VRXn+nunuND7sBaU+Sis2hX/4FhKEL0BpUDUaI4PSn5VGIb0Zfh0AGmmY
         NP3sepjjcuEXyYZw3HWZNUHtzDC/5V7BxV1DT5MZyPk4UIjR45VzY4O/966Uo4wW+D55
         0OmzhmVSn//m6uZAjxTOmFS4UM0xdKyYPvJlsCeTVCPR4YGzKEDBvXSXPXIwfuRkiWj1
         iHZUeRZL4lHAFWnPddL/i/KrOKaTQtGZ9cEnoY2loJKtnXTYj9BEKerUJode4iK+zQCM
         PWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717438132; x=1718042932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QnxyApbFpsfeddwm7SZRHJYhBcPxd4u6Vyq+8HPgcs=;
        b=DDZcMRbgn8oiHMbxg70iBqxM8PGdoGsiuSaIvc1i19nEqVoPFkZ/LfxfLUEIiTk6lm
         89zhyS0qECmK33j3zzO2dkD1xqBeZivYjAnX1mecpHhumtsedcY7SkUYjRlSaL/hsWfK
         zvF5MV/PMQde64YCOfSoYu3+jt3LrzcZx69zQAeRfTzj3wMWztNPKXjHF9YbZ3ILX+6U
         8U/L+X6N7EWLAHRuRY9Vt262Dyadp2PPlmeK6WK54H0AvKQjH+Fp8CyD/ZGo5xlbLPEm
         YufR/L9LW5uhRkvaylZOIxn4XDI/fAlwSaAs2wLgjGm1KWDbV5KuSim7gtuguks446DV
         1TTA==
X-Forwarded-Encrypted: i=1; AJvYcCX22XvYMQOHE4y/VoNGr7Pwgcke/4fRStdXW4luEze5s6gZCXVKNFDSXWjTI3FleFMuDzK1qX5yjBfZi0g8JiS+ng/GLYJ0mUDY
X-Gm-Message-State: AOJu0YxZQbYHMp8LQ5Jtnhl/OYB5Zd0Yvx44f3SQYGo089lVlOVQxYVn
	G3/yHNmn4hjhEt1W5ylOicAx1uo0Awf/eXybkDXvHC9V5AJj1NHlMuC8E2ZiFSw=
X-Google-Smtp-Source: AGHT+IG4dfqtIcb5fbvadClpLYpO4ax5z77JPc7pHWqBzM4NpOkTL3diA9cHpFWbDOAtW4AViEQt7g==
X-Received: by 2002:a17:902:fc43:b0:1f6:850c:3c5f with SMTP id d9443c01a7336-1f6850c3f9cmr17335015ad.69.1717438132182;
        Mon, 03 Jun 2024 11:08:52 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241c39dsm67348985ad.297.2024.06.03.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:08:51 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: hagisf@usp.br,
	linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	lars@metafoo.de
Subject: [PATCH v2 3/3] iio: adc: ad7266: Fix codestyle error
Date: Mon,  3 Jun 2024 15:07:58 -0300
Message-Id: <20240603180757.8560-3-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603180757.8560-1-hagisf@usp.br>
References: <20240508155435.183850-1-hagisf@usp.br>
 <20240603180757.8560-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some codestyle errors indicated by checkpatch.pl

Signed-off-by: Fernando Yang <hagisf@usp.br>
---
 drivers/iio/adc/ad7266.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 356c2fe07..5a2f1bb27 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -63,12 +63,14 @@ static int ad7266_powerdown(struct ad7266_state *st)
 static int ad7266_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7266_state *st = iio_priv(indio_dev);
+
 	return ad7266_wakeup(st);
 }
 
 static int ad7266_postdisable(struct iio_dev *indio_dev)
 {
 	struct ad7266_state *st = iio_priv(indio_dev);
+
 	return ad7266_powerdown(st);
 }
 
@@ -153,7 +155,7 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 			ret = ad7266_read_single(st, val, chan->address);
-			
+
 			if (ret < 0)
 				return ret;
 			*val = (*val >> 2) & 0xfff;
-- 
2.34.1


