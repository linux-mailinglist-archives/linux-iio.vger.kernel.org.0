Return-Path: <linux-iio+bounces-12778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77ED9DB821
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33865163E27
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA851A9B4A;
	Thu, 28 Nov 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGNmvPWr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479ED1A2622;
	Thu, 28 Nov 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798713; cv=none; b=VxXn6wnoY/FEK57RmMJyc2G5Tvh6pH2CYNkNEhNSAHnlJaek74yHVAmdOCqV0P8L1nJKZatBuc8smMPn98Wybx9q84lSRCG6C4oY3Yxf/G8oSBui/+8gC6oAsZLRjJB6/LyHQQ+dQksfR88scX/co87fkPe4AYX/FLH6m3EKzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798713; c=relaxed/simple;
	bh=6WO/KoksPPfNy/Nque/H3GqjWusPWnebfA4rwnNUK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aluho/ReZXyhBY8gkxcetwkKP8mRPHgtxqMhHZMqmbkqoVxmllATuBq+1erEO15eOVrZTOSHe9hJ0HzqgYxFeR3IRlez1hgDgavnlMPnTV2F3dEE8LZ7AbTwjPVvDt0MHoUeK1wxygsTZc4SsUXpFo4KUiDpFckkh+sMd8WPiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGNmvPWr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-382423f4082so601307f8f.3;
        Thu, 28 Nov 2024 04:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732798711; x=1733403511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9VRPpihSbruXIfzlqTllph5cE02i7sBNzb47RuvXOE=;
        b=RGNmvPWrmr8+wratp+TWBvcweuD1GbeRDClATsoI4pj2cPZdBtpR/hvOH2H7r17M+8
         J3suoMnHJs6n8daY97by2wIGVKnqFUd60IDGKv2tFYmGBA9++Rzj7+3GdlUJ/smhdfhy
         4a9oC2sjbG7RAU47NHY3y+Lf2+tCzuTHdoAHi50Xveh7vRwRbQZR1qyPb5BdxrR5vKw1
         fBPBelHQUZep+X9P/jN+TpeTrB2S3/nYn1uuklhT0HN3ES2hRY8Wnhhh2edfVg8SaWTp
         jTqv+Hui8Q7wy0LbSs67hHu52m3zjeShbgpQhhUre7lvbPEvE8lJ97rBSzLsXk36MKUT
         Ys0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798711; x=1733403511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9VRPpihSbruXIfzlqTllph5cE02i7sBNzb47RuvXOE=;
        b=GaYkLiJGIVHALz4DCiPgNOKi45uQXohqbkjxh0DvLjoK4XskHWAv5dJM/0bmdgoIW7
         frF+m5LpDYEGeevqTxvts/LXJTIpNq9x0sjDG189BMRFQHSRCR+TFlM28tFTFOhFnJno
         0TSzC0TTO/UHKXq3jYhcJ+GzErXODLTHC4PRS5BzH2qTnsdF7Rf445SCmjK9RK0rWfbW
         38+529RCx9Ab+1/Jbnr1ur/7z9CE/WQgdK6HTvL0bNKWwo+YMaf11hKPM9008FZ7hYEW
         azBJ+cIlU3RRLzKXIIOm+zMHkm6JqpaH/mEkh5jEe4JNTpEST3YfYNoRyYtsMj2xYR1j
         I36A==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8aL/VT55Ter3V+EE3f/mvgPS5xbtCGE67habVPJEE8LhG9g9e/u/56ir2DdN9Ph7VYE2BtD2xRb+@vger.kernel.org, AJvYcCVcItk1He0UYGAh6ZGFWRfgJ7EjXg74opBIGw6NRgZViJfBSGZToCqWAaZZnnZSMufU3pnpx2TRcm42NQCO@vger.kernel.org, AJvYcCXIelC9ZuVw2lslmeFFwaE7skD/hfu9IaWFt/P8K0VHx+CLqM6y7j9AbPx6TpCkTIvEd59rCPlF0wCz@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxHyE3EOKtIIGihBL8tmh5fHdK0m1rtwmDAJQkHGEYhrzCV7x
	tPHdjq4pyowrJJWPNbamFSfiN/aw5reUvLl3gRT5wUxWfjUDbr/1k8nQ7PWw
X-Gm-Gg: ASbGncs3pOXC8Ac5mV2b2YbeJ0UwF+hPT5qmLaS+JfEfFvNyHszLi3ihBSG3pOoRVO0
	XmWxWeGs5H7wp6GBrCO8n9U1xX2qiuZgsQe9yEmHfx7UkP5fFlXBo5oQR020TvyWz+FXhaDkWcc
	yF8+02hsUdr5OgwkvPQifIdob/sTY++eqH+vLBKlMga52WgMyklbylhi5KWVJF/9x4QA1RtcqYZ
	Jtelq//4L4KVetcGLctDizeNp2F6rUVRCrH4/wsC7uGT6+EYCne
X-Google-Smtp-Source: AGHT+IF/oR+PTz4tovShzWZzj4voHRHDL1lCv3HXzMcxAMQPcv7/yJBk8E30bjkM2sX7ZCAK3t1n7A==
X-Received: by 2002:a05:6000:178a:b0:37d:4647:154e with SMTP id ffacd0b85a97d-385c6eb4accmr5814760f8f.9.1732798710404;
        Thu, 28 Nov 2024 04:58:30 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:3506:d600:5f69:ea1c:6c79:3753])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68d08sm1611853f8f.70.2024.11.28.04.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:58:30 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v1 1/3] dt-bindings: iio: adc: ad7192: Add maintainer
Date: Thu, 28 Nov 2024 14:55:01 +0200
Message-ID: <20241128125811.11913-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128125811.11913-1-alisa.roman@analog.com>
References: <20241128125811.11913-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as a maintainer for AD7192 devicetree bindings.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 66dd1c549bd3..f70caefdace7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -9,6 +9,7 @@ title: Analog Devices AD7192 ADC device driver
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
+  - Alisa-Dariana Roman <alisa.roman@analog.com>
 
 description: |
   Bindings for the Analog Devices AD7192 ADC device. Datasheet can be
-- 
2.43.0


