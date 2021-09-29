Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F9441BD3B
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 05:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhI2DSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 23:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbhI2DSk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 23:18:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BA0C061746;
        Tue, 28 Sep 2021 20:17:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3196943pjc.3;
        Tue, 28 Sep 2021 20:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaNorZsjU8hM7wfPjt4kkgWnkshK3kwrpC14sR+dG8Q=;
        b=MTVhbJ0g2H5Q+y+iwaUM+Bh3FGIN3AqPmcifP/Sor+H7DhGOwW0d9tGv3+DDvgwcy/
         fq6kwXM9UFWAnOHeZ4ndeQY8qRMgDmuCVSohk8BOwv4hKUaJE5pPBFICkQwsJBHimGJC
         QMrlvc4GXCVuNig9YsfSQgGaNuafpLSjFesxO8ou6zgx4oOQ0/mjWpXPlawd73Ckur/S
         xOWa4GYZqR3N8YIABc8ZCr2IoUKsRjG0vYwRYKL47L/vmYzI6xSv7KcCkr38HUtOZv1i
         oCRHaL47cSKjBYzBA5+xzlJ94/SgSQ5VgYd9zT0Tg0SzJMcpt4hrwD9oPiJxtG9fxc5j
         iUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaNorZsjU8hM7wfPjt4kkgWnkshK3kwrpC14sR+dG8Q=;
        b=beRjKDqCmDJLTPuo1Bu5ejKUJXMghQpX239fXTtKphgld58UE0zVARaAEep89/A5Q3
         WwjjdWLcErE80+1uY3dVlX/oGZusgddgB4wa/rFPm32pMRP6G9JKezBatRgMSQm0xv7u
         dGufkHIEDGdhx/syBE1l1QNaPNDDDvZDT4myZ7O6M8I2Rhy1H/vYy+zrwIZgHijk1mvD
         AAX9xmdQXC+icdlr6RHT901CltGPDGFQ5Ah+kBZUsXXyWx8MYtjfrke2c7t6XtEkZUcx
         WBgCU1mXExmBbsJP0/9qQjxl7jCs0HwJ3EPixUnWvLNOMRZvKxmzq+CO3mKYdzIhme4T
         QnBg==
X-Gm-Message-State: AOAM531xIIyEqGawwApTPyaZ+LHN/F55CB8xCMUSf1u0P1dHASutPcD4
        +OzAzJYX4ykkg1CXz3mzVPQ=
X-Google-Smtp-Source: ABdhPJxBpjh5/Urwl7VFC61ZKNbPqzhscwCBb5zGrk+2nHYlWmkuEdjJRuRpMBa/oiQGCRPbmsYQnQ==
X-Received: by 2002:a17:90b:3143:: with SMTP id ip3mr3964650pjb.50.1632885420262;
        Tue, 28 Sep 2021 20:17:00 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 65sm464203pfv.210.2021.09.28.20.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:16:59 -0700 (PDT)
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
Subject: [PATCH v17 5/9] counter: Implement signalZ_action_component_id sysfs attribute
Date:   Wed, 29 Sep 2021 12:16:02 +0900
Message-Id: <a6c81b2f1f5d0b8d59b1ebe4f0fed04914b07547.1632884256.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1632884256.git.vilhelm.gray@gmail.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
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
2.33.0

