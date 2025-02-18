Return-Path: <linux-iio+bounces-15752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D7A3AC6F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 00:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F35175369
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16871DDA3D;
	Tue, 18 Feb 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c+vgxgop"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BA1CF5E2
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920675; cv=none; b=nM+wjUQ1rwEdXCXFruMiQr66YwghG6XUvGLIPT2G7Xxv64+205dMYAIU+8Jf33mEuGiUbK/R48AkDc7G6rMX1HtHUAJ4+ZVsG3Jh7ExAVh0rNzgbCENrJsduUWnJboBR1UXOA/78HErZpjr7LPb+lTAUTq20eiwapDJl13rlVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920675; c=relaxed/simple;
	bh=YtP9jMp1zsEuMGXw+pRfgayF/lnTYJWTTdsWP3y71BU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UO6oH0cww1xW506xj9IavyMnOixWA6FjajYjVf1mjrdp6DQvWk9FitdoYLH7eHWXopXLVh49kIuToyVUSvyQnoNhnMk+XtKt+m9dNSZKBG3dflppf1auO3Qx/fRg8TIMVrJGnM9HIqNNlZM2WV9rbFCEA5ao/QxPNN5Q28U2i7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c+vgxgop; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-727250dbf60so180074a34.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739920672; x=1740525472; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1kVy79PjjwS9vT6eqX/jn2fuQOg4ncGF32yCLYKYdc=;
        b=c+vgxgopCtJw1KDe23QVBN3XYKS+rIVz7XSU4XDgZt/qJpTeGYWdnKmHJbF0YiNSV9
         XaYRGHvrfvj107DsldUEmTME0vK95PJWOl6XP2E2+W4+zG+WQcyH7x8q83Gcuo02Qckw
         2PCuvQTgFq90HJIp3m+H2mN4NWqsQokk18CcvVuFiGBSRb5rRtn8FgPKX+9OwMqEwR4J
         b8GbOKmZtjrtYaeFWbjLljwa4L0S94tH66vTZySzeTe0+j61b9KSJQROzbP4NhJFnB8L
         P6Kau9UYc+dWOo7EDKniSqATiBVmsEcEOk+sOl8UaBVnsnZ/WoNcGYRXRv3SCSAKLfmE
         MnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920672; x=1740525472;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1kVy79PjjwS9vT6eqX/jn2fuQOg4ncGF32yCLYKYdc=;
        b=hWLOlg5etHwxPrJft1DJl5/cvzqF/BPCiUP84s/l8UyD+CgItVXlTD+rEhFZiQ2Mgv
         dSeb+SMqe1QhCYD4QStn5H0JpsTeSMDuYnL4oK+50c+4pEokXCfgrgSimh6e2Ao4qCmu
         MM/Co1JcMi3BIgcOmOldvDdSuKrJOTSmc2rtknqk/wvOVbU+tzpd8f8HJgpOfCmKuo8W
         aNguSgZaoAb0GbpeOQF3SkkM8rzedNyDelYgABkdwPMjKIm3IamJJSBnp00d93NlO2JA
         1N1WOOnzfBH4RNQAwsVf52UvgHEOHazHshgffBKlI+c5mF6DTrAnRjGqVmXO/NnfU+kh
         9IRw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqDgbClkAEuNEnmzGuosuT6omRQudFtqfIR2tdycaQfUq296ResqR8x7NECDuFEZstpVEGHBqvgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGzW2VKSEim3okCaPE8EdgNU/4QHOuGaQ06XMFxPD3elSN81H
	BextFgNhRwyUwk3+KxIPYNFDOP7h64BUzTJkg3ljt+NFIqiqthdH07DW/ukJMbAohPM7yLB1+qf
	R
X-Gm-Gg: ASbGncuR0UJlOtRXEYhMldvlr7Cx89ua4/SwXI7ti3cRJeG/ocEXA049O1r4i2sj9US
	JBjREAILq8ZiVNm6j4wRBsOnHxWkyc9EyBj0YljToVDHwmXCP0lndUYpq0/nJJ3jhNE1+qU0X6p
	vKzjhKKZhXqnWDFZiJJYaeWzpjwxJkG2A6yNuc8tNmQrDkzhbQUOJxmb12h1S5gy0D2UgLBCPNf
	HqPYMLAUpOkgTC79oiphzIJ7xjMZdmWj873Ync8Fpo8MEbbqntO5+YfuU/SEtM9NnBHxipF89hH
	lVATIqDJCMADJGyns6AMqVrln0pAfz6MjzSsnrf8rFZ9/KI=
X-Google-Smtp-Source: AGHT+IF2i0XRfyPdA91wJLKRW1188YEW171fIRsR6f4XJDZE0cMHbi74c3siOXWTxamWwIe6ApxsEg==
X-Received: by 2002:a9d:7482:0:b0:727:2731:d5e5 with SMTP id 46e09a7af769-7273711f98bmr1287196a34.12.1739920672122;
        Tue, 18 Feb 2025 15:17:52 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7271f7c5ba8sm1803129a34.32.2025.02.18.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:17:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad4695: fix out of bounds array access
Date: Tue, 18 Feb 2025 17:17:44 -0600
Message-Id: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgVtWcC/x2NSw7CMAwFr1J5jaUmtOVzFdRF4jjgTYLiFhVVv
 TsWi1nMYt7bQbkJK9y7HRp/RKUWE3fqgF6hPBklmYPv/dh7d0WRiiGRMUy3EbNsWNcFa8ZY15I
 UQ2vhi4GIVfGS3cSRzpHdALb5bmzF/+8xH8cPtGI/WH8AAAA=
X-Change-ID: 20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-7f16ebc3be14
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Trevor Gamblin <tgamblin@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

I was doing some more testing and found a bug with the
in_temp_sampling_frequency attribute being corrupted. This is a patch
to fix that, plus a bonus patch that cleans up some related code (it
wasn't strictly part of the fix, hence the separate patch).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      iio: adc: ad4695: fix out of bounds array access
      iio: adc: ad4695: simplify getting oversampling_ratio

 drivers/iio/adc/ad4695.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)
---
base-commit: ac856912f210bcff6a1cf8cf9cb2f6a1dfe85798
change-id: 20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-7f16ebc3be14

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


