Return-Path: <linux-iio+bounces-13476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F69F2092
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 20:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2094167ADF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310101AD3E5;
	Sat, 14 Dec 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZqM3Of3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51C13C3F6;
	Sat, 14 Dec 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203670; cv=none; b=QnyzY6N3GwwlvQeIRgJOHy1guc86vB8KQKa8t2i2EtKb3xss8Is81N6+wqgamsNY+yvuwSnV6rNmXDIQ/Z8mCL+SRp25OqYe75IBpZjpAJMco10Y0pvNWDeKriPPd66Vl+Od3A3v9FPEKZYP9sqbucH5sGjgECpGrHh8LPhc0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203670; c=relaxed/simple;
	bh=d2OhmxiI5AooTlDW7fxkPksCuvAuqSC7QMfWprQMVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJCfVCeU3LvCT48alDjP8a4lq+0GPWWgD1yvL3deIE21+SIEVbkYFnTWRPBXNUFsTcP9G2hiLcAbsCqoPesNQxgw+gsfbDeOs9KgySbEcTEfeLSHnYJlNL9UX5NDKby1v6GX3FmsXJrG7NChNj/qAtcj3jQ8cXbslT8NwD17hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZqM3Of3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa679ad4265so735996466b.0;
        Sat, 14 Dec 2024 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203667; x=1734808467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu2e1te76pbd3jGB8qjgDG52ERUhwrkw7zPt6u0Sb9A=;
        b=fZqM3Of3b0VFIgpuhlJWNfug2q7SU8zX+xvbOra5PG5hZNpn5hIr9YZgiIpkkyHSUU
         YaAstY0chP1cVORqwm03SNFRFlwYjvPgT6MxlypCCHC9A0krR5qi+/ynpH9jfJvXYAcd
         Tt5EPkMZw1eGiqNtSy6cKFGqkEvQLQgEOZSEM1HTPmNWrrIfsT4sKSrl2NWgfgJ587eC
         y+OpsuLB2vxppaafB6xMFLx06TQPujcSEl8Pmq8ed/07pgoKIZNITGOOfUJijCBwMkj1
         8rG0GlDqh71NuX66MyaNTkepBfvd2adct1hSnTb1KA2G6Yc6kvMntYS6hX5YLKVjp7oE
         MU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203667; x=1734808467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu2e1te76pbd3jGB8qjgDG52ERUhwrkw7zPt6u0Sb9A=;
        b=wV+gZBLX9iZ/PHZO8fR8nJIZ+hGJ/413nc29JxvPQrNwRx+Y/5LhyAfsAc97RdRgt+
         jjeLDsYGtUsyC0eys7RoGN7mTeCs+ok+EGHK606zdOEdp0ylYEwBy1M3bGd1cDvYEx76
         8sYveroP2HmZ7PChQnyOzz7Z/0qwcSgxHUoQDxRrD0otZSrB98NqozKJ3k+yeCuRj3Hy
         9YFPzKP32KpRSLpfJWms2lBDhDG86s3IeXIv/jS79hwc8W1O+rOnkanEQC/1M2t6Xuuv
         x9dqMIMvB8ilBuMAvN7/nre2qI/27+uUISQfH+Z0qWzbTrtDCWgo51439VRT+QfgesaA
         Vm5w==
X-Forwarded-Encrypted: i=1; AJvYcCWUncRQcV310bBOd+Czke89yq0XuQSOWlN4Ok7aVsYwV++23wQ4iDyildyo1bh6RDUGvWuUsazXmLM=@vger.kernel.org, AJvYcCWnd1dzCx8S7lTovXEGDxIQwZcYB5wRZKJ0hQkCWZhOOkiMQJFNkkX+k7H0KggNyTGLh6zKmnsvJ202/qng@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIaKZV6tKw5Mqw0NuitX07ocWTHAkZTeSdDm7pTy9sYfvM/RY
	DO/5NhVVweXZiV69MW79t0xc335ptv5OorD6pOdbpXN7wJA2QFgP
X-Gm-Gg: ASbGnct6nm2i3k4i8ndI4Ag2sHMvZO4CD1o7TVGFNyX5QuV8cAqAdUcnlaiQuddGV0b
	kN5eofsztzzig1/7o0qbqGIcTXdpwE9mUFZfm+QLnbe156vuqvRMxE2tuuDmabDDOtYcsWW4Ero
	E0n9yRaqxNa6Rsokd2JUKOK5D5sTVmoWDecSHH5qEOpIoIWSBFbEbRaWviAhNMzVjcoBQXx+iqJ
	GLVJlerJdtvoEXuc7AT28Py30IG1cpCQhdy+grXdFeZn+8qZmlFtnzwOYi3IwdqhD12Qw==
X-Google-Smtp-Source: AGHT+IGmSHaWumALTERb63RSMZc8h59eP/qVSKoebKQ7UH75jqqyOT0q6zUN5UqR+nYyLAft3cT5AA==
X-Received: by 2002:a17:907:1c10:b0:aa6:7ff9:d248 with SMTP id a640c23a62f3a-aa6c40f78f0mr1285884566b.8.1734203666421;
        Sat, 14 Dec 2024 11:14:26 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:abde:dd08:a767:d63c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab963c54d2sm122818766b.190.2024.12.14.11.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:14:25 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	jackoalan@gmail.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v2 1/4] iio: adc: dln2-adc: zero full struct instead of just the padding
Date: Sat, 14 Dec 2024 20:14:18 +0100
Message-ID: <20241214191421.94172-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214191421.94172-1-vassilisamir@gmail.com>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop a minor optimization of zeroing the padding between data and
timestamp and zero the whole structure. This is done in favor of
simpler code, and in order to drop the usage of the internal private
variable "scan_timestamp" of the struct iio_dev.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/adc/dln2-adc.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 30328626d9be..221a5fdc1eaa 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -66,8 +66,6 @@ struct dln2_adc {
 	/* Demux table */
 	unsigned int demux_count;
 	struct dln2_adc_demux_table demux[DLN2_ADC_MAX_CHANNELS];
-	/* Precomputed timestamp padding offset and length */
-	unsigned int ts_pad_offset, ts_pad_length;
 };
 
 struct dln2_adc_port_chan {
@@ -111,8 +109,6 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
 	if (iio_get_masklength(indio_dev) &&
 	    (*indio_dev->active_scan_mask & 0xff) == 0xff) {
 		dln2_adc_add_demux(dln2, 0, 0, 16);
-		dln2->ts_pad_offset = 0;
-		dln2->ts_pad_length = 0;
 		return;
 	}
 
@@ -127,16 +123,6 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
 		out_loc += 2;
 		in_loc += 2;
 	}
-
-	if (indio_dev->scan_timestamp) {
-		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
-
-		dln2->ts_pad_offset = out_loc;
-		dln2->ts_pad_length = ts_offset * sizeof(int64_t) - out_loc;
-	} else {
-		dln2->ts_pad_offset = 0;
-		dln2->ts_pad_length = 0;
-	}
 }
 
 static int dln2_adc_get_chan_count(struct dln2_adc *dln2)
@@ -494,6 +480,8 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
+	memset(&data, 0, sizeof(data));
+
 	/* Demux operation */
 	for (i = 0; i < dln2->demux_count; ++i) {
 		t = &dln2->demux[i];
@@ -501,11 +489,6 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 		       (void *)dev_data.values + t->from, t->length);
 	}
 
-	/* Zero padding space between values and timestamp */
-	if (dln2->ts_pad_length)
-		memset((void *)data.values + dln2->ts_pad_offset,
-		       0, dln2->ts_pad_length);
-
 	iio_push_to_buffers_with_timestamp(indio_dev, &data,
 					   iio_get_time_ns(indio_dev));
 
-- 
2.43.0


