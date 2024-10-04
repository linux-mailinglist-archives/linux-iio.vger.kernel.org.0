Return-Path: <linux-iio+bounces-10149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8CA990F4F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878B5B32511
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5B231460;
	Fri,  4 Oct 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsQAYb91"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D751E1C2F;
	Fri,  4 Oct 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066733; cv=none; b=aCimjuSKZu0VS2yiJ/8gbEauQc4es6s0Lvz3Ltvv8zZ2wOEtM9MWuojXxXaa6GRP/2LeiJspeI4tMCz5hQ5MKgtu+YH0fNHM73cuuIwJR6m5rDQGNpnFWpGUUaeZVO0kkgbIx/f3h5TaDU9UJa9nABxA4kbKbHV/lZymoX8K9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066733; c=relaxed/simple;
	bh=+koxMIZM77Tt7I8tTJn8hOJqD1LRiVGBhCi9CP4N6G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzlcLAF+iwAoOpIrds3HcFi55k7Hc8tHqqfIM+vfn9RVwaavlwALiLCrWPpFwfByu2pstkPtsltfkyb2kLkRANAd4mR/bfHWUCzViLqEp3M8dlf32hX9/OLRJqTK/rd3n/+4hs31Vk84NamzZUulKDQmppxqT/EBox5z8Nfl+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsQAYb91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37D3C4CECC;
	Fri,  4 Oct 2024 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066732;
	bh=+koxMIZM77Tt7I8tTJn8hOJqD1LRiVGBhCi9CP4N6G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsQAYb918FJHnYZgBhdRZJ1s0efE0kMEWcy3rqtNboo9VtVO2wEIwKghjyj0Edati
	 vNX8H/X37+q1SMRvhc4tDUuXLww321BbzcTXoge2YbEUJO0sGZjrj9EGJUW4sHyF9J
	 1W/6ytq3vtfyyrwRgEqElSbd8hd5kwxtimRYCKF5OJ4xuL0acajBnkk+IuWGdE8WZ7
	 LDk260gjrQl3ed3VdHObOUfaUpVayFlvr8aSjon6B9hVlE9/X60BMcZcCLdythJt92
	 dOs0qJ1T12wV42YGRNJNV5nuPg53sYvC/wvEOBnri8e19N5KZNaOU1l6PQz/REoeVP
	 H2UyltkCkCOhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/16] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:31:41 -0400
Message-ID: <20241004183150.3676355-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index ca9f33fa51c9f..e8cf3dc8de72c 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -483,6 +483,10 @@ int main(int argc, char **argv)
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


