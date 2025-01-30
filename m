Return-Path: <linux-iio+bounces-14742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DAAA2334F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE52F3A3343
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993E1EF091;
	Thu, 30 Jan 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2j8GQH2q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00A17DE2D
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259145; cv=none; b=ktC9gbmF2uObw2T3O0uofufWaATYmovA/JY8OyJ/D7yXlIhFqw2qam99J7fdsL+zBuCSoQx6+nSKoA1Ts36ae+pMYO5buoTx2MC4MintaVjdZtM+7aj0qMQ3URlYs3EOQng8hvK7gUXrNDV8lP1bJ3Sz36P2b79DjCmkTaBbofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259145; c=relaxed/simple;
	bh=2gt7W7B1flK5Lm7UMyz0fy5QgMMvGcib6qdXYcbf70E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDssRMMT/4AWFTmFTHXn7ohG84KXdC+628Gmx9l2YUmTEz8fF0cT4DaF9BESMHpXFSaouoVw8F70vYT4v0hJayI6EXrGCdVJP8AxVoNV1Rn94xq/YwCL5C13cvNl2uf1DJv8BrvbDVlyNNgbkEAfNvof8OvLxvOL5gF/03y/bOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2j8GQH2q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab633d9582aso229163166b.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738259141; x=1738863941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eME1BWbK8eCibwpVC4K8yuJatIeLGXo3/URu+vw+Ntw=;
        b=2j8GQH2qg1DB3XwauRB2PCOb79gdW07FbLqTeHQPH7jkxdIgjbbjNhrNsQnHYHBf22
         DmUA3DtUlQiSSgNk7g2QohARgxXbZuywoQg78YdzvthjEzeSMbYWCVMVWClS4ep/x7OQ
         Y758taCEJlTTCID/EYDGGy+Te8E9+Fxop7PwAwspMPAsucQhR/J2tlZahQtmMvuwOPbZ
         9cGSM2soDCRE8GKUQSpOZo4T8dIzGrfIOFNQpwysf6F21gb9hhsbZ2n4ohQzpxZpOK0U
         IFI6EG3Y3FtyYiVOaj5fiwMO5dKWu2mm2ZPOpeBVqo2cb+RUnkiet6jUr/a0f2JPCpcC
         M+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738259141; x=1738863941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eME1BWbK8eCibwpVC4K8yuJatIeLGXo3/URu+vw+Ntw=;
        b=COkwuudnGrBY3LVxx8AENBTnwsfVMGK73EbRlYoaS31fcufagkjKIAPsZVeDLLM5ot
         LOGzRR2iT1bpvnqMaCR1dQDknEgPZj7SZp8jGaHu3VROzuU/E/O1T84+HHXdT36wYnWw
         sVTx5AxfKOLWHmQOuqFzIPN5eHWXhBiPjIqq7/Epcp1YXw3W1T9IjVkvxGLWdLt8wAc0
         C6+DWl2i4QD2KY6mPD/z/+6dJaQfniCbhDUx1+h4t4nvxrASVIEq4TvBbZAlq/QPegty
         5OKnWGb44NDIztcPH6TSwzB1Jp/Aa+IYLQIKJ7Xr9daxKvnR/+mHvDRBthbQ23odlM+H
         bOPQ==
X-Gm-Message-State: AOJu0YwOsbNy1AXy7o64qFoUaYB3QouGPdVvAgqJG7lHIy4eYjSyQWxG
	CGTEoXCddfjcHMVzu+dBMm/oZLbshgS6acQA714Yz1P3miOMCDk2RT2r6EuUndo=
X-Gm-Gg: ASbGncs3QpAgveMWMDAFyIPHtpxUnh3ghD0x/l6YT/Yx29Oow0luGqizzccA0WBuMse
	xq9/awbVKVWfvUqAG/QUh0uQPsVK7ZTAcLUWTT96ZOuuZWqT3K0Vk7UDXDVXv4zgtKckMBd3lX5
	J2hkjcp6oJWdIOcPS861RwwNWm9RLhPVyHudKZ1oJRTiR442GtAUMt60VT5AlB+JpghFvOGT+xu
	4/sAvnY0GDT+eE8MX6ERKFu/zkxfxX86nO5l8DDItx752GXv9LEEvQ2hN1AAe3zU95qt4FP4HOh
	o89D8Fn8E/nQBDXfqq9A
X-Google-Smtp-Source: AGHT+IH+xhYr6Y7Qf+eZIP8QxnCDuDzAJEjEpAl1o9oZPXW8FzX4JPdcC3lsYvTCX6z/4j4WEg+Uuw==
X-Received: by 2002:a17:906:6a24:b0:aa6:aa8e:c89c with SMTP id a640c23a62f3a-ab6cfda42fbmr911634566b.39.1738259141591;
        Thu, 30 Jan 2025 09:45:41 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a31b37sm154736666b.143.2025.01.30.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 09:45:41 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ad7173: Fix comparison of channel configs
Date: Thu, 30 Jan 2025 18:45:02 +0100
Message-ID:  <aa397f3749403477ee4a8f416b5890099f430ca5.1738258777.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
References: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2gt7W7B1flK5Lm7UMyz0fy5QgMMvGcib6qdXYcbf70E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnm7qiKV2Pd/Alp+UnALad0R6Ddm1Q0jTb0gUgK PKHXlfKuFCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5u6ogAKCRCPgPtYfRL+ TrGkB/wOzzwx/QMrcUTd34arS24CdJT4KSQCDjSeanKCj/ggzutkuSZt1TUHQwcsNTGpXIx/+Q6 MctEbWvm6vM+1lZjoNaXtml5M5267dovjd2oaCYXcqy2I5VfTj5XRmS6/ygE8RaSLB+UEBDZyXq 0jehUsonJxtoEWtZZUFHPEge64hgaedLvpqCMPdvFKLtgeGyWUfZ6VK9dO04zk1tR6WuaJsNN3B NXBKfqAJFtaqRsTZ+4cKBUDD0UDjoalLNwM02Fch0mBgnmXZ7uWXOLetGXAnCqFVh0ZqxZgHhj4 lpDf1QnjGiiwO4Ft+lpbqd2Ej5C2q3/9LZnKJbMe70bQmbxM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Checking the binary representation of two structs (of the same type)
for equality doesn't have the same semantic as comparing all members for
equality. The former might find a difference where the latter doesn't in
the presence of padding or when ambiguous types like float or bool are
involved. (Floats typically have different representations for single
values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
true, but memcmp finds a difference.)

When searching for a channel that already has the configuration we need,
the comparison by member is the one that is needed.

Convert the comparison accordingly to compare the members one after
another. Also add a BUILD_BUG guard to (somewhat) ensure that when
struct ad7173_channel_config::config_props is expanded, the comparison
is adapted, too.

Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 6c4ed10ae580..67821c889010 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -712,15 +712,24 @@ static struct ad7173_channel_config *
 ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
 {
 	struct ad7173_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = sizeof_field(struct ad7173_channel_config, config_props);
+	BUILD_BUG_ON(sizeof_field(struct ad7173_channel_config, config_props) !=
+		     sizeof(struct {
+				    bool bipolar;
+				    bool input_buf;
+				    u8 odr;
+				    u8 ref_sel;
+			    }));
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->bipolar == cfg_aux->bipolar &&
+		    cfg->input_buf == cfg_aux->input_buf &&
+		    cfg->odr == cfg_aux->odr &&
+		    cfg->ref_sel == cfg_aux->ref_sel)
 			return cfg_aux;
 	}
 	return NULL;
-- 
2.47.1


