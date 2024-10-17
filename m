Return-Path: <linux-iio+bounces-10695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD19A2FE3
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352191C2101D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042B1D6DB5;
	Thu, 17 Oct 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Leit3GEd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D311D61B9;
	Thu, 17 Oct 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201176; cv=none; b=AoVdASQt238YVfxUz53LZuc3caJ3rDY/L2aXHeqVxgl//WwIVx4T6tGE2Ptbrk1fKQQ2T8FNXP1uBZsen92Zbj7Dk8udJWqEqwB2UzXoLMi6a/JY27uA0zgsDI4lvUCdf/5x1imcTVNfp8rEdGVHdz2YJ9NwOJEteBzZbQHNGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201176; c=relaxed/simple;
	bh=aoZ0h82kgzuW5AGTpkTwbcGt/l8KTTy/nYspCqa4KPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOlGi4873dOqDNRdYbDFgg/synJUEL50UHarxDNL98az5jDiBT52bFpw8qmXUuDBWsT7cqbIfXACozRbfweDuwGERa1D3x0M3kQf5j3cBtNbq5pGl/2PfpxjVHG8i3lwfRq2YHX5Ki7t7ZRxhAnr0uQlyiEHcaFxCh/f6t1HadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Leit3GEd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1214242f8f.3;
        Thu, 17 Oct 2024 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729201173; x=1729805973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZZskDHhJgNIrqQxqaEa2q6iwbD+pLv8wuGEp1Sg5Mc=;
        b=Leit3GEdw0TADFPjEKZ+GDsGC9we+hmsGE0OYdMYWiuhgP2hpgx8rVTfjVbb3BbIrc
         HxosAbrOMyLK1zwsQIqhQK0frv4ACZGFAe9g9q9/rF7kUbjE0OVGk8Ggcg1Xf5iqDwhg
         PFozB5vtCAXx0AXpyURcbhtBMI1fUKXhMTMSqhlTr5SGtF166Xr1zcoRrfyS2Olp8Edy
         8O8rYWyNqBAkaCyrnBH5Zwrib59OqZ4If1j5oXPFceci+D85AmWF3xSrQtXmNWMXb1D4
         LPYCfK0JTGIFpqBXjz+rT8Avr+Oa7/dg4SrViMboLG+brEZhj2MqKisbHTWcsvbkQoVj
         z8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201173; x=1729805973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZZskDHhJgNIrqQxqaEa2q6iwbD+pLv8wuGEp1Sg5Mc=;
        b=QMM1l3Z5Hr/0MvU+2ApevfqW44YUM3+AdqTFyiz/DFPNC/Q6VuW+r+PCBv9vAD6/ZK
         8Kh5oFy1WCbLhR8AkBe4gy2P0fgkWo9fkpOA9U2RcKcsZp8bBCcCZeOSwOBJw1YaJpFC
         o6ws9XLfzac7T3cO0rQyytMN4kpXkp56v/rdxvhZDQfq8m6VcHVm1PuljtSirTlg/KgC
         LkkxRR0FTC3HXMtYN93l3ZhsOuoSCUU+Gg8u/b2sqUF+UE/E3k1jq956vZV/NxIbuAmS
         1nxfCqo9k2L5NQeQM0K8/dbewj3tQXzslf5mD7/QC+HKRss6eA4E+KxA1e+ED9leILDY
         0Z2w==
X-Forwarded-Encrypted: i=1; AJvYcCWPyg8waa+lDwg5DQWgcM7US5e4FTL7GP4UFMSiQQYz8UEZZkiSEzs7cHpLLwHwMMPx13wRgQQqWriwIr1q@vger.kernel.org, AJvYcCX20AhTJkxsmvton+6+ZxyLJyhc+NrBGbvY1w9/4pubdHPcrhAF8rkYJbLcSogEDNYK4jrhh/aEBXNS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nCcfd4uvruZd70u6VAIwjgaVdWDn2Ys/E+b2OXx8t57Wkx3k
	28SZ4lBulksD7yH0geCchpDexXfde5hi1c3nYAcfM8ggondCgHRZ
X-Google-Smtp-Source: AGHT+IGI5hyT7n8T8UqCYtU3lhPOW16lC4VlEzZTrFqou7Nvu5iRvx5YhrdVGqjL/FqSwGW38PCIaQ==
X-Received: by 2002:adf:eac8:0:b0:37d:397a:5a05 with SMTP id ffacd0b85a97d-37eb485ed73mr282867f8f.54.1729201173416;
        Thu, 17 Oct 2024 14:39:33 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bb11-f817-987f-ea1f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bb11:f817:987f:ea1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06a73esm99874f8f.43.2024.10.17.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:39:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 17 Oct 2024 23:39:25 +0200
Subject: [PATCH 1/4] iio: light: veml6070: use unsigned int instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-veml6070-integration-time-v1-1-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
In-Reply-To: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729201167; l=991;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=aoZ0h82kgzuW5AGTpkTwbcGt/l8KTTy/nYspCqa4KPQ=;
 b=mRM0/5BGvT7x5UCtVg4OVV7VxtwC90/Ax1LgDZxkzuLGj4YkZI5/SiLKEEG3jr07d0JrvjHyN
 ts2QMOGZsZpCw2g2ivVe+uwpzSFqFxVXSLVZ7oMNXmvsDUl9RJfPJC0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Trivial modification to use the recommended keyword 'int' after
'unsigned' for unsigned integers.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 898e285322d4..484b767df481 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -87,14 +87,14 @@ static const struct iio_chan_spec veml6070_channels[] = {
 	}
 };
 
-static int veml6070_to_uv_index(unsigned val)
+static int veml6070_to_uv_index(unsigned int val)
 {
 	/*
 	 * conversion of raw UV intensity values to UV index depends on
 	 * integration time (IT) and value of the resistor connected to
 	 * the RSET pin (default: 270 KOhm)
 	 */
-	unsigned uvi[11] = {
+	unsigned int uvi[11] = {
 		187, 373, 560, /* low */
 		746, 933, 1120, /* moderate */
 		1308, 1494, /* high */

-- 
2.43.0


