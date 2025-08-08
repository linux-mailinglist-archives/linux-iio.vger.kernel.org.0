Return-Path: <linux-iio+bounces-22477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7C5B1ECD5
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B2B5A00EC
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE4280305;
	Fri,  8 Aug 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqtWZIXv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0D1B423B
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669365; cv=none; b=Ix1k5+KMiM1vlJxvVUyeyDl0ZFai5DA9QCq3QNhvz3Iz4OUHKNGefUd1CCLER0AfkwaBMpMLKP3SbEz0bHJscs0QJg1ivdg8bZ3jl8/S3lIBAyszd10Kv3U0twMpaBse0ryIW/waa/s/JknWDsXMwucv6ln9R2GnjXEyjU8Qff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669365; c=relaxed/simple;
	bh=G6fmUJbwfcRM5pX/AL0ib/eCzkZNfZkvmAIbUJmLdzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bNcw+np0XOCJu9EC8r2F3nZVXMwONivpUmbajw/OwboraDrRcXW4uWXCPgsy2dd+tiTwdDL6o8eviAAmrcPUWXvO4dJM8BwH3qK0dLNEhdkZFMvk6pMkcS32kBWGk/7rRHDK/fKG1iyovyQ6/j+Fv4y6xxgzzZ45wibpQp/rZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqtWZIXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE4EC4CEED;
	Fri,  8 Aug 2025 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754669364;
	bh=G6fmUJbwfcRM5pX/AL0ib/eCzkZNfZkvmAIbUJmLdzM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pqtWZIXvJQS9Iy77HKSNwXp5w5AZE7OImOUs0c9QgZwAB8xx0FRVIfRTuOUnw9HnO
	 PcpBHhQqUMTvPfKwHbvXlFbf6m59NkfydvbLwUhoa03bJUepaWAFuwnKzvOj5dKUq+
	 npfnJNC8qXe33RvR81LF2/SUnBNyAR+NO2XveDonwViM6X8o4reRJli1IfxBn5vbiW
	 TGzPXP95Aygt3qFpW6qHUJsjGYGBJYF2apliV5kVUKnbYTEhxCVF1D1wUlo+MEXG5K
	 bCBVKdSknQLl2nLLEGE+Hu31f0O5Hsx18HvvJHb96dGiMg1/1FvWOBB2mCy6OyuVh+
	 toZ4N7h3vGwag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86919C87FCB;
	Fri,  8 Aug 2025 16:09:24 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 08 Aug 2025 17:09:42 +0100
Subject: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
X-B4-Tracking: v=1; b=H4sIAEUhlmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwML3cSUNBNjUwPdtMwKXeNUgyTLJPNkYxMjAyWgjoKiVKAw2LTo2Np
 aAAL/BKhdAAAA
X-Change-ID: 20250808-adf4350-fix-3e0b9b7c3420
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754669382; l=1975;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=cHVai96PjFNOGjoTgFHrKbrwRfCUNqOlh5ER9e9oWHQ=;
 b=ISIHb5W8ZRu5AH1W+JKS7aYmlDzKC4EFN2LtgPZ3ZRcxZaUJVW47FRWVrPfLnCocrhzwo8L9z
 vZf6B3SAg/HA9RyITswzWb0dukl0Y9IQp3pk97zl9P+IALzVuE63FAF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Michael Hennerich <michael.hennerich@analog.com>

The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/9.
When set to 4/5, the maximum RF frequency allowed is 3 GHz.
Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/9.
In this context not the RF output frequency is meant
- it's the VCO frequency.

Therefore move the prescaler selection after we derived the VCO frequency
from the desired RF output frequency.

This BUG may have caused PLL lock instabilities when operating the VCO at
the very high range close to 4.4 GHz.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
The Signed-off is because I'm just carrying Michael's patch without any
change from me.
---
 drivers/iio/frequency/adf4350.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 47f1c7e9efa9f425a4c7cf82be930234e2c18434..2b8b935965ed4536bda835844ed6c7d0a7b88330 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -149,6 +149,13 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
 		return -EINVAL;
 
+	st->r4_rf_div_sel = 0;
+
+	while (freq < ADF4350_MIN_VCO_FREQ) {
+		freq <<= 1;
+		st->r4_rf_div_sel++;
+	}
+
 	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
 		prescaler = ADF4350_REG1_PRESCALER;
 		mdiv = 75;
@@ -157,13 +164,6 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 		mdiv = 23;
 	}
 
-	st->r4_rf_div_sel = 0;
-
-	while (freq < ADF4350_MIN_VCO_FREQ) {
-		freq <<= 1;
-		st->r4_rf_div_sel++;
-	}
-
 	/*
 	 * Allow a predefined reference division factor
 	 * if not set, compute our own

---
base-commit: 6408dba154079656d069a6a25fb3a8954959474c
change-id: 20250808-adf4350-fix-3e0b9b7c3420
--

Thanks!
- Nuno Sá



