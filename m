Return-Path: <linux-iio+bounces-26192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBBC54C53
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 00:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43723B06B2
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6F2F0681;
	Wed, 12 Nov 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiFN5J2o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6742EFD91
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988253; cv=none; b=r7UPQe241p5qlC81EZ+4WDlDbrkrY9eh6KSA0427xLnZWuG4bTglL9B2yEeP/Kyc8JOKVHr+ZUP3Um3O7CsqXpb2TNoDm4rjHe9Q25cwPHW/a47Alx8Fovhs63PF5rkes29ql37/UVWuGncopdhrplFxMB2H2nxNxURj7PjSwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988253; c=relaxed/simple;
	bh=gC1f61DmLG1P9pAkwLU/JjaVxGu82BLBwYykpQQ5tcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLd9Z1QNUHrNs//h4t/2d0RCT5tIVrqpopcDr4yCqB6K9goYN5uuIqv5PBtjevmbnZiz7sI8SjMOv2XsgtoTfbxO22GzZ3R8yju2yZs8LMnejlAUc2bVXkYQUpPv2oAVWWk7ftGb+/j9qjOaF4A4HQy8X3Sa4/o8x1AQEnBu6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiFN5J2o; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b2dc17965so166662f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 14:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988250; x=1763593050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDdGU9f1AjnbUUZofpssnIOwmqCSincQK/z8WMfUJ40=;
        b=LiFN5J2oICD8D4UpNq73/60lM1jSqqtCN12XSVyGH/O2b89rwteB8yEdBsFR6UIju8
         NJm2HJ4uMfn9SFdyGwq+Rm4i/G8dGJNyvDv9Zzr8hIeBpsYT6vZG4clhGssAdkM+m2yY
         lKikoOLaGfbQovsexzhgs7OxIy5d0UZsm5WStgE8Odi8E+aIreC3sTGcaDAhytS1es+r
         Ph9s/elcaQ3BYbGdvW+To5+UHeySz1pzDHjxnvqCxDSaYcscvAmZ4dgtPOZcQrfvKQdq
         4mqRC0zRuvLZhk47f8WKOb1cytakM25DKg+UhAcgsQuLW670bHSq2GnCAgyJ0LhK5E39
         qUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988250; x=1763593050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDdGU9f1AjnbUUZofpssnIOwmqCSincQK/z8WMfUJ40=;
        b=RVmbQeP9WRslQpt6aW2VN4zaC/SHZ23rfbqEZclg8PCnUWO5R3U+gEIkIR7b9/Jg6F
         4oZMCzOzj43P769vnYlSnUwR0Jyc/IUyKAhk0+q2OEIm7whRDRFEoAvR0LpDJQ0vhmqE
         P4hGVPKVtUiqmVTTC5SGyNoXiVgDIQ65ZNDZqNP58SWpLiI3XwtYTXb3vRlQCJ9q3uXo
         LQOMjWTxzSsAg1SnCcGLBrq0hJIBtb2UEA5MV2gr1bjU0Mx4l/4QDTQ1qCFKfdm1WcGd
         KxlmfSpnnlF1vnbNeEBCXxBXfHktVqf9IUQJEtOjV5fC4d5jucnbYezqWDQihTWVefVB
         X+qw==
X-Gm-Message-State: AOJu0Yz8WsgaUJ5QP31yp33AqxDFYmndioGESFijU9cYdegdc1YTAOt+
	CXDy4NPbdRov+uAKOtkHroblsrfkjjGnuyOYJa9pGGdgRfv3c0C7AFLt
X-Gm-Gg: ASbGncu7DOhTEx8rK53HTUIyWx/ACSE29dzq4zp0fPfRl6qouM1O60DZv61rMoM/XIn
	zQ/WKX7Fn/0MO++wrwezIU1IshK5Tm6c74E1UJ6sQ140Zo/FpZqh0an8yswOuoz6rFsqWOv5HNb
	7kZ7UxlGSPEbgBO7zjLir34G5nY43+NAeHKxRdnL/5sfUbebBS2EK0WmKBLOZNMV7xh2DzvUrTQ
	hwErssH01bkPejelb6y7nJSiB4kg4BxNNkyzgkz6FI6iZGTthgLvyy0yMT2HSDAQTASruUyzpPv
	r7ZJTE4yTYVvi5m65E7hzhBBrToIqG70Q/mvUgl4bJXVdCj5zkGf0zeykJk1veQTbPfKMYbN+fT
	oPoTecLwfZRtV9I3QsWiSFzYVzhIOpC7qVhP6uLVjh5k+s3hMYr6gvpIMg2tmmxS3jCFV3gCc
X-Google-Smtp-Source: AGHT+IHd2ghe5/cUirh89dZkN5PNcB58L5BDtdQaut5HE/Jd3Vznjz6w0+Wyr/d7Bgq1xX0pEP1YUw==
X-Received: by 2002:a05:6000:4008:b0:429:d6dc:ae1a with SMTP id ffacd0b85a97d-42b4bd9bca6mr5035268f8f.30.1762988249643;
        Wed, 12 Nov 2025 14:57:29 -0800 (PST)
Received: from localhost.localdomain ([78.209.131.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm236979f8f.17.2025.11.12.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:57:29 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 3/3] iio: ABI: document pressure event attributes
Date: Wed, 12 Nov 2025 23:57:01 +0100
Message-Id: <20251112225701.32158-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112225701.32158-1-apokusinski01@gmail.com>
References: <20251112225701.32158-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs pressure event attributes exposed by the mpl3115 driver. These
allow controlling the threshold value and the enable state.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 352ab7b8476c..5f87dcee78f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_value
 What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
+What:		/sys/.../events/in_pressure_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.25.1


