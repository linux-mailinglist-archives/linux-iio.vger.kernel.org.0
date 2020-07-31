Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137E1234995
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbgGaQtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733150AbgGaQtH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:07 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4464EC0617AA
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so25855226ilk.5
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WJOpih10G5LrQiOZLhDb5AlSl69gNb0B6aytvleDjw=;
        b=dElXqIE1198tbm2UIWdhAIl/ERxxwPIyJ7q5XwpfIpZhs2AEfBIy8WVfSyzcBfZ9kT
         e1ToeJHPAI1L5NPtszeDLtix5iJtBVWvjb+vszBohkfZc22qkSppM61JM6iAVof+KCeX
         HQ8nBfSPJ0LFwevvBLTnaLPIBQIcaTVEsQUBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WJOpih10G5LrQiOZLhDb5AlSl69gNb0B6aytvleDjw=;
        b=c9s/HxQPJ/s7LKLY1vPQ/ji0qwHZW0IRM1NrxDmr7Q3DmcBeVz99NL+ZBTfWePyTUM
         bFVrApyofIlsbLbMCTkAMSnw3nUp3MCMqyQGraLch3ZeCNLA+ozkX3UNR7/VVvGrvksn
         EqPf65yzEO6e5a2I23HscuzMlfzjXkVAKG4U18F9gMaRTR7jqIPufSPDgUca3M01A7KC
         V62kmnFHGIWt2rOf35JzSQGouSWk2n5zwZ5CPh/qqxTL14aUpa/hklmz9f4KZJdRM+ma
         cXOPQzPIcBvswhP+4wgBUiFbdRdyiVUtUG+otQiLAFnL8Hic10mVbAVnRCJWhsrMaKX0
         Pslw==
X-Gm-Message-State: AOAM530cqSkWtRq10bCqjikTlvQ7loJxY8/1U8M90/SXWfGFVm5ucu/M
        Wr07b3zbmryKlLAAQT9xS2zMDg==
X-Google-Smtp-Source: ABdhPJwHvu5de9YhcaASuVrSsByGsU4noAiiti5+DOgk/iNUZwZf4MC4Cuc/93Nh8PAr1hSfEm3aCQ==
X-Received: by 2002:a92:d24a:: with SMTP id v10mr4743833ilg.224.1596214144611;
        Fri, 31 Jul 2020 09:49:04 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:04 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 07/15] iio: sx9310: Use long instead of int for channel bitmaps
Date:   Fri, 31 Jul 2020 10:48:44 -0600
Message-Id: <20200731104555.v3.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Uses for_each_set_bit() macro to loop over channel bitmaps.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3:
 - Added static assert for number of channels.

Changes in v2:
 - Changed prox_stat to chan_prox_stat bitmap.

 drivers/iio/proximity/sx9310.c | 39 ++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index c46584b4817b4a..8f80a4c20ac05e 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -119,6 +119,7 @@
 
 /* 4 hardware channels, as defined in STAT0: COMB, CS2, CS1 and CS0. */
 #define SX9310_NUM_CHANNELS				4
+static_assert(SX9310_NUM_CHANNELS < BITS_PER_LONG);
 
 struct sx9310_data {
 	/* Serialize access to registers and channel configuration */
@@ -130,7 +131,7 @@ struct sx9310_data {
 	 * Last reading of the proximity status for each channel.
 	 * We only send an event to user space when this changes.
 	 */
-	bool prox_stat[SX9310_NUM_CHANNELS];
+	unsigned long chan_prox_stat;
 	bool trigger_enabled;
 	/* Ensure correct alignment of timestamp when present. */
 	struct {
@@ -140,7 +141,8 @@ struct sx9310_data {
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
-	unsigned int chan_read, chan_event;
+	unsigned long chan_read;
+	unsigned long chan_event;
 	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
@@ -283,15 +285,16 @@ static const struct regmap_config sx9310_regmap_config = {
 };
 
 static int sx9310_update_chan_en(struct sx9310_data *data,
-				 unsigned int chan_read,
-				 unsigned int chan_event)
+				 unsigned long chan_read,
+				 unsigned long chan_event)
 {
 	int ret;
+	unsigned long channels = chan_read | chan_event;
 
-	if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
+	if ((data->chan_read | data->chan_event) != channels) {
 		ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
 					 SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
-					 chan_read | chan_event);
+					 channels);
 		if (ret)
 			return ret;
 	}
@@ -535,6 +538,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 	unsigned int val, chan;
 	struct sx9310_data *data = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
+	unsigned long prox_changed;
 
 	/* Read proximity state on all channels */
 	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
@@ -543,24 +547,23 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
 		return;
 	}
 
-	for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
+	/*
+	 * Only iterate over channels with changes on proximity status that have
+	 * events enabled.
+	 */
+	prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
+
+	for_each_set_bit(chan, &prox_changed, SX9310_NUM_CHANNELS) {
 		int dir;
 		u64 ev;
-		bool new_prox = val & BIT(chan);
-
-		if (!(data->chan_event & BIT(chan)))
-			continue;
-		if (new_prox == data->prox_stat[chan])
-			/* No change on this channel. */
-			continue;
 
-		dir = new_prox ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+		dir = val & BIT(chan) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
 		ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan,
 					  IIO_EV_TYPE_THRESH, dir);
 
 		iio_push_event(indio_dev, ev, timestamp);
-		data->prox_stat[chan] = new_prox;
 	}
+	data->chan_prox_stat = val;
 }
 
 static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
@@ -717,13 +720,13 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
 static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct sx9310_data *data = iio_priv(indio_dev);
-	unsigned int channels = 0;
+	unsigned long channels = 0;
 	int bit, ret;
 
 	mutex_lock(&data->mutex);
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength)
-		channels |= BIT(indio_dev->channels[bit].channel);
+		__set_bit(indio_dev->channels[bit].channel, &channels);
 
 	ret = sx9310_update_chan_en(data, channels, data->chan_event);
 	mutex_unlock(&data->mutex);
-- 
2.28.0.163.g6104cc2f0b6-goog

