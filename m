Return-Path: <linux-iio+bounces-8972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C39684E2
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D921C22BEB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D71D363D;
	Mon,  2 Sep 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XeNMGh6k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C61D2790
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273430; cv=none; b=b5eAHs9nAxmLgLdIN+pwHiGgszy6TD5MNJqjc/dzTMGYJBrCfgzBdFzN5KEE85zPumMeZAsB+w+EdzMzVVwVsoRmesd9X5UKQt2BJJ3SN4cxkhoNGqES619+TWsK+oLU98bRtGjoRr3oI9fUDnrEML+It9UPU1uOEjHR49obZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273430; c=relaxed/simple;
	bh=0B4OtPaPq3djfnjasTB0YK8oEPN0Criv7QLDnmRZ0RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnR/EPCPOdQ65k9B0WMo8bMW1ZGemImxslOrBCdUCh2aBqRTP1EZosizXoBOUrBTzw3oUF8bdRzccePkDjaC9TyIyE6luznAOfuCa9SdvRpQCSZ7w4eQ/sOLUX9NSPs6+Hk/0XPv3jKadeoU0+pOKwMGf2GXVi0YsL/FouKx1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XeNMGh6k; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so1941486f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725273424; x=1725878224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/kzmA5I23xNWWAz1AzWxwFHc2DJG5+/Mnn/xB7FK5c=;
        b=XeNMGh6kKOKCiPplTwWMmXd0+k87CTnwEirR5NKx5f1ZvQn6uSIHWIhfVRkakQoLCC
         qTUPdymix1cbfm6ykPxFYAA5YBINw4WwgpIjrgFbzrERaxq5X4+h+kJNNyf06AiJsDQz
         PlDQTe87127K8Cmt1td5qGDwBCc9dsJGlR7EVk7kDqcuRfOMHGT4tOUFEfLE2NkmU/vw
         as++E7J5qKQ81sJZ6dA1OX9ZtancMmGVnHLQB4UU5FbDIijyd6aMwuMPCUssWDrSu/rL
         zfpPaMNGOZGSBKFeARcQDfYB+vyFcbqXjRvY36do3+qFJJBjmkFU5aKLg/GYtoG2JMfD
         0BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273424; x=1725878224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/kzmA5I23xNWWAz1AzWxwFHc2DJG5+/Mnn/xB7FK5c=;
        b=qa70mp5KAct2kuF5y49mJF2eY3tUsPVAdTRlpVxzSA0Q65yd1UhatT5guvcjmSuNwr
         uYX9G3k1IjKHDHF7Z3XZ3Rdqse5u75/Wa31Ul2GqICXr+y9IMvVYtHHP61C3r9602p42
         1U7KpGDZe5gTcvYvFpXeEvJUXKVVkosAPt1lrJ/iPkaUwHF8wNCXYdSZU7XqU12qhv94
         goy9ircLLo6G0QJP7ELOfmQug2ISNgMM48a+XHDARV272JxNAMwZku9LaphJXy8QRPFP
         l47WLKHGz51QIo08M+VEdK5wBcYJXEV1DcHVnkDODWK6tNc44hpoM460tS6zWA6yBVQY
         iAcQ==
X-Gm-Message-State: AOJu0Yyq3p3/Nq5YU+BizzCMtjq0Lk/zkvQyGSqRxlYYLNYwXQ4ge1yz
	09wnqBvfVksfpmBIEc5x4eMaDpUopU4wHaSijkGTNRc/ke5I3ayp9oauAYHSlnwBiTYk8l9uJe2
	nRrQ=
X-Google-Smtp-Source: AGHT+IEBx7IVtTTuLOdUKgwPX+nVjMSPPmQhbounNSfyRo5Pfedonxjb2TvP24fJ6LlPPgr/vZcWww==
X-Received: by 2002:a5d:6485:0:b0:374:d254:61b3 with SMTP id ffacd0b85a97d-374d2546231mr130281f8f.14.1725273423868;
        Mon, 02 Sep 2024 03:37:03 -0700 (PDT)
Received: from neptune.local ([2a02:2f0e:3004:6100:e124:ce40:67a4:fcf0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm540876766b.182.2024.09.02.03.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:37:03 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 6/8] dt-bindings: iio: adc: document diff-channels corner case for some ADCs
Date: Mon,  2 Sep 2024 13:36:29 +0300
Message-ID: <20240902103638.686039-7-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902103638.686039-1-aardelean@baylibre.com>
References: <20240902103638.686039-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ADCs have channels with negative and positive inputs, which can be
used to measure differential voltage levels. These inputs/pins are
dedicated (to the given channel) and cannot be muxed as with other ADCs.

For those types of setups, the 'diff-channels' property can be specified to
be used with the channel number (or reg property) for both negative and
positive inputs/pins.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 8e7835cf36fd..9b7a8e149639 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -37,6 +37,10 @@ properties:
       to both the positive and negative inputs of a differential ADC.
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
+      There are also some ADCs, where the differential channel has dedicated
+      positive and negative inputs which can be used to measure differential
+      voltage levels. For those setups, this property can be configured with
+      the the 'reg' property (i.e. diff-channels = <reg reg>).
 
   single-channel:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.46.0


