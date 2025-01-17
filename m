Return-Path: <linux-iio+bounces-14410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E075A14EA8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 12:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB63316920F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E71FCFF2;
	Fri, 17 Jan 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jqCTYGI1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19801F790F
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114355; cv=none; b=OQLf3r3wmz5Ab93qpoCyEjYKU8ZHV9UMxOlzLn2wzUEqFOgqX78NjPr4P5HPuVtYfWlbR+LKAIBqU1y2k+ToFoylh+wRlNvf5dfXZBbQYfYkhr0YkfEH6GB467/k4Tf5gxOfN3aHAW9ojF6aVbrBq7Gsjp2uDPpGK+koX9slyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114355; c=relaxed/simple;
	bh=TxX9GZPAigyEqICMU7mAfPmTnURHSzNAAjMsT2EtXsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHXwxzB1FyohkequE/ZWo2jpxcHz3GFYgv6boTo+RMWlIhcG2HFNGXS9S370GgWk+S3bab0GF94zR5y2TVBHMbU9R/hFLzEG+gk6MY7KTkzskxwuCxFP6rZ+aRcR3jPIkZja79boFBwziL9tfelAqPLr9XI2PpwmLJEVbk6UeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jqCTYGI1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863494591bso1046901f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737114351; x=1737719151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SX4E5nOs9sDG0cFz3WAmPbWBhgd4TVZdnDk/oMMP88=;
        b=jqCTYGI1vlYKcfSzqyIIAsqV9Yz/TuD70j1MSc35bTH0mPRvnJSELc4yS96oQyv7yx
         dZIJpUvqi+RET4qgH+uOS+gbcP68vZXsa+WJbOS82oaZEOqsW1uNyhDMQQ9TTpUWpvOO
         G79TqTq5X4XRmVrvKdOFxxcThd7zz1lExcM92/8QbvarQUFfp81KKaWsdHduGR8iyVGn
         ghbAIcAQIjginD04m8z7BVQM6x5+HIqPjKhjqIl7WydPo0v2q110o0gEoP/cDcclYjeP
         FmlDsUvV/klCSJYw2c4rHVh1Qr3YhxOV+olQIcNbQw9D3hy1IvUDg3R/iQxERUT8oA8l
         lKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737114351; x=1737719151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SX4E5nOs9sDG0cFz3WAmPbWBhgd4TVZdnDk/oMMP88=;
        b=BQdQPP6KX3CPOwYbbEuiwGzVV7YQn/dQsVWUcIn/WNdMVjxyASWDHfhpkRib6PmFP1
         9NlJlHBgB8eLqmVQOGQkRxP+bmL4xcS2/jfgq6QHFLLVovyMPubg9qkz/v89u4ls8Buu
         aNtqGm1KrIa3nstiGuLcXokLZ2Et358mWADG6dNg/or2yxYTbGbZYpqZwP8obnwN6R5d
         1O5BZXEdR1ZxIFdhifaCPAqbHsZL47vTcrF0gGUL8p/P2DsUgh4tm39T7ODYKItJaWWi
         wInemSJ5vktDG6oiiFmoVCi0CFsaxB/0WTDgbzDQRUzHHy7+mBi6qMusAeU9cupvARK4
         eThw==
X-Forwarded-Encrypted: i=1; AJvYcCVjKQj11He0s19SYqhFlzoTm/LiQWLfHdqOfq993bg6bncADJsh21nJ5e7bqaCZaKxDrN0SQP1K7no=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHGsfcYqgD2rgz82rUetUKJpIg298s9yJAWRlN/w10/wGo1he
	LM8z9XZGMiCeVLYQ9e4uw/TaQdgDr7gR/vrnnoYqd6vWiIp1lWlA/3OIacu1yima45eGz2qTKW2
	U
X-Gm-Gg: ASbGncuMX6C6IoXmE4hcWjN/YDRGzIkvanDbHxldLYXoyBIT2IVWNovK9kpjOrB0vmn
	X+XtS+AOA8degNiD4Fci4Q2d5+PRrrhr76Ou9KvoBKvJDiFkc5w16dRv/WpSFYmSfOLLDTO7pAF
	SdT/UEcDd6jqReLeguodgI1A5uaf5HFLtXyW5YqF29TzE4B5KqrDnFiFdm1uX10B7i0+x77VXrM
	JZksmq+ZSy57k6Ftzo8XlqdV/IWA/GO5ZsXMlKQHKWF8MJKzXF94HPxMBVofA9ljXDqP984llB6
	HB2YPRDKpKU=
X-Google-Smtp-Source: AGHT+IFnyQealSLAM40HDbjd/9KHWOb1sGSNaDORrtaRZtmtd0iJ6agBu8P4BDVsNiR07l+34VbthQ==
X-Received: by 2002:a5d:4e52:0:b0:38a:88bc:aea4 with SMTP id ffacd0b85a97d-38bf57a2304mr1575293f8f.30.1737114350925;
        Fri, 17 Jan 2025 03:45:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322aab8sm2348496f8f.57.2025.01.17.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:45:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Fri, 17 Jan 2025 13:45:38 +0200
Message-ID: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds some cleanups for the RZ/G2L ADC driver after the support
for the RZ/G3S SoC.

Thank you,
Claudiu Beznea

Changes in v2:
- updated cover letter
- collected tags
- updated patch 1/2 to drop devres APIs from the point the
  runtime PM is enabled

Claudiu Beznea (2):
  iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
  iio: adc: rzg2l: Cleanup suspend/resume path

 drivers/iio/adc/rzg2l_adc.c | 89 ++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 35 deletions(-)

-- 
2.43.0


