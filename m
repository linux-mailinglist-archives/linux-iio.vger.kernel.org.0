Return-Path: <linux-iio+bounces-8098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C82942EBC
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3764B24CB6
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F11B14F6;
	Wed, 31 Jul 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1qsWHLK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0B1B1406;
	Wed, 31 Jul 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429454; cv=none; b=KZ5hH3OsFIRvd3uqRB8OExrElszkQm8aUqI0i8ZCM1SI7qWp3NDJt/F8fs9L0I/aVd+rx5ifcK7/bXfV4PwIFx6kcvlHEM52bxJKff/OXKnZjQq6hny+si/enDceDTMfLqQSqPhF8UYmGtLEXGlh6Q1fvTsBzaJIU48z8dyF48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429454; c=relaxed/simple;
	bh=UwRYvAN7LNB8VUvCepUM1zAD2MkiMuj+x2+rgIaqKLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDAi6B47fM4SxwDXj0XfDDnVEcLL1U5Uz/gQtkWhyn1z9he5WSfIjm4OokfVCOUr0xs32ksyIliBI2MVKXryRW7apvt1vARioXnSIKckEOLLnsUwYDKXYB6uhQEsszEHiNEnjMRMXA+RpD9JHW/wHA6XgaMG+QZRlgauPTGxrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1qsWHLK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f149845d81so20095661fa.0;
        Wed, 31 Jul 2024 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722429451; x=1723034251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UU5X7a5HgxCluEnZF+3TvBQHOtwCPJFDpNa5mbVP2Io=;
        b=S1qsWHLKwEN1m8gE/lFSUE+ctF8Ig1RRuyhT2GZZ8x+CQFgCitDRgmY/j4sWv8W96V
         0XSuCeUXOHTPtHpvzg9Q5YPONHj0I833KR4TFQfe1dpVEOIss6THSkkJSAZgRtLFPSaJ
         TV9cGCaZ53W1V+DelixcxCuHBRjApiZUb3spzu4FYYVRcxhEJZbgEMec7faK+LoczDgN
         leRSRq5NDmLz9rZSk16ljcSQavkU+5WlTmkFcaZvlQvmD6sr1Cy1rYA3oJN79IxaFJSC
         CXuKl77YaeBukzp0FAULWv6b1ildYBTLMpA0KCetkPlrqz0AiNYWnF0/yqCowjZWENa5
         Ma/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429451; x=1723034251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU5X7a5HgxCluEnZF+3TvBQHOtwCPJFDpNa5mbVP2Io=;
        b=ZHyshwSdkhdjLzn7rDqkJH1DOqBsE2grTH2KXDuzfa/YS9uO2bJFyJJi1vuq3TAcQ9
         nBDjQ0X6zCDmbwRwFiHbiMM8L6+6Tvpb67PK4SWT0JOTd4+/Nw30UrmHQa6A+XH37UDj
         aWHGBvTeYMuuTxwOpUzRA09DD2rqbDJVDk4eyqr286XimOjLcsZSCQNbcrEDZ3XEUt4n
         k6tjM5BxxXu9Ime8auv+DxgHu8kASstjcVnQ2HYC2S4VhoScOqoEOc+eAzmjwdDX+JgA
         cgKWjvWizbt3qkDrGL5DFx+7Gi3B+/ztGUU1YgSbgOwIPb/oqGtpZd12aJbE8yr+1Tre
         FWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmb+gOr6E8gvrLyh9ifLwcLABNdAYrWrUMclxGeihQ1slUo3iNLHpkQ3EKGbU+uz2k9yr6YRMLmHL7eiZ3rm8he6Bf7TonjdO6Yi0ZMalaeqSoMMlU2xpvskXdsrLYUxutSJdXcirX
X-Gm-Message-State: AOJu0YymabAcpfiEXGW1LZXZy/FdC5tpRlQ1DFLxOk38H3NMMHJrUji7
	pvjhZ24SJoMG2ZHocT3feD+67LBHP5WVyoAtrgGdO9EEuL/1jGjAA+UJQhoWWjw=
X-Google-Smtp-Source: AGHT+IHovvG3uQ4gbH4Wp0Lz9szD9FDkQ256iZXVZdBACrDdRWPF6ckXJmyjLshPzmuKCsD+FHD6mA==
X-Received: by 2002:a2e:9e05:0:b0:2ef:2da9:655d with SMTP id 38308e7fff4ca-2f12ee24b24mr94483741fa.26.1722429450750;
        Wed, 31 Jul 2024 05:37:30 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64755sm20600465e9.36.2024.07.31.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:37:30 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Date: Wed, 31 Jul 2024 15:37:25 +0300
Subject: [PATCH 4/4] iio: adc: ad7124: set initial ADC mode to idle
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7124-fix-v1-4-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
In-Reply-To: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Stefan Popa <stefan.popa@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722429445; l=1102;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=UwRYvAN7LNB8VUvCepUM1zAD2MkiMuj+x2+rgIaqKLM=;
 b=n0ZRGtPVxpL4Rk05uxWPt43ohRg3mz1iNocDGc8XE1o+kKsqrvXFYtDKdYsWvmLOzCIMj+B3w
 1+cFmt40UczDA701gzvjQVf6ZAEAsnlfOm3v7aLVWeue2GVoz5meTC6
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

During setup the st->adc_control is 0, which corresponds to a continuous
conversion mode. The reset value for channel 1 is to enable it. The
combined effect of these two is that the ADC will start conversions for
channel 1 without them being read.
This is not neccessarily a problem, but it is an unexpected behavior.

Set the ADC state to idle during setup to avoid this.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7124.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 4d63cd5c9d04..47abefd0fe5f 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -899,6 +899,9 @@ static int ad7124_setup(struct ad7124_state *st)
 	st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
 	st->adc_control |= AD7124_ADC_CTRL_PWR(power_mode);
 
+	st->adc_control &= ~AD7124_ADC_CTRL_MODE_MSK;
+	st->adc_control |= AD7124_ADC_CTRL_MODE(AD_SD_MODE_IDLE);
+
 	mutex_init(&st->cfgs_lock);
 	INIT_KFIFO(st->live_cfgs_fifo);
 	for (i = 0; i < st->num_channels; i++) {

-- 
2.43.0


