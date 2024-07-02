Return-Path: <linux-iio+bounces-7150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECD92430E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1261F23209
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67581BD01E;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bemJDZw+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124D1BB6BC;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936159; cv=none; b=ZsN4WDlo/Ih/oM3Nbcir1cgpy2PKWEEbnrVr2mn4O0LymPg1pkmYo4gXnb8OptP+tG0E+7Bav3xloIMzG47pDJfVaeVdOe7lxc1TQ5UfuzUnRAYq9GeHETGgV2JpHSRr9adUJNEkBQxdlZ1tYF38ZCbC3Rvnx8JkyetETRxxp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936159; c=relaxed/simple;
	bh=X9U2RqNBvqNInuBI9oKZcFsFepJn/tehK2K25jnqvTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHZKuUw9KiRHZXjySw5bazix5uCKcUHtUza16YrCWWaQwW/P1O0bnHeWepacmIwBFbL3w1hzQANeIhfqiW1dRCKTbkQgtzJIbDXxtYXPj9nR6tWb+9x7waUq++7oqEFj3k/Xhi1/K25BIjP0O/4BXd2XCvpXQjd4gu51njZkFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bemJDZw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13677C4AF0A;
	Tue,  2 Jul 2024 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936159;
	bh=X9U2RqNBvqNInuBI9oKZcFsFepJn/tehK2K25jnqvTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bemJDZw+qLgJsnubBLLySuI0flI8N6XRBymD0l44shxoUyB4GuQnbBCWOrXjkP/mN
	 ezzakjbZWke3Dg6HsD380rRn3XK0SGdBoKriDScl2wxZRbDBgDvjeqqNcq3PC+X2fx
	 DCT+GuZECD2BlIdX2fIxz4FDXl7HJ8A6faOlVARtKNQHIEzxtUjg5N92mG+BMwcuTg
	 70Htz45XYPEfb6LGZfVE5GSQ/OxV+WQzwvmRExHJsZoFa/eQ+O5qIlTfeEVhIv/AV3
	 1QBrnf5NkklVwIf41REFxGym/7LEGqPdbFyScqXH5XhtkXHIbrtkXJKKZj3u1gnPC4
	 UDjtuJkjcZNvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF8C30658;
	Tue,  2 Jul 2024 16:02:38 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:33 +0200
Subject: [PATCH 01/20] iio: core: add accessors 'masklength'
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-1-98193bf536a6@analog.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
To: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936156; l=1677;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=EA7SSU5JCACZ9RbuyelW015qMw9c7NJ9Gp/LUGrm0oI=;
 b=WOeC8On1W5DCuG3LfamYH01OA5F0KKWMc0DWI3AWAeSbOQx46FElbbhV4CKkRfZy3+gYMQqWC
 lf31gWkzbbECs1Z5B21bh3N363YaVGrn7aRYnhS2HeqXObSmuYw+cFY
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

'masklength' is supposed to be an IIO private member. However, drivers
(often in trigger handlers) need to access it to iterate over the
enabled channels for example (there are other reasons). Hence, a couple
of new accessors are being added:

 * iio_for_each_active_channel() - Iterates over the active channels;
 * iio_get_masklength() - Get length of the channels mask.

The goal of these new accessors is to annotate 'masklength' as private
as soon as all drivers accessing it are converted to use the new
helpers.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/iio.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 894309294182d..dd6bbc468283e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -855,6 +855,24 @@ static inline const struct iio_scan_type
 	return &chan->scan_type;
 }
 
+/**
+ * iio_get_masklength - Get length of the channels mask
+ * @indio_dev: the IIO device to get the masklength for
+ */
+static inline unsigned int iio_get_masklength(const struct iio_dev *indio_dev)
+{
+	return indio_dev->masklength;
+}
+
+/**
+ * iio_for_each_active_channel - Iterated over active channels
+ * @indio_dev: the IIO device
+ * @chan: Holds the index of the enabled channel
+ */
+#define iio_for_each_active_channel(indio_dev, chan) \
+	for_each_set_bit((chan), (indio_dev)->active_scan_mask, \
+			 iio_get_masklength(indio_dev))
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,

-- 
2.45.2



