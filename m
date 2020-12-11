Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B602D709E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 08:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgLKHKm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 02:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbgLKHKY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 02:10:24 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B7C0613CF;
        Thu, 10 Dec 2020 23:09:44 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w16so6508660pga.9;
        Thu, 10 Dec 2020 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=agSZMQdvaCGV7hdnrq9aTuJTFu3GU2xvnWahrOKp2Jc=;
        b=iaCwlxTDrUkLZaR2IE70DXZlzMvfp14eegDu7lsHhJVqA94v1rPO5Tw4Re0cXWzUs5
         tTdmMAeE833iUuG2ImjX+nRar2krQmwfag0rFEsw5K4ZZDSsw9fPPIUx1J2XQU6rwbnH
         Kz55ev9L7xh0UTnBPP41ch7Fo9bpfKhtijuuRjlbCoQIPm6fHPuAydEfkg/7WaDcnUw2
         KrX/PojTaAYfFOJojhEJH0JOWh5+06NYveWE7iDEGwTmJRic5BIrac7SqUas4AAAIZYJ
         M0gohUFiRGvu59MmoW09LRLN4qrmmTOMEwyEoyc9qQHocn+A30QS9pv/UEmoXPeSjRD6
         JYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agSZMQdvaCGV7hdnrq9aTuJTFu3GU2xvnWahrOKp2Jc=;
        b=dqWcGVMx6IB8U9g6alO7K1sU0PMOKrfe81K+1noR5utrQcHIYWRGLVmEDYq704aFgV
         OxIAvtHeAuYlI2OS/mEk/U47vrzcJVVmw7lBK978XBwOe6bqplXKbaNuCA2FEEqCBElA
         ATFNTQHNyPJ7cupDjc48mqAVd/pvU0rZUX8QnyaLzz3AVG45GoJbC0WayihkDEI7oaSX
         ik3LG6RpifogWt1Nngg03d2xFNU2FtXpWWVlV9Da1Kx3dogpjH1c1nU6207u9l3pL+fQ
         zm3TsSck8qBkTCHlY9R9Hldy0cJ/NBphlABeGl0NkbMYq0xs9oW9auTgz2For8tFUBO9
         vAgQ==
X-Gm-Message-State: AOAM533KvSO0UuBaJXzT/q33ms2fGMpBm16Ovc4Djj6vefd4jgHC/8PQ
        XgEZvGH1g+Kp4/Kov6OgHss=
X-Google-Smtp-Source: ABdhPJxv8+WMAsqzX+/A7wLGk5FIrmzTZ6C65bUsZXxoEOBEVQ55NlCjhr48qYKwqGs7+RH4FmPorQ==
X-Received: by 2002:a63:4d5c:: with SMTP id n28mr10516947pgl.88.1607670583820;
        Thu, 10 Dec 2020 23:09:43 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id j3sm8846830pjs.50.2020.12.10.23.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 23:09:43 -0800 (PST)
Date:   Thu, 10 Dec 2020 23:09:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] Input: cyapa - do not call input_device_enabled from power
 mode handler
Message-ID: <X9MbMja+TEfbKkmJ@google.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-3-andrzej.p@collabora.com>
 <CGME20201207133237eucas1p26f8484944760a14e51dc7353ed33cd28@eucas1p2.samsung.com>
 <27ce1176-6318-45aa-4e22-3dec9f3df15d@samsung.com>
 <9c784a23-eade-eacd-3e67-d344a5758b83@collabora.com>
 <ad093ba3-7b17-18f3-6bb5-d8133c3da89a@samsung.com>
 <X9BwtHs9XriwR8gL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9BwtHs9XriwR8gL@google.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Input device's user counter is supposed to be accessed only while holding
input->mutex.  Commit d69f0a43c677 ("Input: use input_device_enabled()")
recently switched cyapa to using the dedicated API and it uncovered the
fact that cyapa driver violated this constraint.

This patch removes checks whether the input device is open when clearing
device queues when changing device's power mode as there is no harm in
sending input events through closed input device - the events will simply
be dropped by the input core.

Note that there are more places in cyapa driver that call
input_device_enabled() without holding input->mutex, those are left
unfixed for now.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Marek, could you please try this one?

 drivers/input/mouse/cyapa_gen3.c |    5 +----
 drivers/input/mouse/cyapa_gen5.c |    3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index a97f4acb6452..4a9022faf945 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -907,7 +907,6 @@ static u16 cyapa_get_wait_time_for_pwr_cmd(u8 pwr_mode)
 static int cyapa_gen3_set_power_mode(struct cyapa *cyapa, u8 power_mode,
 		u16 always_unused, enum cyapa_pm_stage pm_stage)
 {
-	struct input_dev *input = cyapa->input;
 	u8 power;
 	int tries;
 	int sleep_time;
@@ -953,7 +952,6 @@ static int cyapa_gen3_set_power_mode(struct cyapa *cyapa, u8 power_mode,
 	 * depending on the command's content.
 	 */
 	if (cyapa->operational &&
-	    input && input_device_enabled(input) &&
 	    (pm_stage == CYAPA_PM_RUNTIME_SUSPEND ||
 	     pm_stage == CYAPA_PM_RUNTIME_RESUME)) {
 		/* Try to polling in 120Hz, read may fail, just ignore it. */
@@ -1223,8 +1221,7 @@ static int cyapa_gen3_try_poll_handler(struct cyapa *cyapa)
 	    (data.finger_btn & OP_DATA_VALID) != OP_DATA_VALID)
 		return -EINVAL;
 
-	return cyapa_gen3_event_process(cyapa, &data);
-
+	return cyapa->input ? cyapa_gen3_event_process(cyapa, &data) : 0;
 }
 
 static int cyapa_gen3_initialize(struct cyapa *cyapa) { return 0; }
diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index abf42f77b4c5..afc5aa4dcf47 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -518,8 +518,7 @@ int cyapa_empty_pip_output_data(struct cyapa *cyapa,
 			*len = length;
 			/* Response found, success. */
 			return 0;
-		} else if (cyapa->operational &&
-			   input && input_device_enabled(input) &&
+		} else if (cyapa->operational && input &&
 			   (pm_stage == CYAPA_PM_RUNTIME_RESUME ||
 			    pm_stage == CYAPA_PM_RUNTIME_SUSPEND)) {
 			/* Parse the data and report it if it's valid. */
