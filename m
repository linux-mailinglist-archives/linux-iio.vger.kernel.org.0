Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA922CE811
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 07:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgLDGVx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 01:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgLDGVw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 01:21:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B167C061A55;
        Thu,  3 Dec 2020 22:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lkYTuLMVK3xD9H7nEaU3PUg6Qinz0z5CmtM+kw5zPU4=; b=jH+c22Wy24yIKOi4p5D4DkSZpO
        c1qUx4pZJK/icmnYLd7+KBq6G+PYGEb/0ASbAQu3pqo1ZdACSPTaaIH/A7OPsQXtoaWsqTv07YaCP
        W3zl58aklGWE43jgLHD15urh/YTyC803eSSXqijtE3R3Wx3qR22rbKEctZJZa483VZcyhdMca2/N8
        q1nETUGyMccy5Dy+RX8cQ+UnxkxP7D9ZPBC5rzQHZYKvnAjkeaBzncu2b44WkwJB8UUu+gHMeSG/b
        ddyFJjP0N72s33db+0cvJWEgb76qZtsgU9QHWJI9EN1rGcNtgBh45toyHrf5uY9RdhDhvUE9FUnBP
        ZLORjhRg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kl4SV-0002HZ-UF; Fri, 04 Dec 2020 06:20:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Alan Ott <alan@signal11.us>
Subject: [PATCH 5/8] Documentation: HID: hidraw editing & corrections
Date:   Thu,  3 Dec 2020 22:20:19 -0800
Message-Id: <20201204062022.5095-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204062022.5095-1-rdunlap@infradead.org>
References: <20201204062022.5095-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Do basic editing & correction to hidraw.rst:
- use "hidraw" consistently except at the beginning of a sentence
- add archive.org URL for signal11.us since the latter seems to be MIA
- use a list for 2 URLs so that they don't run together


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/hid/hidraw.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20201201.orig/Documentation/hid/hidraw.rst
+++ linux-next-20201201/Documentation/hid/hidraw.rst
@@ -21,7 +21,7 @@ Hidraw is the only alternative, short of
 these non-conformant devices.
 
 A benefit of hidraw is that its use by userspace applications is independent
-of the underlying hardware type.  Currently, Hidraw is implemented for USB
+of the underlying hardware type.  Currently, hidraw is implemented for USB
 and Bluetooth.  In the future, as new hardware bus types are developed which
 use the HID specification, hidraw will be expanded to add support for these
 new bus types.
@@ -31,9 +31,10 @@ create hidraw device nodes.  Udev will t
 directly under /dev (eg: /dev/hidraw0).  As this location is distribution-
 and udev rule-dependent, applications should use libudev to locate hidraw
 devices attached to the system.  There is a tutorial on libudev with a
-working example at:
+working example at::
 
 	http://www.signal11.us/oss/udev/
+	https://web.archive.org/web/2019*/www.signal11.us
 
 The HIDRAW API
 ---------------
