Return-Path: <linux-iio+bounces-24548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E4BA80BA
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 08:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94571888EF0
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 06:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFF22FE11;
	Mon, 29 Sep 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP3gChj8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC615E90
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125620; cv=none; b=mBqGfJ3BppeqeH2iSRm6WpXJj6j51wICTlheRMyy+u68XEgKxzQ1svQ8pRmv/+wWLkxHCEcH9ZF9Ybap+ZODB/BJuIP2MiiYZTVnMq9pq9TvtCkhmAg0p/VoZnx8DnetCiJgmHlgaMAk7+h/YXceiUs3ZbRI9rCEQYlCJZC6NsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125620; c=relaxed/simple;
	bh=XQwKFbTeuUhDrTKFLV/hAiNLerWw5Efb84CYWTCqx+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTppMaOR2yzPQ/y9Bvur/qG8cqE7QNHByAxvXwKSlgWdidreLmiHxCNQV1CYXHXtwiway8XMvCmj9/lPN+xV/WXeU85xI9lzgVs3Mrf6zzAKdJYzhuG4yzY+JGY0W58MvrKsHQgjpTE/5cWLBsREpxXqAgFn7JQ8hsPQKIhRPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP3gChj8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7833765433cso1584457b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759125618; x=1759730418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZsigXYqrzEsDLxeQmHmcVAyYOp3vFGkr0atM1S0OAw=;
        b=NP3gChj8HmDocdlkLLZtLyTK4rt33ae0EqDPdVfEYeFCvhyDTn6IUczVPsauPYlfNU
         m1DzzkwMjFurUfZjJQinlwAxcBk8pX+SUVrCc0g6/utuLRS1/z3UEwoSymuJKwl3bm3l
         3AgB+mDsiHsDc8EOcBqn1U/VF/eB/cWn1/7YiUbgV4NQo8e2WQdEbk9CLh79gD1qvpOv
         eO++WzaROp51ncwJrG6huKxNz2dkTuZs3NmQqtFdEkrBqh1VNVoDAz+8m9bdYHwyRq5l
         kZawydyIgCtyzbJLelhHTfMMP637pZGjWCqpQPg98xjMGlZ5NbFfoXvBu4ROIk6GaJeR
         lKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125618; x=1759730418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZsigXYqrzEsDLxeQmHmcVAyYOp3vFGkr0atM1S0OAw=;
        b=dociTilTWeEcCvbJSYDIggf+u3jK0OAZuoZH9PYOwm9IUxk6/w7/DARm+JbIUZmYJL
         1WKxVEAdbP6ilQ+WaOFzlGQG/go7ypCzvbIq2/8TjZrnDj//4aWc/aK/1aaxnC+v5dfo
         AT5GSPGwSGHNwxpbLQmuaVQKiltR/5vnpBTPmCHhjEA0SnfsfI+0HXRcI2c6X/j19vbR
         VRppO2nmQRK1Sj7R2mPFzfxyXXaH7dxELp8rQjJewJ0sJi0OqnCyhlFwQzwHBbLNgYre
         ZvC4TYWtXSx2BgyPZEdQ7gkJ6UAMr6nNUCpMTsFfmXrkfe2sBaphvm98mOKiLfGHAw/0
         SttQ==
X-Gm-Message-State: AOJu0YzGceBV1H0cYZKAUPgZuabE5rT8dcY+sR+08DUOzlpNBF74MuZx
	EZgIXFSA5TRoVq9kv+XoCkwrLLnagamVJ8I9jZ9CKO5AHGoOx08MeKu2kyvtHcpc
X-Gm-Gg: ASbGncuySUN6+sNhh73M24XyXfahGwDjxvQ2WgNrBdRhEnQoL6kFOgKkuF5XQTU2/Gm
	AJqPQZUqcySE/qfd9lWRjSewDXzPExEDE9XenOX93nhLq/fGJYaeEtGO57vVYCkIs8JCHb/PIRB
	s6EU0fT35vWYp9l4Y2uhXXk0szYceGmy7EOjHrK413HBI6LvTsnNVh8IAgjE+At3k6Z2VjGQxjn
	Spk4L8jzfbvBYn29a88afEJMcppaRA5YVoWWudj4qBzRum/pP4QS+h2q0HMLwQ3RW48jnaYj0lw
	nuE3W/Jlbm3B6d6T85IQqjypsYpxa9zzCqG2KInsRMlZzmqEKWlPyFOLFYt+SL92ohfX0LZeO3t
	zMv9+TpUGRfhTDgUAWmdgE/tZfBnykMftUdAzOFqUWXouYZQZ506kALh/
X-Google-Smtp-Source: AGHT+IFNoNSuQK5gnoHJXUdVGZL8uKAkkbJMlFQqragBcUI9NPSv3i2UCBzciAag2RD0Feufk0k2Ig==
X-Received: by 2002:a05:6a00:80c:b0:781:1a62:4a35 with SMTP id d2e1a72fcca58-7811a624de1mr9955828b3a.0.1759125618118;
        Sun, 28 Sep 2025 23:00:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:fda4:f56e:95d0:3775:a428])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b2915csm10196372b3a.55.2025.09.28.23.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:00:17 -0700 (PDT)
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
Subject: [PATCH v12-1 3/3] iio: ABI: Add voltage mean raw attribute
Date: Mon, 29 Sep 2025 02:59:59 -0300
Message-Id: <c9c3b7e67703313913a7fd411cb0cc152a288c82.1759123847.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6106ee185045ade8e1938f87f9588733d6358844.1759123847.git.marilene.agarcia@gmail.com>
References: <6106ee185045ade8e1938f87f9588733d6358844.1759123847.git.marilene.agarcia@gmail.com>
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
index 352ab7b8476c..3efaf91248ca 100644
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

