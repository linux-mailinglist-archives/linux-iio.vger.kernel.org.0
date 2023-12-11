Return-Path: <linux-iio+bounces-818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1882B80C9C1
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 13:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C231B1F216DF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4623B2B7;
	Mon, 11 Dec 2023 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHV8Mr92"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E8FD;
	Mon, 11 Dec 2023 04:28:52 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-5c6839373f8so3098763a12.0;
        Mon, 11 Dec 2023 04:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297732; x=1702902532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQjKnUKr/6rWL0h9abnt4zIo/7TuTvgvuGycMSFLA9c=;
        b=lHV8Mr920CHehgKKDuFoqhSs8wuuGXEh03YTEfThw3IcJ61NmSVpQP/+AADjVLmQHb
         +Tgl/dl8cY1TbI3nZEbEDPHTMDV60Z8Bm3a3SsoG91Xn8eBl9ceXXkXRi49W0l5fIBXp
         mLVpesaUGJKZhx3otRhKF8WwSXUtvJRHcrC7IugvN82EewY9rCSM/ozrgPkpUjqwBAL3
         ZerFlWphOaTP4iZIhNiRshV6Vb8Cfqn2f4KUAVfnFgnkdVrlqYfO5iUsmQEMjc5Qt396
         MKuBDRYAy4dJqpITP0S10Z24TiRaGvGtrbu3oM9ANSmU6INUSDlSOVFsH+DFCL5+QEqr
         4Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297732; x=1702902532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQjKnUKr/6rWL0h9abnt4zIo/7TuTvgvuGycMSFLA9c=;
        b=GfMadNP/Ftjtz7bDJNq3vGpjfA2GBfbwTh4057t1gKkyDIsd5Pg0w0g0p+nB1oviAI
         skEbpbTIQqIoAE6bVBIvno4MlRyoKxg/lCEEsvTCtND4YXUN7OSqQaPh795FG+stTXRV
         ubtMZCU32OawLbQI/zOZx/lab70QxGKekRNPlhFcODRYnaS5LQycox9LK3vIFcgIS4oq
         RrUFbzDEotPfNRHyPCZevtFXXbsz2bILaBTiU7YX/p3iY71TccaqsZiQ4E/z5CDRRU5T
         YaY8pZ4Y3uJR/lvSXCTnB85dCdZMK+wG5z8EhFilA+mOnxbBNeMaK/TKoHsxWFUgWTdg
         bOCQ==
X-Gm-Message-State: AOJu0Yy5twiKjovS9+t9K7mJPf2RMViXuCQ/9SoUIPrTFgIXcv4CeP0u
	kKC/KquvOfrz0icL+te6ePw=
X-Google-Smtp-Source: AGHT+IFhe90FmDS6Au0T5mkmrIGo2qtubFXkliBQpFLCSwT3YZYjpOC/8Vaxr4SP/WjWfWYZO9zw6g==
X-Received: by 2002:a17:902:e552:b0:1d0:c521:ad4a with SMTP id n18-20020a170902e55200b001d0c521ad4amr6389492plf.56.1702297732051;
        Mon, 11 Dec 2023 04:28:52 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.110.72])
        by smtp.gmail.com with ESMTPSA id i1-20020a6551c1000000b005c6e8fa9f24sm5372425pgq.49.2023.12.11.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:28:51 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org
Cc: javier.carrasco.cruz@gmail.com,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] iio: ABI: document temperature and humidity peak/trough raw attributes
Date: Mon, 11 Dec 2023 20:28:40 +0800
Message-Id: <20231211122840.9760-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211122201.9598-1-579lpy@gmail.com>
References: <20231211122201.9598-1-579lpy@gmail.com>
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


