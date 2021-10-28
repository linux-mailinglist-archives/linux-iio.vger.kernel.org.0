Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3324843DE97
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1KVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhJ1KVU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:21:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19DC061767;
        Thu, 28 Oct 2021 03:18:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so23021163edb.2;
        Thu, 28 Oct 2021 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DcV64tc0qvgdVwwFKA7XLINZsdu2DjP4lxKGb7WkvaI=;
        b=hE/CWrw4YyhqFvyErNGlu979sNMjkTVguJMBxkQW2WiRSLjVCWvlvvzuBqnSukqoDA
         2EgZE+SrOzhcyTv/tsZW6iXUoqKw9pmeH7mEJXtbDgmnrAhi21qV/jxYOiKDVoZtC6ga
         eAnkoNa7yJBy/Nz7cFLxZiyxtYBxv1c7gTZwLGk3b5m66+VEkuTrdda24/Zs20k767Jw
         O3sgv/oYwKhmScx1543cXKKOuAZ6jYk1ojoq/V3jSWbGJcwbHKxjFUCgZce702EAQD6r
         EJq1iJDgIBJ3QpCvBBB6L6xuFhS4yFLY2e++Ou9tDxFKmDMvwdD1HhDZzJgJyGVIdqE4
         YJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DcV64tc0qvgdVwwFKA7XLINZsdu2DjP4lxKGb7WkvaI=;
        b=FcDXQG6Mb3NkfoR4sg+F+sD403SmQ+TIQF8gtBy3xkUsfD7xDMto9Z+Wb/9pzqJKWL
         TXFH100A1TzsWlLCEmGk9g4oEW5DlwNzLIZHiZjPQaiC2GTPj2oV0yFb6EsSrynpCzb2
         tVRCsVf1UZAV2/9+WFSPqtdeuR8wzyDXNpox7RdN7KtBxn6E7lfoxlbTVzodnNau129m
         7CgAcr28J7NoCfxef/F6TXOWYnX1XaSP2elxP/eX2cFfQgeszwfKZ3VXHAutlNrwBZvV
         An+4ZzMCG4BpXF9DPDGBFHFqw+Q7yYcakSUPXZsY+mX2j+9R5mu6JTXDUI4MPWRSIt8B
         oBVQ==
X-Gm-Message-State: AOAM531maIAdL5Ian9kFmdM20PLyAe3JRs+tf3xcKJ1ciXOBeFe82cq5
        h2VfpF3PxixFNeaWe3HB++E=
X-Google-Smtp-Source: ABdhPJyoKiQc39RqVleai9q76HukcBcgEry1Ao8OcNzBSQ1jjKtEjUAw8rwfQ9lXremQKB36cwaGmg==
X-Received: by 2002:a17:906:5343:: with SMTP id j3mr4151598ejo.538.1635416331845;
        Thu, 28 Oct 2021 03:18:51 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.googlemail.com with ESMTPSA id mp9sm1175071ejc.48.2021.10.28.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:18:51 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v2 03/10] iio: document euler angles modifiers
Date:   Thu, 28 Oct 2021 12:18:33 +0200
Message-Id: <20211028101840.24632-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028101840.24632-1-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces ABI documentation for new modifiers used for
reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5147a00bf24a..f0adc2c817bd 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1965,3 +1965,11 @@ KernelVersion:	5.15
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) linear acceleration readings.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
+KernelVersion:	5.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) euler angles readings.
-- 
2.17.1

