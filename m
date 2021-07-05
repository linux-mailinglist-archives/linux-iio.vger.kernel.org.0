Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9E3BB8DD
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhGEIXJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhGEIXI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:23:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EEC061574;
        Mon,  5 Jul 2021 01:20:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b14-20020a17090a7aceb029017261c7d206so8290645pjl.5;
        Mon, 05 Jul 2021 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19qNksG3pa57GXuH7o9u4eMtasQffXDZRLPl8079NZc=;
        b=C2v0XNBOjPHtRXzsMG/CkTGP4HlXIOO5rA2U+wqtQGtDpyK71SgVm6XA1wwK+w5Cn0
         nZeT5fNgukYWU1/tQaSd9eLM1qSYOjQlb9naBmVErGG3gLqv1qIWJUx6oCy0j8B+Zkdt
         NbVzFPEqcPUqSd+ue9EXydHOShSP0UKlNh1JJH8nUvErsGrIDbqP0Hn78zywq1jPvnHZ
         ZDgNqPC9nC+CosTd7yVGvpI7MLiLdrQa8zzAYWGHm5m19qKi8hLershHmPD4IKLAbef1
         0/2sA+jG/IE2VA1OmBg9N97r2fPikMGKBFCk886TabbII4gFtgwqJQkw1dCtxVSk/7Ul
         i0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19qNksG3pa57GXuH7o9u4eMtasQffXDZRLPl8079NZc=;
        b=jdSwv5PIeDquz02NwgdmRJH1/DlH9YpRWpn5f+0LKXQidC1kNWI+7nH43q62ocOLzF
         Y9WvW0DzUly0NRJzXhzlGmU1hD+QMr60j1IrH//mwXpFmDn3tWdlGg9nO7GbOAlAQkG6
         gUtres/np40u0SKn6+hSAOeBBmyWtSNkYkU9vEWIWInNw4wtnj3nV7a5DxPjP8K6dueY
         MZTa7pYNqp6rbCmT68uvqpfGM1VTiLXOJbSbHG110LT/4hdm09lQ2FvWjDJhY8YvAXrH
         tTwo0zr3H9RXcelReap10veMvLRQo6LZ/T1GSgAy+g0hONq+7uGTr8n7QBVqlsIEPwmy
         9Qvg==
X-Gm-Message-State: AOAM531IeuB16ihucDZPJQNmaCbVgS8TRkZFoueRIfMjzlUTiVS8j1DO
        TiRtZrI1qxVmGwbeG5W5c1s=
X-Google-Smtp-Source: ABdhPJzWzeNQTmMBqUqK131AtbTR2wxqO1FajJEp6WAeWyl3ugWYQ5QRCVnGkGji2B5VlXgGQYXDuA==
X-Received: by 2002:a17:902:b7c2:b029:128:c1cd:241e with SMTP id v2-20020a170902b7c2b0290128c1cd241emr11604678plz.14.1625473231528;
        Mon, 05 Jul 2021 01:20:31 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y11sm12209986pfo.160.2021.07.05.01.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:20:31 -0700 (PDT)
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
Subject: [PATCH v12 13/17] counter: Implement signalZ_action_component_id sysfs attribute
Date:   Mon,  5 Jul 2021 17:19:01 +0900
Message-Id: <472b3f1cce1bbfedd2031cdb70d0348f3802e821.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1625471640.git.vilhelm.gray@gmail.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
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

Cc: David Lechner <david@lechnology.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter |  7 ++++
 drivers/counter/counter-sysfs.c             | 45 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

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
index 07588130600a..bb49a10f160b 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -533,6 +533,46 @@ static int counter_name_attr_create(struct device *const dev,
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
@@ -627,6 +667,11 @@ static int counter_sysfs_synapses_add(struct counter_device *const counter,
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

