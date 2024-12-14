Return-Path: <linux-iio+bounces-13481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098529F215C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 23:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2530716608E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD761B4F3D;
	Sat, 14 Dec 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNfNm3e1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9629CEF;
	Sat, 14 Dec 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734216966; cv=none; b=rrrRJ4lSkdMvm4FZczhy42e198WIi6gXl0/FFxI8+PbZtlsAQU23hAjcEaRA0O9gWZmVpsh520MGdSmejvdWIT408JhnwDcb12UhcAFc2UmGKbzBoCDfkG/tUwQWNx8GpgzJQbe7FqgdrvlOitit/Xs8rGMXA3yQ1WiO4Uz+5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734216966; c=relaxed/simple;
	bh=BgCbCgnN6Io4CxvOgNBg12hpP6R57z2ThGYb1vcaWmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TNzAWvR2TnOEgzlqiLzR+iPgNRQGkUyS7EsdA4L0tj6+cb/n92mZeV1DJuXDI7hpjp6rArXiMYyRKDz5jyxJ5IvZepDM9xi73gMPuDv2WBDVYrCl2bL2H9xfqW7+vHDvX3Da1d+k7AJKMMN+HZle+kazgVNTKvyg9jsfOJeQVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNfNm3e1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so31900655e9.0;
        Sat, 14 Dec 2024 14:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734216963; x=1734821763; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9JU+pXn4uJOLQy6qorVJZGNm9FKTMEhW5Kr8WecGYk=;
        b=WNfNm3e1SA487GiYxWyXqvQROL94tCRj+461JYebglPDELzkvxJCLPp7ED/NogrLdP
         TOqcrPvO4W49axR/P+VeHqHfhGhWTSodnSQZO8jv0BHnukFzJJjcVAwjyzIULhoAc5ZJ
         YYxxc6nN6rewMZbp/rwzx5IE6fR5YLnSC2VaAD4+2i6mB6965V+q7GBgEvVRP9/GYNwl
         jgZV3nYLIcPbz9nZ+HxY74VSl9St/p9UMBFW91n5KUPU/W8iMYwUP7DOPqUFC+/0Uk6n
         V3vUVh5a/o6L3dT2aNYw6j04vyucaQDXPEsTK23k2aS6TLTjnN+H9wiPzxyIDTlG6ea2
         oi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734216963; x=1734821763;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9JU+pXn4uJOLQy6qorVJZGNm9FKTMEhW5Kr8WecGYk=;
        b=GmpSlu4ppgA+DuChLIqSyBT9o4X3B/kFq4/9Om+Ip/A37ST5XGZxwUZUeJ1PNRFTmq
         TRY8BaPdkydYTEcH+REayZ4jngjVeS8N9U6Ic4TQJC08tl2qyTbInNcGXJaOxnIlDWt7
         agDlwoNCefs8CpY3ay4Tg0tGb439aRd6p6jqIuPesnTAcGLpoi0NRH4Vr5YPhKYUDeVg
         vxmka3LT+eVj8pmV+nKag78K9yXBrdnw/JUsmqhAV2VdKxYYHcrik6a8cJldWhW91OkC
         imvoKVMMcJAwcWzvL8gqQ6ji3H4kYAz3FTlR56I4ax/hiHuvtA4dxm4Nj+7HFMa8jsvG
         buaA==
X-Forwarded-Encrypted: i=1; AJvYcCWB0jNKmbFEJ9R+yv3VBZJtWVoFWatMOiChoUafUxVgg4CRQJU/9Nj4/gSKGHOZFtXV6vINTlL2@vger.kernel.org, AJvYcCWaL+1pXMK4J4U0n6W0lYYuIcfVySv2ijc3b8TIG98JA8Q/efa0FCkqs/cQJaFg8St8pVcUGpODhm9wWzWy@vger.kernel.org, AJvYcCX5zlwAfeDWXgPTIlnbJbyDbBwPRaRy1e5x2MCrHxlCoF4jt1v3t58hxOwIxHnKA/iIauc6NdFopRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1H3gc8+Gz05yrNiMFB0cwaD9/+VRnuswQD+4pzWty5wtuNJL
	LRmK5xSciDbquwfzGhuPIBt25owSy7dutELF+z+5Q6Lz/0srnwoQ4BWcFg==
X-Gm-Gg: ASbGncu+MsKPmVkpHWPz3wSV3RFalTFvrlVGMU2SrkPKLNk3RSAiMt5C+qJTiVhPSjJ
	XWIMtSE04piOlrbv71b8mnrpzbnMmSvU5ED74DKB3BBS2V7WNjiZoy3MhwoU4/jbLBxToMkVNFt
	fA0g0truIZwOT/LBjfLRU/qD2IzdRqBTbfUiryPhU2g1bhgvRDTuGyLd1vUaL6ozuLk34c1jv60
	40yDMJkXNtQ0GLuWdQWI0Yq5/uVlHnWTvJvJgCZgWo/3FmRTseZhVqFRXKlJULOZVH+3TUZR/hk
	ijaQe/MNwywEdAql8wmssLhuguxjjT05jFn7P65SOMiHnKtuG1myMCcKjPk3ledEKrsUTs13dt/
	w4O0=
X-Google-Smtp-Source: AGHT+IHCeumqiTzMF+lPxExwd2Ef1dUuNPTo6DmvjZ2sd9qx99lg8zhxRvkRPaBhtllcRRpRox3F+w==
X-Received: by 2002:a5d:6c63:0:b0:385:ee59:4510 with SMTP id ffacd0b85a97d-38880ac1cc1mr7114757f8f.9.1734216963014;
        Sat, 14 Dec 2024 14:56:03 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3d12-6927-e558-75f6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3d12:6927:e558:75f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361e3406b3sm64795995e9.0.2024.12.14.14.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 14:56:02 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 14 Dec 2024 23:55:50 +0100
Subject: [PATCH v4] iio: light: as73211: fix channel handling in only-color
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-iio_memset_scan_holes-v4-1-260b395b8ed5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPUMXmcC/3XN0QqCMBTG8VeRXbdwZ3O6rnqPCFnzTA+kCydSi
 O/eCqIIvPx/cH5nYRFHwsgO2cJGnClSGFKoXcZcZ4cWOTWpGeSghADJiULdYx9xqqOzQ92FK0Z
 udSkrKdEbCSzd3kb0dH+7p3PqjuIUxsf7zSxe60csNsRZ8Jzn7qLRVE1lCndse0vXvQs9e4kzf
 BXI1ZYCSZHeKFEYsKVu/hX5owjYUiQXvPTK6Iv2JQD8Kuu6PgGdAZJORgEAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Christian Eggers <ceggers@arri.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734216961; l=4603;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BgCbCgnN6Io4CxvOgNBg12hpP6R57z2ThGYb1vcaWmg=;
 b=l+t4MypCOkhcCU5tVVVrmshL3+4W6g5PhmzU5CKJ0NrgJD9ok6I6tjfXIZxQrlsGGVxfq0Nha
 jDDLUWQtCslB48Pl6+ekW0J3ejQ9Z2IDGEKvAc3Y+XDj3eI1rr16EKK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
set (optimized path for color channel readings), and it must be shifted
instead of leaving an empty channel for the temperature when it is off.

Once the channel index is fixed, the uninitialized channel must be set
to zero to avoid pushing uninitialized data.

Add available_scan_masks for all channels and only-color channels to let
the IIO core demux and repack the enabled channels.

Cc: stable@vger.kernel.org
Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Tested-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This issue was found after attempting to make the same mistake for
a driver I maintain, which was fortunately spotted by Jonathan [1].

Keeping old sensor values if the channel configuration changes is known
and not considered an issue, which is also mentioned in [1], so it has
not been addressed by this series. That keeps most of the drivers out
of the way because they store the scan element in iio private data,
which is kzalloc() allocated.

This series only addresses cases where uninitialized i.e. unknown data
is pushed to the userspace, either due to holes in structs or
uninitialized struct members/array elements.

While analyzing involved functions, I found and fixed some triviality
(wrong function name) in the documentation of iio_dev_opaque.

Link: https://lore.kernel.org/linux-iio/20241123151634.303aa860@jic23-huawei/ [1]
---
Changes in v4:
- Fix as73211_scan_masks[] (first MASK_COLOR, then MASK_ALL, no comma
  after 0 i.e. the last element).
- Link to v3: https://lore.kernel.org/r/20241212-iio_memset_scan_holes-v3-1-7f496b6f7222@gmail.com

Changes in v3:
- as73211.c: add available_scan_masks for all channels and only-color
  channels to let the IIO core demux and repack the enabled channels.
- Link to v2: https://lore.kernel.org/r/20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com

Changes in v2:
- as73211.c: shift channels if no temperature is available and
  initialize chan[3] to zero.
- Link to v1: https://lore.kernel.org/r/20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com
---
 drivers/iio/light/as73211.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebb..11fbdcdd26d6 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -177,6 +177,12 @@ struct as73211_data {
 	BIT(AS73211_SCAN_INDEX_TEMP) | \
 	AS73211_SCAN_MASK_COLOR)
 
+static const unsigned long as73211_scan_masks[] = {
+	AS73211_SCAN_MASK_COLOR,
+	AS73211_SCAN_MASK_ALL,
+	0
+};
+
 static const struct iio_chan_spec as73211_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -672,9 +678,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 
 		/* AS73211 starts reading at address 2 */
 		ret = i2c_master_recv(data->client,
-				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
+				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
 		if (ret < 0)
 			goto done;
+
+		/* Avoid pushing uninitialized data */
+		scan.chan[3] = 0;
 	}
 
 	if (data_result) {
@@ -682,9 +691,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 		 * Saturate all channels (in case of overflows). Temperature channel
 		 * is not affected by overflows.
 		 */
-		scan.chan[1] = cpu_to_le16(U16_MAX);
-		scan.chan[2] = cpu_to_le16(U16_MAX);
-		scan.chan[3] = cpu_to_le16(U16_MAX);
+		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+			scan.chan[3] = cpu_to_le16(U16_MAX);
+		} else {
+			scan.chan[0] = cpu_to_le16(U16_MAX);
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+		}
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
@@ -758,6 +773,7 @@ static int as73211_probe(struct i2c_client *client)
 	indio_dev->channels = data->spec_dev->channels;
 	indio_dev->num_channels = data->spec_dev->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = as73211_scan_masks;
 
 	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
 	if (ret < 0)

---
base-commit: 91e71d606356e50f238d7a87aacdee4abc427f07
change-id: 20241123-iio_memset_scan_holes-a673833ef932

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


