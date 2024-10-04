Return-Path: <linux-iio+bounces-10146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DE990E53
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986BE28457B
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F921DF241;
	Fri,  4 Oct 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGcCs7Eg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECEA1E2616;
	Fri,  4 Oct 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066584; cv=none; b=atpQs0SVu2guAeh45SRdRQnASWCKZvwwICyVG7P89dY5lH6qy3KBA2ztdQyJAuMOhBpQ6ryy9Ew55AYtTIUDK8hpAstTGGzDgKjUzx0hjT7qgK2AEPLbeCmmadI/lROBdc9gEiYPx7FZh+IX22iITBvVivtskRnGCKQSaoWVfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066584; c=relaxed/simple;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWtp2KZOmx2nKGToKMVweXiKsjXtfHXtGkjLongBywi0Gqn9IwYvMZ1MRYkxm/Yk15OwpnaIBIbMa1fq+rRigUjn9akpIfQEE1MjracXruN23Gr/yV2Abv7iSjx9Lfj2Cp/iT0dv/BObRZerDNWDcfa5x/w4hXMC6vDTHu1XdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGcCs7Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A2EC4CED1;
	Fri,  4 Oct 2024 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066584;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGcCs7EgHLPO2+N6Npnii/UxkldqmBdkMXckTnnnQTOtnqs7+xJp1Oarsf9Pxr63Y
	 YkZSpqUMhY6v3fnNDMI4oLF+q4iPnvaMZDZjNJRDSl7ceBdOrk6kAowl3G0HEN2epA
	 U9aJIdCCh9P1BqQksTqqNpHMvdVhXTns1gys28yfsEN9VrUNdOEr2mq9iPh0erm6OO
	 7os8mi8fGFU43ShOIWZMtYjDL5F1dJP2xeM9UNJ/ovLI+fLEdqBnq9aO8nikAGBHpn
	 vRun8Qk34cEJ5urfhSoqKzOIMzTHgvEBGv55mcRPARPlPM/Q2hTrw9biJcYdKmU23x
	 QNHb8UA9bld5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 28/31] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:28:36 -0400
Message-ID: <20241004182854.3674661-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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


