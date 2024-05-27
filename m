Return-Path: <linux-iio+bounces-5328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD178D04EB
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A528A17D
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 14:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D84172BD6;
	Mon, 27 May 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0vTB/nQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFB172BAC;
	Mon, 27 May 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819988; cv=none; b=t1WyX34lTAluXzTk/KMi8J+Ye9C9RGVgISqJh4qSGNCYNrhC0TdQZv7djhx0HmovL/UYEvcqEcNnEfOlRBXquwvQwTT/+bnJ25tXnUHM/s0kkkmv7LfCaUUBLSCmkJH1ht0nlCb/LI/dtN/XTFRo6Mhao1i36MMdWGsEa4ET0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819988; c=relaxed/simple;
	bh=I0xdG6bc7x/lwRULRAwBRftSda7x7sn0aB+zYuy+EgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nx7dNK+o9mIF9BRXgKEunMBovds/M4QAYOtlpvSIvAMLIjovr3J8OhhPCE5Muxp7q2rQSoloLlAxBTEBz/eWDDNScPHzgnr3ynRf796jVlo/yiy4loFGAewArNUR9Bq/sIpTRMSRCu63Ffm0r1iQIVsLfkemzOrL07VAWSAAt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0vTB/nQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354e0d4db6cso3372707f8f.0;
        Mon, 27 May 2024 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819985; x=1717424785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqH87/gTwgK/puQUpkEP2q9MDeZqZ8Bu/cUltrUmqHk=;
        b=g0vTB/nQpqA3iHZcFwlAVuDvHpIbZDp97ffvJOqJNB2l1AbQZPOCXp7dxYCRwM2dvD
         JcxGsPoqAmz5lsoLP6CwfcR7fzLjKusv9tgoLf6fLnxK329dAXVyQq5ghILa1VSPpO6h
         f6SoAWAtK8iNQHgp2jO2U1jDPoax1KUJv74yyDFNzgvuTUbop05UnKcUmNY+3u6kPKXk
         bP6e5w9IhMmBV9c33OOffb47k/yMrubVPnGW0/J4lgBEDT67Qp4kIjdDCUG2vqD2oX/R
         NvxRwIho7SxZt1QZu+YxKu/srYPOGBARPf5UPC6XISFbjNO/9a66pn47zectIQobj2fR
         QHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819985; x=1717424785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqH87/gTwgK/puQUpkEP2q9MDeZqZ8Bu/cUltrUmqHk=;
        b=dXHRNOJk/mv09aPc4Ges/M2ZSnymqoUDL4Hpr7RcMyHqgCuNwHDjg55anacswavM0s
         mf/sLn4axkf1kSyTH+hOpejhHtgKfFpTECx9i0zh4pRaM+tSo640HzEXwo9570T2uDJL
         TPynp1Fhct+1gWGl4u1uVUpEyr57DjbJRS97YLQUpyvvHfPtK30i1gEY3H+977ZRC9YD
         HyOGk0MbhBcotsZFACpTErtuqcEoI1KaUDnLGPCvr/1/Nie2nlLygriNucqBozvHdtii
         fN48E3WOMhYvNa3yulwO+kTOU2QdpIFSyFj1+JzCBhxctsCY9XLDUi9RKoFpVEansK+1
         xgDw==
X-Forwarded-Encrypted: i=1; AJvYcCXnLUyIsgmsE/IfGTr9ZMpMpUKeyOG22ngZT+66lW+rzqXFoW8DzIYkKlz98PIqVvYt7R59+T4HqoSvoDBG3qqVyFBbiqLX0xwCRmcYPXP6wSLvspYfwCHnGqNNPPLWiH/t+uQUXQ==
X-Gm-Message-State: AOJu0YxTE7A8LPwj2YV4h9Qj7MQ2ZVPbXR2S8YAGtgnfl3Qwae7Bgeyj
	vx6JW4EG8eeAs6PRrTA0Ee7mIxJi10nqMbJv3pHw9eXe2oyPk3/41S7gqPdutkQ=
X-Google-Smtp-Source: AGHT+IGsfc7qKyeAVvGdlwD5j6w/zD+XHPXYCc22KyM2mfpukP8HASNg94mJ67Dnwf6g1AYyrBu7Wg==
X-Received: by 2002:a05:6000:247:b0:356:af95:e31d with SMTP id ffacd0b85a97d-356af95e4d7mr5332194f8f.6.1716819984779;
        Mon, 27 May 2024 07:26:24 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:24 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/9] dt-bindings: iio: imu: Add ADIS16501 compatibles
Date: Mon, 27 May 2024 17:26:10 +0300
Message-Id: <20240527142618.275897-2-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS16501 compatible. Similarly to other ADIS1650X devices,
ADIS16501 supports sync-mode values [0,2].
There are two differences between ADIS16501 and ADIS16477-2:
- ADIS16501 does not support pulse sync mode
- the delta velocity scale value is different

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v5
 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index 9b7ad609f7db..db52e7063116 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,adis16467-2
       - adi,adis16467-3
       - adi,adis16500
+      - adi,adis16501
       - adi,adis16505-1
       - adi,adis16505-2
       - adi,adis16505-3
@@ -90,6 +91,7 @@ allOf:
           contains:
             enum:
               - adi,adis16500
+              - adi,adis16501
               - adi,adis16505-1
               - adi,adis16505-2
               - adi,adis16505-3
--
2.34.1


