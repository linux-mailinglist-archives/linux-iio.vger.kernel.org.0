Return-Path: <linux-iio+bounces-5276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A95F8CEAC0
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9444B2166D
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805B74427;
	Fri, 24 May 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vV1Xlu3p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA846542
	for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581902; cv=none; b=htadLmdkd8EZ9It16HUXlg6it2PZTyLqvNv/HMbG0tZ5omw12yQUzGAlthuvgxr6m85iF0Or5CW+Lcbh6iC6nvV2oYp+CPAntJYVOojYxJEFGGhOC/+iBt14V/szYSbi05WA17OlUeQ76Gu1UZn4idYtJk2kFfrQ9AYrRqgwcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581902; c=relaxed/simple;
	bh=eU0+2iBlqKN5TWgM1ZRRGbn4eWxUd48oagKUQKm0a2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/0zV4kgm0iwuV9I4ur59DvY3OHuHhhq3WwyPaWjgxZnygOU0hzAzwx+Js1hAzECRixKegP9yTW7gcMTR9xuJtGPJL/QWikFn9qvLY09JYcr8JYcLeLMM00ScmMHxrbOgSreWIBVwIVwqLCqZDPKdad+FVjQdPlbnTbWKADZ/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vV1Xlu3p; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9817a135aso15239eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 24 May 2024 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716581899; x=1717186699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pupJ0zX8Gz4rIa61ZbX42+dQviT6t2wR9g3cWXQmpmY=;
        b=vV1Xlu3plTJ7qyvbis7eF6SGYrHyEI/C4crImH5d1nhQ84EoOOpHuaOivkTxjDxH74
         gOQRQZ+Jkea3Uhp3tINEZ5JzTrkcGW8yppjhjnA11XW/hwx5qcf15KMQsRjtEOX6quIU
         y6fRPyEA5u/FBYPVqtyXnrvr2KG6+TvNrmOoL2JAmNP+vo302btab9NBKCcMHoCLh5jz
         ox5/ry4hslr/ZolDGdAK0V/3qD/4sWvj7DNb8lxalbRzFcfWMtOq1nhukPV2fLnXdQv4
         OuNFMozkbur7gT6hAmx9QX/x6QN6WsRaeZOgpL/i4fVvzVoX4KJGDV2PjRP0h3ZHAE8V
         H8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581899; x=1717186699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pupJ0zX8Gz4rIa61ZbX42+dQviT6t2wR9g3cWXQmpmY=;
        b=kSvgmMtQReTBCxx8GKuegFwq1pfYMDSyndtPR4TPxgJPGYKTelJwzicKaSqR0P3JGb
         thgp+jWJr6cjtYM/pTvkfe3tVbbcryDvuySP50Tux6FC5Cot/qF1fWZnweHPgV+ut8fD
         FWx0XsoFERWBTX2Sd1c0LFhRatQo5qOtNir7D+a87sSlkrq2z2tAjXkaWK/m7am5FBya
         6++Ik2AsQF22POIti4n4GwCncqFLydhuTBS+bRqvUbHWzR9OPjtgPfFee0lhGqv8hpxv
         SJg7XEl03QKhqseK13CPtV8SIvKrxjS/PvlyMW020oVuu6tg+4eGxBbDF6ay26/Btbx8
         BD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrTWvSNWJ0r01YKd/Lid4teI1zPgxOgTQ70eZGVhl16LimVjSZLTy0Dj1cqqPg2n1NChuxWgvYGpohvbN5mzru29die2AIvn6v
X-Gm-Message-State: AOJu0YyTcz2GADLn+SARxI1cH3kgDB9Ooc9+4O0O+uXehhESh4tgrNWF
	0oSrCdxR2Ip7mQvEn5R+gsEPydVYVdaIyOFug06YXt9XKR7LiWHGYx1jS0a71G0=
X-Google-Smtp-Source: AGHT+IHSCklJR+QvpB+nBZa7D5RN+L/XEcvrpg4e2IPoWqNA5iezNgR3a6t19KbxWGvWM5hZCpJ8vQ==
X-Received: by 2002:a05:6871:5810:b0:24e:6d33:9e26 with SMTP id 586e51a60fabf-24e6d33a0eemr1842132fac.15.1716581899115;
        Fri, 24 May 2024 13:18:19 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ca2840481sm516737fac.57.2024.05.24.13.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:18:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: buffer: use struct iio_scan_type to simplify code
Date: Fri, 24 May 2024 15:18:08 -0500
Message-ID: <20240524-iio-add-support-for-multiple-scan-types-v2-2-a6c328fdfab7@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
References: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

By using struct iio_scan_type, we can simplify the code by removing
lots of duplicate pointer dereferences. This make the code a bit easier
to read.

This also prepares for a future where channels may have more than one
scan_type.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
* fixed spelling of dereferences in commit message
---
 drivers/iio/industrialio-buffer.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cec58a604d73..08103a9e77f7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -366,7 +366,8 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 type = this_attr->c->scan_type.endianness;
+	const struct iio_scan_type *scan_type = &this_attr->c->scan_type;
+	u8 type = scan_type->endianness;
 
 	if (type == IIO_CPU) {
 #ifdef __LITTLE_ENDIAN
@@ -375,21 +376,21 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		type = IIO_BE;
 #endif
 	}
-	if (this_attr->c->scan_type.repeat > 1)
+	if (scan_type->repeat > 1)
 		return sysfs_emit(buf, "%s:%c%d/%dX%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.repeat,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->repeat,
+		       scan_type->shift);
 	else
 		return sysfs_emit(buf, "%s:%c%d/%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->shift);
 }
 
 static ssize_t iio_scan_el_show(struct device *dev,
@@ -694,12 +695,16 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 					     unsigned int scan_index)
 {
 	const struct iio_chan_spec *ch;
+	const struct iio_scan_type *scan_type;
 	unsigned int bytes;
 
 	ch = iio_find_channel_from_si(indio_dev, scan_index);
-	bytes = ch->scan_type.storagebits / 8;
-	if (ch->scan_type.repeat > 1)
-		bytes *= ch->scan_type.repeat;
+	scan_type = &ch->scan_type;
+	bytes = scan_type->storagebits / 8;
+
+	if (scan_type->repeat > 1)
+		bytes *= scan_type->repeat;
+
 	return bytes;
 }
 
@@ -1616,18 +1621,21 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < indio_dev->num_channels; i++) {
+			const struct iio_scan_type *scan_type;
+
 			if (channels[i].scan_index < 0)
 				continue;
 
+			scan_type = &channels[i].scan_type;
+
 			/* Verify that sample bits fit into storage */
-			if (channels[i].scan_type.storagebits <
-			    channels[i].scan_type.realbits +
-			    channels[i].scan_type.shift) {
+			if (scan_type->storagebits <
+			    scan_type->realbits + scan_type->shift) {
 				dev_err(&indio_dev->dev,
 					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
-					i, channels[i].scan_type.storagebits,
-					channels[i].scan_type.realbits,
-					channels[i].scan_type.shift);
+					i, scan_type->storagebits,
+					scan_type->realbits,
+					scan_type->shift);
 				ret = -EINVAL;
 				goto error_cleanup_dynamic;
 			}

-- 
2.45.1


