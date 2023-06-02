Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F365171F784
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jun 2023 03:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFBBJE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jun 2023 21:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjFBBJC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jun 2023 21:09:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB69E2;
        Thu,  1 Jun 2023 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685668141; x=1717204141;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=chfMVfnhp5j03xinVitce1S1i2pv18p9kLtJKoM0g+I=;
  b=FJfxuU0rSHVWF3g0zgzEv1POgrCZfBow08kSo2MhTh1G1HuPBxrr5RId
   94JT5DCXCWIVRJlXQVWHgITzwdOCZBwPSTFQ9BQrhQ0nHvqUxCuoFD7RB
   c3pgpZgGEnk1r2wBv4F4NUvzWNTkCAA3h27IlLCfwdyQrdFhvVE3++MU0
   TXHZVE/DUWEpSth7ZenwGAz70JgWQTkBq5lJuFwC5GcWLofQizOANG2zW
   /R0xzshOf7wYCmwnVbPtre0o0mHE2ViEema5axsohcY+VGCZ68Oeai/P0
   yQKZPvToQrUv77a16AcHoGWetMrqjNEFPzo/hPsvBnZ2F+N2hox3Qg4j8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358159962"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="358159962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 18:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="954251520"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="954251520"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2023 18:08:58 -0700
Received: from dkhamitk-mobl1.amr.corp.intel.com (dkhamitk-mobl1.amr.corp.intel.com [10.251.3.100])
        by linux.intel.com (Postfix) with ESMTP id 98D64580CD0;
        Thu,  1 Jun 2023 18:08:57 -0700 (PDT)
Message-ID: <b067f6990c7e6e58c487770126a804500ce8a54a.camel@linux.intel.com>
Subject: Re: [PATCH v4 35/35] acpi/bus: Remove notify callback and flags
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Michal Wilczynski <michal.wilczynski@intel.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, luzmaximilian@gmail.com,
        corentin.chary@gmail.com, jprvita@gmail.com,
        cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org,
        jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com,
        malattia@linux.it, jeremy@system76.com, productdev@system76.com,
        herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu,
        Jason@zx2c4.com, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        acpica-devel@lists.linuxfoundation.org
Date:   Thu, 01 Jun 2023 18:08:57 -0700
In-Reply-To: <20230601132137.301802-1-michal.wilczynski@intel.com>
References: <20230601132137.301802-1-michal.wilczynski@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Michal,

On Thu, 2023-06-01 at 15:21 +0200, Michal Wilczynski wrote:
> As callback has been replaced by drivers installing their handlers in
> .add it's presence is not useful anymore.
>=20
> Remove .notify callback and flags variable from struct acpi_driver,
> as they're not needed anymore.
>=20
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
> =C2=A0include/acpi/acpi_bus.h | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7fb411438b6f..3326794d5b70 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -151,12 +151,10 @@ struct acpi_hotplug_context {
> =C2=A0
> =C2=A0typedef int (*acpi_op_add) (struct acpi_device * device);
> =C2=A0typedef void (*acpi_op_remove) (struct acpi_device *device);
> -typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
> =C2=A0
> =C2=A0struct acpi_device_ops {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_op_add add;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_op_remove remove;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_op_notify notify;
> =C2=A0};
> =C2=A0
> =C2=A0#define ACPI_DRIVER_ALL_NOTIFY_EVENTS=C2=A0=C2=A00x1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0/* system AND device events */
> @@ -165,7 +163,6 @@ struct acpi_driver {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char name[80];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char class[80];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct acpi_device_=
id *ids; /* Supported Hardware IDs */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int flags;

Can ACPI_DRIVER_ALL_NOTIFY_EVENTS be removed as well?

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_device_ops op=
s;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_driver drv;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct module *owner;

