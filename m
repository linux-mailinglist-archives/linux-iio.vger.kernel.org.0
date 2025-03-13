Return-Path: <linux-iio+bounces-16755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FAA5E950
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D427A85B4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821A18952C;
	Thu, 13 Mar 2025 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MTW/oNqf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADF154BF5
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828585; cv=none; b=UalGoDQLox5IOe2YjnQIxFzBcYToqPv2m7St7FyLPsSpk9sdAj7nrFzhcxy67wb5Er4ARkpMXIkUop12xDWQp03YVSorYizml1GaumsIW84EIJqw6xyHuYbpfCQBqZ5YLjgT1sz0lI8AdjQBgmXuZJIhpsWP8+c/e8PL2ymMxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828585; c=relaxed/simple;
	bh=j0OwH7hw7Z1b3HyiF1OCjv9TuVAtV2k/Sj7t3TrDRug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBvaueJvzKsXLXy+j+37IMMum0E7nzHTIxWcYaP/TVkcJ0FWWKwE3QX4pZFTN8bI2DyGHrd7AaaelHkln15ICi4eSx1l+lb1Uw27DnxD+lGDyNIBUcNX8VkO+etnInHzQas/2tIIPIfj22m8E+WH7xbwjDDMoJA+iClt/Brts3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MTW/oNqf; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6003d977ab7so227778eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828582; x=1742433382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fmffu037s/U5DhU/4Qm/eUlh4c3Y4N1MaROpALwgUVI=;
        b=MTW/oNqfD6SI0o9XWUhHOTebehM/D1G0VQurLkhjjIs5JDLI9ZJYFt40yg9bVpZXMD
         LbB5niKwgpqUf8YK18pt5Jr+w+nQLsRjjKSuztDYmt1cv6vdCOepI5HHE0yzNuJr4tGl
         vdhcUUT78t9taGVJpjqvKMNQxds4dcQSrCsddXeVjfXkM92zrF5TfB9eQ7fWk3wYQbb4
         0/EHUTMqNnCsLdUuydFOnPx4XhG1LxI7xtraIY7DuUrR0jhptgdvJ1j0mEZpoX1j3yIw
         NFIxASUD+carIg4mGxd+yu93rBsv9aBq01Lnr85X9qm6MQBvQt9k5jWXmVNpViZWq4yl
         pK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828582; x=1742433382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fmffu037s/U5DhU/4Qm/eUlh4c3Y4N1MaROpALwgUVI=;
        b=ZpaVvUWJlH9b/qq4sYqbxaVkjhUtQZ4K72ocQyKrRQaXG8IWW13CeECnGrKby7IsHT
         sKIZCO9wtWJ1LPiOf2PgVrvp6eW8efcBJMbs4q3yb1jbseuufzKSMcUO2rXL9O2KawF2
         rNCcfqxjMaN9TbePDZfieyEbtF+rG94dgp44x+OgIuMbAoe/rFnKPunWLCOD7UqvNXnV
         pZ5A3uevgohkmE5zEwrtsY2mqPU2sX4Y2QC26O7JouWH0OorGSqKsonalM1FfFjCvuHX
         os3xNXb1FY+bjZDrTI7xUGIUs6B24ouoWNDvg/MqaeDu3OWk0WnY/ogk0y3Lxia4AZxJ
         08iA==
X-Forwarded-Encrypted: i=1; AJvYcCXMjjJ0d1sj4tTpwy0bnDHzaUxmoxC0H2dds84elwTmcQ8Op2sOrDNpKfyLQPz3lZu5GGKwppqq1HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4KWj0Ul44WCV6iSOxc1HV3M2T2BByBJj6Tk7EKioGof2BF3e
	WbdLC2HIrYxtmxxn282hvCJweJcWM3iuhnytyxtwkI7JqwxRqBP0avku7XfHWhJzI8HuSIOzR2K
	Uxvg=
X-Gm-Gg: ASbGncudEvwF+dcmOkdAbtNJyYX9xfEd0gxyuXs2RcRWwAl4jycxDmmKj971w/Dn10x
	khlbAtOX3xL6OJIe75fWfZdzxgi5RJsRm3fl3uk6DOapj3RAvaInl0vc+Gz/Tn+tzQ0r5eUnnvW
	uJyH1Uwus6WLBQZGf2/xZb2TZQG0fdIAutUdI/D4yoEjIn2EHIcqkscLUaR8+ce013wORQ1QGFM
	StoSlkpO3YysXfSTF69gmb7ycY8/PRF0FT7IrqvYgVwQhNKOa82kSaJuqPsDp2NG92IdBfsZPf3
	6ZOBrC/QomPLNuzmR0/nYWrYDJdvhuRxaZ1bQXP0XP0uoFf9CGYd3QtnwDMtDyPQoWvYIuBCdRI
	i
X-Google-Smtp-Source: AGHT+IHG62j6un/OgQv23cM3V5FUNAh1VSrXx89rDwqZ/IlptiiF8UNCSL5BArMVaH92vDzHoN6O1Q==
X-Received: by 2002:a05:6820:1845:b0:601:a813:5f22 with SMTP id 006d021491bc7-601a81360d3mr11639775eaf.6.1741828581864;
        Wed, 12 Mar 2025 18:16:21 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:43 -0500
Subject: [PATCH 05/11] iio: adc: ad7606: use devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-5-d1ec04847aea@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=j0OwH7hw7Z1b3HyiF1OCjv9TuVAtV2k/Sj7t3TrDRug=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHaB/tuEDvy1HQERh8WW6U7nCYeKHCBENB7F
 bBkbdWQ8/OJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPe6BAAkH3NMfjir7Y5B2pqR8bhdCvPJQwbeSvxpljn5Mh
 GpL+cqJpYKZCTVuGH3VTTCDG/k/9GUrmLp1eW6Pa8TW4nIjUt8fNnsXocBri25z7P9PBSB5xRFP
 OCMvorGEOmuKXIthn5YFTTITvdjyAkrAQJ8OPfhgeIozUFGfMA8UBWaj+MG/LpsYpWXt27vQEYI
 QkKzC5pCEz2beAqGknJhLBOAaCmOAsIgbcB1Q69XCivTreM3AT43KAvZhv8FBs6RWOkDc9I9ZYf
 3iu5z7ECH6VDmihvx8nq7Vn1t95p6rZyTwIzml4WMPjWywktbMnI9abCT4gd/cTfLuhSOY6UouZ
 Y760zBwLa183b/R5rikNi4NnsOIaVajfsRAZDXIVAyRWXpYQvrePDFh1EQirnJOUpMGEZWPPDI0
 VBXBfxMa6m5xmIVvYCzsC3llUXCK+4M49x/HWC7YwCoUgxUXA5uXt8LJ93dmTYdqs7veErh13Gl
 IvcgWl0cgQV8OYYP0K12P6rxt000EDMvDUbeY3NQuWn+3AMOjQoTlYAqPGZ0KCgMz12xKlDIvG5
 JHB7fm2WHxXAu6mWYuEoI8gELegex6CEp7qpxDIB4AlLBSS9bFebumJ1b0q9kkZ2UwXb4nsoIx3
 +uPhrMzvMD76T08u7PfVj2SkDNDJOZmZc7pM0KGjHWOE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use devm_mutex_init() in ad7606_probe(). Mutexes should be cleaned up
on driver removal.

Also add missing include while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 440e1e5a9b18570dc6441bff91afbc51d20cbc47..f190269ac8ddd859e94eb24c26f5f010d0951646 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
@@ -1332,8 +1333,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->dev = dev;
-	mutex_init(&st->lock);
 	st->bops = bops;
 	st->base_address = base_address;
 	st->oversampling = 1;

-- 
2.43.0


