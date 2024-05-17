Return-Path: <linux-iio+bounces-5087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22C8C8272
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 10:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE111F21901
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24021373;
	Fri, 17 May 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLdTfjMN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD811805E;
	Fri, 17 May 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933458; cv=none; b=dzgdKdg27LzvfdPOI7Tv/vZVI61/LU5PAIfnibEgwBppCcEcitjQ9mn8fuMOF+UzPiJdVbKD/ofKyJYvKr8rC3+jo6x17MWdLD24Y1X8Ng8M2NQHadBgx0UCWOvNgC1u2Of/ZRlmS8DL/szMa7+Zv0bKh7O5I2k6LQHjf9Hx86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933458; c=relaxed/simple;
	bh=lGw2HybutGoWrWk9oRxBJ4eVJWgMv7KL4eOOwSu0JkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z71d7of1CfijRg4w45nFP4h3Pr46tIbIbd5qigiBv9Yhnok7hXDJLBv6yka/TYeLZUzqCrnaWUkwgRrflq1+3PxwGz2me9j1YKlwb/1P4yWPB0m+IZEAoIvosKdO9qYlbqAsMj05TqPbeSTdh7wHJx+dn+14aoi/Pyq2eArncno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLdTfjMN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a88339780so438448166b.0;
        Fri, 17 May 2024 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715933455; x=1716538255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtJTzIddnIPcMjdjD69D9TyeaZYlnK70BMkjvGWeWhA=;
        b=TLdTfjMNAL8iMEjTMlFWaUzj1PeH1NvYjhcwBZYocIr7gCVdQRlLbV8pPDFdNowEDS
         geW6b9zbba2zB0IbAmYp9iHcR+04hCOamspBJCB/mWfD0z7lgQnO9qhZOZMo+XTtkzm1
         SxHNqvBmG1W/PxUzMuWwxm8PIjvudJF1/2MfKqLHgoWX/wYXXhOITWAxEIurOnmZd4GJ
         Wf720Jwu9xcM8GDc9Jx5ro+qutR9TtCWiaHg5kNm6xNPqIu27X3F8GZp9UIIgKNYZy6i
         nB5ec1Ou6t30J6hdzmL2v0Wf7EoD3hkynrC5Ocmdtv41U0gog+28l278M5Yvt+zbIVcV
         Lm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715933455; x=1716538255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtJTzIddnIPcMjdjD69D9TyeaZYlnK70BMkjvGWeWhA=;
        b=YaZ8tU3hzaFIhI92LNkPZ5h77fxjUSEa2PKsCTUA3m02P8/o1Eq7jtGvK0kvCpRLFH
         2I1z/qed5ISJLpkwGkAyRNFdvgdWHIag13h6jQZ0cTSEJzWIZaxmDBHUEmGMU3AuwnGp
         H1+CfIkL+qV5xNybUgwmacrLoEBs++q7unnJw6WTfIGwBAAvj0yEQEpIDZNJScg9K1hA
         Ne72hbRV6GLLdcC+8Fzr9YsvrwpccNFwLLaAkfRNQ0EZLTvAwvwEIgobVoGo2tcxCwYY
         dxBm2trIdZCiA/jZhwjwDOKBHknGIHBjyxwztPdKVWsFd155/VR54dtllU1g5sOCY5lD
         o0ew==
X-Forwarded-Encrypted: i=1; AJvYcCWtu2Dgp8yPm3cYN0RLDrvbpvXLVtVkunX7vP5famxD4GV+C2Zo1pl6yr1zSzjzOMxp93n14H3W+jW8XI0QOozz8/WfaIjnPJv05ftrULczqBFltJvxA3qHo7PcsB9VY1F+r8pMXEfR
X-Gm-Message-State: AOJu0YzmfO4isZ6P/c70IKUcixFuryFzymtOejn+z/jnRWnsTnAYptRz
	u8ToPqBGsJ6O3RzjMjLtHyUEkzq250FbDG2Mg5tnX7+jnglBmKRH
X-Google-Smtp-Source: AGHT+IF0fygO+uvpnet5qo93jNclcEeiz6X79+F0WROq0d2oJTp+7cCAudpx4tBz8AvVWvK5UxxWow==
X-Received: by 2002:a17:907:cc1e:b0:a5c:e636:d0e5 with SMTP id a640c23a62f3a-a5ce636d12amr276249566b.51.1715933455229;
        Fri, 17 May 2024 01:10:55 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm360867866b.85.2024.05.17.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:10:54 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: temperature: mcp9600: Provide index for both channels
Date: Fri, 17 May 2024 10:10:49 +0200
Message-Id: <20240517081050.168698-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517081050.168698-1-dima.fedrau@gmail.com>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mapping from cold junction to ambient temperature is inaccurate. We
provide an index for hot and cold junction temperatures.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 46845804292b..22451d1d9e1f 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -14,6 +14,9 @@
 
 #include <linux/iio/iio.h>
 
+#define MCP9600_CHAN_HOT_JUNCTION	0
+#define MCP9600_CHAN_COLD_JUNCTION	1
+
 /* MCP9600 registers */
 #define MCP9600_HOT_JUNCTION 0x0
 #define MCP9600_COLD_JUNCTION 0x2
@@ -25,17 +28,19 @@
 static const struct iio_chan_spec mcp9600_channels[] = {
 	{
 		.type = IIO_TEMP,
+		.channel = MCP9600_CHAN_HOT_JUNCTION,
 		.address = MCP9600_HOT_JUNCTION,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
 	},
 	{
 		.type = IIO_TEMP,
+		.channel = MCP9600_CHAN_COLD_JUNCTION,
 		.address = MCP9600_COLD_JUNCTION,
-		.channel2 = IIO_MOD_TEMP_AMBIENT,
-		.modified = 1,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
 	},
 };
 
-- 
2.39.2


