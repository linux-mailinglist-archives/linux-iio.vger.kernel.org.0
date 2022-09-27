Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A895ED077
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiI0WyO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0WyM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:12 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA6B514A
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:10 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1280590722dso15237469fac.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y2Nb7qwlsGg2W87p+FZPAizUVnpTSuZLXpD7yAHCFxY=;
        b=ezUcRZ6s+upZlQqP0rGnqjvYcj1+Yz6/MbYfC+4YGB9pMllYks03v33zt3U9Mkg6dM
         IqG9n03rc84UipsQdK3w1F5pVeznlCItTc/R1o+lvjt4QPoKmLB/Yr9wMbuabxzu723x
         CcL8hf6W7my5y5hHMaQ5rvmmAB3oZWIUnOy8quwq+MOWpIPNvWgcgDgj+enGdGbbMm6V
         D+m7CbHyC/kNIieO9tYouePTc2YpNgDZS1b3ODhZ/P6bbaoYy8wnIjYVCm9p9OTlG6Ao
         ZPFKZLbqT+w5TH4x1GnVJOgpExiHxgtcqDT3mbT2qxrlCrSQG5yi65BYZDCrmUIS28VF
         0nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y2Nb7qwlsGg2W87p+FZPAizUVnpTSuZLXpD7yAHCFxY=;
        b=z+iGeE+hT9MGp5YIAA1z4+get3ro0OBrMv87/OmvLauC8PMtHvqV25nEHIC1E16354
         h1LO+/2nn6uh+q6tUad+QCMd3tHLOefa8bwHYG2aZJvoU/AJGBbltJldm3/IAwoW3uTd
         wc4HdMhpPpfZ8A4G/ULiAQsfz0pCg7vfPHvs646fVKCNr4QxjijFkoXcTHz7Or/EKlyi
         40QB8gW06aJU3AU/60F3QgjoEZREJJ9haHkVMKFDdwM/TnEfAd/4ZbKJ7jb7JrEDP9pN
         6cRdE3YL0AeTR/k5xjELnli/z4KSSvjJNMAsDFf8P5OVBvSes0P18MqyqGXfp5bVoanI
         qttA==
X-Gm-Message-State: ACrzQf30PahEWe7nhkWIic8mWG7nql3VM0rI1/MkOBBqumIFVabfFu/V
        HeFFB1U5G7e9JJkeNIe+R9RX3Q==
X-Google-Smtp-Source: AMsMyM7DHTboXKOPpNBj/Ti0HpyvCExd+tarccrcCIETHRS7CzjTx84BJWEHLg8LZxxvgMUBNXOWoA==
X-Received: by 2002:a05:6870:3052:b0:131:932c:3316 with SMTP id u18-20020a056870305200b00131932c3316mr1890923oau.288.1664319249886;
        Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:09 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 05/12] counter: 104-quad-8: Add Signal polarity component
Date:   Tue, 27 Sep 2022 18:53:39 -0400
Message-Id: <0bf840beee1665e9f04ea82368ecdde87c791a22.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 104-quad-8 driver provides support for Index signal polarity modes
via the "index_polarity" Signal component. This patch exposes the same
functionality through the more standard "polarity" Signal component.

Link: https://lore.kernel.org/r/01d00c21873159833035cb6775d0d0e8ad55f2ef.1664204990.git.william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1323edfbe40c..2a9d8259ed4b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -549,6 +549,32 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	return 0;
 }
 
+static int quad8_polarity_read(struct counter_device *counter,
+			       struct counter_signal *signal,
+			       enum counter_signal_polarity *polarity)
+{
+	int err;
+	u32 index_polarity;
+
+	err = quad8_index_polarity_get(counter, signal, &index_polarity);
+	if (err)
+		return err;
+
+	*polarity = (index_polarity) ? COUNTER_SIGNAL_POLARITY_POSITIVE :
+		COUNTER_SIGNAL_POLARITY_NEGATIVE;
+
+	return 0;
+}
+
+static int quad8_polarity_write(struct counter_device *counter,
+				struct counter_signal *signal,
+				enum counter_signal_polarity polarity)
+{
+	const u32 pol = (polarity == COUNTER_SIGNAL_POLARITY_POSITIVE) ? 1 : 0;
+
+	return quad8_index_polarity_set(counter, signal, pol);
+}
+
 static const char *const quad8_synchronous_modes[] = {
 	"non-synchronous",
 	"synchronous"
@@ -977,6 +1003,13 @@ static struct counter_comp quad8_signal_ext[] = {
 			       quad8_signal_fck_prescaler_write)
 };
 
+static const enum counter_signal_polarity quad8_polarities[] = {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
+static DEFINE_COUNTER_AVAILABLE(quad8_polarity_available, quad8_polarities);
+
 static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_modes);
 static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_modes);
 
@@ -984,6 +1017,8 @@ static struct counter_comp quad8_index_ext[] = {
 	COUNTER_COMP_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
 				 quad8_index_polarity_set,
 				 quad8_index_pol_enum),
+	COUNTER_COMP_POLARITY(quad8_polarity_read, quad8_polarity_write,
+			      quad8_polarity_available),
 	COUNTER_COMP_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_get,
 				 quad8_synchronous_mode_set,
 				 quad8_synch_mode_enum),
-- 
2.37.3

