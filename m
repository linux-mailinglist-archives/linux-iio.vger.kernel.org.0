Return-Path: <linux-iio+bounces-17048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C4A68010
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDED84227EE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809921422F;
	Tue, 18 Mar 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kQFJkzSt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D8213E6F
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338344; cv=none; b=qETPKp8+mvbbEPQQN2JQtIKArYxCIj/wiVQyEM1IQeE7jkk78Iwv77VPeNolCeMQxfA9FqgThLYWZfdlSxM+a2lBuL8s89/LNi/OYxJLI8sfR3j3aIPlYa5BwiuicSBvf8o1jQIqIo8oVNBBsvreiE1meUnW1ea2/CWLVEUjxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338344; c=relaxed/simple;
	bh=Czh6sIf2f9O6GK/Ws2/trCYTXsw1wMYMLHDMiolIa84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFPW9YHlrWHQpU46F4s7b5u98pTND1PD1WeHVmlgKmpba2wQJ4/1IconJbqdRu62AR45UTRiIuv5Gq2G5noInLxH1HcX0V7EGqWhOJVw9laj4CFArxAF2HktKF/wv93/kVPA6JWrlEDmB15475hQw51Jqb7ETwbVG9GLyxrJbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kQFJkzSt; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72bb9725de4so1038127a34.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338341; x=1742943141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKnUxBRqQ7Ggqr1I5p6rWXUIKzQVKhyI8AqqhJXQohI=;
        b=kQFJkzStfqa/gV7eptXXwfvoAm5WmaiKY4xucGIAcjWIpG7zY8jWe4FTSap5NHC5AC
         +WXjJmBqQH8ZRWZ45fqZpv+8D1yftF9yYj9mUfboK7yBYh+9hCq7YeW2Ftzz7UGdFoi6
         CSUQ7K/9uS7dv6h2S+JOmalqV+X32jiFiSsO0McMR36XjeppMcA90FotFSRxAn0Z/GPp
         n1W3FXQyCHRuDkfEBLt4G8wNrEbOULqR8/tJnUNHGsT2hhbAV97fEm+BmrgoLTXZPl+r
         I+O1Xr81gIPKCOAb3pA00SfhA+QPvHddNlpbA4MYnlItlOS+ewnB6wxjTL4LpUxO+V/D
         BruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338341; x=1742943141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKnUxBRqQ7Ggqr1I5p6rWXUIKzQVKhyI8AqqhJXQohI=;
        b=ECnUWqnaKkTK9c27pYZlWD3GjqRjvW36kq43d29Gzqq/S4ofrveyHBCSrjtByPDI5i
         ZydIamtfVNCpSj9pwPBlK5HgI8NAMOy0GbAnbrQmbR6S1ruELf5aH8MT8kQvHrKmjgfM
         SloZmW1TSVeb8iHDYvWC7SOGl7ozsDk6DBEXhU3Vl/rrYK6dwcT2mZky3KQRpRrMlQF3
         cwQ11VPEwoWdN1JMWUHJKETEmh4Oypkextm2W5/gKxpFJ+YWA9+SVraIwdfgXGEXmKTe
         evJCS110UGnYiNlqhYQ67J4/m9Cyt6JwJl/Hue6cn5g8aQKgDaFQqcVm08dV47fOxFjg
         IxIw==
X-Forwarded-Encrypted: i=1; AJvYcCVclFFGWdbPo5Rv4FmGtQHRIQovtzrZy+qk2g0FAzs235gcyayDWzABHksZOnvCGPQKZqnuNUdwhJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkt+UJWptaYJ9sMEo0wxmiA/xeKb1X2AE2wPIbYivHVehwuW2N
	b7IDyP+FNEkap82HTXq0dGGUdSBAhE8EA+OEV47+ONRq9y/CHsGy+y+bygFFWBs=
X-Gm-Gg: ASbGncuHHhzh1gDPSS1QL45YwB7YpObG6pehBopz/yZ68x/3rzFyxKgt01yHuL7W0/Y
	l86hbb83rdiTYBbzsTVcnZAEKSdc9P66k7S1ee4X6MeshIuWHNpfBlQzaLRzMnKNogmI9IFZ/F0
	A7e58Wx2TysN+58JcNsiMM7aJqYiiWVUsGECYSPzb7c+JDjXxLNFuvJTORdNbkMQbyxYrKNyC2x
	Du1dN0YtowSEQ5vDAJLjjK30VQW0MeUBm2fWFQ2IILD5bseReA4R2N59n1PZ+F+t89r4Mjt5uYs
	SVFuWemxp+ZktgcWDsmkZ+h6mICuqe6QS8++Qk1oYE3UJMgOGySTcIC4GPXr6tKtNKbyBrm8SA3
	e
X-Google-Smtp-Source: AGHT+IHEITZFjsR+M4QwJ/R55tRcQB5RKbUX7sp2wgvScRVeOsiUTEZ8TfowTuiSoueX8I9snIFApA==
X-Received: by 2002:a05:6830:4118:b0:72b:9b1f:2e1d with SMTP id 46e09a7af769-72bfbdbed36mr369070a34.2.1742338341409;
        Tue, 18 Mar 2025 15:52:21 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:12 -0500
Subject: [PATCH v2 04/10] iio: adc: ad7606: use devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-4-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Czh6sIf2f9O6GK/Ws2/trCYTXsw1wMYMLHDMiolIa84=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkc7EZdha3SWgCHJA78vArymnZGVtiL/Fx3m
 0DjEldTAoWJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPTOg//YQU9pRBQ8y7NQHTMzUKCZvpoUw1R4xQSGGOyV3k
 WfRpTUt0VoWqDKZHzW3fuluO9Rz4JJjsO5Q9NGrskLPZlROQQdXohBat079jZM9ch/GcoSbiPxD
 ycCv+4RcQYfXb6TlJCesnG0q9UewsZz7WzpwxNN59W9v6J1zX93bHvqrKzF9lI/FG/gQ6No31z8
 0pnsbDcA9CMhCwxrLoKGGYRJ1ats3gZZ0iFpA7L9kiLGsqA4DG7VPWUEBYGpMhrSx4kPBRejiNW
 EnvjtOtjpRN+tKhScsiRnrQowQ622+L3ReGpNHCknzJKyhYEMk39x6CL6zJJjXdxpIQ0SZcGnMl
 VGvJtlSKJpOO9TVOukrp/7x5/3QjHO+gXbDJnJX5SvWgcuAhDHzi4tgRM5/bmU+SwWQg8LvJqJO
 bdgYxZraCg/jOFqjxW2pGWXGbxFoVg6kgGz7ZVEcfTiYve4Fzlxwn93t3SfPO1S0DVIYEfquwOE
 qkR4Db7Yiyf+MF2vZuwrcebBrzKKXkKXELzqU4jokoikl/ynaVXV76opAsSya6h7VLLM1kmGutv
 CDsXlemtgx3azyibsxUgSTD44hs/651ItoIBd041WS4M/ZipNbkZp4vpphIYdq/pKPboowBjKbg
 woxNQwf0MLZj6pWSVus3ysstwcG/OWVu8Yqrs1cfHzhc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use devm_mutex_init() in ad7606_probe(). Mutexes should be cleaned up
on driver removal.

Also add missing include while we are touching this.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f9b5ce0a8fa72974b918912e2388501919175653..b81591d8bc520c730e1632bd15eb1eddb5a59c90 100644
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


