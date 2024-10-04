Return-Path: <linux-iio+bounces-10148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8C990EFA
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143071C22ED5
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4A22E2A4;
	Fri,  4 Oct 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCUaTYST"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DDD22DBB9;
	Fri,  4 Oct 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066699; cv=none; b=NPr1hQO6w+p2HZ6U5Lt4tLMuL/9FIM/gcSsi8pe0ggaI7jSGRuR2CpBnK3NSnPWwm1AL15vblUU7lovXxuqAIdULV3eWEg0Oq/rbVBNVXfBJEqcyWk++llmN0+rAEZDg3PmXaTxm0Rdnd7CF412itOdA10cU6Fk7U8YD68pEIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066699; c=relaxed/simple;
	bh=K9/UHBe0ww9yzMLs3U9/zb6gUJvoZMzYll+Pw1tyizI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY7KXp9LTRyyJM1o9wsJPFCSIW0T+8Wlv6o0ACvb5/9hYXt9YOnnYHgQVGo8Khnxkke5GE2JDO8DgCJCEgVRUwyUVq6G1n3E/KvWRX/qVbO+Doqa+KJyDgLLqFY88cG4+zVCKo2GxeF5NePXpcg9fc8uBtOKAVGeyk8w647vQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCUaTYST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E636C4CEC6;
	Fri,  4 Oct 2024 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066698;
	bh=K9/UHBe0ww9yzMLs3U9/zb6gUJvoZMzYll+Pw1tyizI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCUaTYSTXYVJRFsQostmeMzGqOP4TaSYIvO0AKrtNguEMiiXRFQ8PJqNbHZcBlej1
	 SHyZXhe2QGc2quHf+LwFddIeWHsXDb5+/vgNc1o2knMhLOgky4H0yMdrmXMagF/PP2
	 v4pgQSgnAacuX1vJzl9zvnhIoUWrp4lRIOilpYl+detCPRINWCB8KONVbghR5T3I2b
	 ANeVsrcQbA/p68NLpqTBlqgZkweZT4n7nPtLNgMai7WKkQD51cS4cxAafEDyRVH3SZ
	 DcimUNJR0/RAihZNI14ob8J1i/JQUEiTtnqo+xLzCW8CzsP28zuP6iD5tkFx5N/ooF
	 lP/OqN/aJ9dIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 19/21] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:30:54 -0400
Message-ID: <20241004183105.3675901-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
Content-Transfer-Encoding: 8bit

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

[ Upstream commit 3c6b818b097dd6932859bcc3d6722a74ec5931c1 ]

Added a check to handle memory allocation failure for `trigger_name`
and return `-ENOMEM`.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Link: https://patch.msgid.link/20240828093129.3040-1-zhujun2@cmss.chinamobile.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_generic_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 2fd10eab75b53..5ef09ac6e7cf7 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -479,6 +479,10 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 		}
 		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
+		if (!trigger_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
 		free(trig_dev_name);
 		if (ret < 0) {
-- 
2.43.0


