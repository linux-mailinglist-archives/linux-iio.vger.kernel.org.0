Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30DB32F30A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 19:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCESpJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 13:45:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49364 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhCESoh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 13:44:37 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id a79710fd8a3dea04; Fri, 5 Mar 2021 19:44:35 +0100
Received: from kreacher.localnet (89-64-81-9.dynamic.chello.pl [89.64.81.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 905FD663EA1;
        Fri,  5 Mar 2021 19:44:33 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v1 3/4] IIO: acpi-als: Get rid of ACPICA message printing
Date:   Fri, 05 Mar 2021 19:42:29 +0100
Message-ID: <6250192.e2TqKytQZN@kreacher>
In-Reply-To: <2775419.haJ69vZeI0@kreacher>
References: <2775419.haJ69vZeI0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfelheffhfetffelhfelteejffetteetgfetkeejvdfhfeeftdeufeevgeevieevnecukfhppeekledrieegrdekuddrleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvghtpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuggvlhhvrghrvgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use acpi_evaluation_failure_warn() introduced previously instead of
the ACPICA-specific ACPI_EXCEPTION() macro to log warning messages
regarding ACPI object evaluation failures and drop the
ACPI_MODULE_NAME() definition only used by the ACPICA message
printing macro.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/iio/light/acpi-als.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/iio/light/acpi-als.c
===================================================================
--- linux-pm.orig/drivers/iio/light/acpi-als.c
+++ linux-pm/drivers/iio/light/acpi-als.c
@@ -26,8 +26,6 @@
 #define ACPI_ALS_DEVICE_NAME		"acpi-als"
 #define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
 
-ACPI_MODULE_NAME("acpi-als");
-
 /*
  * So far, there's only one channel in here, but the specification for
  * ACPI0008 says there can be more to what the block can report. Like
@@ -91,7 +89,7 @@ static int acpi_als_read_value(struct ac
 				       &temp_val);
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS %s", prop));
+		acpi_evaluation_failure_warn(als->device->handle, prop, status);
 		return -EIO;
 	}
 



