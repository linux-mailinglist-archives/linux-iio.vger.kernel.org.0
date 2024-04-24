Return-Path: <linux-iio+bounces-4504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB458B168C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 00:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77F8286ED6
	for <lists+linux-iio@lfdr.de>; Wed, 24 Apr 2024 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E616E879;
	Wed, 24 Apr 2024 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="AmQjxmds"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FC155A50
	for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999222; cv=none; b=eHMHXX/CU2NIuggTtRWUBPsBFgLXeZeQdC4s5evmnizxJ17Hr9ErxP4vqdS6s/CD44Q051+s24/CmmlEv4sdWbbZGZa86QaC+xz5HeaUj+wR+Wt5miA9iQ/pFNsC2gvSCDiaXwUWHNvib8FsAI+mPC6Ac1+off3rzS20R7lbFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999222; c=relaxed/simple;
	bh=+5eg/JJ8AqbskfcggVM/jbEiAKuT4oA82Qga2yiWO6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewlw8KOqfJ2jfrj+aJiRqD64TUEw9XReWAGPSJEMg5XywiZItpPg2QWBEiaBAXHWvf0bSDRrAtE6WbeswPdJTXtLHmZXYs3Lwrg1B9AUEQez0Rd0EKE8eEENzCjivufD7vxXZKMjB3wvm3mCDmA1uEMBt/UAVf6oOAHOaqskAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=AmQjxmds; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2abf9305afcso331876a91.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2024 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1713999220; x=1714604020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZEmGnvsIkDhfJpBYJT63mQc79PLy3IqOvNHHOZ8S4o=;
        b=AmQjxmdsUntzaf574jPPhQcSRdiXFcOl3aHGjQq4kUjpZ7HXXEkLNIasuMh/EhlGbK
         P04TiApMeJaqEQpB6qjjRx+TRB7fWdNVYxT/nSr3lc1ZeJnjPZJ9dx4xcBc+46fpKZDA
         GHEFPFH2nq54M4Be4/timpKVG4HGBT7g6yXim6ESkh2XzVukQ94G1pXJIUnTHEJ5oyRF
         LOneVqqs13aNUyNEcBhTbZgM5XxlxpNKb4oSyQg0F2OlJjmF+9HZMOVtCfL0/kX/sFcz
         Fa83rxPaVdyLaP8qceb3Wuqx8znx0CRqMHC54+HdVSF3fibKywdt0AG4odDArKp27nMW
         pL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999220; x=1714604020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZEmGnvsIkDhfJpBYJT63mQc79PLy3IqOvNHHOZ8S4o=;
        b=WmP5jlgNAdS8QJcyAJeCCjHILOVK87UAOZu3zRET0JnKeV9wqg22cL07nVNjdB4JHY
         7pmvVljLy9y/zyq2ofdLmOmJ+ZVX2g86CaJJn9X8hhGo2XVql98GDpcC/dx8aPFuKfeD
         4CpXnvfKwqj4f061aQHk1V0xf3Q5uxgyxzC3Mcv+GLlWx14w1hp/LHRZCKQl/wxLwguM
         CtMw2a7zyBdipUkr6FevfG/YzWuIvkR01PHHsZj1WWwq2ojh5la3/HNxykHi8M3h0k7D
         nktPvetMI7HJRW5o7u+9c68YJSIDX7xbbsjrN3286D/9uxHY663p/BLp/BSYtXcEdBdD
         2u3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFqfvoYGA22t1dSWDS658GnzJnCebJzxSrH7S40CQ8KrIH2oHKU6Jo3b9BxCxuMy3H01mBK0DTy5bXnZSZgDF3mqcAkDwSY1d4
X-Gm-Message-State: AOJu0Yx0imf1UbuoOdW/MESxtEzHKPWhw1o+ZtX+mhPZBJUo6zKD6atn
	QzjI+9CbbK49NB+EOBjtjXvWbho4UxRxIZKOMKllEmYxzo810cqYKw7iSHPhTL4=
X-Google-Smtp-Source: AGHT+IH7vlrbf7VW8I6MfsEOr9tWje/4x2vL0d74aujnQrrcuXrVvNeRnAT2JE2WdTa+Z5KUq15gug==
X-Received: by 2002:a17:90b:3614:b0:2ad:51d6:d578 with SMTP id ml20-20020a17090b361400b002ad51d6d578mr3533920pjb.10.1713999219779;
        Wed, 24 Apr 2024 15:53:39 -0700 (PDT)
Received: from notebook.taila006a.ts.net ([2804:1b3:a542:1ae9:836e:70c6:5624:b2a3])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a668e00b002a6e67e197dsm11710569pjj.45.2024.04.24.15.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:53:39 -0700 (PDT)
From: Pedro Mariano <pedro.mariano@usp.br>
To: anand.ashok.dumbre@xilinx.com,
	jic23@kernel.org,
	michal.simek@amd.com
Cc: Pedro Mariano <pedro.mariano@usp.br>,
	Roberto Bolgheroni <robertobolgheroni@usp.br>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iio: adc: xilinx-ams: Use device_for_each_child_node_scoped()
Date: Wed, 24 Apr 2024 19:53:00 -0300
Message-ID: <20240424225302.47004-1-pedro.mariano@usp.br>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using device_for_each_child_node_scoped instead of
device_for_each_child_node automatically releases the handle on early exit
which reduces the chance of bugs that cause resource leaks.

Co-developed-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
Signed-off-by: Roberto Bolgheroni <robertobolgheroni@usp.br>
Signed-off-by: Pedro Mariano <pedro.mariano@usp.br>
---
 drivers/iio/adc/xilinx-ams.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f0b71a122..7f5571d9d 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1261,7 +1261,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	struct ams *ams = iio_priv(indio_dev);
 	struct iio_chan_spec *ams_channels, *dev_channels;
 	struct device *dev = indio_dev->dev.parent;
-	struct fwnode_handle *child = NULL;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	size_t ams_size;
 	int ret, ch_cnt = 0, i, rising_off, falling_off;
@@ -1283,13 +1282,11 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		num_channels += ret;
 	}
 
-	fwnode_for_each_child_node(fwnode, child) {
+	fwnode_for_each_child_node_scoped(fwnode, child) {
 		if (fwnode_device_is_available(child)) {
 			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
-			if (ret < 0) {
-				fwnode_handle_put(child);
+			if (ret < 0)
 				return ret;
-			}
 
 			num_channels += ret;
 		}
-- 
2.44.0


