Return-Path: <linux-iio+bounces-8142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E75945F62
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107262823C1
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE7200115;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA2x9nCN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EB1E4F0F
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=EeKEZ1Kb8kok+wpi9OyA/hSk7v6lM4Y/69pezAsP+aVKWvkC4eoa4TIp1Dk70cj+Lm5iHdSIl6EzTN9YBMHNJygv+9TIcCOWUn+8+ZCQM26jcGo4dnJ4cUIP4QCKdMkLzD+GsKvXmI0zIebinHSBlRrT5Gnx8PC6rNYZORIzB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=RyYzrspXZNU3YFGMoHMNkUEhxHeSKfFZlMJQpJUvgoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcMnEhZv4X86t22zRYMjl2Pwq7D9nAGac/mYH/F2/Qa5kx9EDhBZl45gW7WoQiZ8gh2IjnDinf3aLzuFx5jYGz7ZwMSZQfhcKH4CurT2Pw/hnnVKrMZN93vVxSD6mLw95Kwh2uwG1ToCm+L6oIfvGrwzf2I1YwMnh9Uu2wbXQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA2x9nCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9BF6C4AF0F;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=RyYzrspXZNU3YFGMoHMNkUEhxHeSKfFZlMJQpJUvgoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eA2x9nCN5TkikJ3PbSCN7ZTHjiGGDJ+dbGRWJ8WHW2bKMvfWiePIldZzwcyzm6j81
	 8TfUggXA6Kmr5OlKyVyiS7WIYiyz5kLKx/BVVt0/hSPnmcVLkVz68ixBojptMqRpJs
	 5fEMzFgBNKLMgLBN0p8mz/lCjJzRTeK/4keT18hzgFRROPDblslazj3FJwOw07VHZT
	 wdTqyjhw+GTdV4K0uF0nk7Mx2dtk21cwIxJgm9NWnukMzO1ayMGQU9z0LwL3tS6lyv
	 EMXWY7BwnpRyPnVfaT1dQGzE/smdP+aX9p6bBxMd4uLH5M/FCmV08VoI6biV8saPPM
	 1HRbIZsvQMMwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD66C52D6F;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:27:01 +0200
Subject: [PATCH v2 3/8] iio: backend: add a modified prbs23 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-3-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=666;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gmG6owXx7+vNZNRlhh8piqNGl0cPxLcyjp7ksNBda48=;
 b=dSYQG/EOsIvahMNnhWGicaCBOOKBYi/OPeFdnkclAAc6wHGRKDWS8bH2zsTOkHFc+WK7f5fVF
 xwGDz49zfk4DlXTlFalEl8CKl4DviIW9GnR9iq/HT8Ce9Bzk3LbAK2h
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Support ADI specific prb23 sequence that can be used both for
calibrating or debugging digital interfaces.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/backend.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 9d0dba7ab9e7..2b9d1aa86552 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -56,6 +56,8 @@ enum iio_backend_test_pattern {
 	IIO_BACKEND_NO_TEST_PATTERN,
 	/* modified prbs9 */
 	IIO_BACKEND_ADI_PRBS_9A = 32,
+	/* modified prbs23 */
+	IIO_BACKEND_ADI_PRBS_23A,
 	IIO_BACKEND_TEST_PATTERN_MAX
 };
 

-- 
2.45.2



