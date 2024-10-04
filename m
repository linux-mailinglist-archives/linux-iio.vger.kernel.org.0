Return-Path: <linux-iio+bounces-10144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A5990DC0
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B883B26370
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5267220ADD6;
	Fri,  4 Oct 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe8i6lut"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82020ADCD;
	Fri,  4 Oct 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066393; cv=none; b=O7B8uov9bXBk9uF8h4ClwzyJr2S2ozyJDF+YPQajOlUVYWupQyObiBbaGLvhoA4Roy8j/oAazC4Ex4huDNHgpinI0Zs72v2F9u1sqJ+NTBqjcXMuqvy5JJVlPKpZvoIeAzcPKNWxW2uDuClNCNoGAW4PANcpeArnGN2dTVbn0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066393; c=relaxed/simple;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+ziYobGWaIU1yE54wpnPWer3lYV761LQl1rkn6VXqXB6giWN6HjagljkZkBV9TRX8gkGb7AqaF87uLzwhHRAfFQZAdFJRyIkDpghXigLvAZBqjCKxz2MJ+Xh3D7sMGLkY5ooYmZcyPoAcN3M5XD4Q0x/i8Gl24CBsXQ+zqZcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe8i6lut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D6C4CEC6;
	Fri,  4 Oct 2024 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066392;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fe8i6lutlQaH4hS2K/cm0vkPH+LvbJQG40EWobON0fnvdpIFWriEyUez4rcrTAbER
	 UB8QOaFuvvWjGkOOCSVC1uMWiqG/bchrtykbYd/tCXrK/c6dKOVomWp1SNYkON0fNr
	 jvgm0u75KIPT6oaqz97uEMqIw53++zL9M4UVFkgQVd+jfg3Pni2QzEECYuangIKyvg
	 tTd8pqwlwknSUJ/a0vvgsG7vIc+4She82O9Mnrgk/yA2rC54Wbhu0542jCCxVIexSA
	 BxVWwoG5gj1MG4eWUruw/DYsW6lHObqc0ZBWx/XlNTXLVWp+vTRwRF8OAUO8TbYbFB
	 kVkiTyxPay0mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 49/58] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:24:22 -0400
Message-ID: <20241004182503.3672477-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 0d0a7a19d6f95..9ef5ee087eda3 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -498,6 +498,10 @@ int main(int argc, char **argv)
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


