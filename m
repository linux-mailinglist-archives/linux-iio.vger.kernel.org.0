Return-Path: <linux-iio+bounces-15701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A91AA385FF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00EBF7A1B45
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B75224894;
	Mon, 17 Feb 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp0InE1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE153224882
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801969; cv=none; b=RsG58gG5+evco5FS3OjdMFc+esVDCg8ElfpgeP5rSV1+CpzbxhBMyNUKdMLSgDMnBUsw8SyVvGGnyQuUjYLYgP4yR+HcLxlhgH3BsT5pHAklP6YIz3aWisaWCB5GxqlMhGUbgM5TxTOtuAqmpGhBPbeM4C+RTUAuJ28sbXRl7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801969; c=relaxed/simple;
	bh=FPoYjPbpXT295JyRgIuWbxFSN+OMkaJAqASunXDGbqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX0T5mN4eBKIqYpL5ifC7PiYZseosWG+hE4FXFjMW6GwTAWiO/r0Y2mN5bvXwNhjOULTycgQjfc0VNWbtVniXc1KfkQfgd4RXGCS7YLOB5TpBgLjwohg6vjV8dHmgsAr7gXzbetvZsV1TbUdt+px3ZuzJeFFqlrrawMFhzh9MaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp0InE1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10236C4CEE4;
	Mon, 17 Feb 2025 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801968;
	bh=FPoYjPbpXT295JyRgIuWbxFSN+OMkaJAqASunXDGbqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bp0InE1ZXbLOCyR866c7B46Nv4EQtajwEp3barzokx8qYyN2jOTNGPkqJWatRhmtm
	 bZTYYfIeFvt5CAhZ8ABo09Hbrz/hiZvpLvL95WIUia2DN7LxM6/67HWvagpYSb3iVA
	 zK/TCrA2HLhTyHsDRNcH22TAEQSc+XqJloB78NkjCah23/G589akwBETMxnNWaPZK2
	 JD5H2L7zfHEtoWzjBj6Z08qL7RtaPL+pf6H+IAgnYSHFL8oKE9vH44lDw6/0Dwvwtn
	 8FrNH7rF9GQNC+obp32O7QYlWIlLS0Ls6kOWi2ydqrD7aWd+s0niahAGmzgqsjsZKI
	 G6E4+98feJvzQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 28/29] iio: adc: rcar: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:28 +0000
Message-ID: <20250217141630.897334-29-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 11170b5852d1..221c075da198 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -199,13 +199,12 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		if (!consumer)
 			return -EINVAL;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = rcar_gyroadc_set_power(priv, true);
 		if (ret < 0) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 
@@ -213,7 +212,7 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		*val &= BIT(priv->sample_width) - 1;
 
 		ret = rcar_gyroadc_set_power(priv, false);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.48.1


