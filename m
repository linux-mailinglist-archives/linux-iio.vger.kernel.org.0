Return-Path: <linux-iio+bounces-15922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8290A40003
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 20:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0733B24B3
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 19:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F631FF1BD;
	Fri, 21 Feb 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2T2AIj/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADA1FBEBE;
	Fri, 21 Feb 2025 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167227; cv=none; b=Hxcnp4krIvnDPIbxrVBpQtpF8KSRIyjuIkL//9Kly64kNTZ2mZ9z5fQUjEqOdg1QJSpQTGJgrpcS5rvDD9iQQtjQRsoST+xt87YovZTtQ2k23UAffT2X7VOpn1bZudg6JuzreGIQq3dv8ZQez+Q4hUNZBp9zLqCHfBnu2t4h9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167227; c=relaxed/simple;
	bh=TBw2bScEcDUBo9NzXVvHKFBz8rLRywVubQjdxqtB6fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OoamQ9ekZDNaZcUi1wdOv9KHFCVL6wAPX1uLR/ZqcfptpDCeGLWjkqgMGRKOKY18h/AKVFrvvzAD/8dlFGuQh0QazVT/FWO29GbcbZxH6ooOeKpYXZ7PVM9qyeH2LIwJvLrnsEVZHXyAgd+D9A9c0shfLmdahwCUK9P1a9BNNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2T2AIj/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dbe706f94fso428526a12.2;
        Fri, 21 Feb 2025 11:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740167224; x=1740772024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJdMcXw32Tg7Kx0gm7Vb+MSaJ2s2bdvGzbLZ44o42MY=;
        b=C2T2AIj/j+G64wA4LZ9QojYsEeI0mBUfT+DHkVE9QPY/ONcurd8YtvmGqodl7h39BI
         TfAsrTLePKvQhXzMsygtz6Rt8IRN4ngsDITnsDkqZR4+DryzRlQzEBx6sleHMiZYSZzS
         iHfC4T4ETwrrtQLLaD+kPl3VbKtfD5so2dL55av0y+nPf/8DMks22VZIrje8vOxa8w5X
         zSxJIElvWH0msyQvFuYShZ7kZHd7vHpl9MOWmJhQ5p/wfvIH0zVagouHsnUd64/N9LRk
         0mb3L1GRI4SmV/xIbqd0X/5k+xdrMRcNqEhzSVY2Cmm/WcCEHQCJCfhRneC2hBo9ct51
         mduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167224; x=1740772024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJdMcXw32Tg7Kx0gm7Vb+MSaJ2s2bdvGzbLZ44o42MY=;
        b=ChBUmdalVIN+5lz5siFrVhRnBNrb/JTuRFoPK+EuQh7lfZmmB5+Lsuiajwpvz5QOpG
         KTtSaT7vhTmdkdxcLObDgVvdF/3kVHYmohnBK7Sq1UaM6PBXBf49QHvkg+52BYjM4jmz
         8Mufe+4XZjs29un2a0uu57DFbYHrdo9iZ25lCNmGSCmGfKJ8qy7y3J7oz6nE9HN41/zc
         plr6iVBmUiNE2ez3axP8A9pnkMHJ2yx2dlQoocRJecXvTiaYdIque7AbH2KnXUf6waLE
         X6HgCFYm2oEpCGL2vBYxQqK1rFovcYryWpm1MNlJIZw5fNjUzO4dNOZSOeDyMxdX5p74
         0tzw==
X-Forwarded-Encrypted: i=1; AJvYcCVSUiSBaWDh6r5z9lHjrBINAx4N8V06mE1y/USAYWCUbjSMMNChma+M2nIjYrdHLO6qWScXEABXsBRoN9JI@vger.kernel.org, AJvYcCXZ02pPkYzfCQSxswaQU1mEL/fQlXAGj2Yj9slR7XZgHf2H9TIm8gPffSj6YyBTr03hRibIcFZdwsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI1ljSm4Ieixumpu54IYo4MMVFKiF0HCxA/NS3t9aGLVtJJw2B
	Cv/nitUCuex5IEkwwXDM3PW+Xoj+UahO/1X+tq1faL/3/rQxqDwS
X-Gm-Gg: ASbGncvq8U5rmW2HP7mKjUdkfYChlJO5NUO2UqHcTeIMqxC14gbUf58sj/2GK+cBP8u
	duds6K7v53SxigFEZd4zfbJPrLqJwos8ZlugYkGvjKvjYGOLJboYbjDxR90xZBuXewJr6eNVloX
	3Ic1wcOyrEZP4tmSBgwPbCamQSf9eC0OS6NaENB5gudbk/FXKe+a6aJtiSkPpWGyPA4NpS2AQNd
	hZ/xTTPSeFwqGHKqkZAQ1gGxYdHrMIWmwk1HV9bm6DrNawKw4ksA2njdfcEyclW78gJDkEGMbZF
	34f3KMoMAkOWM52Jqu070oQZ2pOfImo8A4vUQa0wmo0NrFPcE+hAWngqtzcwwyK8mNWL+/xlgjU
	NoiIF
X-Google-Smtp-Source: AGHT+IFRzksiLhzL1WUTWwraJUWiPJmyeGyuG22NVuRfAS2xcwghkGqN4VRc1ouD+hNtBDaOqEqKrQ==
X-Received: by 2002:a05:6402:5110:b0:5e0:36da:7ae4 with SMTP id 4fb4d7f45d1cf-5e0b70b5f1cmr1438219a12.1.1740167223656;
        Fri, 21 Feb 2025 11:47:03 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e076048c05sm6819525a12.35.2025.02.21.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:47:02 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	corbet@lwn.net,
	jic23@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v1 1/1] docs: iio: fix wrong driver name in documentation
Date: Fri, 21 Feb 2025 19:46:58 +0000
Message-Id: <20250221194658.41358-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADXL380/382 documentation uses in one place a wrong driver name.
Adds no functional change.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/iio/adxl380.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
index 376dee5fe1dd..66c8a4d4f767 100644
--- a/Documentation/iio/adxl380.rst
+++ b/Documentation/iio/adxl380.rst
@@ -94,7 +94,7 @@ apply the following formula:
 Where _offset and _scale are device attributes. If no _offset attribute is
 present, simply assume its value is 0.
 
-The adis16475 driver offers data for 2 types of channels, the table below shows
+The ADXL380 driver offers data for 2 types of channels, the table below shows
 the measurement units for the processed value, which are defined by the IIO
 framework:
 
-- 
2.39.5


