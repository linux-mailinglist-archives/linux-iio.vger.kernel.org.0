Return-Path: <linux-iio+bounces-9122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5496B2DB
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9639E1F20FD6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB61537DA;
	Wed,  4 Sep 2024 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ebEkPiDs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F06146A62
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434858; cv=none; b=grUPUJgArKWtWkz5F2AytSul4qkhQ3nnCSR8bt2Xy0UxNLQ8tx2CcLTJzrnODF9f5qbZmjqDL3fO6vqgmcilZ7dIUGmQPCXoinnd0bEmWsgpZQdxjT4lU1QY866a+k6YJ1nTETreZ0Wr+G6ZdkaOTrP9QCrGDZOMbaEUzP0hvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434858; c=relaxed/simple;
	bh=HFKyY5jobT+EEiF3Y/0HETSYeKrn/igGtDbnGCiZFP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmG329SV3UlcD9+KG/G7HjRf6wf/8RacHLvflQd+sW6UbInp8dJQ6wCEGSGDpNYc04/Isnuirl8yfV/gGd0kv2x4lBNx0ojh0gQABnELdyFbTZ/JrtPB+Rz/mrzTFGJJbsFXRBWBOhVKqnV8mR8Gt8Fk1ENru6APb0s1yomlm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ebEkPiDs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8682bb5e79so59005866b.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725434855; x=1726039655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYWMKG4k6/aCnq2O9xXhUdz5T7fph7bWB64VuOzrqxY=;
        b=ebEkPiDsLR/GtP9vui31LC3vHDF18hQOr8DGbGHqXvtsdslCY7xkojGs710lkVpgtV
         zSikKwDrPGmuXynWgmUfKb+mJeJM4XfzDICdS/2TTknI5CiVy5Mi9IhmBQzlAoO24n8D
         F/6aLSFfY9x/OTzf3/KqOERKHCbE50KD2A5QBz3eVh7yHqAANsOaLvSNJuu6O3fnMe0d
         djGE/4UKiqDKQEQ8pvlcN/2WD4RlP5pMPgz/RqTKHR8O7S0tgz6Olxd5Cla4U/qNrm5k
         cJGq4P0jHZugjH+paiUb4TmtyD7d2P1VcTwlEmz3inmrdlWlLv7dmLX9w+fRd0qYwXd3
         FYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434855; x=1726039655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYWMKG4k6/aCnq2O9xXhUdz5T7fph7bWB64VuOzrqxY=;
        b=evjYzeB3Tplg1fUeuUUw+hacOgXk+amyhlxTKLAVS4CLQ72+3qK+bKirV/FMZEtT0z
         6k09K9NOir/FT7rBZziXntdzu45E0a9f9Yda0MocYEG4P0VUPNWyULfvP9UN5R7nHJ7L
         CK/xCq6xB3CbW1zWIbwLm22WcP/ekoMwghspSyrVq0w1h3H6TCm0nmK1zd3EGya31g/R
         VUER/IK2IwZ9DFqbX2Y+mrfpD+8d+ABw2LMV/hQWhbwdDq4OK+KVmq6UbyMthAGyhPs0
         AKRwzzEEzTOmNPyuK+cjcwZEAzm6RALRBlqG4Qai8VRQ4vd/2O8q7iG5ETtOoE5sRfO4
         lIRg==
X-Gm-Message-State: AOJu0YyEAuRgl//4Yq5nVkdfJhmFt7jahewkD/om1JtcPVFt0RKzpKVN
	Hd35TpVAVpVyIt5BrSLR9Vlt/CMpxeln4HmMjRgiP2l8EbfhMZS/idoWm7+E/Qqm/qsAp8Kk2tm
	q35I=
X-Google-Smtp-Source: AGHT+IGLQXVdPTy6P4iJ6b9Hi7B3TbN9tg+qBPzfs/dxh4CRJsgPSaigTu3J+7vG3GRr4k+zsHFqhQ==
X-Received: by 2002:a17:907:3f9c:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a8a3f183312mr111185166b.21.1725434854106;
        Wed, 04 Sep 2024 00:27:34 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d77fasm771151766b.167.2024.09.04.00.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:27:33 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v3 6/8] dt-bindings: iio: adc: document diff-channels corner case for some ADCs
Date: Wed,  4 Sep 2024 10:27:14 +0300
Message-ID: <20240904072718.1143440-7-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904072718.1143440-1-aardelean@baylibre.com>
References: <20240904072718.1143440-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ADCs have channels with negative and positive inputs, which can be
used to measure differential voltage levels. These inputs/pins are
dedicated (to the given channel) and cannot be muxed as with other ADCs.

For those types of setups, the 'diff-channels' property can be specified to
be used with the channel number (or reg property) for both negative and
positive inputs/pins.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 8e7835cf36fd..b9bc02b5b07a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -37,6 +37,10 @@ properties:
       to both the positive and negative inputs of a differential ADC.
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
+      There are also some ADCs, where the differential channel has dedicated
+      positive and negative inputs which can be used to measure differential
+      voltage levels. For those setups, this property can be configured with
+      the 'reg' property for both inputs (i.e. diff-channels = <reg reg>).
 
   single-channel:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.46.0


