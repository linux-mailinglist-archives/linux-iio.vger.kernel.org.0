Return-Path: <linux-iio+bounces-24384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451BB979D4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 23:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB6C1AE0760
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557B27A44A;
	Tue, 23 Sep 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h5gGrdHN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CD78F58
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664100; cv=none; b=O9OxjD8KnFs5TTbH8a4B8vZqDBcbSRNe+P6xPDa7jxDL9n8jlXpmVy45SrMu83nwAufJJ2knB+a4gWKxC3iQ4rs+p0/m6SGHRInQp+DbkvV56uFPQ3i0CZA92TEdd6D/UHegcZnQTWElL+96tdUl5YpgxuHEJEITOtVDPpfLtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664100; c=relaxed/simple;
	bh=uo3Ph6+cuQG+vMhaoMTiQYspuFS4AgqZTVS+dWozIWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kHQ9zKbKxTDm/9YE+bYCKMa1dkvOsWysLNAK1I87x1ynHaFdHkoKOztq4PlPd1t2Vn+RcK7f/FifJkx3xh2irzpmizsutBUV42EsU+EubDr0pdm8mRGIF13J5OueOKOv0Tilx5DVeBq2LgOVv8aiJEb7AtduTsgGyT2i9hDHEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h5gGrdHN; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74526ca79c2so3064124a34.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758664097; x=1759268897; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBRKsO+I7obZ9fAn4xCLMsUT+Hw5ct/DQcM04liH8Vg=;
        b=h5gGrdHNs17aCvcBmgrU2vu4cMHLGaPIQRuBYPuSZKjjYBI6ks28hD+Dz5/DoZCFqe
         iRcSQ/gtTkolZ081E5xqXcsyZVlUbdgHRApdsyCl2M/7l0MCV4aqzHeruB7zbWZ4xOGw
         6ddbxrLY4nq9Ha4OBGE+De0z36dsboH9isvG6eDHVk/lTtBg/LLRWvX5aXXJNigrB0Ed
         ifr3qRpv+sMI+a48T/AnpEHjGJXi1CIqbvQXnfTogCm1wMRdOTzjtIdiE8y0HYfVLMTU
         49Y83GDMQYajYCrEKWjLwsJJRv69JXm4nQsBKrOFmpwXtgAIZii9GjtMyPVmxrLKcBOd
         iy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758664097; x=1759268897;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBRKsO+I7obZ9fAn4xCLMsUT+Hw5ct/DQcM04liH8Vg=;
        b=doWSAb3COajVzAZegb+vH4ZqJLBKeI0hYU87Jua+3LphT0/BPUdVSGrF72ojZwDOi6
         prZkHljsh1Nk26mD4BSUzo/VumbkpvTNhyQkoC9fVakM6Bsge18BIogAM7xtyXWo7fqH
         CvtujIwvgGfQCQqrEv1cYxgqvRrkocIWuUTe8zupvdFcmWk/Etxf2a/nT7zW06U7ftCB
         atMdU0Estpy7+p8Vbijx9oJI5K1Cl7SH+mVOsL34+Pnhtc5Ir8mECYS61BXXi4XTgWOh
         AF/8uL0lYX8eU21iwxGdilGn/lkPovqT7UJIx8CQxlUVsVjDqwqjiRauhMqx6zpkl8GM
         lSQQ==
X-Gm-Message-State: AOJu0YwoFW+fguz8cOcPLjPryprHLAetPu8Vkn2A0651RSAi+TFiXzvo
	z6k5/WzU9RtVaSYsDDpGEVH95RgFSS32hqUY27/nPH12DA7H2hOIF7EjZ3jU2DSBnPU=
X-Gm-Gg: ASbGncucCHVRCYOXcmX5Kp84SWYZwb0eTYDkd4nnGSy4w/upJhoa7vfwVokht70/7xY
	5779E5+aKsyp3Jt8vaAK+qAhvRj3XGS1ljBTS2RsqMh2BxSpi5gQisdgp+HZ2yA5KRC9RzhlamS
	omq1AQfLeFf/hKnHw1jBTcCFHxG5iIIPnZTgIPW26wdu/vFPnWvlcMmXfuoRfCZ0NDCmxa3J2J5
	SdqlP57RmZlvDTTk1zL+mvHcZrZPCpr4Lkh8KdYPEmPi1ZPZRo7tPx4xyHGvfN6OMSwqxeeyPXJ
	nvAbkesrpYRxYDbCSNjzkOrVQSnDYX3nUzz31Cr2pVzTB5LklM21yToetWUl6PAv3jbRMMw0pCk
	+LeG42hJtNsa7RRUIleFyZY2RINc=
X-Google-Smtp-Source: AGHT+IENnOYEBiYPWp8AQigbpyqSChh+XquKIwNIZ3P6AtkEytNC+SeI8iObMURBdcHANaHO7Ue5Kw==
X-Received: by 2002:a05:6830:6115:b0:78a:5183:8f6a with SMTP id 46e09a7af769-7915180e942mr2588452a34.28.1758664097159;
        Tue, 23 Sep 2025 14:48:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:5b03:6cc2:9ec:21f2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-76929180e5bsm7223544a34.20.2025.09.23.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:48:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Sep 2025 16:48:04 -0500
Subject: [PATCH v2] iio: adc: ad7124: change setup reg allocation strategy
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-iio-adc-ad7124-change-setup-reg-allocation-strategy-v2-1-d9bf01bb3ad8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJMV02gC/6VPy26DQAz8FeRzXFhKQpJT/yPKYR8OsQQs9W5QU
 MS/1yX9gx4sa+zxzPgFiYQpwbl4gdDMieOooN4V4O927Ag5KIa6qvfVybTIHNEGr9WausE/UqL
 8mFCoQ9v30dusMpiy2Ezdgj6Y28H5cGzMHlR5Errxc3O9XN9Y6Puh5vk9BGcToY/DwPlcKDuVQ
 kPUban+pfbMYwe/t3dOOcqyPTCb7fhfWWeDBhsyrfsMVDUH9+Xs0rMT+tA8cF3X9QerFvCKNQE
 AAA==
X-Change-ID: 20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-cd1f6bcd8415
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17937;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=uo3Ph6+cuQG+vMhaoMTiQYspuFS4AgqZTVS+dWozIWg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo0xWYKl9pVE8vlyCyml2sdeYm+d8n7BvIWej7Y
 5BvMzbKdCaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaNMVmAAKCRDCzCAB/wGP
 wAp9B/9vOHSSprIxi9JERhYz9Q45j8kpBmdf8CvVz3pw711JvULWAE4Jzde6Or0McL02Pe1z6YN
 oAQ42GvZW5eIAeURgtzfpaLtGHcRm0hk2z4PcupBd7XRnkqnBLeABHDJa9cSUH0IBtcWrII8XEa
 OsgdzmGQ77mry91dtKBuJHf1vpLxGPLY5nc8gPGj2zscKYIAJH5vcxeLxYt+WSKoCpUgHgOx0L3
 Bcz215Y7aam8ZQAct4n18bnIeQEqtijjhAZITcRlF9mB4cvOQoePO21mkAmwNDhHjaGsY8P+LAz
 R0QbErz+7LkQHjpmmjiXfazkQn66HL3CpxIVjOO95yJSS5Oo
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the allocation strategy of the 8 SETUP registers from a least-
recently-used (LRU) to a first-come-first-served basis.

The AD7124 chips can have up to 16 channels enabled at a time in the
sequencer for buffered reads, but only have 8 SETUP configurations
(namely the OFFSET, GAIN, CONFIG and FILTER registers) that must be
shared among the 16 channels.  This means some of the channels must use
the exact same configuration parameters so that they can share a single
SETUP group of registers.  The previous LRU strategy did not keep track
of how many different configurations were requested at the same time,
so if there were more than 8 different configurations requested, some
channels would end up using the incorrect configuration because the slot
assigned to them would also be assigned to a different configuration
that wrote over it later.

Adding such tracking to solve this would make an already complex
algorithm even more complex.  Instead we can replace it with a simpler
first-come-first-serve strategy.  This makes it easy to track how many
different configurations are being requested at the same time.  This
comes at the expense of slightly longer setup times for buffered reads
since all setup registers must be written each time when a buffered read
is enabled.  But this is generally not considered a hot path where
performance is critical, so should be acceptable.

This new strategy also makes hardware debugging easier since SETUPs are
now assigned in a deterministic manner and in a logical order.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is something I wish I would have noticed earlier. This is
addressing the same issue we saw recently in the ad7173 driver [1].

However, since we have added a bunch of new features to the ad7124
driver recently, it seems too late to make a change like the one in the
link that can be easily backported. So I didn't bother with a Fixes: tag
here. Given how many other broken things we found in ad7124 recently,
I'm not too worried about rushing out a fix for backporting anyway.

Instead, I implemented the idea I first proposed in [2]. I find it much
easier to follow and reason about than the LRU implementation. And while
working on other features, I found the LRU implementation to be annoying
because I never knew which setup registers would be assigned to which
channels after tweaking the channel configuration. This made debugging
more tedious than it could have been. So this seems like an overall
improvement to me.

B4 is picking up all of the recent patches to the ad7124 driver as
dependencies, but really the only one that is actually needed for this
to apply cleanly is the "iio: adc: ad7124: drop nr field" series.

[1]: https://lore.kernel.org/linux-iio/20250722-iio-adc-ad7173-fix-setup-use-limits-v2-1-8e96bdb72a9c@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/bcf599e1-7816-4580-a2f9-039b0d3c0c99@baylibre.com/
---
Changes in v2:
- Simplified search algorithm to a single for loop.
- Renamed loop variable for channels to "other".
- Removed dev_dbg() statements.
- Reworded confusing comment.
- Link to v1: https://lore.kernel.org/r/20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com
---
 drivers/iio/adc/ad7124.c | 233 ++++++++++++++++++++---------------------------
 1 file changed, 100 insertions(+), 133 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 374e39736584f55c1290db3e257dff2c60f884d2..f7bf13ef1c956958569712ed758b7073494e8c24 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -111,6 +111,8 @@
 #define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
 #define AD7124_FILTER_FS		GENMASK(10, 0)
 
+#define AD7124_CFG_SLOT_UNASSIGNED	~0U
+
 #define AD7124_MAX_CONFIGS	8
 #define AD7124_MAX_CHANNELS	16
 
@@ -176,14 +178,13 @@ enum ad7124_filter_type {
 };
 
 struct ad7124_channel_config {
-	bool live;
 	unsigned int cfg_slot;
 	unsigned int requested_odr;
 	unsigned int requested_odr_micro;
 	/*
 	 * Following fields are used to compare for equality. If you
 	 * make adaptations in it, you most likely also have to adapt
-	 * ad7124_find_similar_live_cfg(), too.
+	 * ad7124_config_equal(), too.
 	 */
 	struct_group(config_props,
 		enum ad7124_ref_sel refsel;
@@ -215,14 +216,13 @@ struct ad7124_state {
 	unsigned int adc_control;
 	unsigned int num_channels;
 	struct mutex cfgs_lock; /* lock for configs access */
-	unsigned long cfg_slots_status; /* bitmap with slot status (1 means it is used) */
+	u8 cfg_slot_use_count[AD7124_MAX_CONFIGS];
 
 	/*
 	 * Stores the power-on reset value for the GAIN(x) registers which are
 	 * needed for measurements at gain 1 (i.e. CONFIG(x).PGA == 0)
 	 */
 	unsigned int gain_default;
-	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
 	bool enable_single_cycle;
 };
 
@@ -367,9 +367,6 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 		  cfg->requested_odr_micro * factor / MICRO;
 	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 2047);
 
-	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
-		st->channels[channel].cfg.live = false;
-
 	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
 }
 
@@ -404,61 +401,6 @@ static int ad7124_get_3db_filter_factor(struct ad7124_state *st,
 	}
 }
 
-static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_state *st,
-								  struct ad7124_channel_config *cfg)
-{
-	struct ad7124_channel_config *cfg_aux;
-	int i;
-
-	/*
-	 * This is just to make sure that the comparison is adapted after
-	 * struct ad7124_channel_config was changed.
-	 */
-	static_assert(sizeof_field(struct ad7124_channel_config, config_props) ==
-		      sizeof(struct {
-				     enum ad7124_ref_sel refsel;
-				     bool bipolar;
-				     bool buf_positive;
-				     bool buf_negative;
-				     unsigned int vref_mv;
-				     unsigned int pga_bits;
-				     unsigned int odr_sel_bits;
-				     enum ad7124_filter_type filter_type;
-				     unsigned int calibration_offset;
-				     unsigned int calibration_gain;
-			     }));
-
-	for (i = 0; i < st->num_channels; i++) {
-		cfg_aux = &st->channels[i].cfg;
-
-		if (cfg_aux->live &&
-		    cfg->refsel == cfg_aux->refsel &&
-		    cfg->bipolar == cfg_aux->bipolar &&
-		    cfg->buf_positive == cfg_aux->buf_positive &&
-		    cfg->buf_negative == cfg_aux->buf_negative &&
-		    cfg->vref_mv == cfg_aux->vref_mv &&
-		    cfg->pga_bits == cfg_aux->pga_bits &&
-		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
-		    cfg->filter_type == cfg_aux->filter_type &&
-		    cfg->calibration_offset == cfg_aux->calibration_offset &&
-		    cfg->calibration_gain == cfg_aux->calibration_gain)
-			return cfg_aux;
-	}
-
-	return NULL;
-}
-
-static int ad7124_find_free_config_slot(struct ad7124_state *st)
-{
-	unsigned int free_cfg_slot;
-
-	free_cfg_slot = find_first_zero_bit(&st->cfg_slots_status, AD7124_MAX_CONFIGS);
-	if (free_cfg_slot == AD7124_MAX_CONFIGS)
-		return -1;
-
-	return free_cfg_slot;
-}
-
 /* Only called during probe, so dev_err_probe() can be used */
 static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channel_config *cfg)
 {
@@ -487,6 +429,21 @@ static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channe
 	}
 }
 
+static bool ad7124_config_equal(struct ad7124_channel_config *a,
+				struct ad7124_channel_config *b)
+{
+	return a->refsel == b->refsel &&
+	       a->bipolar == b->bipolar &&
+	       a->buf_positive == b->buf_positive &&
+	       a->buf_negative == b->buf_negative &&
+	       a->vref_mv == b->vref_mv &&
+	       a->pga_bits == b->pga_bits &&
+	       a->odr_sel_bits == b->odr_sel_bits &&
+	       a->filter_type == b->filter_type &&
+	       a->calibration_offset == b->calibration_offset &&
+	       a->calibration_gain == b->calibration_gain;
+}
+
 static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_config *cfg,
 			       unsigned int cfg_slot)
 {
@@ -495,13 +452,13 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	unsigned int post = 0;
 	int ret;
 
-	cfg->cfg_slot = cfg_slot;
-
-	ret = ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg->cfg_slot), 3, cfg->calibration_offset);
+	ret = ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg_slot), 3,
+			      cfg->calibration_offset);
 	if (ret)
 		return ret;
 
-	ret = ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg->cfg_slot), 3, cfg->calibration_gain);
+	ret = ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg_slot), 3,
+			      cfg->calibration_gain);
 	if (ret)
 		return ret;
 
@@ -511,7 +468,7 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 		(cfg->buf_negative ? AD7124_CONFIG_AIN_BUFM : 0) |
 		FIELD_PREP(AD7124_CONFIG_PGA, cfg->pga_bits);
 
-	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg->cfg_slot), 2, val);
+	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg_slot), 2, val);
 	if (ret < 0)
 		return ret;
 
@@ -564,7 +521,7 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	 * was requested. It may only be disabled through debugfs for testing
 	 * purposes.
 	 */
-	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg->cfg_slot), 3,
+	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg_slot), 3,
 			       FIELD_PREP(AD7124_FILTER_FILTER, filter) |
 			       FIELD_PREP(AD7124_FILTER_REJ60, rej60) |
 			       FIELD_PREP(AD7124_FILTER_POST_FILTER, post) |
@@ -573,83 +530,86 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 			       FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits));
 }
 
-static struct ad7124_channel_config *ad7124_pop_config(struct ad7124_state *st)
+/**
+ * ad7124_request_config_slot() - Request a config slot for a given config
+ * @st:		Driver instance
+ * @channel:	Channel to request a slot for
+ *
+ * Tries to find a matching config already in use, otherwise finds a free
+ * slot. If this function returns successfully, the use count for the slot is
+ * increased and the slot number is stored in cfg->cfg_slot.
+ *
+ * The slot must be released again with ad7124_release_config_slot() when no
+ * longer needed.
+ *
+ * Returns: 0 if a slot was successfully assigned, -EUSERS if no slot is
+ * available or other error if SPI communication fails.
+ */
+static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
 {
-	struct ad7124_channel_config *lru_cfg;
-	struct ad7124_channel_config *cfg;
-	int ret;
-	int i;
+	unsigned int other, slot;
+	int last_used_slot = -1;
 
-	/*
-	 * Pop least recently used config from the fifo
-	 * in order to make room for the new one
-	 */
-	ret = kfifo_get(&st->live_cfgs_fifo, &lru_cfg);
-	if (ret <= 0)
-		return NULL;
+	/* Find another channel with a matching config, if any. */
+	for (other = 0; other < st->num_channels; other++) {
+		if (other == channel)
+			continue;
 
-	lru_cfg->live = false;
+		if (st->channels[other].cfg.cfg_slot == AD7124_CFG_SLOT_UNASSIGNED)
+			continue;
 
-	/* mark slot as free */
-	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
+		last_used_slot = max_t(int, last_used_slot,
+				       st->channels[other].cfg.cfg_slot);
 
-	/* invalidate all other configs that pointed to this one */
-	for (i = 0; i < st->num_channels; i++) {
-		cfg = &st->channels[i].cfg;
+		if (!ad7124_config_equal(&st->channels[other].cfg,
+					 &st->channels[channel].cfg))
+			continue;
 
-		if (cfg->cfg_slot == lru_cfg->cfg_slot)
-			cfg->live = false;
+		/* Found a match, re-use that slot. */
+		slot = st->channels[other].cfg.cfg_slot;
+		st->cfg_slot_use_count[slot]++;
+		st->channels[channel].cfg.cfg_slot = slot;
+
+		return 0;
 	}
 
-	return lru_cfg;
-}
+	/* No match, use next free slot. */
+	slot = last_used_slot + 1;
+	if (slot >= AD7124_MAX_CONFIGS)
+		return -EUSERS;
 
-static int ad7124_push_config(struct ad7124_state *st, struct ad7124_channel_config *cfg)
-{
-	struct ad7124_channel_config *lru_cfg;
-	int free_cfg_slot;
+	st->cfg_slot_use_count[slot]++;
+	st->channels[channel].cfg.cfg_slot = slot;
 
-	free_cfg_slot = ad7124_find_free_config_slot(st);
-	if (free_cfg_slot >= 0) {
-		/* push the new config in configs queue */
-		kfifo_put(&st->live_cfgs_fifo, cfg);
-	} else {
-		/* pop one config to make room for the new one */
-		lru_cfg = ad7124_pop_config(st);
-		if (!lru_cfg)
-			return -EINVAL;
+	return ad7124_write_config(st, &st->channels[channel].cfg, slot);
+}
 
-		/* push the new config in configs queue */
-		free_cfg_slot = lru_cfg->cfg_slot;
-		kfifo_put(&st->live_cfgs_fifo, cfg);
-	}
+static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
+{
+	unsigned int slot = st->channels[channel].cfg.cfg_slot;
 
-	/* mark slot as used */
-	assign_bit(free_cfg_slot, &st->cfg_slots_status, 1);
+	/*
+	 * All of these conditions can happen at probe when all channels are
+	 * disabled. Otherwise, they should not happen normally.
+	 */
+	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
+	    st->cfg_slot_use_count[slot] == 0)
+		return;
 
-	return ad7124_write_config(st, cfg, free_cfg_slot);
+	st->cfg_slot_use_count[slot]--;
+	st->channels[channel].cfg.cfg_slot = AD7124_CFG_SLOT_UNASSIGNED;
 }
 
 static int ad7124_prepare_read(struct ad7124_state *st, int address)
 {
 	struct ad7124_channel_config *cfg = &st->channels[address].cfg;
-	struct ad7124_channel_config *live_cfg;
+	int ret;
 
-	/*
-	 * Before doing any reads assign the channel a configuration.
-	 * Check if channel's config is on the device
-	 */
-	if (!cfg->live) {
-		/* check if config matches another one */
-		live_cfg = ad7124_find_similar_live_cfg(st, cfg);
-		if (!live_cfg)
-			ad7124_push_config(st, cfg);
-		else
-			cfg->cfg_slot = live_cfg->cfg_slot;
-	}
+	ret = ad7124_request_config_slot(st, address);
+	if (ret)
+		return ret;
 
 	/* point channel to the config slot and enable */
-	cfg->live = true;
 	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(address), 2,
 			       st->channels[address].ain |
 			       FIELD_PREP(AD7124_CHANNEL_SETUP, cfg->cfg_slot) |
@@ -692,6 +652,8 @@ static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 
+	ad7124_release_config_slot(st, chan);
+
 	/* The relevant thing here is that AD7124_CHANNEL_ENABLE is cleared. */
 	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
 }
@@ -913,9 +875,6 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 		gain = DIV_ROUND_CLOSEST(res, val2);
 		res = ad7124_find_closest_match(ad7124_gain, ARRAY_SIZE(ad7124_gain), gain);
 
-		if (st->channels[chan->address].cfg.pga_bits != res)
-			st->channels[chan->address].cfg.live = false;
-
 		st->channels[chan->address].cfg.pga_bits = res;
 		return 0;
 	default:
@@ -1058,7 +1017,11 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 		if (ret < 0)
 			return ret;
 
-		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3,
+		/*
+		 * Making the assumption that a single conversion will always
+		 * use configuration slot 0 for the OFFSET/GAIN registers.
+		 */
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(0), 3,
 				     &ch->cfg.calibration_offset);
 		if (ret < 0)
 			return ret;
@@ -1073,7 +1036,7 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 		if (ret < 0)
 			return ret;
 
-		ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3,
+		ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3,
 				     &ch->cfg.calibration_gain);
 		if (ret < 0)
 			return ret;
@@ -1164,7 +1127,6 @@ static int ad7124_set_filter_type_attr(struct iio_dev *dev,
 
 	guard(mutex)(&st->cfgs_lock);
 
-	cfg->live = false;
 	cfg->filter_type = value;
 	ad7124_set_channel_odr(st, chan->address);
 
@@ -1483,7 +1445,6 @@ static int ad7124_setup(struct ad7124_state *st)
 	if (ret)
 		return ret;
 
-	INIT_KFIFO(st->live_cfgs_fifo);
 	for (i = 0; i < st->num_channels; i++) {
 		struct ad7124_channel_config *cfg = &st->channels[i].cfg;
 
@@ -1491,6 +1452,8 @@ static int ad7124_setup(struct ad7124_state *st)
 		if (ret < 0)
 			return ret;
 
+		cfg->cfg_slot = AD7124_CFG_SLOT_UNASSIGNED;
+
 		/* Default filter type on the ADC after reset. */
 		cfg->filter_type = AD7124_FILTER_TYPE_SINC4;
 
@@ -1550,7 +1513,7 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 			 * ad_sigma_delta_set_channel() -> ad7124_set_channel()
 			 * -> ad7124_prepare_read().
 			 */
-			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(st->channels[i].cfg.cfg_slot), 3,
+			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3,
 					     &st->channels[i].cfg.calibration_gain);
 			if (ret < 0)
 				return ret;
@@ -1560,7 +1523,11 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 		if (ret < 0)
 			return ret;
 
-		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(st->channels[i].cfg.cfg_slot), 3,
+		/*
+		 * Making the assumption that a single conversion will always
+		 * use configuration slot 0 for the OFFSET/GAIN registers.
+		 */
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(0), 3,
 				     &st->channels[i].cfg.calibration_offset);
 		if (ret < 0)
 			return ret;

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-cd1f6bcd8415

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


