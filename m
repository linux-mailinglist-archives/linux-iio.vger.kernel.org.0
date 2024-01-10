Return-Path: <linux-iio+bounces-1545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615EE82A147
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 20:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704301C22800
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0D4EB24;
	Wed, 10 Jan 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yKV/+Qfr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A94EB23
	for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58e256505f7so2394548eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2024 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916271; x=1705521071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tQFXGB0UBE3yQVmYcImKXXjk/ehD/gF98AYs7jrXzE=;
        b=yKV/+Qfriqeu0qBj16IXEt1rSLw90lnlhjOy+tyC7v7TdhP6uGBuPEMCUXuy1c4O7t
         avMDDkMYaHi7r3eppgI2HoVRyNAxiTYvpiisrGng2hZn609pSm9uAgau+o0nDORZYyRF
         S7wrVb3HuSBn9M4f41ZLCyXDvAMNwS/bZz7rkfhFi0cBecwBe8GMG+PnCG4yV7bUUbDc
         Ao0Mz4cbNDXxNtB/sp/GBvFVqhBqNVJEX+E4dAwSxlI3qJwx9X2jbEroAcAGoVgsP7xa
         yaP2LVm/b9zkPJ9n/zYrm6TZ2OUzZBl1jPuIKCYquxUU5+taZlpjjC3jlL72wx4FYUiz
         1mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916271; x=1705521071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tQFXGB0UBE3yQVmYcImKXXjk/ehD/gF98AYs7jrXzE=;
        b=MxbFs4e6iuQieYF+DYWMNhbCPxYgYS/QlMXScQzXB1PxUCntJWzM0Vh+sk4FxYZE94
         yUKcgsLTnqsReYFMB2yvafbfagxO95TVNDMVFmgZjLtpqVKeSc+H5Le2JhzGbrbLR9dQ
         cJ0W1y6FjCpmT3tqEYYwfNfhUM40U0bR4EfJ/OPGlfmp/1mqJ1njB1jLo/YtN67T7RYC
         cpgIqLTfLCySa9einlv4wVixXDiAiEKgrpOgFF53igK5IGjoRRDf91bC/kh4S/uDxJ5Y
         JOkK3kBYCUGN6fvSA0eGTBS/iAQ7Dprwb+sjksBhfpToa8YSnkKISOex96HX17YmaH66
         CQjg==
X-Gm-Message-State: AOJu0YxQHCNLSuq982qzp/83amEoprNWEnRmX8AsrgoSy0mplpFxOmQc
	6XGqNdMIlvcFypfG9tWXDGyMLJuZ1OkDgA==
X-Google-Smtp-Source: AGHT+IGLTZ7rbIwDjuwU/b4aEWgy3uOE14zbEekH51p0401rK+4z9X/59v8/8YDpPt2l2qc30H7TDg==
X-Received: by 2002:a05:6820:2382:b0:591:acf8:d08f with SMTP id co2-20020a056820238200b00591acf8d08fmr140554oob.11.1704916270980;
        Wed, 10 Jan 2024 11:51:10 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] scripts: dtc: checks: don't warn on SPI non-peripheral child nodes
Date: Wed, 10 Jan 2024 13:49:43 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-2-e42c6a986580@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

According to the spi-controller.yaml bindings, SPI peripheral child
nodes match the pattern "^.*@[0-9a-f]+$".

A SPI controller binding may require a child object node that is not a
peripheral. For example, the adi,axi-spi-engine binding requires an
"offloads" child node that is not a peripheral but rather a part of the
controller itself.

By checking for '@' in the node name, we can avoids a warnings like:

    Warning (spi_bus_reg): /example-0/spi@44a00000/offloads: missing or empty reg property

for a binding like:

    spi {
        ...

        offloads {
            offload@0 {
                ...
            };
            ...
        };

        peripheral@0 {
            ...
        };
    };

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 scripts/dtc/checks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 9f31d2607182..5af68642f231 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1144,6 +1144,10 @@ static void check_spi_bus_reg(struct check *c, struct dt_info *dti, struct node
 	if (!node->parent || (node->parent->bus != &spi_bus))
 		return;
 
+	/* only nodes with '@' in name are SPI devices */
+	if (!strchr(unitname, '@'))
+		return;
+
 	if (get_property(node->parent, "spi-slave"))
 		return;
 

-- 
2.43.0


