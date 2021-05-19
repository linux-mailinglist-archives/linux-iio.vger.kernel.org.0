Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60CD3889C8
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbhESIxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 May 2021 04:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343840AbhESIxL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 May 2021 04:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89454613BE;
        Wed, 19 May 2021 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414311;
        bh=GIEJxGG9nxCY0eLF6InjggDcNAM0Z1TTWf2XzhFZ2Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyRxtXxTC0vqDnj1xGKFijeG8czDKJQUHj58fzB8dkyanCON7gwXsjGmzxQUxOMbb
         sOnRIFSE2+v4OJ6mnmjJL8zPtffnTJ9BJkz7tFwWXNw31NR5uAZbgTk4O6mgZThQYA
         9GC3rCa59yEAfObob0hDWI4wC6FJ+Jvdc0mPq3vJCllSZnT5hkwYhX3sdmJEyUXRGF
         H/mmHg8XTessfwB9iKkUp23zjryU3YCOZIW5izz35henCQJTEjpx0INDygY4RzWpDA
         vISXkP974lHzvnDPn+bgNQ3fan9GOTkAfB6fWPHelY+ivn/Swpxj/TSCsFIfLyd3XB
         8o0gci3iGdayw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHvh-007gYY-Ph; Wed, 19 May 2021 10:51:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] iio: documentation: fix a typo
Date:   Wed, 19 May 2021 10:51:47 +0200
Message-Id: <ebe6c6597409fb9748e6c05d8e8cb3bd3fa4c6f4.1621413933.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621413933.git.mchehab+huawei@kernel.org>
References: <cover.1621413933.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Descrption -> Description

This causes some errors when parsed via scripts/get_abi.pl.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 267973541e72..433fe0ab74be 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -786,7 +786,7 @@ What:		/sys/.../events/in_capacitanceY_adaptive_thresh_rising_en
 What:		/sys/.../events/in_capacitanceY_adaptive_thresh_falling_en
 KernelVersion:	5.13
 Contact:	linux-iio@vger.kernel.org
-Descrption:
+Description:
 		Adaptive thresholds are similar to normal fixed thresholds
 		but the value is expressed as an offset from a value which
 		provides a low frequency approximation of the channel itself.
@@ -798,7 +798,7 @@ What:		/sys/.../in_capacitanceY_adaptive_thresh_rising_timeout
 What:		/sys/.../in_capacitanceY_adaptive_thresh_falling_timeout
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
-Descrption:
+Description:
 		When adaptive thresholds are used, the tracking signal
 		may adjust too slowly to step changes in the raw signal.
 		*_timeout (in seconds) specifies a time for which the
-- 
2.31.1

