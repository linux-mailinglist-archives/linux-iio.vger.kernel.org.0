Return-Path: <linux-iio+bounces-7693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3F934E5D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB63C1C22AE9
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F6140E29;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbG531Ba"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DA13F458
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=BuMihlOjhMqC55MTU8XSxCp2G4iI5Ct7qJwdkbO3kwRZRlHb9hp/4w+fPnpCjQ1ybdAZb5x+wVmOXT6ZDg9/m8z5pCYSY2Z88+kYChIzGwvEsZUpp1bo4PSxzz1qODCJXVsmO5jkeFk9OOj5IBqJ58XSI4hlRBhngujyPyMB2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=UgKbxbF5c4DZY1lwDPltIP9kygl4/Xtb1kDsWdz8cPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHoX0eLloH7hsUkm/FgtE4hvJaf/gFJWaORqaKHS2W7ESZ33b2jiDtcVhgV3lSJEPK5zQjxslE4TQ3vg7N3+Eexp6nXb9TRWdmrKnyUtRps/G9kcgtyLAl6gKo0XizNcvAqGxGA/Je8Ng8XTL2lYcRI5agXN4AzD1Qp3cFpn4fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbG531Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31075C4AF64;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=UgKbxbF5c4DZY1lwDPltIP9kygl4/Xtb1kDsWdz8cPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YbG531BaH39xK4Kz1BcTJ2p6lhrAqsjW1xX+gj2Fs/wSwcvUPdUDw796sPZWnnbCb
	 bVtC1fvoVZ0lFobpMwLMRA/VsG8aChFQgiebBz0PSxs+Drj8VL3rVoIMQQBOoGOyfM
	 HeRj0v37EiNq+AZxd6QcsaHUoVcNbnahQZoZJ+CYBph/n8Dx8FXqMixFH1oDLaQPWc
	 cyQayAX0S6RgvYsT2wFmNntiGaFq/mW6CMogmrBgulD5Y+YfPCB7DyYdh3GvBQPuX9
	 6n9ZIW8SfNFhk0BW71kHKJSsatxXYmTCe/pkuHIJNg7RTplJHV+a5WcxoVAK6WczmU
	 Nf6G+GLgMZRRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED7C3DA63;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:38:01 +0200
Subject: [PATCH 15/22] iio: light: si1145: use new '.masklength' accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-15-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=1394;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ydCEkP8JsRVtoKR9bEq7QSVO3KXJv8WNwFnv2eEpBeY=;
 b=gZ6IUQPm0/RNFe4OkVKzRf1jtalaFetYLzAUqhSgt7EOB8gDOEdPWgEnTdO+raWTHyqKzp8pr
 e72dFK821ICCkLHVQj0FpYw962mT8CAa63j40Y2vxjthY6FmoN9f7SG
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
 drivers/iio/light/si1145.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 77666b780a5c5..66abda021696a 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -465,11 +465,10 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
 			goto done;
 	}
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		int run = 1;
 
-		while (i + run < indio_dev->masklength) {
+		while (i + run < iio_get_masklength(indio_dev)) {
 			if (!test_bit(i + run, indio_dev->active_scan_mask))
 				break;
 			if (indio_dev->channels[i + run].address !=
@@ -514,7 +513,7 @@ static int si1145_set_chlist(struct iio_dev *indio_dev, unsigned long scan_mask)
 	if (data->scan_mask == scan_mask)
 		return 0;
 
-	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
+	for_each_set_bit(i, &scan_mask, iio_get_masklength(indio_dev)) {
 		switch (indio_dev->channels[i].address) {
 		case SI1145_REG_ALSVIS_DATA:
 			reg |= SI1145_CHLIST_EN_ALSVIS;

-- 
2.45.2



