Return-Path: <linux-iio+bounces-10145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5084990DE4
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E765D1C20E36
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62777216427;
	Fri,  4 Oct 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKuX62NV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4441D9693;
	Fri,  4 Oct 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066501; cv=none; b=acB2ZjD+DU+uQSzEMgfmG5Cb8kTjOxa96cNwJnEuffnxDK0pJ4lYYill8gFCRgrat8KK0BaFYm6WJOd31XnxtuWcfnYsB4N/SOdXrTDk/l45tb2sPpcXcHv9S47x7uAofFHP+XB/lyBzsyYLqeks30DTw1NYqx7iQcDgpW7llBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066501; c=relaxed/simple;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoyMEcyD9tjfzLYxnm1LpCPeRMNAeu5PpU2heGFoVXOlZF5NI+AGTjnCC0NZPEsLg11bN2X5zKkeaXGTMKSYQo3VcIQmwp291UYyLyN698fYwRkN2Wd+lpKO6ceyrWhvDyfJ0NZ9rDK3rlfcbsPOUTeX0nZK0lsF5t7dRl6AWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKuX62NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E3DC4CECD;
	Fri,  4 Oct 2024 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066501;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKuX62NVTcWIuUOcbbsRr0G9eBF4NDhH/fBdtoZhek7rc/HrDjzPU07h7TZLdVE8o
	 ouLsw2gFv3acIblHCe7E7IPvYJwPeO7/A19Ry3OSa8O/nAbYMr/Ri+XAULCg/Xw3jS
	 z+Obwwj4FxTM9dbxb2BlAPwtKgNZPhUFL9nhFyg2LAzmi0jbsO5I9v3vwvEWdT8FHA
	 IoIggzuWPhveVVNRbyf4oJzrFaMV4sSQDtiWhHfhYN3GRWJu5/mrj8dQi49NXH43Gk
	 e8346o7eywYI6llLT4JC3EgG6voJYv8GzmBa5y9AmR96uAPt6iB7y7iI/TS8fT/J5m
	 RFQ9MyQ/XqhXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 35/42] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:26:46 -0400
Message-ID: <20241004182718.3673735-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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


