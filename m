Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D233DED89
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhHCMIJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbhHCMII (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:08:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E0C061764;
        Tue,  3 Aug 2021 05:07:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mt6so29408117pjb.1;
        Tue, 03 Aug 2021 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKMCNriu6Oe0b4ijgDqgdhWJc4dVQTXn+gR1UFw9WGc=;
        b=t16QRjZIxcuYdstsPWLMVOH/nKmuF5tZxc61xEAvfR0GMoxYmpjaQeUAS8sUFqX9jl
         YAjhlkc964yIo8VUWzcnAI5hI0QNDqpJXnAFTtLaR81HI4UGEm7iODItlB9BKddN5M6t
         qU/eHbDqLg3xO2WqXTUoeMolqnhBPPtmfr1sWKwqMnNrAqw8BRXJFKNS/2/kmxOBrixu
         JotPQAyEfy38LcVluV5FmfUksZHpQ4mtN0JWc3XaO+ElD/KITPegAlAzbiQaVjvc9D+X
         NCrO20OOyxtjKvMEwmVt9uEr/joDaV40IgIEdh/jzM61V0B69ZasMH4yrmNLOCpe2XCi
         ltNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKMCNriu6Oe0b4ijgDqgdhWJc4dVQTXn+gR1UFw9WGc=;
        b=o3dXxI+a2r/NZKS2Qy0XQKLlZuMvJnqrycI3x0WGArr/KsV6yv9xA2gjElVTGcM/5U
         RL3brh6nrMcb5XmNSyFvaz/SomlgZJf7pHQ2Ye6QB0L3XnRePfYZrStuk3pyD268aAyW
         V1tc1ohfClx3e5nV4d3sLQcD7Bvl6JHzyAjAKxda0yrtBDOu99Bs01rmyAsnIBlTbzAa
         ZoLypjW3IudoR4vC32dQ0XUmpivMUdMX6pYMOB3GCmjZIXAJiN5+TJoasHngt2w/4x10
         ZJvHUrBhySXPii3LRmcepoHdLRnQGOoKeV1JlJXXvpKZaBlRSQWyL6LLFkgsCBQ1VPmt
         MBKQ==
X-Gm-Message-State: AOAM533OkIcKQRM2H+8y/MjsWHvWPUzkZEubtOzalVm8q65LO+J2aZAH
        J7MYVdt+G0TcBy5biMI2k6s=
X-Google-Smtp-Source: ABdhPJyLpOQSNtH7EmIuEBrCh2Djo5Spq15M66GUUwHZD0BSAe1IAKjafBjht842rzJiws9CuFZIJQ==
X-Received: by 2002:a17:90a:fc6:: with SMTP id 64mr22516402pjz.1.1627992476483;
        Tue, 03 Aug 2021 05:07:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n35sm7197502pfv.152.2021.08.03.05.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:07:55 -0700 (PDT)
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
Subject: [PATCH v14 13/17] counter: Implement signalZ_action_component_id sysfs attribute
Date:   Tue,  3 Aug 2021 21:06:23 +0900
Message-Id: <7a9fc7e7272650e0d43b23a6ba65bffe889f4c86.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
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
 drivers/counter/counter-sysfs.c             | 46 ++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index dee79b606847..9809d8a47431 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -203,6 +203,13 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the component ID of the
+		respective Synapse of Count Y for Signal Z.
+
 What:		/sys/bus/counter/devices/counterX/countY/spike_filter_ns
 KernelVersion:	5.14
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index dbb507c9da11..11bef9f8190f 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -393,7 +393,6 @@ static int counter_avail_attr_create(struct device *const dev,
 	struct counter_attribute *counter_attr;
 	struct device_attribute *dev_attr;
 
-	/* Allocate Counter attribute */
 	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
 	if (!counter_attr)
 		return -ENOMEM;
@@ -535,6 +534,46 @@ static int counter_name_attr_create(struct device *const dev,
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
@@ -629,6 +668,11 @@ static int counter_sysfs_synapses_add(struct counter_device *const counter,
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

