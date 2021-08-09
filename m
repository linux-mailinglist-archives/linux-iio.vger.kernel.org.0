Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45B3E45CE
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhHIMjC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 08:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbhHIMi7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 08:38:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3EAC06179B;
        Mon,  9 Aug 2021 05:38:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a5so479193plh.5;
        Mon, 09 Aug 2021 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKMCNriu6Oe0b4ijgDqgdhWJc4dVQTXn+gR1UFw9WGc=;
        b=emOcOs9OtYl2hpoG1uGmocdYTiOr+x/C+4HIwtiawm4q2PKkfcyVaznfNYIg8X05xL
         rEXD8WBSqknqYsEG6dcHQ1lH715EQY403EYOqbaHaOn2rDfb+ZzeNbWUcS4jLecuZzqO
         r/MLxPVDXaHBiS3lT1oukAbBHABv4P2BlcKRkgRAWmW4UKKeIqlCPaXF7rJg32xRysJX
         QPl9fcZZqIItTwjH9eCiA93JcNEBVDEPP0NGsm63XZqJ0OY/ww75tQZ7ygW/yXeYlG41
         Ar/8Nz4Dj2nVRQ03+31we2bIquVFdsvgHNmHjZsByXtRX44Lhl8SyBLwPJ+BfrPoIEez
         g4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKMCNriu6Oe0b4ijgDqgdhWJc4dVQTXn+gR1UFw9WGc=;
        b=B7Vzm5G64vsRsm4Pub+B64fsvSqPta9rkNJVR6Rs3ykzKD6AkBSWxnhv+wwQfl1FvJ
         TUqXPug1rdFqxZWvfjBA/WGZqa0psTyMkRC8Y1mUDY76dhsME4S631LIzNY1LG5cIyib
         oMHPEa4Isa6JQork5KLrRVQNadztyt+Sdn22OB+kXNBrxpXF8v8EdJVgPUiWJI05Ju50
         bXIUVlhAhs0eY9CggdwEGAgF1Ge0jDO1ymEw/l3m2pvm0X+5t23WHMFM+cPr+7p1WdlQ
         TVnU/9UKoH8WEz6MrWcrkLiT7ibvvTNedvaYiRlFhErMqswvU/UuqjUh4Yp1GGFSyJpW
         D8qg==
X-Gm-Message-State: AOAM530qWN+xCiaLQHgaq2LWGUtRXnKvaGqw/xqo5FeSNHXrWOxm1Y3t
        SgV1O62eiKR48rE+FqgKUPo=
X-Google-Smtp-Source: ABdhPJwqr2htRdtyBeh2MILvtPISM2foEQ7rRT86QHqHJ2+DnDJv9ziRaXIZgIiAaMXUBO4mrm/vMQ==
X-Received: by 2002:a05:6a00:1a0e:b029:3c2:ee2f:b236 with SMTP id g14-20020a056a001a0eb02903c2ee2fb236mr23792542pfv.80.1628512719140;
        Mon, 09 Aug 2021 05:38:39 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id e35sm22382177pjk.28.2021.08.09.05.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:38:38 -0700 (PDT)
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
Subject: [PATCH v15 09/13] counter: Implement signalZ_action_component_id sysfs attribute
Date:   Mon,  9 Aug 2021 21:37:34 +0900
Message-Id: <d72159ab7ebfe607d86c0ab472979e8eca6f16a0.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
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

