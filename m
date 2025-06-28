Return-Path: <linux-iio+bounces-21077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F2AEC987
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202E9165172
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A100265CA6;
	Sat, 28 Jun 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xIlt82+p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F72BCFB
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751133176; cv=none; b=L2pFfJ+h287LRqOp/lmENifdB1BF2LGJGJ68wPYU8aH+07/n2oKssPxDb4K3KKz3loxD/cdy/uOKbbQyQFEacKgnZDFF4c+U27uEU5aaJOKdB2aN4fmhhdCQ0kMX0xpZHc6NqO0DVPX6DaDyICFosQGmYXd91gCRWzI1g07NWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751133176; c=relaxed/simple;
	bh=G3Y9nAnQtjyRjf4a+ZR/oAdEauIKbjZi5rgSnqD+vio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qitG5lhh4PUW0bc/dMfpoq8JMRQ5DoreD1ArHN8z2rau40dSDnr4fGcV2rGIi2QDZWlhlqQcLLmJkNWumOXcFum09gEb/0twKyuknT+NNWs9Y+s9Wj9D2yemBdu4Ua4anPnotD2Vmad+Vp/oDICqBOz2fcOOVvdxOaMslwQnLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xIlt82+p; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73ac40e810eso915031a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751133174; x=1751737974; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHo0BNmd9O73IqwLXI7ZVxz5ifNWJwu6M7am5hfDqAw=;
        b=xIlt82+peS1Mb878nRcvAlyyY1s2yh6ltxcnJoGtx/tEoEMJZzqLV9j++YNwxuIHHt
         T2AL6k9V9PJ/qC3CAaSdqzp4JQgvmcVD5KRFu9HfbTOeW+NGQF376qwQwydFAcKPLWdl
         fFsYpwsWGtuH9lRQD5HWe/RroMysMH4DhQB1w+qbmDk0r2cJes0hOXMTKQIUzVSuvtL6
         9hKjKGONsC4eb/SGsAIwbLop30vvjUSxY6e5g+ZzY0W6fi2a3llK7P8PS948F3AfZ8zG
         s2V39jz4i30vXDFKNziezYwU3cPzKsY7iCpRLS/KCUci77UVo9B6yIDEazW8QHYhIVoG
         KnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751133174; x=1751737974;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHo0BNmd9O73IqwLXI7ZVxz5ifNWJwu6M7am5hfDqAw=;
        b=NxNl1LWfpdVz0vnXb1MhFJEBe2Fu+xeqNsV5Vdpe15oCyR2hX+FDgJ9I7A/9PSPpP2
         si8bhjjC1lHX5Aq6f99JN4apg8IzPizOgKnXx7j5302Nf0RIakny2Z1b14zbpevh7cuW
         qGja2jV/GY90lbIE5qEBMQlvxooQh4kUzf2L5704tdgUSshIromFpqnFJEp9znkXmn+z
         WlIcYChFuuW9BIgHU42nQW0T9eEtVN49Dyq3OnO34xhSg3BERwSJdPGSIIzXNA7b4t3i
         VWAtGRdJpU1PV17MoE7nVnvaYFbg9FsZ8fXGZiltgnFs0gwK1sNMIHW+7rQHaDexcLxG
         uAhA==
X-Gm-Message-State: AOJu0Ywmry/aYl2kJmG8xQxDvEw6UbAqzHGwEyM6xe5E0aQfvUQ5fNwP
	nfr7AeUiSDom1NAs0PBNxoAY0i7oH2gmnT1EHoXdffuapPcr8UocGW9Krblp1ta74E0=
X-Gm-Gg: ASbGncvDC7DRCdV4inYCuh+bJZ4ROGiMAIwc4RhXUdpJjvqGAVwJnzFvw1AQrETv9HT
	tZmKGyghb8HAnDas7MliGcsXwn+l04c6nkZw0ll1HeKLAaiyiexrL/6MljiTd4EKAi13lyPfm2f
	JEIAnn2q8hoEOHTA28ytDrdv1ECFu+VzMOWzzKLTKPC3Hbe0Vr4F3xOt3QDtskaVUpMHix1bGhz
	Mg/gzq1I5DjVmcKuQs5SZAx4bTgtr6VlKy0V5xRTYvGSO4D1LgGhHSiTku5Ksyuep9fQOgTgVY7
	DjBnTajc4ZjyuTK8jFhhAaGi7G8HL3C+6ksvM5wgEgVy2CEuQkf4rO673MkNzIm66MMQ
X-Google-Smtp-Source: AGHT+IHMCLIlkhwpjoKd+5r66hiD/rFrgVweC2g79T/XPrWeUJax1Aqm7JCZjalBherHHtL746KLwA==
X-Received: by 2002:a05:6870:3118:b0:2d5:2955:aa6c with SMTP id 586e51a60fabf-2efed72bbd1mr4915513fac.31.1751133173890;
        Sat, 28 Jun 2025 10:52:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b4d84sm1593530fac.23.2025.06.28.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:52:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: light: cm3232: make struct cm3232_als_info const
Date: Sat, 28 Jun 2025 12:52:29 -0500
Message-Id: <20250628-iio-const-data-20-v1-0-2bf90b03f9f1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0rYGgC/x3MQQqAIBBA0avIrBsYhcK6SrQQnWo2GioRhHdPW
 r7F/y8UzsIFFvVC5luKpNihBwX+dPFglNANhsxIk7EoktCnWCoGVx0aQr1rRyORtjNB767Muzz
 /c91a+wCmklZhYwAAAA==
X-Change-ID: 20250628-iio-const-data-20-1f1a05001890
To: Kevin Tsai <ktsai@capellamicro.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=661; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=G3Y9nAnQtjyRjf4a+ZR/oAdEauIKbjZi5rgSnqD+vio=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCvf3RF47torKYrwTGqNjvM+BGYAJPPL8EbV6
 q4LmPmZWC2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAr3wAKCRDCzCAB/wGP
 wE7DB/9JPrm2lZQYqP/P3zkr/AnK1WpXvylRxymdwEdGo6bqo7k+/m+9Fo9qs5VhXFJbvD9TtDa
 oldzzLxE5PomObtrGv1fQ1X9HgjKNLeA0Hp0WcwLReAktt0MBs5oYGE85NO4YyeHVDMpwfwPh/H
 pSA7DDZ++T2lliJZTYpSl64CYX24SFYglJoZ9ceBUmZnLv+wxdpyWOzZYyXCLlllHl+eusVUdiv
 9d4HDFgshkr1xSuHryEbefMpkNpQujXyN4oXJFb/iAgE2bBwpqx/wasig2QXMMTCnA1H4WiTKIN
 9tIqGiRcGPQdgdRrF/GhGi55P+iluwv6o04wzYo9j/nlf9uC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Typically, chip info structs are const. Before we can make that change,
we need to move the calibscale field to the driver data struct. This
also allows individual instances of the driver to have different
calibscale values.

---
David Lechner (2):
      iio: light: cm3232: move calibscale to struct cm3232_chip
      iio: light: cm3232: make struct cm3232_als_info const

 drivers/iio/light/cm3232.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)
---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-20-1f1a05001890

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


