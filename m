Return-Path: <linux-iio+bounces-24123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69650B58750
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 00:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87841B24CFA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86CD2836A3;
	Mon, 15 Sep 2025 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaMBmQyy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAF242D66
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974621; cv=none; b=R1sFKSU2CFGkE4dnVuqC2Nfa1zqbk+g98IimY6k14IVTx+L7unahIa7bEGQNYF5e43Aj6FRJfBRJuyiaqKBVV1+E8pgAL21tq+WdiZfTmRn1a2WKn0N8+zbffvkKYJbY+x9YqEZsNSQrwgurccbyr6qtfYyMj2hpz4/rSZG6EhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974621; c=relaxed/simple;
	bh=aEm/Hz7dGLKXm+uX1tg9XZs7MReffamnZd9d19QAqvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbWZSL1LI7yGPc4WwCR94nkjLzhN0kNqsRefGhqvcuWq12bXpBDIWsawwyBq62k2clMcEPoO2CVHncEHxBEe6JaIml8IAqxOOWZcukayColh5gu0aw8KnHmbRRMW2GLlifhW2rQnZkErbO73M97AQyfMkc/yrMd9/LH7MkT23Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaMBmQyy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b13313b1bso32485735ad.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757974619; x=1758579419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0EZSn+IjTlYfsb20ePSkLkAC/0KOeBJ5P5//u/FW/c=;
        b=XaMBmQyyjHDUUjtwm0Un5xtDkRV0QbwGlWYMMMUtIpz7vCaPCRigPiGUYtO2f9QNNr
         HxBml4nxgMVAjl/PbZuvoUlUxqxgS3QhRZX4B9gdIRAF8PfQo3tdCx5ygyKvF2OavWmj
         CSnba8rEbPB37ImHbDEPM2DZmW0KCzXq5phWM9f9wrG2bvbSjE7DlNcyCB6dsTBDDceE
         cq1c/URqqjUuQhvCbyPQcm4Xx9fSoo2HLmwU5wE3/m2Oid5qkmfsjVpV8VNcvIIogzRm
         gxBac6dY/XBYGoHYQTjpe6p0B9FNeim4Iw8LkpfNGIWeXIwWXteXadx+dxBt8l2aXYBd
         4K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974619; x=1758579419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0EZSn+IjTlYfsb20ePSkLkAC/0KOeBJ5P5//u/FW/c=;
        b=JGOx0ZH4pbYSFO8+E4rl1yBLb++FTs6x4qw7dMbFBk0v98JNjpnCf+6Rj5HjDmUiSA
         wdINf8BWXAh0krT6EmRZ5v5vcIA60NKzJOSGUJO1wDftaULHSQe58qnzhX3eHMREJTvx
         wjZChYIxLwypp3Il4eFU+oYJYF8pHVKRAnkih+6enxlHEO3lg1Z+N2F7nHTCZLdh/AZf
         8dJdWcmJ/ammb/if2hKGl52Y6RmeO8foJ5IqHtoW03XLvOcc3IeuEBFhAKtqYZFPzoLp
         /g9L30yJnxEpn8ohVm/9S09jwN4OAgDIbrjsj7JpmL32LQMlDViYcHGhXskcCh7Z+Y3d
         cnTw==
X-Gm-Message-State: AOJu0YzrnZEOMrV2s1RDPFvopr/FnLpN1HawIRDgcO5vDdOpYFdWCHuo
	JkutMSUUUr0iUzXjr+2JWxKsiWmiGC5hdKafWEJ5glAvmNut1HG6V8+N2I/cf95q810=
X-Gm-Gg: ASbGncvh9vkvL9yIN3DzYNS4mWEOFxI+WqXb9cazIQPgYxUYU4gggsjZQJzYzJnjeHM
	Kz2P+TjjqR9nI9Uh67SFlyCD/l0LW2SHQjoGoOK8bSeNwAOruk5QhPM/vzJUm3B/LzejTWrR+xl
	tAEtuoi7er+4a+J1x7MnTvkYLmwjmyGz6Wxhv2JP1ZNGc7V44luymjSgzOz3ueFrLzMLwXJekzL
	PB9sfl7DCWdgbQDZVmBXJw8N9Zotb2B+aiZyRl6bFlPEpoe/k2d6bVGcFTv8kmPRQZ9eOwjiBFc
	dFlj0QtZfOrsdzaz8CAgWQtLUIzllm1GvxA/c5MkOmK4bOuvedbaOD7aITbKzFDGqsKMqs1xFHE
	Cfeo/n2WRV9nfWtDkY97Ry16DNK0JXZqj0mgbugSV7tpU+A==
X-Google-Smtp-Source: AGHT+IED7gyrnto+fW51wF3a9rAub6MC34GOv17/JZeQR5eEHSxj8vA0sE8eVX1bxsMfOXdefGr+JA==
X-Received: by 2002:a17:902:d488:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-261e1c01f2emr107392155ad.40.1757974619205;
        Mon, 15 Sep 2025 15:16:59 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:d43e:6485:d878:c0c4:abbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26711e5d42csm35215385ad.78.2025.09.15.15.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:16:58 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v11 3/3] iio: ABI: Add voltage mean raw attribute
Date: Mon, 15 Sep 2025 19:16:49 -0300
Message-Id: <a346e8b2f406eb14fcc9e1f3c4999de74413d650.1757971454.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757971454.git.marilene.agarcia@gmail.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing in_voltageY_mean_raw attribute for the average of voltage
measurements.

Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
---

When I use _mean_raw (IIO_CHAN_INFO_AVERAGE_RAW), I get a file called 
in_voltageY_mean_raw, so I added it to the documentation. 
Thanks.

 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 89b4740dcfa1..6dd67bd4e73d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -422,6 +422,7 @@ Description:
 		Scaled humidity measurement in milli percent.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_Y_mean_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_mean_raw
 KernelVersion:	3.5
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.34.1


