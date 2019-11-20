Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB756103DAB
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfKTOt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56136 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfKTOt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so7234110wmb.5
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdMYiFuOvyNlGLkZxBQQ30nIniyERoe33IWXlfbDnCs=;
        b=D4RW4tyvGi/OLqZZwZaS3AW2yybHCu4REsnd6l2QqtqxOg2PyU760s9uoojEAUelbQ
         3Z6YFTCx2xuKHVmHD++3SAJlMXdLEMc9KXBt5LHfeBsqrC7nWiNSVT0bL8gLOOcVoJdV
         awKeJ3E2Ddc3PU8U2otjvbVlSbEYNTDKpl3cyoledmAM2mrxVvTgPfxa3heZKkhgxcUY
         bKoMblukb6BSytBPzpVK26DcbxRdxtFHxwYLtPwJ2h7p1whBCZE7lgMmpB8Fxnxf/7VV
         o+Pj8L5Iq0kct7IzNR3VlX0ZDdlnEwLWblKtoc3agJnCk+UG1vqGA2stsnVwxBfDfgBZ
         IztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zdMYiFuOvyNlGLkZxBQQ30nIniyERoe33IWXlfbDnCs=;
        b=j2yJd3dAcUajt9H8RzSZL7pHZprJe9BXU0JiudSIMRF1Nelx427UexOxqC36YGLsFV
         PcZGUqJMELMM8mh8bk8Z0JtKpOc5D9EOvrI2O2eDxdHOqKMyHXtmSY2c3FoP1sSHvnJy
         h1J7Emli8s/rsqxHnHjCVPluM+hYxbpF8sretjfHu+QQdB8A7NnQaLN/gF82o7DgClzA
         9rEHf7M4MJx7G/Nro0ITdgFq2ht5BNj/tH+quNEldgGINVN3Tb1PLcf18qRI+T1ab9FL
         D23kDygxSyU08tAFmubW49Crs5lUfLaDu/MViuykADEZ5zeJckCCsIwh9Z+tJnv1joqa
         Ok2w==
X-Gm-Message-State: APjAAAXjLeFwBxg1yCNo/JzbumIsjCW8fFag8yT9o9x2m2y+UTY+EMT1
        OV1Cjr83ShpK4psPSe+Qnho=
X-Google-Smtp-Source: APXvYqyU2+N0mA/ChX3rchSysSEgWcOOmRHL7IDYEa82fspJYlefkdAaNK1euzeB8Z9AkTeADg3Lcw==
X-Received: by 2002:a05:600c:2103:: with SMTP id u3mr3884101wml.150.1574261365379;
        Wed, 20 Nov 2019 06:49:25 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:24 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v3 6/9] Documentation: ABI: document IIO thermocouple_type file
Date:   Wed, 20 Nov 2019 15:47:53 +0100
Message-Id: <20191120144756.28424-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IIO core layer gained a new sysfs standard attribute "thermocouple_type".
This patch adds it to the list of documented ABI for sysfs-bus-iio

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 94f7eb675108..d3e53a6d8331 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1733,3 +1733,9 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Center frequency in Hz for a notch filter. Used i.e. for line
 		noise suppression.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_thermocouple_type
+KernelVersion:	5.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		One of the following thermocouple types: B, E, J, K, N, R, S, T.
-- 
2.17.1

