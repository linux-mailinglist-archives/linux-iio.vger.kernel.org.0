Return-Path: <linux-iio+bounces-16956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8AA64D5F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0733AC4DD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB8237A4F;
	Mon, 17 Mar 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0jdTWPpN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA12356C0
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212389; cv=none; b=J2vWijpRItNGV7CXnE68A3pvrPH4E+NFvI0VugD4mHzy7CuPWJgdKpRB/liSi4d43f1F9J0AwpYoFnzukoTQtHSRLSwNYscpEYH525O8obSLDFMP8QuULVP8AsS9Oyj7O7GXiifGZR8GmEkdeYhTW9q5EznDI32IRyeSch46dH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212389; c=relaxed/simple;
	bh=MqkTOrjgvmzhBHZcGpIj76Hm7oR/ABZC/znv6lJg3Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jm2r4KlrghaHKljqK8+ykcyJ3F/krrJZ6yLOVnh+0BffEC4Zu9ru6+o2gtl9p71eEvoYYnxutGgCzfFyfQWgFcSix/VpVkjSdO7gQ0qMEVXrH4xhJpybyhubDfiD2cOAMJYUyHdsznZiCkOHGDTyuLNTFPbloXKTfRox/pe9rTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0jdTWPpN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso831284666b.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742212385; x=1742817185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xL4rlPtR6FRysHDX2cqXk7PHv3PnlCL6DB+jPNwBESA=;
        b=0jdTWPpNTgol0BGadmOiir8YOdPyy0LNGkT9/q8iIdNXyB/1lS4lGGvIL+OajFZbBk
         Roc7hB7/Jm77ARN0WRFAGF5evzHoXG+m6e0h0iHwCJ1rVWQ4a0tjHfJ/w9H3VF+TDqN4
         s8DDGA5mn8ZAl2FpXnElk0ZGEr81KqXreVAnN0v0RqX5X6FB0dm5lAGbjkpFWooXirie
         a1z+c3pQ+DiOA7IpmeOIQpNsKkufGWaHbRbHK7KEwqAUI9TKXtEu+rwgfUG0jOkzNxU4
         cPc0T0CPaXRTbXWTNoKnJefWY1IJGLUsqWt6ePSNoBhK6/TDM/rEp74lFg0JE241413Z
         zLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742212385; x=1742817185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xL4rlPtR6FRysHDX2cqXk7PHv3PnlCL6DB+jPNwBESA=;
        b=A045+HvRkCFreldSLgr03cKxKjy4SpGuoTzR/va9AlQA7N0MKGHIP0ufD5Kwv6Xeh4
         pSPLIDIbkLTR+V4kz8+KBNfdlERHdugxQBH6APpcpBrgAXtAc10zoD2cIwd4KrJ5eX1f
         9QJRZpMRfeqtSkgVq0mmuvgXUpajbpb1W63WuLFqpROYfU7EEDOxLzn95WpNijCXblQP
         P+W5qznuP/cooBRU8Sg5i9PnE5iuNbJz2fBwgZmR5/ad3KJo82pbSWzvoqFDl7oW0x6q
         QIV9ZHwfNySJyYfu9Jdq3mifBM+WZfVXo9LivN36qVU09ba18Y55cco5sj4NqFuh11I7
         IPUA==
X-Forwarded-Encrypted: i=1; AJvYcCVdM6Bdrb+1K857N4TqZzCQ2werraPNg6TcF+ZeDYvEh1FsmtG/peJpd/SGgjJfifzeFmrA1AcjfeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTTMsVsliloTueY2S/pQEFhqEleOkLzNluRfsaOefnO9m6XpA
	Hc+X3qF3DUk5jJ6R88iPVKgLKK6PeNqRCf51izgrRobv5fI7tQ3UvrP3jSHSXI4=
X-Gm-Gg: ASbGncu4nHgeIutv/Xj1bchx1CtNToqqsRpDIrOgk3qsHcGQFpbF6oRmpTVet8C0Z+9
	jOn9d+pyNNxJqqgwBDLAVmtno47YitMY+A9xNvXyfw9gDZPMwmVwwrEdH/GEAoUmy3o0FXubwyd
	32Brxm3Cm/elCM2YamLPPTvSs8FazmmtXy+GzFypwIOuGZ00BPikzHtQEe+X9YnxuiSNRQFVX3z
	caqgD7w5r+YI0AljSbNHrsFhcKKFpyJas8XoMH2wEy/ejdOKn4G3bfGyYFY0RtNFdVb0P8rV6TY
	o50jTzMiUGrYzceqn396sRtxiryEJBJn7oCBUiwXmIq3kv0UajTVgQanT4q+4r8/Tpr8MJrspkT
	+0FcK9UYAtms=
X-Google-Smtp-Source: AGHT+IGpLjeE7lrVIOrTkE055czVuaDO482r0X6DI3l8phu0IjWNECf2Ngxdx6RincNilOSrt5d6BQ==
X-Received: by 2002:a17:907:7211:b0:ab7:d87f:665b with SMTP id a640c23a62f3a-ac3303da575mr1114713466b.48.1742212384558;
        Mon, 17 Mar 2025 04:53:04 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa5a7csm659013266b.179.2025.03.17.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:53:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/3] iio: adc: ad7124: Fix 3dB filter frequency reading
Date: Mon, 17 Mar 2025 12:52:46 +0100
Message-ID: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=MqkTOrjgvmzhBHZcGpIj76Hm7oR/ABZC/znv6lJg3Vw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn2A0P7B3bxOV3T5ipUWPuJ+XuCmvndkaHdVup8 EsmAJqB42KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ9gNDwAKCRCPgPtYfRL+ ThzXB/0cyC5RYWJPQXV7pVDyXDwkQJTYS5/azF2U5JAXA4CvLeSUGid3qSgaqqdOp9SuTa1LYcG I5c9wlG2NB+rs87L55Smfi4cK6qkkSGFTkkuMM80U8YVd5xnf9OfZiHat01BHuw4j5PR2DQcBL2 CHSMIKc2EwEGyu1yHIWN97pRfXZ0HbfgvYruXKwhKHBpOuFQdQC0sBJlKM3RZST78vM93sES1rK sXSCitZH8YCd5jIsLLYntcr+cHNfG6ar4PWjWdVaSSWA165L8hmRLFhpWLwsU6vvtgAgWVyRFK0 BVHLp5wGKq8bUbyovUggnmzHyBn5PXrnOiA9H9R0N0YQ9VXl
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

(implicit) v1 of this patch set is available at
https://lore.kernel.org/linux-iio/cover.1741801853.git.u.kleine-koenig@baylibre.com
.

Changes since then:

 - Reorder patches to have the cleanup ("Make register naming
   consistent") last
 - Drop write support for the filter_low_pass_3db_frequency property
   which is completely broken.
 - trivially rebase to todays iio/togreg

I wonder if there is a way to remove the writable permission of the
filter_low_pass_3db_frequency sysfs file instead of erroring out when a
value is written. Hints welcome.

Best regards
Uwe

Uwe Kleine-König (3):
  iio: adc: ad7124: Fix 3dB filter frequency reading
  iio: adc: ad7124: Remove ability to write
    filter_low_pass_3db_frequency
  iio: adc: ad7124: Make register naming consistent

 drivers/iio/adc/ad7124.c | 208 ++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 124 deletions(-)


base-commit: 8dbeb413806f9f810d97d25284f585b201aa3bdc
-- 
2.47.1


