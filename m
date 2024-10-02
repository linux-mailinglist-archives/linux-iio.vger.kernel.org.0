Return-Path: <linux-iio+bounces-10003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A2798D0BD
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 12:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C5E28514D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F841E493E;
	Wed,  2 Oct 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlrPsf+n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4CE1E492C;
	Wed,  2 Oct 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863400; cv=none; b=GhfqZaNKKa4+IVEKbNd3qn9Wx/x8d3hlnQdGRRpPq9NmC+nzVGfivZr3h2AXrMmkndW5TfyKSxqWM2XciLv2zvg5VG6p+SqROLM2jEF7+pIj4q9QKeBGJccl72ZSLY1mTmQz1xlmViUYm674Ta+/ut0DFtC7tlhjMFpf4L1YRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863400; c=relaxed/simple;
	bh=HKMPKyPW0rrp5se8xekeznmvYEB193hXpxkx0NCtiT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+Gz5w6YlEC4ZsydfREimdgj2zpm1CRf9Eq2ILN93hKI0jxDXOG6DvUidC+59GgHFBpFs6XL3JuhQxJiVnSF2U2y1a/eAGfQN/IbTfbPOiYrcRGuhL0tj3IxXgkt1sHbnL89jF6u8dJKi+dUCxxcKEYqskRRDcBIcXePzCWUKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlrPsf+n; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b070ff24dso5792909b3a.2;
        Wed, 02 Oct 2024 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727863398; x=1728468198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kQNcsZl/V5kYlgzlqdcBvajouJ6eU37y0/qRQm49yY=;
        b=KlrPsf+nIkCKW9RmgTZLOv5bfdJ3cc0OM7wiPf6+8oAGDKEoLJ/MVctisgRAgTbn5Q
         KjBK14OiOrH2Q2aJ9tvABqQ6c+oOj2eZlaYuH1AJ0PjzIJn1Sg+q90lhLL0ni++RaK9A
         8+76tu1fa2+N72K/8ra7CGpPnpPepVcC9IbkwxSHBvzB+jaj+PF2P3FuGwPHCMDU6SjI
         NXvtzwrE34QIPWO0wmfEsTGzmJBVb5OIMktSFLdcMuzvFLWJphdYYaoiw1k///gRXvXs
         v8LsdaP4nBoEf11TemPiEAwn/tM3/pqi7CUdzd4aJ4XL/aZEjc/4BPt7Khrc0W0gr4rr
         XHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727863398; x=1728468198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kQNcsZl/V5kYlgzlqdcBvajouJ6eU37y0/qRQm49yY=;
        b=gFCz8AJQyZiK5BiVBXhN716YIXaUJ8d6ZJq0KX8srIgLAekz3UE6y0IEtp7p2B+TsB
         P39OJFat3whl5+k9lV5zi8tss+abBOYplfw6yuQ+4mcN8HzLnbmAXFf737xnpdBR+DtB
         zWeiLV18oOke7c7oZ/ep2DsgJNYWPZbYU45FKMmycn+3TqzEu4labWvCNkfyC9TFhvOG
         HGzSQgZmWB2mw9A9kxP4uLPh1k68q3jtUFf0tSXCQKX8uoCSSOnCVZ/pab07yMs2JdKB
         x0va//L7brIk4eoilF+ZSX7fV0pPXhkDvJ0Sn9qQ3AnVk0tvnE8LSyzux15rDjLjGj8E
         6ymA==
X-Forwarded-Encrypted: i=1; AJvYcCV0+PE0vrKO/2PP0f85V5OhNt0wzqx15ukrcRP6nQ8Zir8bwzke5L3R8XqoXkawYrTFieo5N29uQbn+RNtH@vger.kernel.org, AJvYcCVob6jxtCOwbtaF3HTqSop9NjhxxwSpdJOFw/166l9CdLQTyACFrCpRnIbJlguJPqKCCwQB84nsadM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77T14NfgO2OYGD7aH3HRx/GVMSjbbJxLTIxgVu3ko52JeNsXq
	cx8/izZjzf7FKhIhYlhFAM8tEKMOlhGAw7MId5TdIofPqYmYLinDMV8GTgJivOM=
X-Google-Smtp-Source: AGHT+IG7+5r/rfYo4QhjMBCNNToKZzxF5g0OTzqZv32TXsmcUszzvKJQKEcq40AorldEIR5YYX+lMg==
X-Received: by 2002:a05:6a00:1956:b0:706:a931:20da with SMTP id d2e1a72fcca58-71dc5c48f7emr4172970b3a.3.1727863398105;
        Wed, 02 Oct 2024 03:03:18 -0700 (PDT)
Received: from Notebook.mec.ac.in ([14.139.184.222])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b265389desm9463728b3a.215.2024.10.02.03.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:03:17 -0700 (PDT)
From: Ivin Joel Abraham <ivinjabraham@gmail.com>
To: linux-doc@vger.kernel.org
Cc: ivinjabraham@gmail.com,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: iio: fix grammatical error
Date: Wed,  2 Oct 2024 15:33:41 +0530
Message-ID: <20241002100341.110435-1-ivinjabraham@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify the instruction for disabling autocalibration by adding the word
"by"

Signed-off-by: Ivin Joel Abraham <ivinjabraham@gmail.com>
---
 Documentation/iio/bno055.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
index 9a489a79d8f5..f1111ff3fe2e 100644
--- a/Documentation/iio/bno055.rst
+++ b/Documentation/iio/bno055.rst
@@ -22,7 +22,7 @@ This driver supports also IIO buffers.
 
 The IMU continuously performs an autocalibration procedure if (and only if)
 operating in fusion mode. The magnetometer autocalibration can however be
-disabled writing 0 in the sysfs in_magn_calibration_fast_enable attribute.
+disabled by writing 0 in the sysfs in_magn_calibration_fast_enable attribute.
 
 The driver provides access to autocalibration flags (i.e. you can known if
 the IMU has successfully autocalibrated) and to the calibration data blob.
-- 
2.46.2


