Return-Path: <linux-iio+bounces-775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B1F80B3CF
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 11:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81FE1F2119A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35213AD3;
	Sat,  9 Dec 2023 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na8x32m/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356E1D1;
	Sat,  9 Dec 2023 02:56:24 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-2886579d59fso2907233a91.1;
        Sat, 09 Dec 2023 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702119383; x=1702724183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQjKnUKr/6rWL0h9abnt4zIo/7TuTvgvuGycMSFLA9c=;
        b=Na8x32m/LYhuoiHbrSYm65KQ2ZLixMwxDy70MMtBbrRlthXCt/I3+xjhZ9qxFLyB6J
         Ts86wtHMl00TQYGHJSQHyzgiQZl/7mjDXKwdvSrcGEcxfH5Z1MgSAe8rgt3pCnCGNjud
         zdLyGLz6Upb5Fk1jKqG/oqoGKWaa4khOOGCXQBxl6ju7hDTggvmfQEdrJXw41z298P0M
         UqnTX7W+xgudDQF8rMPTNAylUbMV5qdq5ovF3FuFEoQo8kqPYL8gptllISoPSArr4BSj
         a2Kv8z8gZOnoJrkyv1cJqeM8oIjXpV7CZjCISQJgM9Rm882v3gYLVZ8r44FcS6SAfEUU
         3Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119383; x=1702724183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQjKnUKr/6rWL0h9abnt4zIo/7TuTvgvuGycMSFLA9c=;
        b=kXgJYPcdhVTciyttW5BXJ5kM/Wi/siR80hdjoyYawgco2LXqXkIPqJG6msiTH2L652
         65YzA5qjq6swWQ1vmxUXds/J81/RnHcY/G8dz8L93twgnWDuunS0b7mNGvEtvSPj5HgO
         cxE5j9H+yvAJIBxf1YsWlVibDND74CGk+WV903onbp1jrrQXKAsje0Tj8oj/DuwSo1SX
         l2Cml7SClmSM53WBVMCLL3QV5aK19uOERQRvFgDvKhyvQQvqHV4qEbMF/SSARmkorgGk
         GQTk7A7/CLZsJKvcPaSV6K2d4Wo8vCuMXpcAJa3wMghf6WwcBSVVkP1/2nLhtA59YDSS
         1HZw==
X-Gm-Message-State: AOJu0Yyos9+ClDhRILzaSxB/QbkF+wS8AduYOVgjsqo9W/on2RcVEVhg
	Wl7reengiwRnzcXMW7Iq+aY=
X-Google-Smtp-Source: AGHT+IHTLsZFrCzNWQC/KcLVloMG2wD6jN4hlslCQM9FlqbedZjOXCkRLcJMwrwjOzWsN9IMs4ZKjw==
X-Received: by 2002:a05:6a21:8195:b0:190:2941:7e1f with SMTP id pd21-20020a056a21819500b0019029417e1fmr1471542pzb.9.1702119383331;
        Sat, 09 Dec 2023 02:56:23 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.111.112])
        by smtp.gmail.com with ESMTPSA id gu25-20020a056a004e5900b006cbb58301basm3125586pfb.19.2023.12.09.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:56:22 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org
Cc: javier.carrasco.cruz@gmail.com,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/4] iio: ABI: document temperature and humidity peak/trough raw attributes
Date: Sat,  9 Dec 2023 18:56:11 +0800
Message-Id: <20231209105611.3740-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209105217.3630-1-579lpy@gmail.com>
References: <20231209105217.3630-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

The in_temp_peak_raw attribute is already in use, but its documentation
is still missing. The in_humidityrelative_raw must be documented for a
new iio user that supports this attribute. Add temp and humidityrelative
use cases.
When at it, remove an extra blank space in the description.

For users that support minimum values, a new in_<type>_trough_raw
attribute is required. Add this attribute and document the first uses of
it for temp and humidityrelative types.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0d3ec5fc45f2..9d937e29724b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -362,10 +362,21 @@ Description:
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_peak_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_peak_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_peak_raw
 KernelVersion:	2.6.36
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Highest value since some reset condition.  These
+		Highest value since some reset condition. These
+		attributes allow access to this and are otherwise
+		the direct equivalent of the <type>Y[_name]_raw attributes.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_trough_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_trough_raw
+KernelVersion:	6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lowest value since some reset condition. These
 		attributes allow access to this and are otherwise
 		the direct equivalent of the <type>Y[_name]_raw attributes.
 
-- 
2.34.1


