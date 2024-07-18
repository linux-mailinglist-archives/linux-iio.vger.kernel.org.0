Return-Path: <linux-iio+bounces-7681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3537934E53
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B21CB232AD
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7213E025;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWnNJkV6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F113D2A9
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309905; cv=none; b=mmZ3p8rGmmaZ1KhqVIvs+SHoN9yPjWuh+grOhGgX45G89qzkmYZ6F7+zGd3LAD8D+Jp9tgCZbIp8GMrwu7poIiKPRqAFd6Jn6mDb2zmvIY404ozbhk+8uLuoSuguTBYWrDFSpQ5fFKWMZMSP+Z69Rfu9RlPVp5LqWbL2mR5JP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309905; c=relaxed/simple;
	bh=5kYGH32Wpz/uNIl14Tu1KKxGLY+TV7PQmg1MnU82w+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUD19i3xY8nPTZ4r1VQSOx8Sg3CwwOpmD1Wh3JhnD7EzheVUGcc2ZlOK32OcYqdn+mFG4rmNFOb9f3V75W7gUfxKbF/G9fHTMChaz10DqJveMgfmT9gsb7znmU3NK+pBuRy9gUdAfI6LkaGwKQZsIXOXE3crHPF1WMcXfe53C8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWnNJkV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57539C4AF0E;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=5kYGH32Wpz/uNIl14Tu1KKxGLY+TV7PQmg1MnU82w+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IWnNJkV6jgW5kfHBb/zfXyBpcR88TDi67fbClQFA9rDZna0KJxzbGy3mUjJpUXh88
	 he2jvTuIB5lfoRE7qo5Zaa4lm+V5a56hzBd8ETR4CwpBJ4RSLK8+e7Q5QJlQeBA/3Q
	 J96dBBW/cHXV4keFMwxk43oyYclUDij7YrbhWmcK+e5daJbQt+zbQA0lYArOxlFJk1
	 deS9bHj7R1qVAy9MEunEf+fBbWjdM+MlLOKH/9duFKLsAjFNd8o4xrsVsOaqyN+EME
	 cGcnZ7Iic/nEPT1oeY93w212n2dxVntKdXsBdf+Tq1B8hjoBT1rsr2lgOJxbIuui2C
	 1cuZlcQi/GXFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D07C3DA6F;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:48 +0200
Subject: [PATCH 02/22] iio: adc: dln2-adc: use new '.masklength' accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-2-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=1702;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SVzVUJhUJEG0BkoeN3CF9y2OFfW7PnyRhClF65Q6WLY=;
 b=ZBWG1YfMAwcurvzBRn9mCDkOUHRVFtnp29Wq3GrNTMZpjHgzT1+Pq/XL4Q9LpOogmNRV8K5Np
 pVnbhPOzkJoA70sar1d44x+XLZD55Eipc2NeXWJ20r9v0YzIK9nB4XA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make use of iio_get_masklength) and iio_for_each_active_channel() to
access '.masklength' so it can be annotated as __private when there
are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/dln2-adc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 06cfbbabaf8dc..de7252a10047d 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -108,7 +108,7 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
 	dln2->demux_count = 0;
 
 	/* Optimize all 8-channels case */
-	if (indio_dev->masklength &&
+	if (iio_get_masklength(indio_dev) &&
 	    (*indio_dev->active_scan_mask & 0xff) == 0xff) {
 		dln2_adc_add_demux(dln2, 0, 0, 16);
 		dln2->ts_pad_offset = 0;
@@ -117,9 +117,7 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
 	}
 
 	/* Build demux table from fixed 8-channels to active_scan_mask */
-	for_each_set_bit(out_ind,
-			 indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, out_ind) {
 		/* Handle timestamp separately */
 		if (out_ind == DLN2_ADC_MAX_CHANNELS)
 			break;
@@ -541,7 +539,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
 
 	/* Assign trigger channel based on first enabled channel */
 	trigger_chan = find_first_bit(indio_dev->active_scan_mask,
-				      indio_dev->masklength);
+				      iio_get_masklength(indio_dev));
 	if (trigger_chan < DLN2_ADC_MAX_CHANNELS) {
 		dln2->trigger_chan = trigger_chan;
 		ret = dln2_adc_set_chan_period(dln2, dln2->trigger_chan,

-- 
2.45.2



