Return-Path: <linux-iio+bounces-626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A60DA804C78
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 09:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F5CB209F8
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61013C494;
	Tue,  5 Dec 2023 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivz1REuS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415AF10F
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 00:34:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a19ce1404e1so532358766b.3
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2023 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765239; x=1702370039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnFff+QuL7vmldPN3v6OY/6lZPDvUr+IdtMzq+xf1Fo=;
        b=ivz1REuSfAUGm8N7cf+OW9zgOZdImInMTmSMnst/eJn43JipBOEnGitEqtu2LEpPXu
         sM5c8WiOzSI9dP+wX6szj4COYw1mnmBaPvtAvjujVpwOu1XAkNYTCnAyokgkjSYpBaXU
         Dp0lKC4zaCs+umi44MK+wOJTpoau8cvo9OH/JBQvr4uPCxLbH6+auj0p9ICvwTxId+CX
         NS+RuwJty+K5BNs4TXOFN8HiD0Eu7X8VlT83qb8uaG7unTyi3H5SQwUEI8QdwyuWpqfo
         RkHZxKGYlII4WrjXJhUg8w6KfDSLP7/F+ctrIU+xyoZlERad/Jlaa2jD1uTsu4lVwO7F
         U3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765239; x=1702370039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnFff+QuL7vmldPN3v6OY/6lZPDvUr+IdtMzq+xf1Fo=;
        b=mA43AdR/XgZ3V6766hYz6k8tusENZl4TVEv1rWyspIE+rx+zxcu2Z28fEss/0ZA5Yl
         ZyyngN0aqCGnRvj+VdcJv4TdoKRH0hNAx26ok1gDCqc8dr2z6u3E0kVbe5Y7d5xYtqZu
         A+QHifqLRNAsjY/SnxJGIAA5USVt/AgwBv6i6A3cT+EG/C748NpzkHxFq3QVI10Zbkwc
         TksQX9xyz4sEgopWJL1JZuU3Slo2OckHQvwnu13VUa3FT2XVFiCFXoHJtfSLlWEtnarf
         znoxe5pleeu4KARPHRajGbumxzw3kqHFIp7QDoyhAk85xtxNfW/1Sy3CQPYsjLk1+dG4
         mvEA==
X-Gm-Message-State: AOJu0Yxgmho9xIPR4lwk7Zi9v8MryaXNOPCnACkvS5ARzNeetGn0gcg4
	NdamB32Wz8o7iKiEzEq/OxqMSeMVWdU=
X-Google-Smtp-Source: AGHT+IGcIVthbUqtedDzENUzXSa/ZeAls3TYuu2akuxPzuzkU4l2D/auvknc75ar5L3Rp/Q9ReJTvw==
X-Received: by 2002:a17:906:2707:b0:a04:c9c4:8fc with SMTP id z7-20020a170906270700b00a04c9c408fcmr4179752ejc.18.1701765238519;
        Tue, 05 Dec 2023 00:33:58 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7143-f865-4a98-8091.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7143:f865:4a98:8091])
        by smtp.gmail.com with ESMTPSA id oz23-20020a170906cd1700b00a0ad10b3f68sm6253853ejb.205.2023.12.05.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:33:58 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 05 Dec 2023 09:33:53 +0100
Subject: [PATCH v2 2/4] iio: ABI: document temperature and humidity
 peak/trough raw attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-hdc302x-v2-2-72f765c0f1e0@gmail.com>
References: <20231130-hdc302x-v2-0-72f765c0f1e0@gmail.com>
In-Reply-To: <20231130-hdc302x-v2-0-72f765c0f1e0@gmail.com>
To: Li peiyu <579lpy@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701765234; l=1940;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=tW4pA44Fa/DKbGpQBPZUvHiQ2iwupyhhwbF+ZIU2pOs=;
 b=qNRQ28dopec3KkKdPRAR+vAys8E4GfWqdn/JXKPJNgPr0ppt3gnSZmBOvVuC558v+N/kT7Oc1
 g48WNd1RAALCp3l3mZmUnhS4p1bQTAbKwIbLcKDqTpzrzC6cLkQUJnN
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

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
index 19cde14f3869..dc1c7df6a19c 100644
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
2.39.2


