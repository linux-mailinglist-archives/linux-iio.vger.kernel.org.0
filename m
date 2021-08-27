Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D313F933A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbhH0DuB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbhH0Dt4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:49:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F9C0613C1;
        Thu, 26 Aug 2021 20:49:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t42so4528083pfg.12;
        Thu, 26 Aug 2021 20:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2K+kS5TRvGGkXAwbGDp8tnI9+r3LlY6NFNe0uu/BE4=;
        b=k1WbMu8ca8Ct40n9Q0xZcjLb3Q4cHi9KvSJSWG2YCEFvUhdjko2wVk6ZwcMGKpdji7
         dFiETS3KdIiymhyFe2ipAfp7abuUvmRdlfnLg7t+I7TKg6eSGgBaAbKgivUReOvYT8pk
         EgV+iJYf3+f26QLfkxIF+ua6I0NBXrLubi0cajWXvPD/vQRiEXRoK9c8mMuO/EBoaNo9
         A4Qb1owPvMwn3bBPgauzPH3MYsZsR462sBPGT/1Pyp+U3XPhW9rPrbn5BY/Tt+vIXNOX
         4M049c5ZjRleUsBSb33pdVC9oQw9eyOiYVdKKNYw4KHpRfC9/4GQnLmFVyuyqoftMiy/
         PVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2K+kS5TRvGGkXAwbGDp8tnI9+r3LlY6NFNe0uu/BE4=;
        b=jcDGVFUvzKD5xhHC/Z/2p9biUr9RTHjHv6rD5m7+Snf9/4iQxNkKLC0WixjJjhPFsl
         A0FeiBz6CbrjVHjeeQ9G1M/4olIXWlDobiFgfjULlFF8I04Dldl1VOsQqYYVKaUYs+ZK
         p5jkGsVS62Ou/UMS9TJc7KBotsqyEf0SScuNBsjg54REsMrTcbNt3N5z7plxH/0YZTFM
         Uq29J6jXirKuiOFGbRksWSZNJLF/Rze1UISgkToFajpHmKq5ApK38atWHfPjmO7Cydka
         OrBsJQWhE4YBDlFiwU12cDyZRATNamKTr06vtTIXyK6lYOUihHDLCSnzJIKnuvBwXNfY
         n9bg==
X-Gm-Message-State: AOAM531MnRhzdfvxHZOFXILidYn/NldYSAOD+b3rQGSpwDs3971SuvRP
        QM09HwcYY5h/fmdyXcD1Lnw=
X-Google-Smtp-Source: ABdhPJwX1U5ELlZ+GkFtm8/nGPz8fVhImmJ/9iReiB1g6lN8ocy4/mI0Kx5nceb3/fjL3f2Vz8u2WQ==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr6107703pgq.300.1630036146775;
        Thu, 26 Aug 2021 20:49:06 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:49:06 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v16 10/14] counter: Implement signalZ_action_component_id sysfs attribute
Date:   Fri, 27 Aug 2021 12:47:54 +0900
Message-Id: <e87de8c56bd9cb5c204c12866de6c04199dee9fa.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Generic Counter chrdev interface expects users to supply component
IDs in order to select Synapses for requests. In order for users to know
what component ID belongs to which Synapse this information must be
exposed. The signalZ_action_component_id attribute provides a way for
users to discover what component ID belongs to the respective Synapse.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter |  7 ++++
 drivers/counter/counter-sysfs.c             | 45 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index dee79b606847..aa2cd3c10d74 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -203,6 +203,13 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the component ID of the
+		respective Synapse of Count Y for Signal Z.
+
 What:		/sys/bus/counter/devices/counterX/countY/spike_filter_ns
 KernelVersion:	5.14
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 108cbd838eb9..ee7ff1cde454 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -532,6 +532,46 @@ static int counter_name_attr_create(struct device *const dev,
 	return 0;
 }
 
+static ssize_t counter_comp_id_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	const size_t id = (size_t)to_counter_attribute(attr)->comp.priv;
+
+	return sprintf(buf, "%zu\n", id);
+}
+
+static int counter_comp_id_attr_create(struct device *const dev,
+				       struct counter_attribute_group *const group,
+				       const char *name, const size_t id)
+{
+	struct counter_attribute *counter_attr;
+
+	/* Allocate Counter attribute */
+	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
+	if (!counter_attr)
+		return -ENOMEM;
+
+	/* Generate component ID name */
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s_component_id", name);
+	if (!name)
+		return -ENOMEM;
+
+	/* Configure Counter attribute */
+	counter_attr->comp.priv = (void *)id;
+
+	/* Configure device attribute */
+	sysfs_attr_init(&counter_attr->dev_attr.attr);
+	counter_attr->dev_attr.attr.name = name;
+	counter_attr->dev_attr.attr.mode = 0444;
+	counter_attr->dev_attr.show = counter_comp_id_show;
+
+	/* Store list node */
+	list_add(&counter_attr->l, &group->attr_list);
+	group->num_attr++;
+
+	return 0;
+}
+
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
 	.name = "signal",
@@ -626,6 +666,11 @@ static int counter_sysfs_synapses_add(struct counter_device *const counter,
 					  COUNTER_SCOPE_COUNT, count);
 		if (err < 0)
 			return err;
+
+		/* Create Synapse component ID attribute */
+		err = counter_comp_id_attr_create(dev, group, comp.name, i);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
2.32.0

