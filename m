Return-Path: <linux-iio+bounces-9503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8199780FA
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898CF1C22664
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4841DC189;
	Fri, 13 Sep 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXYAVmJs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97DA1DC053;
	Fri, 13 Sep 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233565; cv=none; b=pxqrN4BQO9zF9PiWiRx3RKWBZtfqv77WiJU5BEMc1ibsSs56/GBYjgLBvE/gh/8O0jRTEUh2z8pPHZ9PKR6z+ER9oK0zXj1tw7RULkLqTNLYlbfGPxseH5zlCmsGLGqrfPaRd2gpo0q0DbkqiUsMFzApgP9WRFrrBBA9hRa2yRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233565; c=relaxed/simple;
	bh=85e+X4xDHQ8G/+GRgrGhA5QTajN49KeRr+ftQm+Z52Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QowXImKfIDA22pzZQJmk2mNTKVuFRSa8FQ6F/KztnqI0AIiHbfKTkXidyaw61iV4QjTETaVwN8In72sKbItEhnDa2TLAP7PnwSKa6Nt5GVYFppSawX0jknh2BtQXHOijk0gfkbI3Pd9VfchalrlaA5w9pdz5eH3Ac0NlPfy+3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXYAVmJs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d60e23b33so265113466b.0;
        Fri, 13 Sep 2024 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233562; x=1726838362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LORptDXk4Y1iRqE/7SK2ZpJpXJQmX7uETBnq/7nMKgA=;
        b=DXYAVmJsTF6vMvHO2PYpmMJ0H0qEe+y4ljqJEDi+msxOo4c4Lpv5RsH+1kwd3CtU9/
         W0foLGvlh9X+6Y3t0xKK3QHhO9BCURvIPEHjBUDACDgK/qPK/JpJKiRSkUwTsGHeu/Kr
         6DZm3lA1pP34TRt1VB0qt8EA/VnqFDremSwJFGEJI2OCvtoj3TyVaNrwyBNet3cmVdNF
         XtNtpK6Kkd07P42DI9lphd8vyQFVW31W0/a3+F0jOr91kJ5V3e35+mlgCVvquUH0ubzp
         XJAVLgZ4XCXB4P+c5KiwuCAuwzoXUwHF9FYC3zkLjHIU+20PaCByiAw8NZuSYNHgrOrV
         izuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233562; x=1726838362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LORptDXk4Y1iRqE/7SK2ZpJpXJQmX7uETBnq/7nMKgA=;
        b=Oudt0NMYlRVID9alTAMj+qsNCdnB2DaZFKLmSvKbqmRFJDyxhFjmQs1buXVS/0VAJq
         QlVlzYZvbFReeL8aDkGBV4BG2cjheMKDlGGO+GqGdOTl0/w7DfnPcWx5NOw7rrmPvawa
         OUgCZIk5ZtMTBGBMYzR9sijdggh7L+bdt3BCYvPAIEoyS+3jGL7us8tmVvuMwsJxTgRM
         3PS+LdT9/wLX68cuhnE7BoBSkFRCY8wMM3N0lFGTzM/OCFMMUA4TisSdSzxK9BkZ4gB+
         cfkCVZO6KH6q7Bpf42kndWaRU58oE5Bdy8sy09lodGEM3t73qpPUFImR4MvX1zrf7mh5
         Tlug==
X-Forwarded-Encrypted: i=1; AJvYcCV4h06InsAFiya9RXI86MuZWRo0kxW24YtY3DWosXqFkrpBzeL/ZVXVK8GvB4CPkWuJ9GoK6fDHHJ+daW23@vger.kernel.org, AJvYcCX4aBIp49eP1vfvGgIXJxTcNBiXMuIvrgL21Tshjgau67MasOznxkhQsoT3G1tCtrzSjS+Vzx6tQSJB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xAdcbRjQ5HEBdtlXVh950byEzVt8C+ZTM0yR4GwgNsIRw3BV
	ffoW5nknso8ivql9FVlLkR0y1J8eE7rpABrw+daX4QUaw6WZ3+rJ
X-Google-Smtp-Source: AGHT+IHDq4jgzjcLqTc3/uOVIa0kkv2MFxp8aHNHieRdheewDs1UobJxoiqK3kT39Ys3PwOX9BSQCw==
X-Received: by 2002:a17:907:3f93:b0:a80:f81c:fd75 with SMTP id a640c23a62f3a-a902910072amr642109466b.0.1726233562108;
        Fri, 13 Sep 2024 06:19:22 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:21 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 13 Sep 2024 15:19:00 +0200
Subject: [PATCH 5/7] iio: light: veml6030: update sensor resolution
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-veml6035-v1-5-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
In-Reply-To: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=1170;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=85e+X4xDHQ8G/+GRgrGhA5QTajN49KeRr+ftQm+Z52Q=;
 b=p/zCkIQzTjDLy7kWj9BMmZj3PptIel0XilWJOs6qx/LCE4b1Ndbgvn7cIFpYdUmcPHpL2+CS/
 hss4Qgzkex+Drjen88FN+IZ86jgS9FUvLjNnkH3B/uLmtbXBgI8XOrh
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The driver still uses the sensor resolution provided in the datasheet
until Rev. 1.6, 28-Apr-2022, which was updated with Rev 1.7,
28-Nov-2023. The original ambient light resolution has been updated from
0.0036 lx/ct to 0.0042 lx/ct, which is the value that can be found in
the current device datasheet.

Update the default resolution for IT = 100 ms and GAIN = 1/8 from the
original 4608 mlux/cnt to the current value from the "Resolution and
maximum detection range" table (Application Note 84367, page 5), 5376
mlux/cnt.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 5d4c2e35b987..d5add040d0b3 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -779,7 +779,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 
 	/* Cache currently active measurement parameters */
 	data->cur_gain = 3;
-	data->cur_resolution = 4608;
+	data->cur_resolution = 5376;
 	data->cur_integration_time = 3;
 
 	return ret;

-- 
2.43.0


