Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27A4F77CC
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKKPfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55151 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfKKPfk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so13790475wmi.4
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 07:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c4UaxyvklkVUid1A0WwdmyjZMCmwAFkWblBVGXHBIG4=;
        b=kIOrsFjScJCngxyWvA3HUU+Ko2BUMp9vKgM47xy5iBhnJhuaZOV2Nxf/zqWizLncj/
         5qdAQkRJHvp5FAsI7ofGUJTR5DcNX1ZnXycOHKjaq9Rm5qE7tlA04v4KLULAFDXfl25C
         juPoHzgm2vWDm6LX+X7+h2k076zc2jGWD2NCohaZlJ9eJHhkE5GiyCvSKOC+2VrAyJqq
         uHUhIBriEOwYgSoiDN5/C8tIk9e2s2bvXBVcvJ5Lk/VuglVbEu+03yOSz/xh1gOr49RD
         Bj7jLogUqSNu+/eZNNPvjtygVG4pYbZe5NKq3lO7gqFK5W+0X59HXCI5WMt+kcd+sxrk
         rR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c4UaxyvklkVUid1A0WwdmyjZMCmwAFkWblBVGXHBIG4=;
        b=qIoavex+7FY8PXP+gynKvuYwCiTa2xkMNQJ3/1zjNSc6VoyH7sRCwWX4Na/HLlMAhQ
         TBsoJJvnEItGUOV44AoM3i8YjJ0VL0eH2/inq2Foffr3w7GK5kkQ+AFO3uItZjujvGi5
         PG8yI67ldyFW+xgn5eqLswSZ/dHE3u78jJ5KROnbuR4luY9BsiUTaDPhJ6z50/KucKcr
         CK6B/hUIJxZpa/56xE+abuocvXR33TAP+MS4f/aV5QHFOgTNikU2VDfK14+KNFFzYzY3
         9yg7CXeSSqbtUuEIzkKXqnSj92+AsvzxTSJle/EZYFPyx69k+aWF8AFDPYxhMEKTAS1/
         O99A==
X-Gm-Message-State: APjAAAVa5yo2wcDNt654Xpzwp9ZC+01a9oP5JVtL04LRi9mo2MXcR4ov
        qwkFVRAP/d68MqUu4lg350o=
X-Google-Smtp-Source: APXvYqw2fRzpHSbD4K4Gsekt9z3gbEqd1FZRpCmBgMU8tADa/phjC+xHthMwhlsSRsUnv6N8q6tD3Q==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr10218235wmc.164.1573486538315;
        Mon, 11 Nov 2019 07:35:38 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:37 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v2 6/9] Documentation: ABI: document IIO thermocouple_type file
Date:   Mon, 11 Nov 2019 16:35:14 +0100
Message-Id: <20191111153517.13862-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
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
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
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
index 94f7eb675108..2cf2c800dba2 100644
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
+		Thermocouple type i.e. J, K, R, ...
-- 
2.17.1

