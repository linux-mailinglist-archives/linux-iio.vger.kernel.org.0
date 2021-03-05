Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65032F316
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 19:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCESpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 13:45:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63644 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCESoo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 13:44:44 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id de62d34a7a55f328; Fri, 5 Mar 2021 19:44:42 +0100
Received: from kreacher.localnet (89-64-81-9.dynamic.chello.pl [89.64.81.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D678C663EA1;
        Fri,  5 Mar 2021 19:44:40 +0100 (CET)
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
Subject: [PATCH v1 0/4] ACPI: New helper for warning messages and replacing ACPI_EXCEPTION()
Date:   Fri, 05 Mar 2021 19:39:31 +0100
Message-ID: <2775419.haJ69vZeI0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvedufefggeeutdejvdfhteevgeeludevueevvdejkeelfefhudfhfeehkefffeevnecukfhppeekledrieegrdekuddrleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthht
 oheplhgrrhhssehmvghtrghfohhordguvgdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvghtpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuggvlhhvrghrvgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

The purpose of this series is to get rid of the remaining (questionable)
usage of ACPI_EXCEPTION() outside ACPICA.

The first patch is a tiny cleanup of the ACPI processor driver, but it is
depended on by the second one which in turn is depended on by the last two.

The second patch introduces a new helper function for logging messages
regarding ACPI object evaluation failures and makes some code under
drivers/acpi/ use it.

The other two patches use the new helper to get rid of ACPI_EXCEPTION()
and the related definitions from the acpi-als and acpi_power_meter drivers.

Please see the patch changelogs for details.

Thanks!



