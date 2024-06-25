Return-Path: <linux-iio+bounces-6921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283629172E6
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48B9282BDE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B0F17CA16;
	Tue, 25 Jun 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD24tZhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086174AEF6
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349335; cv=none; b=gYYtMDktwUVgB5LYul2/2ovmArpXmVE3QnjuT5kmJ9JuWWD0/o/L5kLVcirZ4mbZ9s48nrFQcMcBmsnSQvcGzxue7ry2PFCVnds7flIm8ug2CbrJz+i+lXAtgz5SQpUZACUu93TpDtgoCPve4K/UrxdKBgkLWnHU4CAMAWUwBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349335; c=relaxed/simple;
	bh=bbVzfmW3YXOx54EvBkplsGrEnJ8w9d7Uleu0ZSpsPo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0ObJbkY5me1UUNw7CyOouS9eUpxL1zuCQg28C/JzKFY1lA00MCZMzdGguIjFe+B+c9RSv3FR5OLXIGYk3gJzN5n8sdrzmCt86Yo26vcFscuZjUj+D4jOBH5aqNgPsD+BcMNxZucWxKUf01MJIRoIRzwpxn5SUWYR5jvRytrVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD24tZhL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42108856c33so41728045e9.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719349332; x=1719954132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gKQTsBZWYOMEX0Li8yrBaTPo/8Ysw0gq2GqVQZDCbk=;
        b=mD24tZhLjaf0ssz9XGBAk/YBIEpJuGwf6G9q6/h9lcJbzXS3caQYeQeQpJt+aNzWEd
         YflKHZVzRs0GU8uA1dQVyha8jYM+Kc6cv9yg8jS/cZWG/ntLlqmr9tsZttD2x/efMlik
         n39eNvu8kYGulD7Nuv38LeYnFzN2X0q/+mhI1Lz1BsiBEcFeRyn3WthzwrBzgQNK0sAH
         lILFK1i9YyEF9wnUizhplKZAWr95lLxA8D0bqHwoiKaWsz9x91dcFkBCTIIBcJDkO6L1
         6TCnu2jwHGZo+IT0dZkH1HlBmbvpDW9r2Cz0/y0O14b9NNpU9+JHOfYtochdEqUBBd3N
         A2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349332; x=1719954132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gKQTsBZWYOMEX0Li8yrBaTPo/8Ysw0gq2GqVQZDCbk=;
        b=jQZH/twxx1V1HXnS2npEwa7256w0g8soXdEpdS3UA/B7klb/06qGxEX7g+lqdzI1+3
         cMzXuPhY2skGC1MQvSAV4yeldK2NdGip8gRxdi5J+25vN2fQebTW6ftIpkbTu0KGfNtI
         xXTU5rDAKIsFvrxgd1Fg1LAt/qeskjMbCZTx4hUpkv4DjYoGZtiWDr4tyVtvh7s3OtfM
         gqXulf/XxcvPL0bd7/I1CF90EQKPJhm4iJxQPDzaXrROjm/rFsp3asRsMVO5uNU0yNHC
         KXQW55tWQG9Z1VvXi3cvLQFWOf4YfEG7GATJWHoTihhZC95XKPEeAFDlHnzuPE2baIKN
         ltQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC3i+ivS9YgxikhhQM7mf+NcjQXQqCKhOv0bQ3NZKyf0XYZxSr1JFJpEyKa59ChKGcniOrWH+iwolOcfmjcoOGATmmEKcLHBCf
X-Gm-Message-State: AOJu0YzLCzEqaVo2fHQjfP+L6p7NU5MXI71+BAoFv8kR9EKAYn7NI44k
	2ktdSIs7GElhMo8Pb9BB+ayZBJrLQKmEEr5piucKFWcsF+THej49kCJRWMA0lwg=
X-Google-Smtp-Source: AGHT+IGmXWn18c988klyJYYpXavCR7WbEtO7rcL5Mr1PfPaZB1foLdva9PyJgtzjZ5KePsRiBAdeoA==
X-Received: by 2002:adf:f411:0:b0:362:69b3:8e4d with SMTP id ffacd0b85a97d-366e36baee6mr8386443f8f.25.1719349331986;
        Tue, 25 Jun 2024 14:02:11 -0700 (PDT)
Received: from localhost.localdomain ([2a10:d582:37c5:0:a86b:b44f:15fa:ccf9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9b8a8sm13866974f8f.50.2024.06.25.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:02:11 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	subhajit.ghosh@tweaklogic.com,
	dan.carpenter@linaro.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: apds9306: Fix error handing
Date: Tue, 25 Jun 2024 22:02:01 +0100
Message-ID: <20240625210203.522179-1-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of 'iio_gts_find_int_time_by_sel()' is assigned to
variable 'intg_old' but value of 'ret' is checked for error. Update to
use 'intg_old' for error checking.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
---
 drivers/iio/light/apds9306.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index d6627b3e6000..66a063ea3db4 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -583,8 +583,8 @@ static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
 		return ret;
 
 	intg_old = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
-	if (ret < 0)
-		return ret;
+	if (intg_old < 0)
+		return intg_old;
 
 	if (intg_old == val2)
 		return 0;
-- 
2.43.0


