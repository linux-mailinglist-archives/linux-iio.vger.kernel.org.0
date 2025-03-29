Return-Path: <linux-iio+bounces-17327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F3A75735
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 17:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B103D7A50CE
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B37E1DC074;
	Sat, 29 Mar 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YATDviqA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C113C3C2;
	Sat, 29 Mar 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743267003; cv=none; b=XuI6KppBMexOQ9h2wapDvOHy+l5Ph63SG/BAv47frebvb0uEiRme6rfHVXVOfk1c4L8KaICpj+H1JCpaJIRDH93Yj4RKWr00WrBVOj0ErGyD0+PAi4C2Lz0lzWaF6lAysLFMRQhAZMU4xECZE7pLJWwAtOQ7LN1jqJAFgFWlhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743267003; c=relaxed/simple;
	bh=wBItJjr2PFPlGSTXKyODvK2wAD3XVPMg4l7jmi28GnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MBYompx0mxUtuLcs++zSsXeitExlLnZv2YmGJd3+BmQK18PXd7aHTOrF/1YeaRgfmm5z5cSIP/7gA4FfjSZ0ptYCeLkGUGD5O8FvhAlmtg4pbw8S/E9wYgfBTTfdgE5nqBG3KupdA8/IovnvSzSwd7/e5XJtOm7pmi+69w7Ca/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YATDviqA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225477548e1so61494555ad.0;
        Sat, 29 Mar 2025 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743267001; x=1743871801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39bqTR2oxSLGDqqqGswRbolaRzFR8BCm6ARtdr3H4RU=;
        b=YATDviqAO6fSsrLPS3AO+5XWD12Hr5DguMGsl1cpmLGrjiomV7VcjAbq0hqvU27rqG
         bsMHN3M7+yl84Vv/jyOQ2W5iA7sk2n0Qwn0g7G67I5sYP4K5jfqkRhn3IJ7Pba+ny02L
         XtD9Jzc+pTbpi2+8MUWJe4+ZniC3YmMYj7Tm/EgtZI9LXzNLn/jVjdpwK5ONCFNg1xv+
         nnab2MTrgHeGUHOjBbSv0W0lUNoqAG6uqyk3Ag4gCbxdaF61rp1q+zuHeqFVUKrb24AR
         ET/bxz5+Vu3yjTX21IUHH+SqyW/ylTDzY92tlVrHZMzi1+HuH3OkpPPX9X6KBCtnnnEc
         8lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743267001; x=1743871801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39bqTR2oxSLGDqqqGswRbolaRzFR8BCm6ARtdr3H4RU=;
        b=JISWiNNmZyUvhWskxpwThCOvlnJDlQ3pYG2guq5bevYgMMqzUX2Q8KeNIJg1i9UMy3
         Ht7fEJXdXzIyxMXQBhlQaHGn6rXYx/1alE7lDe9DK4ra6StemLwT2UJf2GDHOQRtIUEs
         UMZCDIGy+TRpGkdbPbFpqI7dK36q+jb3phu4e/5z4FRd6dtLx+l5r7N6lxZlSv+0HJzO
         HWJ8Nlqz8WLaDZpPuaP+XmqaX7DEn05xceqZdMoSa/4fwKZJ/9Lv0y4Nci30l+u8/bA7
         edz1meI6oGJpgSzqBra/Hf6dF1LMMOZkqFPMS82RiO1t333EGOnCOACYZkCfVXTn2e0k
         Ha5A==
X-Forwarded-Encrypted: i=1; AJvYcCV81/3c2BBNc+A5gNPyX1RgoFuSSfJbOeGimU/xZCgr/SdtASh/u6JdVwMalQdCmYpoKSATFiFXm7q1@vger.kernel.org, AJvYcCW2I97GXqmVeo1BUDXTHILcNCDTU6jp9mh+cn4P2v3JResoX8qpmDm16PdrreSHMvpxhksyqspL7CTA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6kcCts1VW8ithm/S0PcyFYbjVTKfda+8kD0TYA+nXi4DmdYT
	P7OVSCb/ZBwkzbTQmewzCDx57dgbKXMFPJ41Ve3y75uH+4ocYfCJ
X-Gm-Gg: ASbGncu7C8Xui+JpUCAvfJuMoxBwYUIEfcr/Z2W5rhsSVRTEyX8Uy1v78EoIGhLfsSa
	wsqiF71e6SIB2m0Rp6HJ6K6zOniZNm+jOGapdB2fa9D3BdpZlHZbj7bpa9IXOgjmlq3D59EGLL7
	15+Cx2+fJXgR45LB+PVe1QXjU3MncD1wAXa6PKt9c6ey07Ql5fBw+144yurP6oUOaykAXEIrrme
	eyg4P/U5ZLEt0ETdSZz2wuAhSGGRCVoD07xyONY8yHuWZhs9k2FLb883BNhn/0uSSp7AGD0RwTC
	U9dTVUPpzfy6qEVQzleqBMuUavzi6o+kHBibT+v9ZpE669iKqoE=
X-Google-Smtp-Source: AGHT+IGGQ7/Oioc67bPlAJ8bCjjkylkU8yl91NVBs1nhRRoh13X9p/4w0kCOfyNJhcdy3+K+dn2YBg==
X-Received: by 2002:a17:903:1a07:b0:223:4d7e:e523 with SMTP id d9443c01a7336-2292fa055aamr52791245ad.50.1743267000819;
        Sat, 29 Mar 2025 09:50:00 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291eec6fb2sm38565425ad.26.2025.03.29.09.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 09:50:00 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH 0/3] add support for winsen MHZ19B CO2 sensor
Date: Sun, 30 Mar 2025 01:49:02 +0900
Message-Id: <20250329164905.632491-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for winsen MHZ19B CO2 sensor.

Datasheet:
https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf

Gyeyoung Baek (3):
  iio: chemical: add support for winsen MHZ19B CO2 sensor
  dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
  dt-bindings: add winsen to the vendor prefixes

 .../bindings/iio/chemical/winsen,mhz19b.yaml  |  31 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/chemical/Kconfig                  |   6 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/mhz19b.c                 | 354 ++++++++++++++++++
 5 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
 create mode 100644 drivers/iio/chemical/mhz19b.c

-- 
2.34.1


