Return-Path: <linux-iio+bounces-5166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883A8CBE8D
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 11:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040272817AF
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E4B81724;
	Wed, 22 May 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr99sXcE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE97FBC4;
	Wed, 22 May 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371436; cv=none; b=c2FI+tTRX0WLFUAP+b3qz6+ahONdT5sJqNXdUXzET+89+v0iPm686TajRGh1CcuwA2h8CD+2SlZZW909IAIWZkwuc4kS7hid8U4i9XG5iUaa6CjFSWsRK0zdV0xubJEHjG+mbvY9HV1mOg4MREaMN8IkpiPC0ohqIQpgATKOuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371436; c=relaxed/simple;
	bh=s38cFtVzJD6qbysyN3bZJfC0joEZb1eAw1TbBF8E06c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUflpmycExCbYiQ5cMceQKskJF3Y5PcbV3waztVNn+uESdlLnwA4cChp2eW1uL8oRGxodh9X3RQKw2HSrg1+KJoQEHtwv+hKWTJzAywKz59X1GKV27pofmBjaqGOZOrmoNGMh9fCkQCsJvNUCfwR7g13IPt6V14Umuzm22Utcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr99sXcE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59cdd185b9so144962666b.1;
        Wed, 22 May 2024 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716371433; x=1716976233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT1jn5XZVlHhaOOAiUsTvpY+rK0Oxoh6SbeLRw0834s=;
        b=cr99sXcEphIyP/MTjF/CTcx+pMFNhC/iFE3N2tyt11iMyBq1XhxdHauVaLbSu6RJqC
         +BcPS5S65DevNE+I7s3kQSN/SMmBhaCBFODOfBj3OF4F9dfizJaqBGAwe9KYrkdh4C+8
         nChX/BTVmGlStuaQ69LBQ0cOyuifgb9MFLQkXzvYqaTklVYnPvbZYV4d+tswGW5bHGSH
         qPhvy/KqIHbeQcU60u6b+Qac5z06ceRXvMbj32VVRSITP5x2FciVylv9XgH9eNTosNAD
         ofcm3xagOpQgee58w9tomCoRI0ZfPN3Yjhtmp8JR2Ss2YiGSDJ2T0O/0LNyXYQAPVLSV
         Yhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716371433; x=1716976233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT1jn5XZVlHhaOOAiUsTvpY+rK0Oxoh6SbeLRw0834s=;
        b=LafiPZ8dJ54avgeTorhlEWC2gByG1CaI1YJN7tqdu1yjGh2gMcz0VOD6CMWbJXPdGS
         tpu8DJrgQ7jze5yWDk5lm8WbDZnLRxEhNVI/2LRrv64nwiSuFNPtYR7ViPH3GdC5I7Nm
         QG/FUFr7AU0oKnAVuie4UyrLr3x5h65DHDPZekuPWtzB3epj2ZVKheXn9a7BmYq6XHaj
         ccN8MWsZaBfipQCekMmp+g91Sfxnz1oRZBI/gI5s/pLUrPhW8Cpj/2F1AsfQfOMErCYO
         NTF4/eeqmPFBu15wtDU3zGQX8SToX84P6uyD0BvDQ6l+0TDAayna2xiDkaz12vVdxT+4
         ovPg==
X-Forwarded-Encrypted: i=1; AJvYcCUjI2IrT3C2WUMp6hbkYMn0DCaZVaGw2LppZwWq1mtcCtistObT+PDVR415n11KOpQybfsVWUuLe9GR0x0sCVJj/Mn/62jOVhV1sbVhuP3YJcFLVLSYyCTs7MuqL4NPO+ChKa512fate8XmrhlmiyW7uz1ED93OT70FjB5tJVVetK8qYw==
X-Gm-Message-State: AOJu0Ywciicw1Iba5IRDAHRAj/psjBmReHESJm3dIo4b2m12cSDUv9FY
	Wkw/Fl3OVgC65WQYPLBRLJ+HQgTgWWmc+daoTIGozF/uVc/krE4f
X-Google-Smtp-Source: AGHT+IHSdIB34GezXsnYJdQRlu4R1+I4JK0TPdgS+Fbz5G5y04tAFR/jtDPbSfrE9LMiPyK4ZSum8g==
X-Received: by 2002:a17:906:3c54:b0:a59:c3a1:23f9 with SMTP id a640c23a62f3a-a5d58e495b3mr1005218966b.7.1716371432490;
        Wed, 22 May 2024 02:50:32 -0700 (PDT)
Received: from spiri.. ([5.14.134.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c686sm1745589166b.47.2024.05.22.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:50:32 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: andy@kernel.org
Cc: Jonathan.Cameron@huawei.com,
	alisa.roman@analog.com,
	alisadariana@gmail.com,
	bigunclemax@gmail.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	fr0st61te@gmail.com,
	jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lars@metafoo.de,
	lgirdwood@gmail.com,
	liambeguin@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	marcus.folkesson@gmail.com,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	okan.sahin@analog.com,
	robh@kernel.org,
	schnelle@linux.ibm.com
Subject: [PATCH] fix
Date: Wed, 22 May 2024 12:50:23 +0300
Message-Id: <20240522095023.35189-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZktB5Ex5oQ2E45QR@smile.fi.intel.com>
References: <ZktB5Ex5oQ2E45QR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---

Would this fix be alright, since writing something like if(!ret) may be
confusing?

And regarding the comment, my bad, there is nothing wrong there.

 drivers/iio/adc/ad7192.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 101afce49378..0789121236d6 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1101,14 +1101,12 @@ static int ad7194_parse_channels(struct iio_dev *indio_dev)
 		ret = fwnode_property_read_u32_array(child, "diff-channels",
 						     ain, ARRAY_SIZE(ain));
 		if (ret == 0) {
-			ret = ad7194_validate_ain_channel(dev, ain[0]);
-			if (ret)
+			if (!ad7194_validate_ain_channel(dev, ain[0]))
 				return dev_err_probe(dev, -EINVAL,
 						     "Invalid AIN channel: %u\n",
 						     ain[0]);
 
-			ret = ad7194_validate_ain_channel(dev, ain[1]);
-			if (ret)
+			if (!ad7194_validate_ain_channel(dev, ain[1]))
 				return dev_err_probe(dev, -EINVAL,
 						     "Invalid AIN channel: %u\n",
 						     ain[1]);
@@ -1125,8 +1123,7 @@ static int ad7194_parse_channels(struct iio_dev *indio_dev)
 				return dev_err_probe(dev, ret,
 						     "Missing channel property\n");
 
-			ret = ad7194_validate_ain_channel(dev, ain[0]);
-			if (ret)
+			if (!ad7194_validate_ain_channel(dev, ain[0]))
 				return dev_err_probe(dev, -EINVAL,
 						     "Invalid AIN channel: %u\n",
 						     ain[0]);
-- 
2.34.1


