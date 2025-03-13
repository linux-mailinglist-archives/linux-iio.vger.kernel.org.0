Return-Path: <linux-iio+bounces-16753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD7A5E949
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B97AA776
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECCE14830C;
	Thu, 13 Mar 2025 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KFVAPU2v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85D78F34
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828581; cv=none; b=h8Fj9aWiWwPWd9vA6/gubphppdJSMyV36HSRKimyLSnEmpMW35Z3GjZTc1hTvhx2sBbdd0wxCYPHcEXEfy1Ms+gSqcpQEDdwEfMgMCTF6LDOJanITIzoPd+H2mjLqT4CfGalsh6aa1KIAIcneDJaXUAcJeBHzIhllcC/CAOMQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828581; c=relaxed/simple;
	bh=aCSNxcqCNLEUdXP5FazNSb+W8f+NI36xN5h7zORo6DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rf+VwuklQn6z9UDEMWMIgmUKrXXSY8CzuQlguMmXYv1EH16KYiTo0BboQhLCN8ObKZ8L1gAQR6hjZSV1ppIwjbyAiaa+Z+5UCH89TaKIozTqRFDtLlL1lk+OrHOi4dzHfJYLfJXMYtw9+ZIqaK/i5N/jLW+Amo9rjgfyR3ScrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KFVAPU2v; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fc6cd89f85so197917eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828578; x=1742433378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IIuScC1rZDljAss89HaUIuq6Uq+FR8kalUDdTgby0M=;
        b=KFVAPU2vIcGi5ZE7anJ//Tb2ehsCrzMEH42TlwzK0p948gDf2poRkfNDtT+eZxlAQX
         Zx5j6okEJFy6CPN/JDyjOtmzkefxXuBMppGeKyr3CF0rBFg+Nsf//osVf+Qse34VJOeY
         LmSHVjclwIs7Vzh6DdTJae8k1jijAkmPRDvrkttU6M1rcFqH3Gc8KzaEvd2+Y9ITFe65
         4nSlwTE9IzFxZVW7FAS9JD7At/kZJ2iREuSVkzqUCdxKGE/0jZVwt/T8QzQJUk6rqrQe
         OqCARC9Mm2svAmCsVDbOkclxytrUKNPWs54YR+fSngQYLujWi0bi6nn78d4Jyvw04W+p
         TDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828578; x=1742433378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IIuScC1rZDljAss89HaUIuq6Uq+FR8kalUDdTgby0M=;
        b=WpgakYjsExD6noSi0sflgmfq1f6MS66Jm8WZGPwjoTVc+628JCPO4a5svaM05Mezjy
         fNYK4tXnklmbzk81yqxjwwdjbm1k7+oSnNDJV8NwbzOc7XQckZ493i6w+xQ7jalTPOo0
         EU5gd7jPMjBMxsPKq708H1vtqBErqIW+Hha8UgLym1BHH+M1cMd6lB1LYgTXmBddH2YX
         H4XODfRnzWi/FIEZfkQKcdMgsiNBeoYwIrmC+ae0J6tajKcnIPrvXXcOMcajuJXzEYl1
         jaZAkUbcrrlQYZdzyXe7WnJq6pgh3dtAU5TA4okx6yB/KxAjxq5fCdRLnuxdfSIUmCHT
         H5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6BJvfLWMfDmdqocY9looUA2wQVtH694XfZ1l6/tmgTcm+2TYGlgMPwu7aJGvRArKdVq5poey/FdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVHSsvME6eM+rtOZZedv1Nq5mHcTEtWa+5r75oMmPJ18h1D0B
	49wIMAph6j5SxQ6oflek0E1b712yhLar4d43koXGmj7Xs+vNb3FFkH0U/v5RT70Sgc2v2+b7Zd7
	3rlk=
X-Gm-Gg: ASbGncvr+lDhhrRJ9dtgSSD4+Cg0gkbVUs5gs+bPSRtiadUirEHwCmV6dOh8PzcQjuS
	HYL0CTeteKoMfHOW25O0qYKGquDTPLo4cBLfVUxca/AddzfPhMkP22Tzj78rNTr74746r8aLnqA
	KFkH8ORX/yz9PgXF/UtVDLoP0kHzVH4LijytnNmEQVut0j9NOVXFOYaaSaajCJNX0atjyZngYwz
	s8s+q2u9yTAdvaf5AxCJb3e6jKd7U3OITg/IDjFZK30M98yFrnBbbhkOx6Jw4wVRrIx9w/KMPcd
	7RX9XIbJhdOkcPvDapWhSZfTwTeA0IV44AP30yaKayPkFQ/aM94vnWbtemF1JcY4KywuCG/0UDL
	8
X-Google-Smtp-Source: AGHT+IGtx2k9tphbhIxjLIxklim43Ww0KS/NgM6K2oCL4pPoTPBS4pw84Znc7oQxTKhMXDFS/U+0ag==
X-Received: by 2002:a05:6820:2004:b0:601:cdab:15b5 with SMTP id 006d021491bc7-601cdab16f0mr3345333eaf.2.1741828578467;
        Wed, 12 Mar 2025 18:16:18 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:41 -0500
Subject: [PATCH 03/11] iio: adc: ad7606: fix scales_available attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-3-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=aCSNxcqCNLEUdXP5FazNSb+W8f+NI36xN5h7zORo6DA=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHa2hL66LYzoihyFfoiIzMijDBg1sgkeGOsH
 l+BVFG9g1WJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANf4BAAnzvOR2ntBn0KilSMct3KWbfusfV/nfau1wbSCvC
 PPzWDfPfOoloJrfGmPCk5f9MJJmL1EC7hPiu0ssSjTrau9bocl9PPqEFgJ5DEugPcjIudpPiRto
 XN18BydifzRg/cgIJ5ZJYqW+nBZan/XXqgiY5yA0sgGUi0GqExjz5bvoOZvUAOo27iK/E9MdKvN
 KQ6ayM/ap9GfedElY8n6iZy8WmBcZBb+/XAC3ob6CYrTMQJBB3xOmvlQXUJviUwCuB0ZoLYVX0Z
 aHKsu7lVB2hGyXJZ3c52xU1PYvvUn/8+wi96unTsx/HpcqHO3B61HMx7KgOf9q4FXarKEURRcmN
 FicSHrcqoPJw0sHZOZeEip8Kjv4GhFwRyQyjgDtA9p1XyOkxJGuox/hnWwLP7D60m+y0OszDHYW
 1KqR2T4zCLD+tUauBMgWHpKQe6tThoQbaKchdd6IN6A1CXsDTCJPWck35vNSzkwez7ywQ7vC5/C
 /psRq+h9/hoQas1giG4gC6ONJLtDrjEIuSPKjF1r5h4P9WaL6kOTiBWdH455R9yMOvS3Z5KX1QR
 vkr9McvTYmOgnvbaGEQDAxhbfZ5VWssvwcO8cBN0RRlMQrLY13vSQuNxwBVQK9TBt33puNoT8DP
 c7RauJGq91IHfPF5Z0yX+HIgWGzUVPBItUQIX2CL/TSQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the scales_available attributes to return all of the scales, not
just 1/2 of them. Also fix const correctness in the cast while we are
touching this.

Fixes: 94aab7a0f5c7 ("iio: adc: ad7606: rework available attributes for SW channels")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ec444aba25e89ced7b84b723aded3c9dbf2c738b..79929bd24fa40bccfcdd88673107da4bf56e032b 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1064,8 +1064,8 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 			ch = chan->address;
 
 		cs = &st->chan_scales[ch];
-		*vals = (int *)cs->scale_avail;
-		*length = cs->num_scales;
+		*vals = (const int *)cs->scale_avail;
+		*length = cs->num_scales * 2;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;

-- 
2.43.0


