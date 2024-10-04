Return-Path: <linux-iio+bounces-10142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3E990C47
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B493EB2A902
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E581E9066;
	Fri,  4 Oct 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui65pVlT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47181E7C3D;
	Fri,  4 Oct 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066026; cv=none; b=RnlQ8aHXgDqa0y0MSFL9TxeFpAZyw6z+QvCmwYqmUo/FfpV51r4Ez5aScqHX5JPi52m9Ubebs5f4z2iFvuH4TPIJfGJFBixtG2CnwRthXvjOGof2t0pbkLrwAammQsSMwLIhnbrblOWiuyZxT3Z3Fhz2YPXfkAfrXKl7SmCPTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066026; c=relaxed/simple;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBa2URgb+ApZTlDGkdIZ+2vWdwcoTZPG8oT3btq4WRRhN+eqaHSp4fA/cyIfOW+D7J98HkxVgs+vW4dO+r/r4ckjGZiR5ZYp3IUFlO9L/oHGZb7lnEekkYz/SFx66D9aiekC5TsTlclkCofbu+SZ2iJUNAvZLQDsw98s4ml228U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui65pVlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A02C4CECE;
	Fri,  4 Oct 2024 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066026;
	bh=MBjN4JNZbfHj09pIbFVjtX56PRWwuJv6/BKVipyEr3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ui65pVlTdk3ETCcCTCkE9JcWj4r1IBQ+sLy+nLOShhMa0PP5+BZqlaIk6NSyQ3AEr
	 oKPdWj3+DnOwzSd8duYm0whHLY5QPxSUU7Q35Xtv8WDXdGHrdTz4BiPPGWbg9Qpky8
	 fTgs1th3UuX8UcTxIcJKtQ4lhBgzu4UqcCPdIjkFmFMwI0mxFg+o75Q8aBnXFrA+qH
	 7JwCBXexhHSODTWjcA/HAHle2JhrTZ/h4OqEboH1yn9pOduzh9zjAJWDC6q3IraDWl
	 XE9dSeup3nDRMTZY78ejYilFDusvCrX000OZWTpPPuYGHzfZO2Z2eYqpoQcYn9dfLx
	 1Ulf7jK4bixeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 62/76] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:17:19 -0400
Message-ID: <20241004181828.3669209-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


