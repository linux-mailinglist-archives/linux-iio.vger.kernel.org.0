Return-Path: <linux-iio+bounces-5805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C42F8FC4E5
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B582823C3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B718C35C;
	Wed,  5 Jun 2024 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNWivKN6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168618C33A;
	Wed,  5 Jun 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573588; cv=none; b=AqIjzb+0OjahKih+nJyJnXrBJsXBT4CFnWyNE2o+Ui1oEK2wMYg2HxjbFAxV8uPxhFzLrW8Ao8BkUb1GBDc9y8HFVR32AMCEIEZBJ9JrKKc19PFKFeesQCuXSNVmpj1OpfeeN9t0hsPMp4fBZLTE0jvbELtn3QMxv/1vBqk4VMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573588; c=relaxed/simple;
	bh=Wu8ixq/vrHERKUg8DBnJ3ob8md7NOPJWklrzwYNjQqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udRlsy7IsjJ+JEtHYt/l6xZS4GInY4Ab8RgEWRgscIWmVZIyi6UuyijgSXn6AYLF41vbX+cjlzN7MLrBTVEcZ8u949YfGzQmfjbiPJFzV04fvY5eqghN8ZaODYyUZsY+Avh34XFfREOT9dOD1jhw0IjFcX6zEMrNvrROwtBCUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNWivKN6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1180026a12.0;
        Wed, 05 Jun 2024 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717573586; x=1718178386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n84dpS87cJhgimQJRE4boDvZ08eYSNIcFdCIL4Yrgo8=;
        b=SNWivKN6Q1szPZMYzh+YY2mXUiHfBg4W1w6CueB5pPOrGv/KVadShl56vyI3V65jec
         cwPOGAI4yycvzdSF9j1d7azj5YI7RLIMZxOB+O8ncJs3gRqAdOGAxnJLq1C3lY7Hq614
         /8BbxFIQRq1xkIiK3gI9blDVdjnQwJ3MJzwVgWdvnOHW2B97xk9wvwXAnYzQldOhTQhn
         iI/O0VRc9jLMN2ZMB3H6Qd6peFNRHZmYGjtRHZTrTDYbeIJN4WFI0lZCN7NcjXJ/8AoW
         gsM15TRHVXy7M2M4bmMxSVMzzQb/K33UAx8KAtKDIAJ3korjkpW5sNzkS8O4cB2G+jxf
         Ty3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573586; x=1718178386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n84dpS87cJhgimQJRE4boDvZ08eYSNIcFdCIL4Yrgo8=;
        b=cp7N6wOzK8hcAufZVj1J7jlukrP1RlGbsFFXwrclNQYEuHVKEcIQXl2NisS6bJWQJ7
         NNJ8wxIxHGsDIGxZycnIlsTLd25zkU91iUOJrY19Jy/G+JTOsUdBMH2Lre7gX19lMwRA
         zzbVxFjBkr5xrwscfAiTS9BA8i1dNAeaBMHIVn/pkRp27xoHF40QmN6Gdh+dyA+qE1kS
         aB/I5CCfhVYvgqNk0PisJS+rDlQXlitiLdmql/s6hQRq7P+eHnt5rpwyWYnP1FYY1/DO
         JE3pumX+va9auwK/WPMDSfAfQ6yg+cfirVAkX9c1DkKCaHTmYWXdVKS6opkfaYYo5imp
         wNCw==
X-Forwarded-Encrypted: i=1; AJvYcCXJMBefHTXtlWkoty2EMLrLJt2CkYI1U8xYE2wEXAYRsHSQp07AcjvqxdL9u54lfMTld4yhNOhfgtEHzy3zWFW6iZ1F2/n5+p94am7s6jacdAnynjDesYuaIzCBCVDR6TrIvrWEcwJrtOJHlQShislig2xhxZwqG+U6cGB+2NhLmhdXXA==
X-Gm-Message-State: AOJu0Yx1qnOU3Sf1TFV7CH94jsY2IlPdsaeLt1XLhG6mxM1wbvKr1MFq
	2Gyy9E+/ZvjhpeKpucv0FyQdQcbz/9Otm8xMdzOxHcKFy28lPJbWoKlitQ==
X-Google-Smtp-Source: AGHT+IEeO1g6nOVR506mmH5Ir1DQWtyOye1Qx1NI3m8u20MbrVq1EjAMOxa7BSjI1LalUsuSgkahtA==
X-Received: by 2002:a50:d59a:0:b0:579:c5df:af84 with SMTP id 4fb4d7f45d1cf-57a8bca01a0mr1629125a12.15.1717573585312;
        Wed, 05 Jun 2024 00:46:25 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a10a:2300:8e59:f160:bdc8:6311])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be5a15sm8903429a12.57.2024.06.05.00.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:46:25 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] iio: adc: ad7192: Update
Date: Wed,  5 Jun 2024 10:45:47 +0300
Message-Id: <20240605074547.612704-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

I am submitting a series of improvements for the ad7192 driver.

Please consider applying in order.

Thank you!

King regards,
Alisa-Dariana Roman (3):
  iio: adc: ad7192: Clean up dev
  dt-bindings: iio: adc: ad7192: Fix clock config
  iio: adc: ad7192: Fix clock config

 .../bindings/iio/adc/adi,ad7192.yaml          |  19 +-
 drivers/iio/adc/ad7192.c                      | 194 +++++++++++++-----
 2 files changed, 150 insertions(+), 63 deletions(-)

-- 
2.34.1


