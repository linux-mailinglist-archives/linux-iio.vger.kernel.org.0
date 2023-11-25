Return-Path: <linux-iio+bounces-332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231A7F8A68
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 12:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AE92810CF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A53EAE4;
	Sat, 25 Nov 2023 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhEyZBFS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065010EB;
	Sat, 25 Nov 2023 03:57:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a02cc476581so366731466b.2;
        Sat, 25 Nov 2023 03:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700913419; x=1701518219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyJvKifjCksa9ZtBNafx8NGbx/DvHUPSdg3ul1e3Sf4=;
        b=nhEyZBFS75LTwG5A1CA0WyQ9lpZN69d56raOV4FA9Tajf1+/tBcUEatJiipkJw8pKO
         +jMvFlBUjiAplXUZEkUEEh4ASBWjxHC4L/w0B52eGNQIRXb/ItbDLRV0R7Me42svmo/M
         6E8eY3yQfSg45NH+SVruZF9O5AZXgELsR1h7jboElijVtt6tDTtLsy7eALDqDeYGCal+
         CQlPIH8+stGbBKLXpgd4RkRfgbcW9XObOBpWCTQgPZiZkrph697vfbqljAEcCL+Lt+4A
         qcUj/LCIUz6+7OKmJQ7syigkDiYc/+VWEAxgg/keCVNuuUyHdebctELnjMEfQgJ/bP6J
         b7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700913419; x=1701518219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyJvKifjCksa9ZtBNafx8NGbx/DvHUPSdg3ul1e3Sf4=;
        b=K574I+c9eq8Ij6CPmQWIRoeKXM1LbS9KVIEU+kqM/It1p3CwC8QU38h8lf6twlOwF9
         wI9Y9avzaI313y6/ePO0Dg5wmGZ9t2PfE2Cv0kgAMV3UNfZv4+ur5tfmUja106KrAl6b
         eCdUKGZ0eBp1Ie0t8Wq7++c49wBgVuu1vyIT5QbK7AF+YKgy7IOUy4yXhF9uhtcCF0fM
         UFxG0oC1fEFBYfvlHcmWDbhgmc+b0fF4QVyJGEDMRZmGLhScDJng6YIv0yA4yLKvDbcb
         Yy4nTyTuu/Cg3Z31MeKbwo4q9HdMbuDqOc0N4EGArMMFEvvy7l6Dnyre01ES5UkZHH/+
         ZCrw==
X-Gm-Message-State: AOJu0Ywey7Fsr5L/6Zl8LL3gEisyd68vTl6PRRaxbErokoFMj6oBp/A1
	/nOqh/szptWDspOZz6UevaLIIeOHcenFhA==
X-Google-Smtp-Source: AGHT+IG6Dos7XvaZp1QxtaDVXbxvbrQUpf8xoJ/l9hNlCRHIbkDVY5CPpxOcmmPnX+niof183sAakg==
X-Received: by 2002:a17:906:6711:b0:a01:77ef:e887 with SMTP id a17-20020a170906671100b00a0177efe887mr4026945ejp.64.1700913419355;
        Sat, 25 Nov 2023 03:56:59 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3176-084d-819d-12bf.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3176:84d:819d:12bf])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906a21100b009ae57888718sm3344349ejy.207.2023.11.25.03.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 03:56:59 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 25 Nov 2023 12:56:55 +0100
Subject: [PATCH v2 1/3] iio: add modifiers for A and B ultraviolet light
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231110-veml6075-v2-1-d04efbc8bf51@gmail.com>
References: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
In-Reply-To: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700913416; l=3539;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=nymkBqy1zy5W1DkFZRCIlPpGK++jMxfNLk6XrJLr6Js=;
 b=qTOSDOAdV6ujrNBtJLLo1oxm+L27V6lBQRWNroF8w4wBc/fqjphx/ReyrlCEsOmzQVvnI5c84
 7KJI/7mSyODApjQZpWYoM8uVjF85UkNqfvWXu3+D9nUQVz9BbxYWn5A
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Currently there are only two modifiers for ultraviolet light: a generic
one for any ultraviolet light (IIO_MOD_LIGHT_UV) and one for deep
ultraviolet (IIO_MOD_LIGHT_DUV), which is also referred as ultraviolet
C (UV-C) band and covers short-wave ultraviolet.

There are still no modifiers for the long-wave and medium-wave
ultraviolet bands. These two bands are the main components used to
obtain the UV index on the Earth's surface.

Add modifiers for the ultraviolet A (UV-A) and ultraviolet B (UV-B)
bands.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
 drivers/iio/industrialio-core.c         | 2 ++
 include/uapi/linux/iio/types.h          | 2 ++
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 19cde14f3869..e2a9937be99c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1574,6 +1574,8 @@ What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
 What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
+What:		/sys/.../iio:deviceX/in_intensityY_uva_raw
+What:		/sys/.../iio:deviceX/in_intensityY_uvb_raw
 What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
 KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
@@ -1582,8 +1584,9 @@ Description:
 		that measurements contain visible and infrared light
 		components or just infrared light, respectively. Modifier
 		uv indicates that measurements contain ultraviolet light
-		components. Modifier duv indicates that measurements
-		contain deep ultraviolet light components.
+		components. Modifiers uva, uvb and duv indicate that
+		measurements contain A, B or deep (C) ultraviolet light
+		components respectively.
 
 What:		/sys/.../iio:deviceX/in_uvindex_input
 KernelVersion:	4.6
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..65f567e4ff2a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -117,6 +117,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_UVA] = "uva",
+	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 9c2ffdcd6623..5060963707b1 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -91,6 +91,8 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
+	IIO_MOD_LIGHT_UVA,
+	IIO_MOD_LIGHT_UVB,
 	IIO_MOD_LIGHT_DUV,
 	IIO_MOD_PM1,
 	IIO_MOD_PM2P5,
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 2eaaa7123b04..8073c9e4fe46 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -105,6 +105,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_UVA] = "uva",
+	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",

-- 
2.39.2


