Return-Path: <linux-iio+bounces-11504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E559B376C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B312C1F239AB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C31DF273;
	Mon, 28 Oct 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct+fVxZ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17A1DF246;
	Mon, 28 Oct 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135649; cv=none; b=BnP56bGbgalkVzOh5m1YJ706eEcKdOgTi6GAATDFZNltUsEiu5bNfn8Aqn/aDptkcLIisNA4OaLde5N30PhHSxE9SoSaCF7HIKBLKyqEhsAWdy9T9NwKrx6H1A2Kl54Og+OwlESaRKNEuj5ltm94iLLhLZqR4aOqdptrT3CZy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135649; c=relaxed/simple;
	bh=7m5wXDiwv06gpjNw2JsVejh2q1Px/bfyGJOLGg/xMnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DP92Ppx37EKvcubQdXuyBWvrkz8raESiPmmzv3ZaIE66Qepd5mMH67L7mbLqHmqTYuKoexLGu0vflw6qnp3gQgn+fjzsoOft19a4ziqbCYe3vGTl+AXycDJUCIhK67QWE2rLByZSJDsQn6bYfM7zAXhShrJLe0tLrTlkjTIcOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct+fVxZ5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so45859525e9.1;
        Mon, 28 Oct 2024 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135646; x=1730740446; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2TQgkgIq5ZmGgVbkeehsOSAF3zSViUzgIHhHB8QyBIU=;
        b=Ct+fVxZ5e6Ox+wGYkwsBt2iU5yOKnnlD3pq705UeUbK9HcWg+snZQi2gg34RNVIhch
         hvgFEadjcGytM7rdqa53KtKeOeDMkdYAlvwGYDY1KxPdAEH2U4I5eqAS5fWtYh8QzpUO
         lHPbPfV2/DvWQVSJ+lCMmRQqMnAaXZaCp4nQQAOChTQj0P0JBm7zHL0WQIvg9KLcQw9w
         3zFqBeVN9PPbGqyTWhc0m5WcZZTpYWYFY82uWArin6jwnK2LrrCz+f+JLueQ9FRF/MHM
         +hYNNUE5Q9FX2f0fh0xYgSK9iSgZhMQbebhYrOLBAoEls1FWXCr/47YQHughQYNVOZZl
         cEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135646; x=1730740446;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TQgkgIq5ZmGgVbkeehsOSAF3zSViUzgIHhHB8QyBIU=;
        b=MnblT9FesqSUPodB5YEtXpr0+8DK93g+smnCBpJzdJ7sjjleDUE+hdzbWUESCeQokr
         Yf/aGxj9LOcf4CBIM6hwQaKaxYjCijemN/6QPrgcUDTS2RERClOjMoSU4R9yBnfTF7ol
         Bu7FBnONkikOG1+lG2+pIkkbFNMQgxP27rOdzBdMKp9bzdY95//DMn9oOPbLSuH3F6zH
         FwO+4G9KYWLj5rRv+bb6mhzu7LLbrFsIW1J3ntoerCBS9SakPP9mgqGOOddvOWXrerBz
         Fv2eRuJULKacceClp6h+V88H6BlsuJF5tak0Sv/YaWwOaUogBIusBjiuzda5MVUBgo4z
         6bVg==
X-Forwarded-Encrypted: i=1; AJvYcCVYlgWUQLMowOVDwcSLHOxvMtWTowYqfFiEn00jhdKOxoVL5BHUj+n/yTs4MJgTmL7byRwUUCTNL6P7i97u@vger.kernel.org, AJvYcCWGugXZYtvle1kjxlnxFDiALkOX7RwhtMnEWuhBtx4BWi0Z9aAO+dCpefdRZ+zjheZkzrPlGAH4l7HD@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMr0TRHzUYtcByq74WlOkwhYWZzdIo6bgM7gxnulk3e9xwTlA
	0dLDrXoMs43mnrjKKtFTnBXdZHILRbXbAah9SKzr7WgYdnALvzh1glMIgA==
X-Google-Smtp-Source: AGHT+IH80hcLSPDbqezNso9e0Ius3puDDPEIZoJ82jPsXytO4hdHe23fSDkOjYRyTDg+NMLxfWcpLw==
X-Received: by 2002:a05:600c:3c9a:b0:431:5d14:1cae with SMTP id 5b1f17b1804b1-4319acb1d60mr73927265e9.19.1730135645914;
        Mon, 28 Oct 2024 10:14:05 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193595470sm114693795e9.15.2024.10.28.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:14:05 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/2] iio: light: veml6070: add integration time
Date: Mon, 28 Oct 2024 18:14:00 +0100
Message-Id: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjGH2cC/33OTQqDMBAF4KtI1k1Jxp+UrnqP0kVqJjpgVJIQW
 sS7NwoFVy7fwPveLCygJwzsXizMY6JA05hDeSlY2+uxQ04mZwYCKilkxRO6oRFKcBojdl7HXOC
 RHHJ1M9pWqLUBy3J/9mjps9vPV849hTj57z6V5Hb9q+pETZILXtZCGalM3YB+dE7TcG0nxzY1w
 UGCs/8SZMnUJSjAVlh8H6V1XX9EqWYnDAEAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135643; l=2472;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7m5wXDiwv06gpjNw2JsVejh2q1Px/bfyGJOLGg/xMnk=;
 b=cCAUSJMqxZRH+52IXxD8JFbJ3jENtwu2N814G7xHnblVWbE5sj91VGS7kkxgjAthdQG/pBvEs
 1bOM40dmQ90DICY+ghypEbAdat68SezaHhdMEgd8bmTEHuaQNO8kF9S
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds a missing feature in the veml6070 driver to select the
integration time, which also depends on an external restistor that has
been added to the corresponding bindings.

The datasheet provides a Refresh time vs Rset graph (figure 7), which
does not clearly specify the minimum and maximum values for Rset. The
manufacuter has confirmed that no values under 75 kohms should be used
to keep linearity, and the graph does not go beyond 1200 kohms, which is
also the biggest Rset used in the application note. The default value of
270 kohms is the one currently used in the driver to calculate the UVI.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- veml6075.yaml: simplify property handling (describe it completely at
  the top and add block for the devices that do not support it).
- veml6070.c: use int instead of u32 for the integration times.
- veml6070.c: refactor default rset value assignment.
- veml6070.c: drop comment about default Rset and IT.
- veml6070.c: use units from units.h
- Link to v2: https://lore.kernel.org/r/20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com

Changes in v2:
- Rebase onto iio/testing and drop applied patches.
- veml6075.yaml: use documented -ohms, top-level definition and
  per-device restriction.
- veml6075.yaml: add default value.
- veml6075.yaml: fix typo in commit message.
- veml6070.c: adjust rset property name and convert from ohms to kohms
  to avoid overflows and work with the same units as in the datasheet.
- veml6070.c: change default to 270 kohms (already used as default
  value to calculate UVI).
- veml6070.c: calculate UVI according to the current integration time.
- veml6070.c: re-calculate measurement time (i.e. msleep()) with the
  current integration time.
- Link to v1: https://lore.kernel.org/r/20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com

---
Javier Carrasco (2):
      dt-bindings: iio: light: veml6075: document rset-ohms
      iio: light: veml6070: add support for integration time

 .../bindings/iio/light/vishay,veml6075.yaml        |  18 +++
 drivers/iio/light/veml6070.c                       | 134 +++++++++++++++++++--
 2 files changed, 144 insertions(+), 8 deletions(-)
---
base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
change-id: 20241014-veml6070-integration-time-78daf4eaad2f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


