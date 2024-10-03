Return-Path: <linux-iio+bounces-10056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9798F485
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E7B1F2241C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE81AB6D4;
	Thu,  3 Oct 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImshHwP5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632D1AB51B;
	Thu,  3 Oct 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974195; cv=none; b=koK4Yt3jKHeCPWQiNZ7Pa2C8808daCmi++Xblw1AwiB5TkHy2ggdZ+9BdamDF54AvT4ECxmTlXnVF3UGCZNKVNeoHTW8MA1jLPW9YhfZvxB+HrGIFtgkC0+uJ4duLFNff05Z1fcOKznh2LmQyZQ4LiLRfklNFmxbdn0Kkb4TK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974195; c=relaxed/simple;
	bh=fYps7tbBDMfY5p6j0WDMn3HTxiHN77MkfazuEtpJ5UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NbMZ7GtZ2P+kM1MTIQf2G+1Evk8AVN2/JjTtxYJQmJ5OrbUmDBWhH0nlWQlUwoAKAV+L4xy/CWjilChjEoUHsFQm42vN6612v28gWBq0IdIIr8X99zy/+E5uZymxqTk0h7aYihNkvGhj1PzMDyZqJzVbG295Rf8TXg0cr/WKEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImshHwP5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so9844345e9.3;
        Thu, 03 Oct 2024 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974192; x=1728578992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ec2MaAArL9ko9bfMhyuOZDd7+dTFUOvg5nm4pFeShkw=;
        b=ImshHwP5pcCydr+h9wpW+UluBk7JWRA/3dpg8gOP0q+2LLs/Fp7LlxRA17XIvXwbxJ
         AW1ms/6N5Sd9UBGnh7Nq8H+p4iBcuBGuar1V6v3HgTOWKkuptOeR5fqsKwVZomfmRj4K
         I1zEx6sFRIsfu3HGwmQmwxFvEaWuzNw3+AIvkcu5bwLHs2ppZGpQ5d+M/Ez0y/oNOj8k
         qPYFGsofuSfPz7CFjlCUUKD8TktKcKspDJXY6s3yXBp4Bmlk1VxOqqgdeoxTQdPJzlHo
         yZncSF1A4veKEajhSz30JVDX1vFoWFSxUwnhp9HUJZxbNl5Dg3Yk77YfAcDf7kcBt1G9
         4jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974192; x=1728578992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec2MaAArL9ko9bfMhyuOZDd7+dTFUOvg5nm4pFeShkw=;
        b=bYTVn3ZTMDEeFvZKVDSc8qYzHtp0va/BENajc450NAH+xMNKL493xY8zcofvvaX5+g
         mFEGBFg5zvWSDI5WG/rwTObmBs4DntMDFOxbdVpk1Vp8BeS/aYmJPastl5BKng5cSa4P
         fFLRZlWbxA1jWJ3zWD96m8tma//98/CW+rscyvYLntJC4ayXeoxy+JLkbiTgKSLCVAFt
         pEM8e7POFyh1E/5eoJzsyAYSrkwRnesHht1z5qrtjSn/teonWg3f21BlZt/32sCpsPix
         uI8T7qKNoIPb0zjsbkc5Z8VO11BsYUXwYUShMb0gOdlI4U7NNqWibYqERL9VD1CYywO3
         y6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4HjsvvnGeECju5MWNtXdSOsgLoBKNHeojMN2Sk9xDz+FT5Q3P4kqkmSl9VUBOGVx7LXqFx4ckUFgc0x+Q@vger.kernel.org, AJvYcCWI/NygzXjXBLpEFje7Hb667fWhpaWQnweK6vORYrgzNoN7rneA41r2F9z8GA7DF2oNAhSbcSQTIEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPd6TjWAQoQr+EdI9EN0XhG7kETLIl9AfM+9GsWsC4vxlKVfh
	QsZHxjRVwVwNELlaHnmxq/cSFkxmJRYPD9paOBl0mxGM8cxSr5DKmqLpXo2Y
X-Google-Smtp-Source: AGHT+IF490mQueNxhycQ24Ndivihv3S+jue+DJJpkfn+y1tm/8L6ws0MzBlm4NtXuGmgfYwOeQ+ytw==
X-Received: by 2002:a05:600c:4448:b0:42c:b950:680a with SMTP id 5b1f17b1804b1-42f777c2c01mr48707665e9.20.1727974192267;
        Thu, 03 Oct 2024 09:49:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0134sm19783385e9.31.2024.10.03.09.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:49:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 18:49:37 +0200
Subject: [PATCH 5/8] iio: amplifiers: ada4250: add missing select
 REGMAP_SPI in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-ad2s1210-select-v1-5-4019453f8c33@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
In-Reply-To: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Cristian Pop <cristian.pop@analog.com>, 
 Mircea Caprioru <mircea.caprioru@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727974182; l=839;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=fYps7tbBDMfY5p6j0WDMn3HTxiHN77MkfazuEtpJ5UM=;
 b=t0GHWSkfnKoJ5et69GPHsgzQ4f4kn+pU/hShz704azRIE9EoOCmUpAcIIBM5n0lhGxN0fmkUD
 FU3ryT/Tw78BVETu4FoDyzFE56xrFFtIW53n6+ZEjlLrLSIG448AiYz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of regmap_spi, but does not select the required
module.
Add the missing 'select REGMAP_SPI'.

Fixes: 28b4c30bfa5f ("iio: amplifiers: ada4250: add support for ADA4250")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/amplifiers/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index b54fe01734b0..55eb16b32f6c 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -27,6 +27,7 @@ config AD8366
 config ADA4250
 	tristate "Analog Devices ADA4250 Instrumentation Amplifier"
 	depends on SPI
+	select REGMAP_SPI
 	help
 	  Say yes here to build support for Analog Devices ADA4250
 	  SPI Amplifier's support. The driver provides direct access via

-- 
2.43.0


