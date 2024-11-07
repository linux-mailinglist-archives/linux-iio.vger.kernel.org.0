Return-Path: <linux-iio+bounces-12002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419FF9C0E29
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CB2284B40
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CA221733F;
	Thu,  7 Nov 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOmM44yo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD752170D6;
	Thu,  7 Nov 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005878; cv=none; b=tLFHAh8kmHr1NA712UdHKVX5Bxh16sQTBG6X39bxDtFDpTTjezQ6/WWcwt0N7NR67J3NpwqvML9/CRX0UOd0gnXyU6l5XPt1gvi898QEEDCa4EeP5uAHLPx/fyJ47RjH0pfp0GeoruvaduEGMktZI19s+4EhlvpR6FoA7GeorLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005878; c=relaxed/simple;
	bh=1td9xftETZA1A/qAhMIBTQDxbkGUWl8Wbp9i68K9FIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gyhou0Wrxl+PI+aBBRG3TZ0CTE/UBj3B9s/Lw7Snm4AyJsF9DTYpgT3nkszNdEkvXVi1pE3cUgrsSBDGHymtt6f5UPv62ySwyeKjI5nm17igvNUctIOLeRD0AbPEcOGneJ5BXvj0N1Dx3Iyiwo0ZKvgksWFS8Vh16bFkd9LW1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOmM44yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EB7C4CECC;
	Thu,  7 Nov 2024 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731005877;
	bh=1td9xftETZA1A/qAhMIBTQDxbkGUWl8Wbp9i68K9FIU=;
	h=From:To:Cc:Subject:Date:From;
	b=gOmM44yolyFhePX18nvwVpjXpKB+sxn/IzdYyUmK+c9Bm0tPOssCIDESBj2SzRgd8
	 wD/h+TaWSYoP8qK+4uwPQoZJAvNnCArN352rXgAyALvxCD+psd0iVCTAMd4YgIUyA+
	 lFYUH8M2V0JYqqoUh72AG/FBP9VelBfg0Yd6RtDn9yXRcGKhstvkOxMzl+Cj3fYEWp
	 9Q20CqmueUXWCXO1TeBSJEtjpPfb7W7HWLNtVWnt5eFIkGG2TF626r6uw1I3fwtE7i
	 Ibm++3Mtnyf538+IjJ1sf0jCVHi8OPT6owgCEsyXW4o9z0rHed8CMukyZnvTS8Xq7v
	 XmFmP/eEzXegQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: Move __private marking before struct element priv in struct iio_dev
Date: Thu,  7 Nov 2024 18:57:46 +0000
Message-ID: <20241107185746.138146-1-jic23@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is to avoid tripping up kernel-doc which filters it out before
but not after the name.

Fixes:
./include/linux/iio/iio.h:628: warning: Function parameter or struct member '__private' not described in 'iio_dev'
./include/linux/iio/iio.h:628: warning: Excess struct member 'priv' description in 'iio_dev'

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 The alternative is tweak kernel-doc. Given it was inconsistent with the
 other __private entry anyway I decided to do it like this.

 Not already applied and pushed out to squash the issue in linux-next.

 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 59c58f455311..3350162f190f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -624,7 +624,7 @@ struct iio_dev {
 	const struct iio_info		*info;
 	const struct iio_buffer_setup_ops	*setup_ops;
 
-	void				*priv __private;
+	void				__private *priv;
 };
 
 int iio_device_id(struct iio_dev *indio_dev);
-- 
2.46.2


