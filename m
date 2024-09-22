Return-Path: <linux-iio+bounces-9709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C196397E3F1
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2071C20F90
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872D980BFC;
	Sun, 22 Sep 2024 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAmrJcNQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EFD745CB;
	Sun, 22 Sep 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043481; cv=none; b=fEbCWJN93PtCpHluCvpv3H6OrJ2kUmiLw8HfIIAerXLT+/5CZ3EWBRIKY5BatYF/K7sCL1fmEQwy1V1RQzO600pDJoAMLnqkeGbCtNAvE8lE16wgK3dbN3mafWbrcfSCrMfqEi8DxKs+GwwutVi1EFAsVxkd48iDBi8jUVCPDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043481; c=relaxed/simple;
	bh=P5p+Hh0ofpp5AZDc1SNz04zJpI/e4lfi7LuPsD2A6qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLNkVwWa2cEkvOtfbi8VDlQqP/xA7zUdjxqZDjCHsArleUXOVlNMR1VvbC7eXwNwvhs80UXpABdhMp8ct8cfq2LEFXxZKvrT72QCAujngCfVFEe5ama7yfo6IZXGa/JNHaPC5+Y0b3TxTBjQFI3vj9M8XxRy3ie9PEtnJ61lxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAmrJcNQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso643066266b.0;
        Sun, 22 Sep 2024 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043478; x=1727648278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5CVvTrJ2msrTdCqfd00y+3rlkucKNIEprj9js6Ycgc=;
        b=eAmrJcNQLgAE3d+x3zZk8Siu8epv8ZYf4ZRndIWswacga7CPsZaqO8I67kc5r13uTh
         6qullRpaq35nerUUAj9rbyppWzL49EwLZFPvyyzVUqusb4sPGnYgPFP2y3v7567RlFlX
         R37iQfuZcMIVomjzWzBgxCJ1q/Vo7I/Xdvf4Q+v/eijKXUFZmO2Xh2uVQveLmUzmogqb
         7AgcQt7pIHTzWGpDZRdd10IUxwicMhpymv6SyxPG1clbHOYtykscswteQzRpoaTh+L7A
         mruNOqXHqGa8oh1Ni6OSaMaRRYn87RPkV1kF3Tm5w7BCQEC49BdT3Kur0pTI6ZKEgzDg
         Jp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043478; x=1727648278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5CVvTrJ2msrTdCqfd00y+3rlkucKNIEprj9js6Ycgc=;
        b=vQ9m9zTWeXEd6rhczc56I4uTQHxhB43jy2qQOjjqXFffkFVmhfaxi9nZ8JAE6Iod5E
         vUrlU5/wN9ZmyD1sJCTZjWTUmBmpH033BmwbUPQrgL3f0kp/3CcrLqP20YUHs1AcmHS+
         TueIu2Wt7nXrDoUNc0FkVrUMLicwykoY7aXbefgTeEQyrMxGikrmpUMUZ34xQlegfhiT
         11fvjQeznZoVIq7HpZ16ioLECBSXjutLxSaD6jf5ZadRyfpGOt/a6J7bKiTrBqNmpXJZ
         +VPx/B0Tkx0ZovrKYVw1qzQMPOEJ5V162yOfO9vtsFTTyv/EJpYVJvawuWS8URaSgGaR
         DMzA==
X-Forwarded-Encrypted: i=1; AJvYcCWH+3neGU2r1Iu+vmzB2BcEBNutauOhQT5dl+dOvEpPB8V3YRObydZdy0jEm9ybZa4QlFvr3ertQeBT@vger.kernel.org, AJvYcCX36LSPgjomVUZ/QO9NwxZcEf684B9QglIPdhoLwk4dMtvgr3Z0t3137EnXF1wuSX4BEqXSlJmAqAzy6hya@vger.kernel.org, AJvYcCXQyh+1LmbRsshoPsAjpAKS4o9ySBXFrXnlKhgurFrHRQ9pn0hrEdB/utq1ceMvgxLF2Z2sm6e0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4pZfbLxsIQf+nk+aV9FGai+qhM3w/13PikQ1+gB+K2Wa+yaC4
	hGxY7tYuOBmHZSgTgIO7hWlMIz01P4Pt5nbf+w76sF5P/9atUqtY
X-Google-Smtp-Source: AGHT+IH+aJcOSwRSwLKBjNRT5UbMZ7j3xwWo8W/b/ZzJI95Ju3+4wm0A0S/8IaToy++ymoZoYMjXdw==
X-Received: by 2002:a17:907:1c2a:b0:a8d:4954:c209 with SMTP id a640c23a62f3a-a90c1d6e85fmr1493271766b.22.1727043477642;
        Sun, 22 Sep 2024 15:17:57 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:17:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:49 +0200
Subject: [PATCH v2 01/10] iio: light: veml6030: fix ALS sensor resolution
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-1-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=1280;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=P5p+Hh0ofpp5AZDc1SNz04zJpI/e4lfi7LuPsD2A6qE=;
 b=Bg+7vLzgVF/f4i9k91dsQi/UvD/TqLno9y6miJDc8bW232GLgF57qaQ67ZMtKdjTknCSNCEQC
 /mECX+fBw+OAXD3jSmX/zC2wFNus2W8l5rH+yFeGLuuZRP+cz8iZr0Q
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

Cc: stable@vger.kernel.org
Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 4c436c5e0787..a3dfe56b7eec 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -780,7 +780,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 
 	/* Cache currently active measurement parameters */
 	data->cur_gain = 3;
-	data->cur_resolution = 4608;
+	data->cur_resolution = 5376;
 	data->cur_integration_time = 3;
 
 	return ret;

-- 
2.43.0


