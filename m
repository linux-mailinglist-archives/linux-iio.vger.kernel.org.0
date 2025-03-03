Return-Path: <linux-iio+bounces-16375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AABA4E96E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF114200D5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33724EAA6;
	Tue,  4 Mar 2025 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kvg5Dv8q"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B624EA9C
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108147; cv=fail; b=G2sjCZne8PzolM/II+Vf2kAnepCe4LXcuwK4HVzWg6O3TLnqI0flN7Yaqjfn2xzP9pc4m6QUrBm2TYDlsRPUj5C4wCOe9NsLvyiQBKtqIASi9iDiuSLqHR9izEHoUYBLmr20KjjvM8nygNHMTdM1vBXG4FYADLsjtrdoe5nBLOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108147; c=relaxed/simple;
	bh=2A1KFUvcEF85ppqZEKPsXV0POtDSgcS99PzQXoNwOco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSG8YJaxp2u3yXoI4dEvtm4g0YP96RG6gW+BjT4lAGYJQhiPOKsSpsbYiNvMBRgwct3EgchMG+CIwPzVEf/CkDa/piqJNeOZ8qqTj5Ru41/DBGy8u6rI0dP9whNfhlzkRxkT6hXOblnVWXu+8CSuA0YyhCXdQ5cIlMFzOD073wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kvg5Dv8q reason="signature verification failed"; arc=none smtp.client-ip=209.85.128.46; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id A27004089528
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 20:09:03 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Kvg5Dv8q
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dCL0pt7zFwNx
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:21:18 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7AAF842721; Tue,  4 Mar 2025 17:20:55 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kvg5Dv8q
X-Envelope-From: <linux-kernel+bounces-541624-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kvg5Dv8q
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 090DD42949
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:52:37 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 68F1B2DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:52:37 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D233B16C2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044220E333;
	Mon,  3 Mar 2025 11:47:58 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0020D500
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002472; cv=none; b=WRxUVvAd2SwhnXQX8lVw+HomoDNkZJngiARk5M9djI1iHoeXRFX4GpdaPUH9Z7HdZ5dbXkA7aZtXGV++jcpUuJWnwpx/dgViCTNfH1sOTShXGvwWqsl4FL6sK+DmezJ1SQNV8AKbPUFv4D4tbGOFR0V4o4Qqx+atDzbn/Se2f00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002472; c=relaxed/simple;
	bh=f5oXDYngVLmmeCgw3m2NxlkPSjJDX6EDhYcIJAY4bHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hB5yZrwQv6Y/UTxz7wl2OSjMKJ9YewQTtXq1AA30MqmZx3KIS6ZzF4bGqS1dmQ/ijqKy5+cJPlkJ3xN2uFtszMRhlTt4ch7lsA5HIUHW3yuIBqGL7PSYDsCa2YUVc6Vf8IyQqG6lakiGtLKdxQ+aq+P6nr9Nl3yU3GPofYqjxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kvg5Dv8q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso3792025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002469; x=1741607269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oStMvILYc+VcE0Bos6wZo8DhR0OCDR8DIF2cp2zAmw=;
        b=Kvg5Dv8q27F+9fY4+9dvP9nw5dxD/T/cY1xeQpvnMGjlAq+1RCNalf+3aP1HYkxQEh
         WXD2FrvxELzuGwye3gSljMkPK6xi8cfTLdWfNmWKDS2azpxpKRd7833kDc8cOyUe3u2z
         zKEgL2KYqdHrqKAC5raBrIWNmAhQR2SV/Eiectu0Wjvf2xjwUViwPWMsptHGWPa2Md+V
         ui+XdMwAwgC1WxVVNhijfF4Y909WTBbXXGsuFRLvtz6zVTrCmAm6SccUa+5h9y4IlNRa
         MLz6lmX+HqIhAKgcgLs3v/DtSl3tKlMUpF3vjidw51ki3E105Li8HwNM9ptw9dsz5RkB
         BtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002469; x=1741607269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oStMvILYc+VcE0Bos6wZo8DhR0OCDR8DIF2cp2zAmw=;
        b=Fb9SHuQ4bMes/wkRfchQTpBkg81Yh0uXlUJCVxk0c1EJ1sYwsVmouXilqj3MWVLc/s
         Xkg+qt+rsfiJoDsHbwxi2lDUYKnkz34Lx8EfhXLZHJJJTQyUD0m6o8ih5jhNPOIIcbLy
         f0pde2atCDhk82JjBqzTCUulC1w2jlYK5humTPGjard6Z3XQRQdzRf1CJm2SyTr8V+x/
         H8LX7UiIZmyGWrYFGVHGQpzLJnspSaX55HOiNIBq7JOVlZlaLo1a3opl2Dg0PlbrzX3m
         Elj6U1ZvEHn8Syi/3u4uxx8QAhbMmaqyP6iXeFdwTqZpNvv9jUANDNk1za11ch4DrdxZ
         hUug==
X-Forwarded-Encrypted: i=1; AJvYcCXTKg2TbceGMjfUSWLJKAS0535a4r6sE2GVAPu3W5b9ZH9MlrQCkEGYL1wv5XeBuhJrvbES2oH+p91tgmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwH3lENXTtBOldphe1yvC+pLgPfEWXAuogMhsY+Qpk6CjV1R3x
	j+Jkn6vSMU8cF/JqAHrGxuegprclLlIZ27K1Y/bwZMUjZG1xRSLbf2/8Eiwm2So=
X-Gm-Gg: ASbGncvYFey2ZLnExuxrNnS5Helfy7a+eaekS4Fy2hneQvyJLk36v9+0JKXrejJN2o6
	LBhWTbKcCEmRW0HpG66sUqriRqmttPUBRcptsEDuzVn4c05Dh/MyYOhCgvtpmGpmc7XjtBrOznp
	Xsc5goJiflUkkNcDiAIuu64pqTk4xrHUUE1E7GqQVW8D2kzeNp7/rm1Bhd3n/FHB56oCMMS5oiH
	rnvWmK627eFhvGvZ0zhFbfSnGnctrWF0fZk1y9RLqyoBa2dkMOyfSsl2uoMyec9s12lyE5/qxMH
	H5l3DBaNX0eF9OIt2pSPnBh29BnGj0YjggXBLV8Qo5fR1AHYLA9T5g4owxHDN+vs/YAfArnxaKU
	GIzI2neOVfLVpZPcV3LGMu/t66g==
X-Google-Smtp-Source: AGHT+IELfVBNUZ3T62EMT1S63oZc8YXWbdY+myyuSZ9x2ZPWALyNI6M68yP4U9enUx3QzHfaeTngGA==
X-Received: by 2002:a05:600c:5119:b0:439:a25b:e7d3 with SMTP id 5b1f17b1804b1-43ba67047c9mr107630935e9.14.1741002469168;
        Mon, 03 Mar 2025 03:47:49 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73702bd0sm158648515e9.10.2025.03.03.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:48 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] iio: adc: ad4130: Adapt internal names to match official filter_type ABI
Date: Mon,  3 Mar 2025 12:47:03 +0100
Message-ID: <20250303114659.1672695-15-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10026; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=f5oXDYngVLmmeCgw3m2NxlkPSjJDX6EDhYcIJAY4bHI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbJmgat15ejTK0QQKh7YezB6CM5zXG9qgXEo EJXgAtDlCmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWyQAKCRCPgPtYfRL+ TmOEB/40PrifRoyMnbRW15f0Kc5i2Lyj3lHgreXcSplrKQrQ2yQT8ugWqShJzKm3GrX8Ivmxuay /ROUnJccQp+uZrdP6UXQS4IttUfsMk/wET65liNBPSoQr//Mw0l5Do5jUJ2js0C+MssELsulZMO GmX7KoRlwPum8U2U232iA4nUBn7Ed5XHe140HYOsR2+xvZjC80dc+JGdceUW64U0MgXV34DLLWC K3fjzvFG+dyIBLiLUJOnJ2v5B9lchBTUyoZIER10Eufnf9Z7De+rIT0h+kzY2Z1gry51NVnsr+r 4q/SeYDF5v4+nubYhxlYB8zc3sjL5Gd4Wk4G/iDhUh0jOTDx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dCL0pt7zFwNx
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712818.29694@qEbZ6onaE7LCO8uxEq2tHQ
X-ITU-MailScanner-SpamCheck: not spam

Recently the interface to to select a filter was officially blessed to
use "filter_type". Adapt the naming of several functions accordingly to
make the new standard more present and so make the driver a better
template for other drivers. Apart from the comment update this is just
s/filter_mode/filter_type/.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 84 ++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 4ab1943c4697..3dbf1d89b671 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -203,7 +203,7 @@ enum ad4130_mode {
 	AD4130_MODE_IDLE =3D 0b0100,
 };
=20
-enum ad4130_filter_mode {
+enum ad4130_filter_type {
 	AD4130_FILTER_SINC4,
 	AD4130_FILTER_SINC4_SINC1,
 	AD4130_FILTER_SINC3,
@@ -234,7 +234,7 @@ struct ad4130_setup_info {
 	unsigned int			pga;
 	unsigned int			fs;
 	u32				ref_sel;
-	enum ad4130_filter_mode		filter_mode;
+	enum ad4130_filter_type		filter_type;
 	bool				ref_bufp;
 	bool				ref_bufm;
 };
@@ -255,7 +255,7 @@ struct ad4130_chan_info {
 };
=20
 struct ad4130_filter_config {
-	enum ad4130_filter_mode		filter_mode;
+	enum ad4130_filter_type		filter_type;
 	unsigned int			odr_div;
 	unsigned int			fs_max;
 	enum iio_available_type		samp_freq_avail_type;
@@ -341,9 +341,9 @@ static const unsigned int ad4130_burnout_current_na_t=
bl[AD4130_BURNOUT_MAX] =3D {
 	[AD4130_BURNOUT_4000NA] =3D 4000,
 };
=20
-#define AD4130_VARIABLE_ODR_CONFIG(_filter_mode, _odr_div, _fs_max)	\
+#define AD4130_VARIABLE_ODR_CONFIG(_filter_type, _odr_div, _fs_max)	\
 {									\
-		.filter_mode =3D (_filter_mode),				\
+		.filter_type =3D (_filter_type),				\
 		.odr_div =3D (_odr_div),					\
 		.fs_max =3D (_fs_max),					\
 		.samp_freq_avail_type =3D IIO_AVAIL_RANGE,		\
@@ -354,9 +354,9 @@ static const unsigned int ad4130_burnout_current_na_t=
bl[AD4130_BURNOUT_MAX] =3D {
 		},							\
 }
=20
-#define AD4130_FIXED_ODR_CONFIG(_filter_mode, _odr_div)			\
+#define AD4130_FIXED_ODR_CONFIG(_filter_type, _odr_div)			\
 {									\
-		.filter_mode =3D (_filter_mode),				\
+		.filter_type =3D (_filter_type),				\
 		.odr_div =3D (_odr_div),					\
 		.fs_max =3D AD4130_FILTER_SELECT_MIN,			\
 		.samp_freq_avail_type =3D IIO_AVAIL_LIST,			\
@@ -378,7 +378,7 @@ static const struct ad4130_filter_config ad4130_filte=
r_configs[] =3D {
 	AD4130_FIXED_ODR_CONFIG(AD4130_FILTER_SINC3_PF4,      148),
 };
=20
-static const char * const ad4130_filter_modes_str[] =3D {
+static const char * const ad4130_filter_types_str[] =3D {
 	[AD4130_FILTER_SINC4] =3D "sinc4",
 	[AD4130_FILTER_SINC4_SINC1] =3D "sinc4+sinc1",
 	[AD4130_FILTER_SINC3] =3D "sinc3",
@@ -610,7 +610,7 @@ static bool ad4130_setup_info_eq(struct ad4130_setup_=
info *a,
 				     unsigned int pga;
 				     unsigned int fs;
 				     u32 ref_sel;
-				     enum ad4130_filter_mode filter_mode;
+				     enum ad4130_filter_type filter_type;
 				     bool ref_bufp;
 				     bool ref_bufm;
 			     }));
@@ -621,7 +621,7 @@ static bool ad4130_setup_info_eq(struct ad4130_setup_=
info *a,
 	    a->pga !=3D b->pga ||
 	    a->fs !=3D b->fs ||
 	    a->ref_sel !=3D b->ref_sel ||
-	    a->filter_mode !=3D b->filter_mode ||
+	    a->filter_type !=3D b->filter_type ||
 	    a->ref_bufp !=3D b->ref_bufp ||
 	    a->ref_bufm !=3D b->ref_bufm)
 		return false;
@@ -728,7 +728,7 @@ static int ad4130_write_slot_setup(struct ad4130_stat=
e *st,
 	if (ret)
 		return ret;
=20
-	val =3D FIELD_PREP(AD4130_FILTER_MODE_MASK, setup_info->filter_mode) |
+	val =3D FIELD_PREP(AD4130_FILTER_MODE_MASK, setup_info->filter_type) |
 	      FIELD_PREP(AD4130_FILTER_SELECT_MASK, setup_info->fs);
=20
 	ret =3D regmap_write(st->regmap, AD4130_FILTER_X_REG(slot), val);
@@ -872,11 +872,11 @@ static int ad4130_set_channel_enable(struct ad4130_=
state *st,
  * (used in ad4130_fs_to_freq)
  */
=20
-static void ad4130_freq_to_fs(enum ad4130_filter_mode filter_mode,
+static void ad4130_freq_to_fs(enum ad4130_filter_type filter_type,
 			      int val, int val2, unsigned int *fs)
 {
 	const struct ad4130_filter_config *filter_config =3D
-		&ad4130_filter_configs[filter_mode];
+		&ad4130_filter_configs[filter_type];
 	u64 dividend, divisor;
 	int temp;
=20
@@ -895,11 +895,11 @@ static void ad4130_freq_to_fs(enum ad4130_filter_mo=
de filter_mode,
 	*fs =3D temp;
 }
=20
-static void ad4130_fs_to_freq(enum ad4130_filter_mode filter_mode,
+static void ad4130_fs_to_freq(enum ad4130_filter_type filter_type,
 			      unsigned int fs, int *val, int *val2)
 {
 	const struct ad4130_filter_config *filter_config =3D
-		&ad4130_filter_configs[filter_mode];
+		&ad4130_filter_configs[filter_type];
 	unsigned int dividend, divisor;
 	u64 temp;
=20
@@ -911,7 +911,7 @@ static void ad4130_fs_to_freq(enum ad4130_filter_mode=
 filter_mode,
 	*val =3D div_u64_rem(temp, NANO, val2);
 }
=20
-static int ad4130_set_filter_mode(struct iio_dev *indio_dev,
+static int ad4130_set_filter_type(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  unsigned int val)
 {
@@ -919,17 +919,17 @@ static int ad4130_set_filter_mode(struct iio_dev *i=
ndio_dev,
 	unsigned int channel =3D chan->scan_index;
 	struct ad4130_chan_info *chan_info =3D &st->chans_info[channel];
 	struct ad4130_setup_info *setup_info =3D &chan_info->setup;
-	enum ad4130_filter_mode old_filter_mode;
+	enum ad4130_filter_type old_filter_type;
 	int freq_val, freq_val2;
 	unsigned int old_fs;
 	int ret =3D 0;
=20
 	guard(mutex)(&st->lock);
-	if (setup_info->filter_mode =3D=3D val)
+	if (setup_info->filter_type =3D=3D val)
 		return 0;
=20
 	old_fs =3D setup_info->fs;
-	old_filter_mode =3D setup_info->filter_mode;
+	old_filter_type =3D setup_info->filter_type;
=20
 	/*
 	 * When switching between filter modes, try to match the ODR as
@@ -937,55 +937,55 @@ static int ad4130_set_filter_mode(struct iio_dev *i=
ndio_dev,
 	 * using the old filter mode, then convert it back into FS using
 	 * the new filter mode.
 	 */
-	ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
+	ad4130_fs_to_freq(setup_info->filter_type, setup_info->fs,
 			  &freq_val, &freq_val2);
=20
 	ad4130_freq_to_fs(val, freq_val, freq_val2, &setup_info->fs);
=20
-	setup_info->filter_mode =3D val;
+	setup_info->filter_type =3D val;
=20
 	ret =3D ad4130_write_channel_setup(st, channel, false);
 	if (ret) {
 		setup_info->fs =3D old_fs;
-		setup_info->filter_mode =3D old_filter_mode;
+		setup_info->filter_type =3D old_filter_type;
 		return ret;
 	}
=20
 	return 0;
 }
=20
-static int ad4130_get_filter_mode(struct iio_dev *indio_dev,
+static int ad4130_get_filter_type(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan)
 {
 	struct ad4130_state *st =3D iio_priv(indio_dev);
 	unsigned int channel =3D chan->scan_index;
 	struct ad4130_setup_info *setup_info =3D &st->chans_info[channel].setup=
;
-	enum ad4130_filter_mode filter_mode;
+	enum ad4130_filter_type filter_type;
=20
 	guard(mutex)(&st->lock);
-	filter_mode =3D setup_info->filter_mode;
+	filter_type =3D setup_info->filter_type;
=20
-	return filter_mode;
+	return filter_type;
 }
=20
-static const struct iio_enum ad4130_filter_mode_enum =3D {
-	.items =3D ad4130_filter_modes_str,
-	.num_items =3D ARRAY_SIZE(ad4130_filter_modes_str),
-	.set =3D ad4130_set_filter_mode,
-	.get =3D ad4130_get_filter_mode,
+static const struct iio_enum ad4130_filter_type_enum =3D {
+	.items =3D ad4130_filter_types_str,
+	.num_items =3D ARRAY_SIZE(ad4130_filter_types_str),
+	.set =3D ad4130_set_filter_type,
+	.get =3D ad4130_get_filter_type,
 };
=20
-static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[]=
 =3D {
+static const struct iio_chan_spec_ext_info ad4130_ext_info[] =3D {
 	/*
-	 * Intentional duplication of attributes to keep backwards compatibilit=
y
-	 * while standardizing over the main IIO ABI for digital filtering.
+	 * `filter_type` is the standardized IIO ABI for digital filtering.
+	 * `filter_mode` is just kept for backwards compatibility.
 	 */
-	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
+	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_type_enum),
 	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
-			   &ad4130_filter_mode_enum),
-	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_mode_enum),
+			   &ad4130_filter_type_enum),
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_type_enum),
 	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
-			   &ad4130_filter_mode_enum),
+			   &ad4130_filter_type_enum),
 	{ }
 };
=20
@@ -999,7 +999,7 @@ static const struct iio_chan_spec ad4130_channel_temp=
late =3D {
 			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE) |
 					BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	.ext_info =3D ad4130_filter_mode_ext_info,
+	.ext_info =3D ad4130_ext_info,
 	.scan_type =3D {
 		.sign =3D 'u',
 		.endianness =3D IIO_BE,
@@ -1049,7 +1049,7 @@ static int ad4130_set_channel_freq(struct ad4130_st=
ate *st,
 	guard(mutex)(&st->lock);
 	old_fs =3D setup_info->fs;
=20
-	ad4130_freq_to_fs(setup_info->filter_mode, val, val2, &fs);
+	ad4130_freq_to_fs(setup_info->filter_type, val, val2, &fs);
=20
 	if (fs =3D=3D setup_info->fs)
 		return 0;
@@ -1141,7 +1141,7 @@ static int ad4130_read_raw(struct iio_dev *indio_de=
v,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		guard(mutex)(&st->lock);
-		ad4130_fs_to_freq(setup_info->filter_mode, setup_info->fs,
+		ad4130_fs_to_freq(setup_info->filter_type, setup_info->fs,
 				  val, val2);
=20
 		return IIO_VAL_INT_PLUS_NANO;
@@ -1171,7 +1171,7 @@ static int ad4130_read_avail(struct iio_dev *indio_=
dev,
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		scoped_guard(mutex, &st->lock) {
-			filter_config =3D &ad4130_filter_configs[setup_info->filter_mode];
+			filter_config =3D &ad4130_filter_configs[setup_info->filter_type];
 		}
=20
 		*vals =3D (int *)filter_config->samp_freq_avail;
--=20
2.47.1



