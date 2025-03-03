Return-Path: <linux-iio+bounces-16389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D390A4EB83
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 19:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DC0170CB2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D90279323;
	Tue,  4 Mar 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ukkS3HEI"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4D204875
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111954; cv=fail; b=cA6BukibIn0d1fofwnpca5QaOMMZpaFezhYeu8XSlSidEBdASMtTNK77S9/APWIfSbZT/dVLeFzU2Ass55bhBNC31/eud7sJZ08iy44WID9FjNSi35r5MA+U2a/W2moynMcUdUHUI+jOf3CT0bSuDen+abyZNM5x7FJ/+s1UfHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111954; c=relaxed/simple;
	bh=EKoiYwtGgXk8RJ9rVi3ua65cRu2mGPewdepx743X8Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnp/PQp5VC0ew6F48882ob3LaPES6rNlSHgAHAf+miJOJB4FS6IxCn0/J5618O4ALUNkJajqCH1GKcYwIW19d1xJSqK43i8jgjnLk0nBwtWC9Q5jP8DeM0qwKKgv1Npi05ZZFnt5aG4ueow5M1lkoE1M5NzlHjtiGCiVH4lwKmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ukkS3HEI reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.46; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 8F14940D1F45
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 21:12:30 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ukkS3HEI
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hM51wHLzG43G
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 19:43:13 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id E35EE42728; Tue,  4 Mar 2025 19:43:05 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ukkS3HEI
X-Envelope-From: <linux-kernel+bounces-541622-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ukkS3HEI
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id EBA4441B21
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:49:00 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id A25E83063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:49:00 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B13E16721E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A320E002;
	Mon,  3 Mar 2025 11:47:53 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD920C499
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002469; cv=none; b=ZfobCR2YwgDzR/eNM4KE1+SLg1x9ve7je41h6aySpA8jK3HdNoK4Ib5p88wUURDmipWyZGocd9MJEUhDIFcKFQxgO9qCiHcWeFqGnj9ugvXkk8MO+rxM07IsD7Fc7SByDPtu1x6fgGROzDjN+95jisM+4qNuq2eOmoZe9RAE290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002469; c=relaxed/simple;
	bh=np/7+Gia9o5hRCqEtnJukHY+JqLP+X1gw41ncD9ejcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AM+i6IsSTuzg43+tX0d0UMY3HAAeQddZBuCoQPJsvt4Jll9lUJgtb+TpxIGsROiFEOUGsNj3eFqXS68t+zkvMmDLh9JKKVIwjPTadgMp2Eow/vxUalHyrSX2bzO1WbHgnImPOQgbhE+0SbvG0Yw9h3FiLBV7nWBWML+hAtYTP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ukkS3HEI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390dd35c78dso2824018f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002465; x=1741607265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fn2Y9vpcQ3oAClJnMsZcxwhOJxacZwCbnE8JdwAGjM=;
        b=ukkS3HEIbCvK98xCilOhLg9mqdr7sIRcZzVGckXNduV7O/rUMrXgA2eAEucoL5alEc
         j5ICxKMEz6njdZvAd7UjyhcVXbYLb9BtqNSwF/lCIdNDD+u/h224BSGEJpSRMCXbrGVv
         b/b7w9YDxyHfLhfGIlu2dgYINd7liT8TRf5eR8NuaOjZZGC1XQvEje3HWTKRrSEIu+4B
         0CFqoA9naFE6NHZWSTDC24ZvnqUSWjNMyb9B1dNZ6Qf4kVizH0UyE9WRrybVmdhG4pQA
         ZFUCDKszk5Ub+HSm2XMEIcvz0KVNBssOkxmGagQ1HGZSBUX6Fgyuz7pHAXaUzvNQlQ/v
         ouag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002465; x=1741607265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fn2Y9vpcQ3oAClJnMsZcxwhOJxacZwCbnE8JdwAGjM=;
        b=thsGDE7ZTds5cfz/F3nvFQX1EY5muZfPszq4h7nJg6aFRJRHFG3u2MEpKMyGesG9Zh
         dVTleXbTX0yZDJdhnNdWJTrSTjvtUDDFYgoIqGMmt02mWIqJRNHr+osfFwaPIBSCysER
         J4eVPMwo9cyuD2P/s8PGXsVY0NIyXDmMf+425+igZHaL/KvYBVkg94D5f2EFfKtkUJNT
         CjOzRn20aYPO2/kzK80jSoJ3N+cQTgHw+LjmId9ExUsg9tXLuSHDMkbT9c8L/Bq3cuJv
         PLch1fhgDx0jpaYqlFQDVsdeXpVw+yNGAzRs8laIQ1wUcqdVsNTnMnOHYOcydkBX+tyC
         vQFA==
X-Forwarded-Encrypted: i=1; AJvYcCUQk5uArVGdmENksOtALghTFAajr/JMIapvZgs0okgAzMtUn8ZEVAJD0ydp7Lp0736Ibq/7VvImsgMy6kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzigWUOVh2cKyqwQ+bZFoXr9AKUk7+atHKJ+EJEQyMEjuPWb+0n
	UlP4SUWVIlJX22xdsvh/AVHwJkxmc/s8C+HVC9qtcnDTXsXrfId4VTti9sZ+Yng=
X-Gm-Gg: ASbGncsuMA2z0iWWjc6NJu2F8N/KlKUbQ0GyHvTCLRE95cqiV9CoPSdvS8VE6z/v5qP
	LyfVeEiFL8s7GVXirg7Ko4cAOiPaIAp9BLDGYHI1KC8r626YodXl8S/lYra87TnBGsnWctvYay2
	TxrSaQlmdTkg4n01cNsNZA6PU4rnwjxkVSD356SRmvUV5qulUyyBWi3PubbmJJQPYiQJe16JRUe
	eswWmvopzbOq17MSZricrr7SaPguKZTAMjiXIYW6k35TGmwV+czN3JvznJwVZgm1nj166SVhxyL
	4fonNs7HVhGzQ16oeZ99bjVc7JJ/DHTZCWWlJQgRaKQm+9t0Bh/Y/ey8y1Jz6p5twVqWw05W3AW
	sufWsf+NmqtAObal64RyBOfgxaQ==
X-Google-Smtp-Source: AGHT+IHGuolsvcew0aNtGB2on+v463R3QZeJSIqaolbyjPawP/M5ygIMB2T2uNeJ8FlmUsy4njoNGA==
X-Received: by 2002:a05:6000:4591:b0:390:f025:9e85 with SMTP id ffacd0b85a97d-390f0259ebfmr7497566f8f.21.1741002465316;
        Mon, 03 Mar 2025 03:47:45 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485df22sm14465256f8f.97.2025.03.03.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:44 -0800 (PST)
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
Subject: [PATCH v4 3/8] iio: adc: ad7124: Fix comparison of channel configs
Date: Mon,  3 Mar 2025 12:47:01 +0100
Message-ID: <20250303114659.1672695-13-u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3388; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=np/7+Gia9o5hRCqEtnJukHY+JqLP+X1gw41ncD9ejcs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbAJOt5fORmw5hG2SGvZ4uf/Inm2XPAMzWvj nzD3Jjk6W2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWwAAKCRCPgPtYfRL+ TtAuB/9O9MJyCKychQJPr1/HtaYd7pkBazF4KnKZYm6z81dPMHWwxpxURZkhm960VrHf97ZygAb DP7NBlMXeylVlbicg4wuGR1lktiu0ftQULqr/4qVsIDveEDAZl3o8vtl+8jdv3xUa6vuQzyivUZ FtPWVFOzUePAD1XX66kiFd0qdwWSuiRLyQyTwyGtKneQG5AvykSpuF7RZkT2qk9+ykmSFTAu4SP B1Bw2+ME4rGSNMDmqgs41fUuIUncDvnHSlhWM2yiz4ZeJGSkQmI77+z2EWnWfGvsEE2pujOBrbg YS82JlzmwWJyrFLyLn/MNNM/t6zk/qxPaB/H/pxNZfXuS95M
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hM51wHLzG43G
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716626.3538@E/zMQpuBVQwolKalgrd/Ww
X-ITU-MailScanner-SpamCheck: not spam

Checking the binary representation of two structs (of the same type)
for equality doesn't have the same semantic as comparing all members for
equality. The former might find a difference where the latter doesn't in
the presence of padding or when ambiguous types like float or bool are
involved. (Floats typically have different representations for single
values, like -0.0 vs +0.0, or 0.5 * 2=C2=B2 vs 0.25 * 2=C2=B3. The type b=
ool has
at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
true, but memcmp finds a difference.)

When searching for a channel that already has the configuration we need,
the comparison by member is the one that is needed.

Convert the comparison accordingly to compare the members one after
another. Also add a static_assert guard to (somewhat) ensure that when
struct ad7124_channel_config::config_props is expanded, the comparison
is adapted, too.

This issue is somewhat theoretic, but using memcmp() on a struct is a
bad pattern that is worth fixing.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 6bc418d38820..de90ecb5f630 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -151,7 +151,11 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare for equality. If you
+	 * make adaptations in it, you most likely also have to adapt
+	 * ad7124_find_similar_live_cfg(), too.
+	 */
 	struct_group(config_props,
 		enum ad7124_ref_sel refsel;
 		bool bipolar;
@@ -338,15 +342,38 @@ static struct ad7124_channel_config *ad7124_find_si=
milar_live_cfg(struct ad7124_
 								  struct ad7124_channel_config *cfg)
 {
 	struct ad7124_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
=20
-	cmp_size =3D sizeof_field(struct ad7124_channel_config, config_props);
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad7124_channel_config was changed.
+	 */
+	static_assert(sizeof_field(struct ad7124_channel_config, config_props) =
=3D=3D
+		      sizeof(struct {
+				     enum ad7124_ref_sel refsel;
+				     bool bipolar;
+				     bool buf_positive;
+				     bool buf_negative;
+				     unsigned int vref_mv;
+				     unsigned int pga_bits;
+				     unsigned int odr;
+				     unsigned int odr_sel_bits;
+				     unsigned int filter_type;
+			     }));
+
 	for (i =3D 0; i < st->num_channels; i++) {
 		cfg_aux =3D &st->channels[i].cfg;
=20
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->refsel =3D=3D cfg_aux->refsel &&
+		    cfg->bipolar =3D=3D cfg_aux->bipolar &&
+		    cfg->buf_positive =3D=3D cfg_aux->buf_positive &&
+		    cfg->buf_negative =3D=3D cfg_aux->buf_negative &&
+		    cfg->vref_mv =3D=3D cfg_aux->vref_mv &&
+		    cfg->pga_bits =3D=3D cfg_aux->pga_bits &&
+		    cfg->odr =3D=3D cfg_aux->odr &&
+		    cfg->odr_sel_bits =3D=3D cfg_aux->odr_sel_bits &&
+		    cfg->filter_type =3D=3D cfg_aux->filter_type)
 			return cfg_aux;
 	}
=20
--=20
2.47.1



