Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9133341AFA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCSLDz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCSLDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:03:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3431EC06174A;
        Fri, 19 Mar 2021 04:03:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bt4so4459529pjb.5;
        Fri, 19 Mar 2021 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvvZ2pFbiubk/RaFwxqoeYMzhVunEOAm5oGM3eeUGTQ=;
        b=QJV7fv95tRRdF9dMz2rMqAh3PXAvZhzETCESyHORpq7x8zaFNohYd+hcP9fOE5yOWq
         lk90CY0uPOLq9ALlpUjAcKv8rVibRlqvUd9Kn/fP93rV8PAANO23klH6qn3imFYw1LGx
         nj0Khb283VbK6JHmRMPXFkvFvt68CivKVNdq3emh26UT1e3bSM3KdoMaswBNbOTfh52Q
         83x9/PX6yL0I/N/MwcdzPKlHyK26Z/AWQrWrr4g9rpjtJ5Zk3/raOkkKPI/maZ9E6lVT
         eSngc/ZSbSYu0q30HqpIGgiPzLxrbV+hs53seao99ATGuNJSvJ4hyp2xiX0OQ2hQxBrp
         Taow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvvZ2pFbiubk/RaFwxqoeYMzhVunEOAm5oGM3eeUGTQ=;
        b=S5oxhe7ZebgoSutVRmQp1tN7L/FHuDDjlUT6xiH/T1p+E2VxjDvylg1Va3P568Guv2
         XGgxD3Yk1iOsfuynwlBv+loqxH2TpLcUCg4fBSctMpO7PTsl+XJmdZ4ojT0H3NKQiKCM
         yR1vpBxbvexATjbrMhVp5eWLUTFxJ/T+d/ANy4pZnUJG2KVHTK1cPBycPMco5r+tpLEP
         jDKUs+ZmYgiMG3UiF5nZF4168LvqIcZSSFE6riDeN1bj4PHicwxgT37oZXZMWD2kYiLB
         bshYidn8QrkqiPsq8au/77HXmfBTsyJkLzzcPdTUTEqPZZ6BWR2mYYjtxY2hDYLzT8f3
         q/dw==
X-Gm-Message-State: AOAM532qxzk1XQ27EchGvyojxn/DCEaGTj5Nx8SjcI8jVhYsbvu10hyk
        meuuWLnTm9seOUWjCHZMS18=
X-Google-Smtp-Source: ABdhPJySR2eEoe+Yo+Lcvmnooi8jbrWZVxfL4eFoFxMkwGBmYvLZpUrXyf+N23OZ20WvIBCDGS3XPQ==
X-Received: by 2002:a17:90b:4c0a:: with SMTP id na10mr9561896pjb.227.1616151810858;
        Fri, 19 Mar 2021 04:03:30 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:03:30 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v10 29/33] counter: Implement signalZ_action_component_id sysfs attribute
Date:   Fri, 19 Mar 2021 20:00:48 +0900
Message-Id: <699de2bee70cbcdbafd7ba652849fc3cf77b0e34.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
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
index 6353f0a2f8f8..bee9289aecd1 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -203,6 +203,13 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
+KernelVersion:	5.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the component ID of the
+		respective Synapse of Count Y for Signal Z.
+
 What:		/sys/bus/counter/devices/counterX/name
 KernelVersion:	5.2
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
2.30.2

