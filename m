Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E232F304
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 19:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCESoh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 13:44:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45674 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCESoe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 13:44:34 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id bbf02adda70a6deb; Fri, 5 Mar 2021 19:44:32 +0100
Received: from kreacher.localnet (89-64-81-9.dynamic.chello.pl [89.64.81.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B8C91663EA1;
        Fri,  5 Mar 2021 19:44:30 +0100 (CET)
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
Subject: [PATCH v1 4/4] hwmon: acpi_power_meter: Get rid of ACPICA message printing
Date:   Fri, 05 Mar 2021 19:43:54 +0100
Message-ID: <1890478.AxU35vj7Mz@kreacher>
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
regarding ACPI object evaluation failures and use dev_err() instead
of ACPI_EXCEPTION() to log _PMC package parsing failures, which is
consistent with the other messages printed by the code in question.

Next, drop the ACPI_MODULE_NAME() definition only used by the ACPICA
message printing macro.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/acpi_power_meter.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/hwmon/acpi_power_meter.c
===================================================================
--- linux-pm.orig/drivers/hwmon/acpi_power_meter.c
+++ linux-pm/drivers/hwmon/acpi_power_meter.c
@@ -20,7 +20,6 @@
 #include <linux/acpi.h>
 
 #define ACPI_POWER_METER_NAME		"power_meter"
-ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
 #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
 #define ACPI_POWER_METER_CLASS		"pwr_meter_resource"
 
@@ -114,7 +113,8 @@ static int update_avg_interval(struct ac
 	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_GAI",
 				       NULL, &data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _GAI"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_GAI",
+					     status);
 		return -ENODEV;
 	}
 
@@ -166,7 +166,8 @@ static ssize_t set_avg_interval(struct d
 	mutex_unlock(&resource->lock);
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PAI"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PAI",
+					     status);
 		return -EINVAL;
 	}
 
@@ -186,7 +187,8 @@ static int update_cap(struct acpi_power_
 	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_GHL",
 				       NULL, &data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _GHL"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_GHL",
+					     status);
 		return -ENODEV;
 	}
 
@@ -237,7 +239,8 @@ static ssize_t set_cap(struct device *de
 	mutex_unlock(&resource->lock);
 
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SHL"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_SHL",
+					     status);
 		return -EINVAL;
 	}
 
@@ -270,7 +273,8 @@ static int set_acpi_trip(struct acpi_pow
 	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PTP",
 				       &args, &data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTP"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PTP",
+					     status);
 		return -EINVAL;
 	}
 
@@ -322,7 +326,8 @@ static int update_meter(struct acpi_powe
 	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PMM",
 				       NULL, &data);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PMM"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PMM",
+					     status);
 		return -ENODEV;
 	}
 
@@ -549,7 +554,8 @@ static int read_domain_devices(struct ac
 	status = acpi_evaluate_object(resource->acpi_dev->handle, "_PMD", NULL,
 				      &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PMD"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PMD",
+					     status);
 		return -ENODEV;
 	}
 
@@ -745,7 +751,8 @@ static int read_capabilities(struct acpi
 	status = acpi_evaluate_object(resource->acpi_dev->handle, "_PMC", NULL,
 				      &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PMC"));
+		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PMC",
+					     status);
 		return -ENODEV;
 	}
 
@@ -765,7 +772,9 @@ static int read_capabilities(struct acpi
 
 	status = acpi_extract_package(pss, &format, &state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Invalid data"));
+		dev_err(&resource->acpi_dev->dev, ACPI_POWER_METER_NAME
+			"_PMC package parsing failed: %s\n",
+			acpi_format_exception(status));
 		res = -EFAULT;
 		goto end;
 	}



