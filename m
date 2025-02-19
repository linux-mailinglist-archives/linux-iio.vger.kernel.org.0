Return-Path: <linux-iio+bounces-15803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7DA3C82A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB9D3B79DE
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB521518A;
	Wed, 19 Feb 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CUveTSWS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F1215068
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991544; cv=none; b=IaVb0dRdQKTfSNr/FYW1QaaXJVIO+sTs/P2Xk8R7+OZpJ+KLsogAHnDg5rXjiCpzKYXZUhEeR5MUTQI8Ixin7/nAlv5IMuJmzaokAPf9u5CkDljEfmNcN5J5NX4kbx2YAaa4mT3KEzlQZaCAe76S1RXCGpK/QgYC/7IEWk+4IRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991544; c=relaxed/simple;
	bh=oxIDr8H7+ynD5icMp1L0tohpWoDKxhs52fiB5mW6gUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jzn3Jqv0LgAf41OYaV8TSaa9Bcp1CHPCBlYPg+zZ9lGnE98Os5J5gKYq8S/aRBcLSCs7rgWC3e3+t78Pr8neSffQ2sBRgq2qibvBWnt6A2pU9Un444jbDcV+NFpqn4JasMR1s72PJWxzOZ0I1d1kqX6mOnFUatoLK6lxp2mFoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CUveTSWS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso515045e9.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739991539; x=1740596339; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kygqAvSk2wzyJnjkj1tcZQhsJjKBlVF3GdzFiy8QNlA=;
        b=CUveTSWSQfDKbfE7CFbBg4jaImltj08rsgh1xhkDMJsEfCHk78JDS+kDqPf+/ZN81h
         i8HMQ+jefPyaxUjzx7cwztd0ndCeCBOCcxjg22gQq3bhooPUJRxmgwZYaVcnAcUpQqzi
         TgyznZrV4tiKIiaqt2uELRFbJv/Wz4U4kmOSBx35qiKqt8lDqjRmD+nsOK/e3BCSgPfH
         DD9gOx62gPXCm3nF1z0RQchQyqSJ0v1xvgP5pYUAWewjlGhNLu3V6lrDGNqw85jOg+qg
         ZfBQVS4fK/WSBw21iCEoxYGrxjvrZRAWRgjdTT8xYI1/+BdEDZ3dAE2PmePYcv62bpDY
         IVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991539; x=1740596339;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kygqAvSk2wzyJnjkj1tcZQhsJjKBlVF3GdzFiy8QNlA=;
        b=WszvkLeM3WqwXc0qlez4e7tcH592Ak7Qz3X2zT2cxg8+5n/b7O9AMu/E4VoiXx+K5r
         aEDe3xFMfaZbhPGO/FrFiEEbSMmlkt35bAUoGZAii/L9E8EEnLn6u118Fcl7doLFRtLO
         7dGslEZoPjgTjILb2Dac4N58X7Pite8jksmAMNmdRva3EK5dHe4K3nmye9tfYC3XPDvy
         asR1pNlhn99ck8qzJS8O6QcuVEBNifhnF9c58C0slwv/H9UIRElkuugqbAXJAm0gtGlx
         ss5D7dkCVccjIHyWBhNhyKtoBxTw4EcUmuNDYj5vRXQ6wMSpSfDShGc0QkBSIhlUOD/g
         8COQ==
X-Gm-Message-State: AOJu0YxanmX2VepDGgqnPEYpwsF6lvpZVT0JR+/iaT8oVRa0kY/jn1q1
	EBhWeD0/ySpa2DOJccGcN3xrxKyQGWU170oQUVLDF5L7NKXK9EEHBphj+EHZszQ=
X-Gm-Gg: ASbGncv6OADH29/7cotEy4bKjgoSVh4qQlV7cRKf2WtseIA9/0pq2c/zIImGhcfTn+E
	2Ahgc0ctmGXV9ujAEa6kitx/YJu+n1pahQzWlt2Vaje1lNIEXJxVLWmZoxmK4zq0JWCAU/LH7DE
	1J1kFvIk/wz66HEYYImtdVJd3bEqY08geIT3X8qd3Lr7gyBX/f/Yxck+Ch1ie1+PE+BcCOWz0RE
	twif64CnASn+nWIehNMRo4heaiCUwy6Q6gxBXu75CZhWr3Dgmb+nD/veVdJzmO6VHAWbyTPyNCj
	lJB3UBMcF19L4b3pAI9m+xnKbXMn8Gj0SYG47qG7s8U9puYtRBWmCgf5hAniW+U=
X-Google-Smtp-Source: AGHT+IEnbJY/mIDaP2qtCLo05g9UW5rHHcHO+JXueHyKnlKuuX8Vac6lYcqM+/9ztHZ3NKRRxRGTAQ==
X-Received: by 2002:a5d:64e9:0:b0:38f:2c28:687c with SMTP id ffacd0b85a97d-38f5878c9cemr3941389f8f.15.1739991539353;
        Wed, 19 Feb 2025 10:58:59 -0800 (PST)
Received: from [127.0.1.1] (host-79-54-50-21.retail.telecomitalia.it. [79.54.50.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b44b2sm18336665f8f.20.2025.02.19.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:58:58 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 19 Feb 2025 19:57:43 +0100
Subject: [PATCH] iio: dac: adi-axi-dac: add io_mode check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-wip-bl-axi-dac-add-enum-check-v1-1-8de9db0b3b1b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKYptmcC/x3MTQqDMBAG0KvIrPuBiVi1Vyku8jPVQU0loVUQ7
 25w+TbvoMRRONGrOCjyX5J8Q4Z6FORGEwaG+GzSpa5LrTpsssLOMLvAGwfjPTj8FriR3YTW2qd
 qdFs3XUX5WCN/ZL//d3+eF/ahDhtvAAAA
X-Change-ID: 20250219-wip-bl-axi-dac-add-enum-check-8bb617285793
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add safe check to the high bound of the enum values,

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 009fb987e1afd04c3dbc59a9742f7982744420c2..892d770aec69c4259de777058801c9ab33c79923 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -728,6 +728,9 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 	int ival, ret;
 
+	if (mode > AD3552R_IO_MODE_QSPI)
+		return -EINVAL;
+
 	guard(mutex)(&st->lock);
 
 	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,

---
base-commit: 4dd0ce442fa57f5274878c89223362344f28224c
change-id: 20250219-wip-bl-axi-dac-add-enum-check-8bb617285793

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


