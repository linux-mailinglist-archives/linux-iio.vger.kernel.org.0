Return-Path: <linux-iio+bounces-15794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB4A3C2FD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F67A7B57
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938A1F4180;
	Wed, 19 Feb 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8mzHaMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402ED1F30A4;
	Wed, 19 Feb 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977413; cv=none; b=Da9ndOX5ybJBt7b6N3DIDXJme/iR2RNSZzJW/N6rbQp312x3f6Na25OltI/LGFRWLD6Wm6r/cCC+ciEiXHQgUEPGBxm/NJzkH8VE84MVBveWxMBCMineig6LAsPwdaYTQd2f35c+O0rJEVoeY+96t268pWSRGgA9NHDQf/KnrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977413; c=relaxed/simple;
	bh=Gd9SxygxTLKOh9h22adGoLu8IsmJ5HnvKN/I+YS9u5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLjAFnwLSwwE1fkArO2oVP3B2eGl7LkwCsaTIaISeRB+vBVuhtyeCkJNClqxa169D9egwdF7Q2WGF0Ysu9NHTto6K4b/HoslT9qZV+bJmtoMjGQLqdW/4U0L4WRVbjXHto7+9nGv52YOBwXG+0bpcadE7i1VVWWt/pZ1N1HuS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8mzHaMW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c8cf98bbso139380195ad.1;
        Wed, 19 Feb 2025 07:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977411; x=1740582211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDtM3LKTpyGDe7HA8GkkT9qfwrfKuIszVf5WOPbYasI=;
        b=a8mzHaMWsFL8xWqN3N0LFTCesH1QYB5WpNPCJsy9rGIG1dRXpVLIcbsj0WLVW8bovg
         mcWs5CUmZr6DgwCsiU/1YJR4VoD0Bzde4c7DpSJQM0B2ItuvnF0tim3rUEhKZAkpY+bN
         2YEhMwPstjuzSLTwNB2mGEQD45Gk+siwEra3jXthQuBnX2af/jSTzPGBkFV2poYRWU8I
         BILkcGRhGqi1FqvLHe6OKv2jNhlQ+0ouLxw0vYDBkD2hW4ibDIvn62YVfeE/9lOvASf7
         ganjfcQEeCAA57CRotzrxOFRDD0Qaqlm0nyj16oo18JNQpMC/U6Bg70xB3OrEMcl7osP
         +Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977411; x=1740582211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDtM3LKTpyGDe7HA8GkkT9qfwrfKuIszVf5WOPbYasI=;
        b=qoAPYEfNPCUoztlGYtUDMKPmTotXT+kNmXm961eBb1VT2WNjlyYsVf0jOYMp2D3tX4
         WXiCVZCUl5e7+lxP11/3gd42aXeYfwE5fhB7zAqlUa81nic26bVQ6o6rSgA0G7/OnuWc
         xNt5ZYA4oQw2hip7u3ksjnMtf2amVfSPN3zd1evb8nxTr0hpznb2Q52fyb+ASSnpT8tr
         R19+A7RonbBHTNXmoZydw22CfSrgi6/zFNrWx6x1VaACLXguIptU9LdURFLRA2K5XbOa
         4Pkcf+1sqa1DxhyC0grU3YP1mAA9/nLbVZcd/IKY/uJW62278eW6U3sxQ/zA8jo8x8b4
         HfEA==
X-Forwarded-Encrypted: i=1; AJvYcCUSz9PcukZx6RA48gbpkeCCfQc76YtXGiPGD1GAyWzi2AcVL+pGiJuPJzA+wkV++wy8x0yynaXnpZ4=@vger.kernel.org, AJvYcCVPooWILIE0O1amiMnLdIMJs7Wo3/Wr4jEOZc4Rek/tkxzLpwWA1gFxm3UToBpaI2WRCmiVr2MsNHIfsRxL@vger.kernel.org
X-Gm-Message-State: AOJu0YxlomlLjGqcPRCDArFHZU+M//J78Qj83tUjL12G65K1OIh2MIlo
	oEuTUc0490zKPO/uoYj5y9F+4iQcSgPbO1Dx046YIaihwFcdFt1nf17kohdpw/w=
X-Gm-Gg: ASbGncuEvmY8gJzJxWitLDxvi8G7ib8l9RY63e2BilR/xVRc6UGvOd610YktDPGCE7p
	sp1c/dcm9LMpvtXCcKLpyc0Yh+GkAZ0tn7htM0KacEe2275Q4bPnMYeEBBP8Xb5Svx5R/1R2LMK
	eYm/EKgHa4Lm1zO1LCIAhRP7aR6+PcMfuVeJEI/Xk5VlcAk7Z5eIQDM6UWjoHbfgQXN2vFJIFWR
	c0HdjRGIYObULKzZi1Lvkq01omeLZtiWr0BmnVc9zPDQ/kzGPFoXLEeShsHh0nRR775VSpn/FaG
	MlPq97OcRd51H+Xp
X-Google-Smtp-Source: AGHT+IHkDejfe/yAHHkUx5kZZEC4mfz3BQpuGVy/zfvCnCYcXyOj3DMpndIP1CZsEyVIvXI5iR/iSw==
X-Received: by 2002:a05:6a21:32aa:b0:1ee:cf5d:c05e with SMTP id adf61e73a8af0-1eecf5dc1f1mr8860724637.9.1739977411460;
        Wed, 19 Feb 2025 07:03:31 -0800 (PST)
Received: from arch.localdomain ([2a09:bac5:cb26:1541::21e:92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327367a960sm6888976b3a.150.2025.02.19.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:03:31 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH 2/2] iio: gyro: bmg160_i2c: add BMI088 to of_match_table
Date: Wed, 19 Feb 2025 23:02:54 +0800
Message-ID: <20250219150254.24664-3-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219150254.24664-1-jerrysteve1101@gmail.com>
References: <20250219150254.24664-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BMI088 is missing from the of_match_table. Let's complete it.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/gyro/bmg160_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 9c5d7e8ee99c..e6caab49f98a 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -58,6 +58,7 @@ MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
 static const struct of_device_id bmg160_of_match[] = {
 	{ .compatible = "bosch,bmg160" },
 	{ .compatible = "bosch,bmi055_gyro" },
+	{ .compatible = "bosch,bmi088_gyro" },
 	{ }
 };
 
-- 
2.48.1


