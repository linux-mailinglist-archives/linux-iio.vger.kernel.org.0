Return-Path: <linux-iio+bounces-24229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F97B81CCE
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFAB4A04DF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 20:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3952F49E9;
	Wed, 17 Sep 2025 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yayO0t9L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EE2E5B19
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141603; cv=none; b=a22qkNdbSNZnB9FBJ621R2mavNVTLb3tZlfmc/FJz0E5X2rxA0Wc4sinpKS607lT1pylG92NdXCNcQxac/MHvzkQsHM0JzEqPsLaCCVCwpu8QuqRmSN2jvgnlkPwMHa3r2ZbelnRuu887uixthCSQc+41FIFRSMNVudhhXus4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141603; c=relaxed/simple;
	bh=HjK6xUpUrbM/x0TIyzdMRw0JP/vNXqUhT9pldXHvbvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaC67lLf3CsQxKTdLAUMFE0lxjDg6Bi5AacDtTOcWh+tBgmEcOIrq/JerMuzIoX0Nd6vMjHKndYJt+Z0nFQBqMB9Nm/zOl3en9q9E4lcaXv5Gd8IH+jEp8Nrw40cuHUuBHC+q/tTuDmw17PJ1x3tT5+g4K1Ayf6JkK7MQvo0I94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yayO0t9L; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6236479c8d6so159963eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758141600; x=1758746400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1+Gj+S0d6SY5zdQCDjVAjkrnEsIPPrh8A/IsSIYkC8=;
        b=yayO0t9LdNA+HrK71JZTxUAsIO4pxGOcJftVc8hyALOEuUhhkPm37Mq+M+oD+1OmkE
         HqJuV4WIle3gGM0HTgtFipV1Hgjgp7SMatjClYqxI3n4YcHSbVVSk0ibB5SCd6XrIwqj
         TjatEBS6dcK0Z+rIO6T/FXsNfotkMXZv+yt2uJv5c+fb73Etv5zL+90daGWflwQTotuK
         X4wnEYbQn3XsDlURQOf48GtcxLZ2m08RC2bUSMVM5EgyJT8zG/i4J41yQhIvo9xx9jRm
         jeMBiujanIC0F8EmvkXlTnGRlFJEIt3ToaSNPWS/74qfgxCPgEN82/P9c00Ac0EcEP0V
         blog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141600; x=1758746400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1+Gj+S0d6SY5zdQCDjVAjkrnEsIPPrh8A/IsSIYkC8=;
        b=MpLn3X6v9z1hI+4Kwklq7I/yG6fZouLZNXch2pWNQLUI6t6JXD+wq66AvNtFk6AYEc
         h9hZW2PZNRrjX9jBeeF2pJVJML2blH6+shfKq40O+rRRCh5eKUmChS8gJntXENQN+Epz
         XlxINaNv41l3P40F9VUMT+2Ab8nhcpuTM5Khnuba/og9eXqLD/69ILsreKMFJ8N/K7B9
         ZdgeZnAchOqS6+6+ilwjKMOnvklG71etZcmtNLRCuS12RnHwHjU2EerHt2uLwuXRtUDT
         xW5dcmEDAevD7v/t0Xof11qVUUA4IFQ0UiK7l7Ko/4kjGCW/539/9ecEfYD9H2m7+Hbx
         fPVA==
X-Gm-Message-State: AOJu0YywdEqBVKcVGfyWPxoIbFT5BzHlLU6zI1jUPOxdM7CWzyrw5kcT
	tBxY7qR4qwpHMq9nX7dZS04MvX3RcYQSdPPNjixM5JgaRpo2g2Po/Ysw2DxAJpTiCCWe4JAcmHg
	3QBzpF+A=
X-Gm-Gg: ASbGncss9H/XYp7EyaSvlCCMgFkQApqV6Z7ZQm2DUilo4F+Pc0xl07UEYagnH5tiPoq
	OZmJMIunVBgs/HRcXOE/7jJtQE1LxvIOr2mp2LsX7UGfNw+Fjutu9O7KgcxPUhcI3x0SdtCN971
	7lbH8jqs1k6HUq0IyDfsAYeV7Z6ouo7YoniHIjctYqCviuvYe5porPIwNE7TEMMs8upqCfGgJd0
	bXlgZM+TOgtvZIXYXRiLK1WJYFMxS32JJf9EVkNH6D6cH9PS2HSiW2k6Q0XCNMrnlGW3/PcnQHi
	iGEsKGX3MZfcvWjcmQ2kI8APD969YB8eT2Aiqu3rkO1U4IE4KBx0XzaBNfPNeWzbC1xzsMtaor7
	mICzyeFCiy48TL5EB5Mr3mPhBLovjyX+MHCIT29KjKwmaRQ==
X-Google-Smtp-Source: AGHT+IEvRN0WGfOGvp8ghfVc4RqR70y4AuOHnN18NtG8AtA9iZCtysm1F9Wzp3LB/eZnthqZaBatIA==
X-Received: by 2002:a05:6820:1c87:b0:61e:78bb:ff16 with SMTP id 006d021491bc7-624a4ea2983mr1980403eaf.1.1758141599762;
        Wed, 17 Sep 2025 13:39:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d8eec45csm124036eaf.10.2025.09.17.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:39:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Sep 2025 15:39:23 -0500
Subject: [PATCH 2/2] iio: adc: ad7124: remove unused `nr` field
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-iio-adc-ad7124-drop-nr-field-v1-2-5ef5cdc387c6@baylibre.com>
References: <20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
In-Reply-To: <20250917-iio-adc-ad7124-drop-nr-field-v1-0-5ef5cdc387c6@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HjK6xUpUrbM/x0TIyzdMRw0JP/vNXqUhT9pldXHvbvM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoyxyStTLuPMuQs5d4Ff8j5MtU3bpDK5q2CFrXk
 voXJ8vPEyGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMsckgAKCRDCzCAB/wGP
 wN29B/4mfJkpp1iONvSOEMmqRQMsIMxY+lWau0IOUUQEM9/2HWTWk4olp9P7+xL3fdscg3+JQCN
 oVUz8oBfqC6Bto0dhqK3sdbYWLgppqepfSNKuy4v7bf0zdI8+C95kypIGr+cVNUgsxMwe+U8WAB
 dxvXefD6khDjFFX8i4MJZ6jHdxwMh+hrtSnqUNzbd7rFWGs3BYtO59AGZVaamCIMhMFdKzcG+St
 ZQh+msW/H8aZTy6exHRzA218wU+KRbACOwtTwdF9hPncwN0z+wbgBsK0wKQ6gSxz6NqDaaMEQ3O
 nIqWIi3kzbCBUv965kwHEaVww8/ERWfQb2b/bX+wc6eCMByK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove the unused `nr` field from the `ad7124_channel` struct. There
are no more users of this field (it is only assigned to but never read)
so can be removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c61a95c5881a69e38c21ce4c340a0a61864de22b..1d93ab500a7b80bdcf18db645c3afdaea999cf48 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -199,7 +199,6 @@ struct ad7124_channel_config {
 };
 
 struct ad7124_channel {
-	unsigned int nr;
 	struct ad7124_channel_config cfg;
 	unsigned int ain;
 	unsigned int slot;
@@ -1301,7 +1300,6 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 			return dev_err_probe(dev, -EINVAL,
 					     "diff-channels property of %pfwP contains invalid data\n", child);
 
-		st->channels[channel].nr = channel;
 		st->channels[channel].ain = FIELD_PREP(AD7124_CHANNEL_AINP, ain[0]) |
 			FIELD_PREP(AD7124_CHANNEL_AINM, ain[1]);
 
@@ -1328,7 +1326,6 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 
 	if (num_channels < AD7124_MAX_CHANNELS) {
 		st->channels[num_channels] = (struct ad7124_channel) {
-			.nr = num_channels,
 			.ain = FIELD_PREP(AD7124_CHANNEL_AINP, AD7124_CHANNEL_AINx_TEMPSENSOR) |
 				FIELD_PREP(AD7124_CHANNEL_AINM, AD7124_CHANNEL_AINx_AVSS),
 			.cfg = {

-- 
2.43.0


