Return-Path: <linux-iio+bounces-4039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C2C89772E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 19:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A428B629
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AAE16F827;
	Wed,  3 Apr 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpJRWdt3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254D156231;
	Wed,  3 Apr 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164841; cv=none; b=Nqgce4Tz405QOX3d01Sk1gUZ34Iq9SLKc1DZlBRVPkEewUeviIjjokHbAB9/VqKeK8TOstDx0Kzy0CICfbkyR0mYC9uEreu5SOfnmZ3HIu9bk9yneIfRVHU0hPOVUw5kStb5C9KC3mTPyLDwB2e03PuYYVnGCVBbJ6wALpxyxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164841; c=relaxed/simple;
	bh=0FRWAnjUUhfEu3c+uEpE2f2IrF0ulTBcuBoD6QlU87A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9LJY5cMBipY16wuodyZAyfp1Gg0pwA88uv1cVQh78uDFHX0KL1YBKdIES+M6tR8LrYzCErB5EyVJg1B9IWofVb+s1SkNWgslaaY2An6xwNQI3krZJP2apoknHggJDT1VdM3wXhKdmsYjrF1A/SyT6PrkrRhBQznNi+Ak2SEkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpJRWdt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1BAC433C7;
	Wed,  3 Apr 2024 17:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164841;
	bh=0FRWAnjUUhfEu3c+uEpE2f2IrF0ulTBcuBoD6QlU87A=;
	h=From:To:Cc:Subject:Date:From;
	b=LpJRWdt3/x/bmNNNW/oleY4L9jYqP+GD0D3y0ix/OwQX1DIR4Q0XjP6C1RrUjfepq
	 s6pWiWk/DtXYx5ygs/qsoWbcns5FGReJTiLgGNCYU22H3x/QuWb12ceao2FsLkVejE
	 cC/c4ugPVPh3GeTUqFVuNgv9MQob2XxDOthmBPGBij9ipeZh8KdQ5+8GQlCdOxndGl
	 xdxwcMv8L8hXIc9BZFJzR2sfTCl430+o4F4s6qFHIZ43dfeTGj5Mj8cW9lP3K6Do0F
	 2v7IXnmxKA4R4tGednHmH404lsWmuz5W1dqTmwMmBKjzo7tcdSFBf0mLP1folLlpev
	 nX9WT8uVfI0Ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/5] tools: iio: replace seekdir() in iio_generic_buffer
Date: Wed,  3 Apr 2024 13:20:34 -0400
Message-ID: <20240403172041.354877-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Petre Rodan <petre.rodan@subdimension.ro>

[ Upstream commit 4e6500bfa053dc133021f9c144261b77b0ba7dc8 ]

Replace seekdir() with rewinddir() in order to fix a localized glibc bug.

One of the glibc patches that stable Gentoo is using causes an improper
directory stream positioning bug on 32bit arm. That in turn ends up as a
floating point exception in iio_generic_buffer.

The attached patch provides a fix by using an equivalent function which
should not cause trouble for other distros and is easier to reason about
in general as it obviously always goes back to to the start.

https://sourceware.org/bugzilla/show_bug.cgi?id=31212

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Link: https://lore.kernel.org/r/20240108103224.3986-1-petre.rodan@subdimension.ro
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index d174487b2f226..1ef51c7e7b04f 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir,
 		goto error_close_dir;
 	}
 
-	seekdir(dp, 0);
+	rewinddir(dp);
 	while (ent = readdir(dp), ent) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
-- 
2.43.0


