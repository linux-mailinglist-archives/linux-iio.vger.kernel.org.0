Return-Path: <linux-iio+bounces-17016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A054A670B0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 11:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B550A3A9A6C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6AA2054F1;
	Tue, 18 Mar 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et6Az3ud"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8513FC3;
	Tue, 18 Mar 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292064; cv=none; b=A0wPKwmfrgo68RltrQprSIHgbI/RCyJdQ5XgcvVVictgHd7WOxc1qoF3bqQK8WIPxltlKt4RNV3UZ7ng5nd/rSDJGd71w8SVY62tdHH7y9GOfJGTGmASUF7Nb0ury0xZg4YLKnGJqufxLz531YHMLkMjsCJFo7QwHXNmkfMZ94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292064; c=relaxed/simple;
	bh=tt3Nu4a7fSE5kL5LsQ+x0JD00Jc5aMTc6CLr+Hbgmms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K1NPCydmkN/wz6r58ckU3sn1DxztSwDVBAsvr92bK0V+J8wQ5UVAkBHBO72WijX8AOYHpVHCSHNv3Xz03qE4lk5zi0PYLq/aUXZZCK12A5P8gotQa5nbhwRcu5W9UpvfJsvXI7PDgn6qV59b9hBz0XFsaiNtwN+2Wtj+17Cyz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et6Az3ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACE2C4CEE9;
	Tue, 18 Mar 2025 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742292064;
	bh=tt3Nu4a7fSE5kL5LsQ+x0JD00Jc5aMTc6CLr+Hbgmms=;
	h=Date:From:To:Cc:Subject:From;
	b=et6Az3udmz4Mz657jl3MASizJt9x4k4sbiXaZrJMLBVdWl3EJXskHIiACfubDovzm
	 /juqTtALTBRanx7nCHMVAUyI8PLAgNSV+2ZczK2ht/eefJGF/a3Wq04WVlL45b2LC7
	 sCr83n5QYB3PkKiBWZbihUWFjUvPxfrXuk/wO8GLeWI+kpvNrNZOIGf6a5Id+OOMgV
	 NSC8vrVZvuoi0Z5pW+vQiXaIsfiX5tMGgLcyofxeuNsXQNOx+9TSnvskK4MIiLlcqb
	 sTEmoCFyg3+y9j9iCG7B3mlWIcOTUl23G8W+ExcneG41j/fF9JTiTgjcKrckORRqN7
	 6kTeB+MdugmGQ==
Date: Tue, 18 Mar 2025 20:31:05 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2][next] iio: proximity: cros_ec_mkbp_proximity: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z9lEYdPPIyiRGm36@kspp>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/iio/proximity/cros_ec_mkbp_proximity.c:63:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use MAX() to calculate the number of bytes for the flex array. (Kees)

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z9dzDB1gttXehYGO@kspp/

 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 667369be0555..d2ddb7d45ec2 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -59,16 +59,11 @@ static int cros_ec_mkbp_proximity_parse_state(const void *data)
 static int cros_ec_mkbp_proximity_query(struct cros_ec_device *ec_dev,
 					int *state)
 {
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_params_mkbp_info params;
-			u32 switches;
-		};
-	} __packed buf = { };
-	struct ec_params_mkbp_info *params = &buf.params;
-	struct cros_ec_command *msg = &buf.msg;
-	u32 *switches = &buf.switches;
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
+			MAX(sizeof(u32), sizeof(struct ec_params_mkbp_info)));
+	struct ec_params_mkbp_info *params = (struct ec_params_mkbp_info *)buf->data;
+	struct cros_ec_command *msg = buf;
+	u32 *switches = (u32 *)buf->data;
 	size_t insize = sizeof(*switches);
 	int ret;
 
-- 
2.43.0


