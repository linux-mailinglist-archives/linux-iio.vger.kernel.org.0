Return-Path: <linux-iio+bounces-8158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE549463CD
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FAAB21E83
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA0376F1;
	Fri,  2 Aug 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnZOJi/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399B166F00;
	Fri,  2 Aug 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626579; cv=none; b=PKyXWfeyduLgdYNq3Yp2gZCpZQ8v1Sh7VZU3EdPNWF3TaF9AmgCv4uOCNvvudaTstZI8A7kpoxFRTmkiahLPF1kDnUyE1lAbGS20gsM0vWtaxY8owRqESlMdwvamhLDNRoSZlkPdu84rmRpkEqSxQtO6ELrZilpo228TsNLw7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626579; c=relaxed/simple;
	bh=a4Ix1bN7kYAyaexe/JE52OKfO2ZR8L/mUIPikwT94Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ch6AHFS8aCkzoREW2hkxqN9Q7tKX958lRkd4sR4t2gfh9x5U/RVpX2zg+G0mrv/B/pkzn4YOeIL0iX+ZD7WLwhqqYJcaNujMDOqLmD/f66l4v/uoA9NSE2WhdhOalep2Os5TugbFpV3o/dRMjfX2T/f6e0lsbIc5L8hDCeHUafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnZOJi/6; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db2315d7ceso4878515b6e.1;
        Fri, 02 Aug 2024 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626577; x=1723231377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mouIfH8iXKAgiuPl+irz5vubIoLkf5e+ydr2Ab2V/ac=;
        b=jnZOJi/6AFDbwvLTu1Wffqa9Q6n6txa5XzmTUacT9Ylg6UtKVKzY6KGbBC5QbpnGDX
         t62OvVfsW4VFV7ipthrSnVQQLQlnVeXv3+DDvqiDP2mz+qEAbtj9FtxLHo99SlwD9+YX
         8N22lJk8T/gl6S8poBxQg2fW8MGHcGHAd9kM6bcmd3WVWhFYMjacyQ9upqa7FxO0mDk8
         Fa6BLgUDSnrmgDwE2qqZAXz9IUsOxleyNsjUBHrbDrRdZxLcjnLySpIMrSzCjxl5I65m
         5HcYG3zL0VMXHUWmEClPgYCJMu7Sr8rihYls1GbVuPN8POEoYhMokZ+up6HoiyxqSXRf
         edtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626577; x=1723231377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mouIfH8iXKAgiuPl+irz5vubIoLkf5e+ydr2Ab2V/ac=;
        b=LbefLXsn0xy6DvLTW3udl336NoeuTqJGLrLHJTrykvsrqpoVYC8dVySYplUYcpqgUP
         yFZjln6ndgC20vvhlDrYi2+84AuAlUNZx7Quk9JgMCep1V6dHubumuam1mpAjPtleVGC
         Q5Dnx8ngpVf4dDZU8xchuVVq6o+RgKp2y3Ec0w6Nwgj0q6CroSVP4KGQhxo781+PmTws
         UJ3sBpofl/rqwDbBLwgS6x3WuFBMfePTJ5LPn6uq1utlGdP7IYNLbBWlbUSqBU4MNRPs
         ixP4su0xdWol6B6A5dzAVhpVlOpCmh/8sLwC+Hde0YRf3AHHO/5tk54VYS63Y6KLC73g
         MDog==
X-Forwarded-Encrypted: i=1; AJvYcCWIyU8W8qMJQNuZ/UhsCZRWkWII1k6rWGN8NCJcn95zVn3SbSw3JYZ3pgwOcWo/KNXBLomGvaTEP1BPP109Ysx/DPxsMIDlOspRML7tvz2w4nLeltE79+alkJ5gTJeiRZGVSQYuEw==
X-Gm-Message-State: AOJu0YwBnOJTqSxL08tHkqOK+R46O0/MaBbzM+QjhQYJ5Yif6fsAq5Sj
	S/2MrNTwLyIg8c+JmjoFBvHv584a0OGJhK90xDz7MAfOeVDus5lU
X-Google-Smtp-Source: AGHT+IEvGd6Xp975ECbxmLXitW6A80ucHgMhA2P1pDKhXhsdpg83qCIyCSwuxXQ3qrx89OpC/iWJSw==
X-Received: by 2002:a05:6808:23c5:b0:3d9:2b15:65d4 with SMTP id 5614622812f47-3db5580b007mr5610603b6e.21.1722626577346;
        Fri, 02 Aug 2024 12:22:57 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:56 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 09/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
Date: Fri,  2 Aug 2024 14:20:20 -0500
Message-Id: <20240802192026.446344-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the AXP717. It has BC 1.2 detection like the AXP813
and uses ADC channels like all other AXP devices, but otherwise is
very different requiring new registers for most functions.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 903e0bac24a0..e5879c85c9a3 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -26,6 +26,7 @@ properties:
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
+          - x-powers,axp717-usb-power-supply
           - x-powers,axp813-usb-power-supply
       - items:
           - const: x-powers,axp803-usb-power-supply
-- 
2.34.1


