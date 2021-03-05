Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FBA32F30E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCESpL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 13:45:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45302 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCESom (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 13:44:42 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 1d37435550e664f6; Fri, 5 Mar 2021 19:44:40 +0100
Received: from kreacher.localnet (89-64-81-9.dynamic.chello.pl [89.64.81.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 85A2B663EA1;
        Fri,  5 Mar 2021 19:44:38 +0100 (CET)
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
Subject: [PATCH v1 1/4] ACPI: processor: perflib: Eliminate redundant status check
Date:   Fri, 05 Mar 2021 19:40:36 +0100
Message-ID: <3231858.06thYagCLy@kreacher>
In-Reply-To: <2775419.haJ69vZeI0@kreacher>
References: <2775419.haJ69vZeI0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfelheffhfetffelhfelteejffetteetgfetkeejvdfhfeeftdeufeevgeevieevnecukfhppeekledrieegrdekuddrleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvghtpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuggvlhhvrghrvgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the "status != AE_NOT_FOUND" checks in
acpi_processor_get_platform_limit() is redundant,
so rearrange the code to eliminate it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_perflib.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -63,14 +63,15 @@ static int acpi_processor_get_platform_l
 	 * (e.g. 0 = states 0..n; 1 = states 1..n; etc.
 	 */
 	status = acpi_evaluate_integer(pr->handle, "_PPC", NULL, &ppc);
-
-	if (status != AE_NOT_FOUND)
+	if (status != AE_NOT_FOUND) {
 		acpi_processor_ppc_in_use = true;
 
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		acpi_handle_warn(pr->handle, "_PPC evaluation failed: %s\n",
-				 acpi_format_exception(status));
-		return -ENODEV;
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_warn(pr->handle,
+					 "_PPC evaluation failed: %s\n",
+					 acpi_format_exception(status));
+			return -ENODEV;
+		}
 	}
 
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,



