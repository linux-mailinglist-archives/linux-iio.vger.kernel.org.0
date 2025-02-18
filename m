Return-Path: <linux-iio+bounces-15724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69CA39911
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 11:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DD77A2C69
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB623C8A9;
	Tue, 18 Feb 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRUHY8Qc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD92235361
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874691; cv=none; b=ETD9nJh7g3giUN8HH8pp0RNywlW8zkgSdEjG2zEAtFZtPNENrgk+ArSovyhz+sAwAo3hM2GHTvwpcL2QonIMIXSEcCFFcgTycBRewL94umEtA0G0krFkBuhlgUifBgo2A1PhSSdlxYBpEjlGMrUGYgrxMC0e0aASVPc/zuw3lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874691; c=relaxed/simple;
	bh=taSrnLdz3Fe0l9Q4/6/PCVx42x8bmRSJKQ7JFhaWy6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkMy0JKa2z+Y9xo02O7aWxkSHX3e6e7Cna8bTxLCthqS/AKhvqUL0KwWEAr1LJ2tCcCisH9nfvNjwySUn/wLjsqoVEEDti0rmBq7pWpyky9t+dM60FRQdzkpHMMK8LAFIb37cqbLv0NYAioI6mipvS6Keyom69TrMde3V+BgYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRUHY8Qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7CE9C4CEE4;
	Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874690;
	bh=taSrnLdz3Fe0l9Q4/6/PCVx42x8bmRSJKQ7JFhaWy6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TRUHY8QcGePvUIqJeTNs3wYtl/SU3YEBeKk4kY1nNXAD784gw/N/INFJknO8MFIVF
	 yoAHmiVbMvukpV+S0Ih76pgJgoV/eUmzodZ1+P3wUaJ7cROG2HQ5PqWLhSquIPjjjs
	 rw5RlqSqx0HhQSqxeV33OqO+mSaJlJO8bleAHo3bH6FXYJCNHTadu9iZ/+52C9eCtM
	 chXzNDK4D0nWXyklT9oJUJw0pNtXzcEkLi7PLAPcHAON/osFUTXu4dt5ha2nZsRuRk
	 OXbCJ+BVDvH3DOxMLpkqnkZBdbk2pzRpKnYTi4Hrmt5E2wMOrvfgvWwjxzwtOmUoRC
	 gZBej6SHLEvEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB07CC021AE;
	Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 18 Feb 2025 10:31:26 +0000
Subject: [PATCH 2/2] iio: core: make use of simple_write_to_buffer()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-dev-iio-misc-v1-2-bf72b20a1eb8@analog.com>
References: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
In-Reply-To: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
To: linux-iio@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739874693; l=1029;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XSfph9ScrctizABSM0SAUyR4HL7Q5VFFkc9KAHORCIQ=;
 b=WtkAqNh6pJ1VanNffMmjSRxLtfRCNB6dJavd+KtTeyGbWdvRL/293piuSiEt2QhMSNVf0feX+
 xLKB+MDVle5DOXivrz7fua/Cecjr/zvArX7ZAWzt6oWtFB4SToztRh3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Instead of open coding (kind of) simple_write_to_buffer(), use it.

While at it, use ascii representation to terminate the string as that is
the more common way of doing it.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a2117ad1337d55468c0f21c274fcbedd352c97ff..b9f4113ae5fc3ee1ef76be6808cc437286690dae 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -410,11 +410,12 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	count = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
-		return -EFAULT;
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
+				     count);
+	if (ret < 0)
+		return ret;
 
-	buf[count] = 0;
+	buf[count] = '\0';
 
 	ret = sscanf(buf, "%i %i", &reg, &val);
 

-- 
2.48.1



