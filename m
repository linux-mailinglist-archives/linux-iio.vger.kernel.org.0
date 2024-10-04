Return-Path: <linux-iio+bounces-10143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA270990D4C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D41CB2499D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 18:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1B1FBCA8;
	Fri,  4 Oct 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZAHmsW0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9331FBC9F;
	Fri,  4 Oct 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066228; cv=none; b=dJpZmU481TTdLjXniZytbNRzfsXzDkatLjKYkpfZBlssRn5h6N6kLTSbxY+JsXT6ccM7X0ZbB7yOEK5Mb2xKCWAxX1JUkgT8Dytnv8ONboTP7iVICkdnMG6jQ2RQTjmNw9tBZegXPI2ZtI+2ZMJ44Oj0Z2pMeWKdYMv9DECwohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066228; c=relaxed/simple;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8GjvwZ8tfL0x3q6xCI/OeqQfmpXGT6SLXJH3mRLs+YiAU1XPcpPLrk4OPE72AW7d8m4wGV5tbmb/znDgAkLZUFOhZOVZeru9CR1Q3RtHTCXldEoBO+KLIsmv0DDTVn2k1pzndabF9y6VzsWyBrusscVaXQ98gBu9EJeH38lHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZAHmsW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCA9C4CECC;
	Fri,  4 Oct 2024 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066228;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZAHmsW04X2wWZAA4EsOOM2NU6QRkH1SwyHpav8wVH8h/Nsv1wYJFAhVZDQLUiXOP
	 zg1/MlKXpxmM03NL09VuoqmK08tYxt7jkdFvBelQKS2FUC+89jJmvD82zIJQ2y44Wq
	 eof4r7YMr6jBZKmUz8oosMprQOwcBmxIjf2vd4um+dmfJ7c8IPbnxVPLY2A/13zFZH
	 dxDt2qTTe4PaOJSIvLdPIBPdt0tjZPqWcJLMv+3peY5l5WtDBJjBh05VYDpB6qAHtg
	 hFEMvfDZM6Cjtt7w73YNE/5lzeHMjvANPBaeh0JEQTIc9WovHrxTP7rz/bHWnZhs0v
	 7mL3Zm0JLnTew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 56/70] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:20:54 -0400
Message-ID: <20241004182200.3670903-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


