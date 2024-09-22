Return-Path: <linux-iio+bounces-9715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F45797E403
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C0F1F212E1
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5B012E1E9;
	Sun, 22 Sep 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMmfhrUG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664D81AD7;
	Sun, 22 Sep 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043489; cv=none; b=fPKuqzpG+nnOw8t3v6kwl2tIvl7Qaw60IAAwMawULiG3owCvx2Q7mnkTJogLw+LdhrXooLJctAONEaaqskXm6Rw1CluLIatbIUnAPAJy0sZRML10pw7s4hr8oBuWp4ffV4TKum8aIYa4OFULYJsgnUELZPCcl7APUh9MY0XvcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043489; c=relaxed/simple;
	bh=ollvBjvErNXaHNbYeIrSHie4RI9hs0qso3/Fg/qNxRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPq1QKkeMX9ZwBLbAHr5SRiMANNMU1uaRqktRKmj2gxfpP9RB2nvJVrcpvO6czMV8zHsNlIIjBlwK+4yUlIpEki2RqzL9j1Jpl3Kdahwd6AVm+nVXKwFf57u+x1rg7ZwF549DbvAcBJm0jFPACIYAynlBV0IL1bC9cZ+Y+XrjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMmfhrUG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d24f98215so502479866b.1;
        Sun, 22 Sep 2024 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043486; x=1727648286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atM4/LAX7ZK8RsTsiLHW5ehwcD1lF5iSh5UoPr5wOPU=;
        b=mMmfhrUGsbvNu4nRiupbk/pTWdW+r+MjhmDwF5RMvd19V97VbmdNwFRtGE1gje3rGc
         +9+0G1BW9+ptYbuYrM4szDrTUaoYynKdd3JVfYqn+oMhZno2SMlsUEVN+FfYzxMyLIle
         sGN2NTIDO3HBDceEN3Z2kGIgvW9rT4yQQ0/C/FaDYKxZogHr7mR1PxwE7WV/RyQP97fl
         /cQnXLc3y/WpYxVF7Yas6p9imkQPgv2wPOcMDcq7oCooTGB7APgidu7Z6NB2Uk7ik2wb
         yL+BlZKKbFfvyUeDWkv8aODB0LYxPef7z2dNfAUe32kCtU6QHkPp46YPOkraoQGjmrxe
         /LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043486; x=1727648286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atM4/LAX7ZK8RsTsiLHW5ehwcD1lF5iSh5UoPr5wOPU=;
        b=mx/uBkT1X1jnvrRYAolTBzXir54jyJxPp7Z/M2CCyqlw+An+k4VbyUeo0SSpAWjeJk
         3+qysBe4tCMqfxMwR0r6vtjZFZjElWaPpoz4oOagstTznA9j+C2TQ88/6lzAUfv+RjmG
         63eBOKIYPKJ5w+peEdeoYIAlOHJZ0yHB9o/o9yeLBWYdIyzurrA88ADJkbEpyNHP6ir7
         0tvmY3bEtZ4Dl3V3Z/vW7exm+kRxN9MrIspnJe7qvPO//6aPsmQHtvnYK5dZBHn4vREe
         6rJcaephxb2b3w7ADMd9wdiPe9inQyPi/NWPGvsIZKQfM0pJGnQ5TvF+JjgCrc+vOIBh
         y4iA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWzjYpLd/aZjSFH/cKUgxI4y9LQfgzg5iKgB3e02WtZ3uaAP//UrJysrBFXa9H9CKRYhyGK7hUkQ99jDZ@vger.kernel.org, AJvYcCXNhJYaIr95Tv6ONYRMQKyRbkM15QcNOgMuNdNfQZmIyffDgXbIPksSzQ3tr0dy/COmtJAQsGGRu2CZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UEcaSOBPsw11lEvBd2b5OGdkuOH7dLeAFJ6F9laJ5U8LAWU4
	lY5StueIptu3jTckaPTDnMBb+WHH29e54vgdR60U1wh76Lt510Ia
X-Google-Smtp-Source: AGHT+IEh0lYznsv1d+yTj9tXE+5nroz1XY5UUh67nl1K5P7PwmK1LwWrZtJwNUvBNc8SqcnZHbcPbw==
X-Received: by 2002:a17:907:1b02:b0:a7a:aa35:408c with SMTP id a640c23a62f3a-a90d4fbc6c2mr1129133366b.8.1727043486208;
        Sun, 22 Sep 2024 15:18:06 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:05 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:55 +0200
Subject: [PATCH v2 07/10] iio: light: veml6030: drop processed info for
 white channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-7-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=1693;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ollvBjvErNXaHNbYeIrSHie4RI9hs0qso3/Fg/qNxRs=;
 b=GdOy8wmI4+hpirhee48CrGf1J4w5x6XzqU+uDExl15LIfVu8cSLmAR8imWN0X2QUyICuA8id/
 EO89CSpyhbPDERQEjvDZaTOREmHxjEKtKfo/AlO4WSs6wAWOBdrLdAI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The resolution of the WHITE channel is not provided by the manufacturer,
neither in the datasheet nor in the application note (even their
proprietary application only processes the ALS channel, giving raw
values for WHITE).

The current implementation assumes that both resolutions are identical,
which is extremely unlikely, especially for photodiodes with different
spectral responses.

Drop the processed information as it is meaningless.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index a3190fab3add..861bdf2edd4d 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -209,8 +209,7 @@ static const struct iio_chan_spec veml6030_channels[] = {
 		.channel = CH_WHITE,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
 					       BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
@@ -549,11 +548,6 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 				dev_err(dev, "can't read white data %d\n", ret);
 				return ret;
 			}
-			if (mask == IIO_CHAN_INFO_PROCESSED) {
-				*val = (reg * data->cur_resolution) / 10000;
-				*val2 = (reg * data->cur_resolution) % 10000;
-				return IIO_VAL_INT_PLUS_MICRO;
-			}
 			*val = reg;
 			return IIO_VAL_INT;
 		default:

-- 
2.43.0


