Return-Path: <linux-iio+bounces-20514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF84AD62E4
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7523AC3DF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6F293462;
	Wed, 11 Jun 2025 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vnpUm35s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF028DB71
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681783; cv=none; b=U7hbZZ1lkEFV6NfpSfvkyqT0ohR5nAqP0+4bolFqvv0Cm6qfngPzM8dvkNy7jTqi9jmt49NulHIic9jtXZi1hgg7P7MZ7IA9TvQbCtXOG6diULTOYoTtvWO+Ba41alswqH+gYh8H4EKrNmIAk0Rrk3JDAVVYJwArJPEmWpW2vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681783; c=relaxed/simple;
	bh=jR04YIdN9O2ZMn6ou5NomkQoDwMcMUyRaU/L4iFhuwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i81mJXvIR/gaKquG7KQIKbADGj55fTUFiWN3Ow6tMSgAVlJDZJKyr07ovPyclpJGqVxlsRn9akUObjW5eTT8A67Dj8vC8dTSEOYu7/RQbxtgECF7E28pi9FdWkMPM6Sq6YGyxSpFnRY/+8+y+UBmlyst5+04PMDM0AUxRvwdsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vnpUm35s; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c172f1de1so209464a34.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681780; x=1750286580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/fyvlcVM1ITpV4doxg6wZond1KIaJ0G2TrYPww/yVY=;
        b=vnpUm35s+cIC5c7Ch6NmozrPTA929hkGlKHV2HSfnefNXCQf7qDSKi27rYt8ro1jgu
         MAomi044K9kNwHxVJEPJhDLPF6dKNIU5vrqLyY0G4JHnbBcrjy0cSL1m30w0gL7Wnbi+
         tLmM5OdNwXwIOJZOBTsFiDUof9wnOcYFzxIww10Wd/ZsmhL4UDHXtEU7lwp358Tabg8d
         Q9qCEMkJ56Djf8bCp4CicppxPwEPdIyPZ3VPEQE6UeykgLt3py7LRtepLYsFoPK1wA3P
         alr0qWNzukCh98ddCGLeY5eU3VOhC4lpI6z1ZLJ/fA8J94wcQy6IDTFFf4stxBZrN6de
         oICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681780; x=1750286580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/fyvlcVM1ITpV4doxg6wZond1KIaJ0G2TrYPww/yVY=;
        b=Y5d29ViqCRrp+KY1rBaRRcTSFYi1LRRNSsXlo0Lo5UiUKdvWb1QS2Ac4eDxxYqiUJE
         5lWhnSOG88WE3nFUkKD87N6CVzxCW9+y8ISBzdPnRF/PcLpUzSGI8Xt8oZ+OtXPnyXER
         Uj1uEEPn63QLz7lIjNYE0c2nDgtyNRCsGCXKGFCs3gLJCOuu2o+l7MN719l9HTHAymKt
         f15p6zlAMR04CugNVuAqoxnJ0XWRA87tOEoElQdhLJ9mePAsgwi1X96vpn2FuWkuBsJN
         fM8zp7WS5W6X6YT8+jkW49oLtzxSuI1X2Ip8yeG5WZygFThUiUUqmpjbq/ONXgrwHeVo
         8sLg==
X-Gm-Message-State: AOJu0Yw9tyPOIDXKjgS+rdFqrZafs5KX78vBDds8HIfrS62tbyIYYXnk
	HK4xlpV5ab/HWzYLGxs6dAzxOf1AlcVg1R71vnl02xzZHzRHB/QAZgAh0+8iVa3g+JM=
X-Gm-Gg: ASbGncuYcmUgcaW4AAud7EFnh2neNSkOMgmaqH8WV4ABAVF1LqR8TxwiXh12Z4l7lkX
	n44i1/0SPNV75ZlrFjoswGGxVKLxKiFC/tCHfoFciOjnQec2zfYboh66MCIaSW4E2ayQYNCJw5y
	uY+/c63UHzJ48svaR0gykYHQg47SrZzXpoOuWTu1685TmmiZQ+dOIizdIYZrLMBssF6G4JD5jvB
	CkWhBOraUmr+iLNCYc2jj0NcC0GzGPXwottUlsM+XgGGMxouOAx02bSLPXjnHVvL8iDZxtAyTPT
	GmwD0q7c8ObFXxa72DDSMmKFv+aC5+AwTYge+IJb6vUGkpN/jLpc43eadfuS55v84PQv
X-Google-Smtp-Source: AGHT+IG6Fb6ruVGlbHN4wGtZayIBTNPpt4aY0XQOYZxYfr6Numkaii3iELBWcumofDFYzCahxlkCgA==
X-Received: by 2002:a05:6808:199b:b0:404:f14a:1345 with SMTP id 5614622812f47-40a66b0ca19mr438688b6e.20.1749681780657;
        Wed, 11 Jun 2025 15:43:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:43:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:15 -0500
Subject: [PATCH 23/28] iio: pressure: bmp280: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-23-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=jR04YIdN9O2ZMn6ou5NomkQoDwMcMUyRaU/L4iFhuwQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgYdm0BKld1aGwa/n8Ufra0S7lpef2bRmG8sm
 XrxLOEC2AGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoGHQAKCRDCzCAB/wGP
 wHmNB/9z/ZKAzqrCy6jCj9Nu3CwEx8km3zZWktgGGSTTwtSfGw/x5LdCO3sFLygxQWItan+1Ich
 yO8fN+fnbDRpUq82KyKlfgXYeZ2fx7BLOWimk7amjtwwGL7GwFtoDG6M4WAYuoSlfZDY4Z559WI
 avlUzdpOOZ0uGVROXj1yJsI9B8t1XZCb7Vcuz9L61yMgAPtHcR5MOGVBvenewxkzOS4/+HGapl9
 U67xnC/8UibkMOEViHKdq5RBSx4DBeDzP4zUfHQD1dbiPQO+Rqo8SfdFfQMLRFMpM2NE1QQXecV
 eoiNvbO76iaTybSyC3JuboXfNbd7tzFGUfKYhLRg4vDgwf0R
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f37f20776c89173b0b2a8e28be0ef9aa30ceea53..74505c9ec1a08cf3ffdb55bf578d40ede3cc5d00 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1234,12 +1234,9 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		s32 comp_temp;
 		u32 comp_humidity;
 		aligned_s64 timestamp;
-	} buffer;
+	} buffer = { }; /* Don't leak uninitialized stack to userspace. */
 	int ret;
 
-	/* Don't leak uninitialized stack to userspace. */
-	memset(&buffer, 0, sizeof(buffer));
-
 	guard(mutex)(&data->lock);
 
 	/* Burst read data registers */

-- 
2.43.0


