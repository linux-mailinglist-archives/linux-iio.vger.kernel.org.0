Return-Path: <linux-iio+bounces-18911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E2AA539A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 20:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8901B67484
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6FD262D14;
	Wed, 30 Apr 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTzQSgTo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB3190676;
	Wed, 30 Apr 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037417; cv=none; b=VzP8Cc9W3ih8KMiS0IKYjqD5QDC3j+m8rL2e8nqsf8gmmUQz6gH4DnFPwiGujEXsHD4HoymMXhvwbJYLN24SwLvDttxw0GukRNgphgXvwlfuuqYXvD1AbNrC+BuGUxRecdbmGbeaho+EymS03SH+a5GxTCcpwDyjYq/q9IZ7t+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037417; c=relaxed/simple;
	bh=BGE5P8pILZj++lhgPLZi13PAymNSTla+4LMFaC02wP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIjvbC0wXEgZIkNtk8DxyxR+ji4YpLA6ERWHfGXLv58QgVgiO4UQLvfm9t4nHGuXthR6og4wBx5a5t51/NWv9y2R7semuSA61CDMuN4O34xOBQbidgjoSJaF2zj8q/9Y9b1/sDlYE93FIHi+nKKuK3zusJG87Uif/rnocvQHurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTzQSgTo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8ffa00555so2192986d6.0;
        Wed, 30 Apr 2025 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746037415; x=1746642215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni9fsiOSDdijzrkYLIlegIUtj7F8njM6gU+RRiJK3jo=;
        b=OTzQSgTodHHI26L/6HNm/nLVClPezAT3Dmtz4/J1zYf8pfwgsqfGkQFKzvcss5O6hW
         WVVPgsVcfJr10eOUdKQPquMtuf907TUsr0ukN49x33jDt1hKyTG9J8WlBXSPm5dUqeD7
         zc+rCrOP/lElxkfMurn982Fy7zy9as6JsPVdWXsWTtyL/xq5qH0KhUQQvWkYynFIdJcn
         mW4K9OAlTS2p6jmcVLi9me43eKHfnLZOrcjwOGa2CaH39UENo+H/PQ00mzdd9avyAj4d
         NMdV1rxSYUOvV5jKTVfHi/DBY0RT/mOpeR8ZQWRkNCtrX5llf+KA4hXUoKHikNqKHXKd
         Skvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746037415; x=1746642215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ni9fsiOSDdijzrkYLIlegIUtj7F8njM6gU+RRiJK3jo=;
        b=RbEYRnxcvRKpN9nt68pZM9NWEE0CjLEO6pHpF5CqTZxAqNVP9T+FRrnbfIgLjxga3b
         Ei72vpC3zfRKdF39zrIbAs9HWmVUJQBNflC7ZSvmlD/sSOX2rqHlyTXgpDsPzaWvFs7E
         fMxfIilNFJ5ebDcUB2s7EKvlo9yeZZjlkQoXRwGzCFPiAMcVxRt/ux9+5wZNqTnvJluB
         UwHjc/vzJHFrIXX3BZQz7emAO1wLeOpOdb67QFoDkpDYhKqE312vN4rjGkLwxy5cC6gU
         og90vNKJjlvpfu/hXABrAAlLWoJbBmhvH8wUYH+RtzUaVmweGnh0qW31aBJbQ+3Rwt0s
         GpOg==
X-Forwarded-Encrypted: i=1; AJvYcCU0I/Vj4fw1OKHsIa4vZiK/Hkp5jz0BHHVcX1LfWHopczAi24gX8RRl5SoDQ4O6dsFhxjUdC3pBwvA=@vger.kernel.org, AJvYcCWhxJEwri6llDDtPjPbCX9e7jp7/1VtryEE8EH7OSgz3S0nNhvUrY0Cqp4UhPYh06yX7coxGvnSvKAcSGO4@vger.kernel.org
X-Gm-Message-State: AOJu0YxIF8uU0frn1i5M1j0Ai1RuT/mM8M95BSaOB7VctnscnmR0CZzu
	HOaghW4BfpltfQ6J+k+B+e0xPcsIK915jHtVBUvqE7GjT4ZYGXis
X-Gm-Gg: ASbGnctTpBjFklfpif7nNVnptcdY1IVCirHFwULhcYnS/sREe90X5pIY1peJYe//xLr
	DTnJhlXqeta9e5iEnv6MkxFbZObVxsDOga9mb+dr5MuIIEIngqvh/azsxGZ4mvflbEQgdOvUMN0
	Vu7hK781BcU4fa2jaFJOdg5Nwi42jOLlvO/Voqo0LjuKxsUQQGD+qvU+iWDFbRNCIWfSVhlUD5p
	c0/M9QIz+78bkynnsHx1WzPpplEAQuHDhUG8t6KOZDxpD35POBWHCTbDOABxAyYJ0LbMM7UB+Sg
	NWt5aZTYWeuHJOpDtK88i7RpASoAIJ1t8YV9MjXY+jrnKwN42DgLktpCbvogfc8uBxq/CcTb
X-Google-Smtp-Source: AGHT+IG4uyiUy+B7giYkxeAY6IdTUsN4jxLf9aft69KrEkNVHODs+hWMZKgECu+DhpxrxYjvD4bDAA==
X-Received: by 2002:a05:6214:2388:b0:6ea:d6e1:f3f8 with SMTP id 6a1803df08f44-6f4fe1333ecmr59467246d6.45.1746037415123;
        Wed, 30 Apr 2025 11:23:35 -0700 (PDT)
Received: from c65201v1.fyre.ibm.com ([129.41.87.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe88108esm11084396d6.122.2025.04.30.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:23:34 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] HID: sensor-hub: Fix typo and improve documentation for sensor_hub_remove_callback()
Date: Wed, 30 Apr 2025 11:23:00 -0700
Message-ID: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a typo in "registered" and improved grammar for better readability
and consistency with kernel-doc standards. No functional changes.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 include/linux/hid-sensor-hub.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index c27329e2a5ad..5d2ac79429d4 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -130,10 +130,11 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 /**
 * sensor_hub_remove_callback() - Remove client callbacks
 * @hsdev:	Hub device instance.
-* @usage_id:	Usage id of the client (E.g. 0x200076 for Gyro).
+* @usage_id:	Usage id of the client (e.g. 0x200076 for Gyro).
 *
-* If there is a callback registred, this call will remove that
-* callbacks, so that it will stop data and event notifications.
+* Removes a previously registered callback for the given usage ID.
+* Once removed, the client will no longer receive data or event
+* notifications.
 */
 int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id);
-- 
2.43.5


