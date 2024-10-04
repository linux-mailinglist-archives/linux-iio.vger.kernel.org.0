Return-Path: <linux-iio+bounces-10147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844E990EB1
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84E21F24103
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4052229EFC;
	Fri,  4 Oct 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHT8Hzt2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F325229EF1;
	Fri,  4 Oct 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066647; cv=none; b=HcRNa2D6cM2OhAsBTvvFodSjByfaWsASAVeA8eWffeaBAhD9He+8D4eMaLsTrDaKp8Ap4Hwqog/wSFkmrhlXSCuH8bTCyOtuyXfUZOLZEOCJB0dHWpAKnWz1LJbc2dIemDmCRwlhqXsL/z0dz+MrysmbMW9P3WbXKeOU4bDcFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066647; c=relaxed/simple;
	bh=K9/UHBe0ww9yzMLs3U9/zb6gUJvoZMzYll+Pw1tyizI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2h1Mwsh23Kl+EVWQEFLkeVCD073GGciG+zA5QqdG8TjuPA6staI72Ev5olgClWqWMujwjW/6fRt2etMDkuwHhj7h683vZtRxovMQEfw+kOhJaFHYxsUZcnsoiwk5m74WFtuFjd/ufa34W7Z7ppvWifkpLBHvRS4+Qyg2eunJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHT8Hzt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71927C4CED1;
	Fri,  4 Oct 2024 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066647;
	bh=K9/UHBe0ww9yzMLs3U9/zb6gUJvoZMzYll+Pw1tyizI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHT8Hzt2gSxqFOOflO6nxMlfkmnn5xU1AFnI5Vcbw2V6jyx9Qb64MbciWfwq45lwP
	 Xx+CgYEfUdb0lPyp845Gob3Ogj5WH7WrxtbOF61TUrlgUhy048f7d3V5QzLsy7qBTl
	 N7Erfbii/nA/q9IoZcgdw1VEFoEXlKjgDDDp19PaUYyyTnGNr/r6sH9syKpixweEa1
	 vdMNdOVmEkwPBTytU2hceGD7pNU47IaGkapBjCuTmll2G23E7wti3cx35VxnQjYNvy
	 +JgBnyBIBBrkCvDSMymCUEAnak7Z3jveFEN67ci81zJNbsZeGEy05RrfQXwrQN5i0i
	 9yAvdcTkCCrrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 23/26] tools/iio: Add memory allocation failure check for trigger_name
Date: Fri,  4 Oct 2024 14:29:49 -0400
Message-ID: <20241004183005.3675332-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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


