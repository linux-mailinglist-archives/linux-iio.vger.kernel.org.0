Return-Path: <linux-iio+bounces-22379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65262B1D3B0
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5E21884A4E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5FA2472B9;
	Thu,  7 Aug 2025 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MANoIPj0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20F23F42A;
	Thu,  7 Aug 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552963; cv=none; b=mXWHdAzLc2/5Fi+aLT0YH34QxAd2C3Qpf4JCV5RMAmdR3psnH0mGwexKOKfa4E7JUS22OIDelEaqSh8uzBvEEs5JoRmM7YGbhp3xcl7fQA4gB8AZUmaz0z8Lmxpu2+VSpvzLoWUJ6IKLyIlS/hWORSgtkfNAPvk7YJABeb73EmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552963; c=relaxed/simple;
	bh=uAzacStBJwsWg8AFUrSslCCBYjuQKh+NwTcBPg7N1nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHi178QjkA+0z8Vj0tXqnQwkQlRqCbtpR4cXnFV/q3JXg+QveGb62ORSagqFjlM4/9pRCMGQ9bBBOk2rhq5lUrlDukJKYhV8zgdFrYPTGzQZvX7sDUMorNrb74a5UYHn18dAYCm+lFFWOePKebnSoTZ5AR4q6xkriu82j0eLRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MANoIPj0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b783d851e6so561260f8f.0;
        Thu, 07 Aug 2025 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754552960; x=1755157760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0I69ypRA5Xwv5UMnjFfLGICyjveT/YVABctJWvudMI=;
        b=MANoIPj0oRSClZTnRqm6JCeNu/Qi9YZU+3dwUxgLQ0XcXl5tTds+ebv6dWrxnCqb0j
         El/tgyQZizUJ6JonxukxGxRzSK9UBHmrH5PvDjD08fHSD1GXmSl8/PFKDIoeNp5Oc520
         JwGqer/7s66f7dU9eXzwbNR8Eo2uVi3vjfBhdOMlw19PZ40QjdoPwKlEVyvHDBGKgAE7
         DLwI26y82lDFBiyyHlUvsCD7fE9H+SRsap0Wi/Q6G2697X+a8DTPUtjW8beKcWj2sZMK
         D+EY0SLHsho+dPpxNeL+uK4q/YlDPWXJsYxZjLvyITPlFj5yQfjRuZvXD+WdDHPqdZB8
         GOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552960; x=1755157760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0I69ypRA5Xwv5UMnjFfLGICyjveT/YVABctJWvudMI=;
        b=BKQKXjqElzFoCK+wMtClc+U3CX9HS44cx1mTaj/NvXzJqaM/3o9bEUgHznaNh1wBtq
         M3zp2iTpcKl6/oPHMwMCixb9VFeH0MttYG19wIeMlIFILRn/2IzMRuopZuy75CDr94fH
         OkPjI6lZL7sfRMwl2R9GvnWzscK59MZMZ3dgrTvRuKYVYvnwael7aWykm/mkUkA4tL5m
         qelTNZpxI9a8rEomZlYnP3/V5gStfLiNPFH2Cg1AYXGIr56em55Z2mQQsVc05AichvMG
         GneWMxVZ/Zd9ql4DcB4DxNe5eoWVinq4eDM35DS3fJHoQp253NVJ2EPw2OCT0Ec1qlM9
         D9kw==
X-Forwarded-Encrypted: i=1; AJvYcCWY9X/Nn1axhLisQAdRAP/rfYAQnAWQux6YdcCOBBGxabPitr1Z/bxnkT68GOm/9UCpLx16ka++E08f3rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyyOzdXxf/rXuMEMjwYmvr7x5EtzB4w5sI430K57Kysahwh+FL
	eqIm8TrsS8n6AsaTmn8RbSSz0jWWnbn4IUxJXjLp3mtzc92Bi9MBa/UW
X-Gm-Gg: ASbGnctkBbFmHlhjzce6zFykhbI9iaH4uXgL5yGpkJjpbvN8a/45yFPirbkm8O0eu1R
	kUnmddGTE4BwmN5psb19JAqpXre6PtGUhB5blt7Ce9T6AiwOkJGuz7RHCdRiQ3PAOP4y1WsmkHl
	F+yju+66OxCknNTGbMVubrDMaD1Dt5eRnVbUUHu/nlFIyl1bX+c6F5Z9oYF/WM6RKtadfpQ//bH
	I4e9e2vUN6J5hMnEM4chAytiTxKB2puCr6lGN47mwwmVltxU98S6pwDJbZHHcGgqetqiEp/Up5A
	EOkowvfzvXzxxWWH19qzTGoSLBLayrpE5taaOV3pqY+gdA2JY3ve0ADBW6FfVoKu+k5RCs+I7Iw
	VDgmPAA07fskN8HLSyBsveaGVwc94g7VzgDFK3XDW1xtA+m5GxRM7kVVrrUEzAlVRRRtYPQnYLd
	Q=
X-Google-Smtp-Source: AGHT+IGFHGotX1jXtvL4ELSMlr5Zn5+mwoOGK78n/949PjNl60tzbBiPOFBSa9JvXwG7onoT0zFJXw==
X-Received: by 2002:a05:6000:18ab:b0:3b8:d32e:9231 with SMTP id ffacd0b85a97d-3b8f4915380mr4023440f8f.29.1754552959981;
        Thu, 07 Aug 2025 00:49:19 -0700 (PDT)
Received: from localhost.localdomain (2-229-167-183.ip197.fastwebnet.it. [2.229.167.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm27054362f8f.49.2025.08.07.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:49:19 -0700 (PDT)
From: Stefano Manni <stefano.manni@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: ad799x: add reference voltage to ad7994
Date: Thu,  7 Aug 2025 09:48:50 +0200
Message-ID: <20250807074850.130831-3-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250807074850.130831-1-stefano.manni@gmail.com>
References: <20250807074850.130831-1-stefano.manni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AD7994 supports external reference voltage on REFIN
pin so if a vref-supply has been defined it shall be
used.

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/iio/adc/ad799x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index f645995b0929..108bb22162ef 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -692,6 +692,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7994] = {
 		.num_channels = 5,
+		.has_vref = true,
 		.noirq_config = {
 			.channel = {
 				AD799X_CHANNEL(0, 12),
-- 
2.48.1


