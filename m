Return-Path: <linux-iio+bounces-13901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35201A01AD7
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB653A2EF1
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C015CD41;
	Sun,  5 Jan 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2iyfiCN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653838F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736097993; cv=none; b=MgsLTlSEQNsOiAGOG7BQnE4lyp6feWNJklbX8Om4fIEwLAM3Xj7cL4eRXQTIL80VX0SIT/f2lOh5Pn3C6cAvsbh0pDMj5+JyGuWTFVCLdBiipEL+RNsVIvU01stouxwSXD8IfCkiMUwybrycirh0ynNEtHGDyu7/jr8XvznNx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736097993; c=relaxed/simple;
	bh=tXARHx0nU+EFgnfS5x8+8xk5+/ZqqRKljBqydqynMrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCxeqBtHfsR63U/CO+LUhIO00lirZqj/3tgYrcGcQm3cYvchKqGH3AEnidUR5KOGrING/WIJBr9wIVReeiC3bJsvZjNADLRvxlGwTVnfnAbI1dKNg1uTlCLKP2izGGcE5gi3yFFk5HI58g8MtyPA0vuCVATbXH+H7tlrA612E6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2iyfiCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020F1C4CED0;
	Sun,  5 Jan 2025 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736097992;
	bh=tXARHx0nU+EFgnfS5x8+8xk5+/ZqqRKljBqydqynMrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2iyfiCN5QTz+r+TXJXhj4Tf4BVl/4bw3/oSp5Q366uxKYAbtuyi5pZ5xPNzbuHkO
	 3eWjBKOf6Fmmk1aayG027L+1x6VvF7tfZZFAggQslV3VlOFTe/O6jYq/8v9A2YJqaV
	 k+2Oo6RCwdX/OgTG1L/715vK1E7ErAHiqUvdysBJr3KoMvvmbZUPbLglwamnG8CrkY
	 NmDQ6tTwlt3kC42LdyuL8sffBhpTDJOWK5zyAxTqFY+Ucr8n99e9tFz5wRI0l42Jn0
	 vXNVMtLcESjSdPsWc1zr/m4p5fPqBr7uD0vu7U3y8hnn6SFbjp8mXaE5xOfH+5mYiq
	 bQiajDomCsWug==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 02/27] iio: chemical: scd30: Switch to sparse friendly claim/release_direct()
Date: Sun,  5 Jan 2025 17:25:47 +0000
Message-ID: <20250105172613.1204781-3-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver caused a false positive with __cond_lock() style solution
but is fine with the simple boolean return approach now used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/scd30_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index d613c54cb28d..cfbf2f5e9443 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -211,18 +211,19 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 			break;
 		}
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
+		if (!iio_device_claim_direct(indio_dev)) {
+			ret = -EBUSY;
 			break;
+		}
 
 		ret = scd30_read(state);
 		if (ret) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			break;
 		}
 
 		*val = state->meas[chan->address];
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.47.1


