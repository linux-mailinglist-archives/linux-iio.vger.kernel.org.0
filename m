Return-Path: <linux-iio+bounces-5234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D68CD961
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 19:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC45E283053
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC427F496;
	Thu, 23 May 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvyK99/R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132C2628D;
	Thu, 23 May 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486466; cv=none; b=AuN8HfArtu3jCTRumqJiGnc9FQiqCiQzASBVkebO2gVavm8WLbwLAOKkkdz0/kNFIJ3cWjB3wavue2fqkCVa+ygFqJ7yVBHiDIF0yMYumseHw3XVJyncVp4n+S63xgEvQWnbbof1MHt2Fvv6wKEWiFw47BEkTJ5ro9/Dsl47fBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486466; c=relaxed/simple;
	bh=lcqZ+FjBGjrX/PtKF2ya9YXI4vuEMgFcKrf9NL6W4Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svFYhd2Ivl0OBM4+f3u0DZFWE4PsF/1LiiKKXwd9lvZMt+9NwOcb611ctjd12TegBvRCkoc7l5cYhZizP1hRnKArEGKBOxUEeioYNLOvPR7sHytnNQ+70z4D1bHNjwvfb3uAxRHnC4gf2ei399+SnZD1XfXi+Z6JcCd2lQsiwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvyK99/R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42100fa9dd6so6962805e9.1;
        Thu, 23 May 2024 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486463; x=1717091263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSTalkfvmF/fb9MA7fV24rRvPvb/ocKvXSqCugTjWH0=;
        b=PvyK99/Raay4OdTSRX7fBzPk2uabzYLHz2h4QCE9UwwZrAHY6C8TLKBn61TZRaZ51Z
         nkNSK9W/Mdx78rlnXOAXIs7I3VI2Wdhf2ZLPR+MHw7du+z/LqKoxY1EuhS7ms8nbrDLX
         uKYSrHETNpbV7N3Y+YdRVjE3D5Q1kLcpgp8pzwT0/93PWuWdImZhEFNv8rtfLkaExeGO
         rmz88cEDMPo/Sl1Rsb8i263k07bYu75T87yiOjTXVCCcHX12RkYVj/zMN16hhBi0vYzz
         b6cGMYF0v8RgXlnvMfEIHyb/YCAw2F3KbC0/ANodMc0b5x+R7jsRkarwV5uaXmeotvmd
         dvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486463; x=1717091263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSTalkfvmF/fb9MA7fV24rRvPvb/ocKvXSqCugTjWH0=;
        b=XXbnpxNjMG1FuIYXKxooAEc/CbHXyGvGpEE9DkqmUrs2Lge4LCebDVD1lCzP+A1zml
         ZtRp6Ya0+6g0OK++NXObQGlfAM7ZSRnAwvfc9IL9q5/VrhLidf3msQmUfq5NCuxlIugU
         yDLZqdSMLqycSP5os8PYdG8EqnyAhxeu/T+ZmdkPDwbVkZ0BmkPlV6b/mIe/hj/Y+xbD
         FHJQUkrEzthBy0YbViGN/UDc/UhVzkv25xXQ/bQOHU2rSFJkMqltN2JTHZzLmavPgjoW
         sUU3uVREZrf24rIPnp2ZvqMVK6cZQZNbLiPl4Gm9sXBEXlrrms95c9SOOVn3/vYgQMxm
         uiHA==
X-Forwarded-Encrypted: i=1; AJvYcCVmiITwyRRpn618vs4Jag0AZgsKgzxT9fsC+RK090P+xTryNigmFgJxPrJzqho+dlCt8VeQhLS6YyMj7wtOpNCdNgodvU/j61joFNcrrubgfP4WfE9ouAOgZz3qqQW+SP11Awkpio71
X-Gm-Message-State: AOJu0Yymeo9A0xbNyhooGi+GsTxtVH5wMee1TMXDtZLNfcFgrWzh7Nj/
	5yksiLt7lEdIk0VYKoM32Mo/QBOWyp5+il8gGd3oLl47PtBhVN1/
X-Google-Smtp-Source: AGHT+IGfYAuEmLwC87dNTA2GHDPJHpJ36eYGucWEfY7plM//1P7ePIaSA7tp/0K5PuP8/+6exQF/VQ==
X-Received: by 2002:a05:600c:5706:b0:41b:f43b:e263 with SMTP id 5b1f17b1804b1-42108172f5cmr1466125e9.0.1716486463246;
        Thu, 23 May 2024 10:47:43 -0700 (PDT)
Received: from localhost.localdomain ([176.206.88.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1410csm31103855e9.15.2024.05.23.10.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:47:42 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iio: imu: bmi323: Use iio read_acpi_mount_matrix() helper
Date: Thu, 23 May 2024 19:47:36 +0200
Message-ID: <20240523174736.16692-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523174736.16692-1-benato.denis96@gmail.com>
References: <20240523174736.16692-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmi150-accel and bmi323-imu are declared in an almost identical way in the ACPI and in some devices such as the Asus RC71L the "ROTM" property can be found: parse and use the ACPI-defined mount-matrix.

Co-developed-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 5d42ab9b176a..b391e5e701b1 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2083,9 +2083,11 @@ int bmi323_core_probe(struct device *dev)
 	if (ret)
 		return -EINVAL;
 
-	ret = iio_read_mount_matrix(dev, &data->orientation);
-	if (ret)
-		return ret;
+	if (!iio_read_acpi_mount_matrix(dev, &data->orientation, "ROTM")) {
+		ret = iio_read_mount_matrix(dev, &data->orientation);
+		if (ret)
+			return ret;
+	}
 
 	indio_dev->name = "bmi323-imu";
 	indio_dev->info = &bmi323_info;
-- 
2.44.0


