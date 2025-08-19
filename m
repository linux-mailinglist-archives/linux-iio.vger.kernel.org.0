Return-Path: <linux-iio+bounces-22973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56AB2C0BA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 13:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9583B3A993C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AB32BF30;
	Tue, 19 Aug 2025 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIbgWpOC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537332BF22;
	Tue, 19 Aug 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603593; cv=none; b=RHmUy0J7FEn0zDlugrwdMxm/iEGuUm1352S1LJlX1oNUg/8M5pUIR58jZ18jIsJOdYRpQiX2BujjiBynVFsqrQyCshV4KjbAdX0WMEyttodYDEc9iUbPj36434ClnLVLgUdOG3UEPX4hkKjrKYhwnfbfRwV4bq2WmNiyEcGFTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603593; c=relaxed/simple;
	bh=yzPa+ozyXmPnfMnBDHe6hjrPY3CWOPGU3bBJlC3RrTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jDQTt+316cHfC32ih9i1gk8OhVt0B5ZP9xzFRuckKgjcw7CzxKYC6RCIVfsS29QNS1yiE9bV0xDNaySUoYLl+irpRvfzlakDWQy+2nni7hBa3lwl4/5izqoz8zDJVGZpW1YUrps5+5FXMNffHlh96Xru6zzB6/aJfZwZKvSZnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIbgWpOC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so25438825e9.3;
        Tue, 19 Aug 2025 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755603590; x=1756208390; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/YHiMiSEXGJ+Otn/lJFKDk3uocdFFMzq2l/EhCHt+4=;
        b=EIbgWpOCNg+sbU70pwJjQkbMrj0+VW04SUsCcdlcryzaW4u+fhXQcZN530Gu6frpXC
         2ZsknRYNmjtrgxDtXXPwaRiCwLWuCaNmETQxw+i6im9PjJDHrE0IEwGH+3b7wPrvsTzy
         FdNEcq0V9J7ziSIGDrcAFQ1dCMK7HF3C5Sx7aNc/tEPHpsrwpCg9GzUOhfBBm22ZJmVW
         bHok+/40J640r3r+tfRIQDPSVpJxm902Hv8FdiItJu3nLz8ahAHHZo8bMV29a3+5SVYc
         P+A0/7LwCq3VOSkY+QNhwcNR1C1lUs9DdiqlKFMxxnNc78qXXZ0r/VPLa/ghT2EoCRFv
         Vf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603590; x=1756208390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/YHiMiSEXGJ+Otn/lJFKDk3uocdFFMzq2l/EhCHt+4=;
        b=HIBqssHgSPk0QBxgKi48E3vhCiaD3R4GxKwwreiM4Evm5/3m0emT1XguCLAkF5rjLp
         sh+exDqxlCRNm1mAmZxpHSAoFuSQcqWOtIhuyuiRC6KI5e2kt4O0yff3URSLDru8EP2E
         nZLYbq6yp26G0tBjd173qI80gXKH+1GmthMOakfuzyQiGoVnK7gXLUKI5JKIdR7vJYZU
         2KifD6gsWpSlQwVk9GLPNIswj6qc6XqinwSYPd7kXNbn1jW4J6IBor+QoE3yfpl9bcL2
         UENgO1RS2CJJCtwICTnQgNaL3i6pL443loFKkSup5nLE2pwsYZnPyowI3RXUlQbjZbld
         aR7A==
X-Forwarded-Encrypted: i=1; AJvYcCU8XBdmnn6bt6G8e2YScXP32G+19hoINsXnnxHx3k0JsRNqhKr3ouUpNtN/RwFISm5z8KEbnO91X+7Qwr5i@vger.kernel.org, AJvYcCV/I2z92feNqtL2HIWWriBHTX7Ny8t5h0rFAf5+CNINlEORBa6fyBBNdmyglOniOtWheVabqnsbwhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIu28D1zHoVVAQAWypx9I1fSL8Wcxc2iY5tKNbK+qa8ykf9lp/
	VOhWsbuDbUmAqfQH0UkN68Q+tlwYEN+1ulQDkhzN97Yjlvwp6cM6QmJX
X-Gm-Gg: ASbGncuN98/CEqY+GmPqyx6mHG++r9aH/FP4Lrjnmrev0erjarFDQqB8BYjx7trVIBi
	i4xaEqRkTpSq8YjIV27AVWPqhddEe9Mlud1bZq6uP6GrEqDaCmFMVW0+FiNvYX8eLVGnphht/67
	NQYc+fIB4FiY9mHdF+DfoQMG+y8z0GKSd/kFxltM9A2Cx3AvrLAztPjpW2iJqrgtPeZFapG2Bq1
	qzu7Fw+rDLzA6FxPpPxiiDzQE9JdehAaFYmM5kBL+fUbadzdOFfF6csIA17Pd1hSd2QLiQjrV/+
	M8BH5QW6VdRN7YTd1s2NlVupmkmNP3GWzhYlwMZIUjrKMUVbBacvEekFX0Mu9u7ecLH+WA6BR0e
	Lr9NAs4CJ
X-Google-Smtp-Source: AGHT+IEEyAKmkNJbiKHBYaP4BljEbzWdPCRpfKg9xhckNfhaurnODS7Zuy7nPkGxLEza4L1RzbfFVA==
X-Received: by 2002:a05:600c:46cb:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-45b43e12419mr14734595e9.23.1755603589519;
        Tue, 19 Aug 2025 04:39:49 -0700 (PDT)
Received: from pc ([165.51.6.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c19fbsm3425900f8f.41.2025.08.19.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:39:48 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:39:45 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] staging: iio: adc: ad7816: Use spi_set_drvdata() for clarity
Message-ID: <aKRigf3TtH-x-i1C@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace the use of `dev_set_drvdata()` with the `spi_set_drvdata()`
helper. This is functionally identical, but improves readability.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 4774df778de9..599f75103cb0 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -360,7 +360,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
-	dev_set_drvdata(&spi_dev->dev, indio_dev);
+	spi_set_drvdata(spi_dev, indio_dev);
 
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
-- 
2.43.0


