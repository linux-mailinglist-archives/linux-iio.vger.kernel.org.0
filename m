Return-Path: <linux-iio+bounces-10294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834F9931DF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97001B2536B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588521DB37A;
	Mon,  7 Oct 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wjync4DH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA391DA60F
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315953; cv=none; b=MrNPd/wS1bYNinregVLLKivlzN5MSpnpe7YC7yxe6GdczxzvK8PsqL5pLfZlvk0GZqFflqeLiW6c0WkCVFMni7/23LpsbfutkeujN6dYav4iSJLhEgIQ9fM3IrzNnUNWYZZ8M+o5igjIRBqNoozBs4SIe0ylOztVCWxlajE0f8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315953; c=relaxed/simple;
	bh=ZXp2MaLpZvcOm5A1oxJOmpktuau4lw5UjykBgfjJO8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jH0kTUPw9Z5+1FGUmwPYPp15COte6WgXB3aUIkqOrn7bXISJPNrdFgtHLTs3zAupxeJOVXxUp581vjouhHpcg/O9AgB2AtXBDuAllXv/yGbKbUscbv/jcidoT+1+hNT017dlHxJ/ZFhhX6zGI+lCBErBBig4pO30wMggjJbHtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Wjync4DH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so46741345e9.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315949; x=1728920749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojstTyg1pnZB23KdDSwZrfNu+xTBHe5+8ZL6KQWO5vU=;
        b=Wjync4DH/EE9HWUf5DMYu/ZeMs889KqFHCkqFGyxL3DeQE1FthjiSymS4G92anPZHS
         cybMUQj5p8YELZ8b3eehV+RNMiTFQHdMf2LmzFiZ1c/LYYKIh3BNu0raPgYATb3jW5DA
         peO9WwpFL2QJGGIwoic5BeYBlcEGMUNUloUqsX0/0/XnVlUf+hneqOUTc/m76zRem3Vb
         vrWWfnC/BArXSUF2H4CKu1KevpJVs231g02aXOdkY7UeIGp1UyoJg64zvcApzb72m4sP
         C1II73DJyyamgfpC+nAOdWV0zAdG06urJXGlVMbmx/hWr8pWxAVYeEslX0LcMsrCrhru
         DbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315949; x=1728920749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojstTyg1pnZB23KdDSwZrfNu+xTBHe5+8ZL6KQWO5vU=;
        b=jMfTGHzcL4WpG3hrcGlhtJRLcbYRNiAFfGFGTev+ckXP+RdkUr2ySMxWnHHO/kjnb7
         eZixjn4Hja2IBnRXM7Ugv8LjoE+j6pvpFjlaEFNFPLFL/DIfeZ6H6wOlkRmyDOcp0dBi
         b/nYEuSEaLAN+lQESPuQFeF/PgiFOpb2aC7Qa1BQsJDgeGq4Lj98uoqat1rRCs0q/5Uu
         68dyJFtP8hwKFMG4u4vSgmdZGtxUFJX3LM/1koQjj7UpwO1dot1gj1xOmalW32asbJtZ
         C8JxkpvALQhb+5VEab7MHJjxCCt9utBcCU4gVHANG6uuTJgd5li4raPEzou3G6eHDUdF
         JFMg==
X-Gm-Message-State: AOJu0YzAJWpmhBGPXQAENZ9TbJCt1pQWjrhIWDYk5mkAIcUl7bk5rMW+
	QXB4+bsKdaVB5+NZLb1xDP16umYpWpDWsiLUD+7C3h7St2PRRlb7olcxNwQZMPc=
X-Google-Smtp-Source: AGHT+IFkaUFrNKgpEhRj9y7Z751fJZyDqB9TXK6VMlRQ+6Ipso8Gpm2aKBbAueSQ7imOULbXRTfOOg==
X-Received: by 2002:a05:600c:4f14:b0:42c:b5f1:4508 with SMTP id 5b1f17b1804b1-42f85aea060mr88251595e9.23.1728315948973;
        Mon, 07 Oct 2024 08:45:48 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 07 Oct 2024 17:45:49 +0200
Subject: [PATCH 6/6] docs: iio: ad7380: fix supply for ad7380-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad7380-fix-supplies-v1-6-badcf813c9b9@baylibre.com>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
In-Reply-To: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

ad7380-4 is the only device from ad738x family that doesn't have an
internal reference. Moreover it's external reference is called REFIN in
the datasheet while all other use REFIO as an optional external
reference. Update documentation to highlight this.

Fixes: 3e82dfc82f38 ("docs: iio: new docs for ad7380 driver")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/iio/ad7380.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index 9c784c1e652e..6f70b49b9ef2 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -41,13 +41,22 @@ supports only 1 SDO line.
 Reference voltage
 -----------------
 
-2 possible reference voltage sources are supported:
+ad7380-4
+~~~~~~~~
+
+ad7380-4 supports only an external reference voltage (2.5V to 3.3V). It must be
+declared in the device tree as ``refin-supply``.
+
+All other devices from ad738x family
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+All other devices from ad738x support 2 possible reference voltage sources:
 
 - Internal reference (2.5V)
 - External reference (2.5V to 3.3V)
 
 The source is determined by the device tree. If ``refio-supply`` is present,
-then the external reference is used, else the internal reference is used.
+then it is used as external reference, else the internal reference is used.
 
 Oversampling and resolution boost
 ---------------------------------

-- 
2.46.0


