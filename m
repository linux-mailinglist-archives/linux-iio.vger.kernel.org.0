Return-Path: <linux-iio+bounces-16922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B6A63953
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 01:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D132E188E218
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 00:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161A286A1;
	Mon, 17 Mar 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft8Qyowi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D81F941;
	Mon, 17 Mar 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742172938; cv=none; b=W7tKlLRG/p/rFp8w17T7V1zTjKhtrcKhlSSjYk41DkS4g3iYUIZ3U1Mb4Dg0Q2H7nAlZH7RTIz+trze0L/qhwT0f2fhilzM9NL0OosacFVn+iiX5CMHrZd773EnnmxNDOgrFBQvdiWywpEF2ks0ALNsOvFSD0C+8fhLC+saI5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742172938; c=relaxed/simple;
	bh=PVgQzkmryWOb7mXmc9/WhWRNe5ZnnKuIEC0s4BOLFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NxBQZPfguwuuNTC5ZkiOZyi0MBT+01fNYRluuHyG4IWuwD5KfPlgHDT+QictF+rwb/OWyDQPSH6+5zAtynooC6tCWqXoC7/r07bDwsRu6PPv7feN2eJz8e2yQcYgcI+4bY7QoZhafcAKR7GaMD/UZiW+oZ0dViSp6iek2HsLf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft8Qyowi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1974C4CEDD;
	Mon, 17 Mar 2025 00:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742172937;
	bh=PVgQzkmryWOb7mXmc9/WhWRNe5ZnnKuIEC0s4BOLFcA=;
	h=Date:From:To:Cc:Subject:From;
	b=ft8Qyowib5ZlMK+kXV4IOprCs2RVIN2uLX/adDWp8X919Xzag+w6mLSP2sl4IeGCM
	 +Is1pk8ee85Z2oZo/OEmOp6+jyuEbTYGkXZCA3Z6L4scuzVkXoPTYpd29n6TI3LHo4
	 ZgjaRIjWVcoGFgTSnnNBaC61p2owgl6fCGDbKjcPLpWt2u42Tv9+jUwIEWRBzV3vDG
	 e2A4Bymgz93Z6Y6lVUGOi/nVVjtlNljwUbgE6mLQePupai1OKmce8ffSXY9BdAJ5Ck
	 cIKrl6LDwMeDWIP3/O1XFJeSeYomWl8aLR56Gle2iMd+/js9XyOHZPahx5e+xqNWVU
	 6ZPtpQghrI3XQ==
Date: Mon, 17 Mar 2025 11:25:40 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] iio: proximity: cros_ec_mkbp_proximity: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z9dzDB1gttXehYGO@kspp>
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

This looks pretty much like the following patch for RTC:

https://lore.kernel.org/linux-hardening/Z9PpPg06OK8ghNvm@kspp/

Thanks

 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 667369be0555..4fe3d84e2729 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -59,16 +59,10 @@ static int cros_ec_mkbp_proximity_parse_state(const void *data)
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
+	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data, sizeof(u32));
+	struct ec_params_mkbp_info *params = (struct ec_params_mkbp_info *)buf->data;
+	struct cros_ec_command *msg = buf;
+	u32 *switches = (u32 *)buf->data;
 	size_t insize = sizeof(*switches);
 	int ret;
 
-- 
2.43.0


