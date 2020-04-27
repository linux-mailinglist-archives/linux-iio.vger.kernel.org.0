Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4B81BA314
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgD0MAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 08:00:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:61677 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0MAg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Apr 2020 08:00:36 -0400
IronPort-SDR: fLTtaa6fCX/LUqwF5MEayQrkbQ21KyJKr//yV7YjW1JVkwUaZ70Gy45irwpQaIesV4a4BqJfmN
 oKogZsEAmr2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 05:00:35 -0700
IronPort-SDR: f4dieNNeqH+D72icavoYrhwnajLAet2hWZRv24hCwhaJgXQI1yjWeIaW8Igjbh95dX8UTT3GZl
 MvtDiNfbzEYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="367141656"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 27 Apr 2020 05:00:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 27 Apr 2020 15:00:32 +0300
Date:   Mon, 27 Apr 2020 15:00:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
Subject: Re: ucsi and DRD controller interaction
Message-ID: <20200427120032.GA2351955@kuha.fi.intel.com>
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
 <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
 <20200422110056.GB618654@kuha.fi.intel.com>
 <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
 <20200422142808.GE618654@kuha.fi.intel.com>
 <e85cefec-2731-65e8-f0f5-8cdc5d9e3773@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e85cefec-2731-65e8-f0f5-8cdc5d9e3773@amd.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 08:23:54PM +0530, Shah, Nehal-bakulchandra wrote:
> > Can you still influence what goes to your ACPI tables, or are we
> > talking about products that are already on the market?
> 
> Yes still it is in development phase so i can work out with BIOS team for the same. When you say description of connection ,something like this should be part of _DSD method right? (i.e from below dts
> to _DSD of ACPI)
> 
>  usb_con: connector {
> compatible = "usb-c-connector";
>  label = "USB-C";
>  data-role = "dual";
>  power-role = "dual";
>  try-power-role = "sink";
>  source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
>  sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
>  PDO_VAR(5000, 5000, 1000)>;
>  op-sink-microwatt = <10000000>;
>  };

Here's how the ASL for the _DSD should look like. I don't know how
are all these components placed on your platform, so I'm just assuming
that your I2C host is under PCI0, as well as your DWC3 controller.
It's just an example, but hopefully you get the point from it:

/*
 * I2C1 is the I2C host, and PDC1 is the USB PD Controller (I2C slave device).
 */
Scope (\_SB.PCI0.I2C1.PDC1)
{
        /* Each connector should have its own ACPI device entry (node). */
        Device (CON0)
        {
                Name (_ADR, 0)

                Name (_DSD, Package () {
                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package() {
                        Package () {"usb-role-switch", \_SB.PCI0.DWC3},
                    }
                })
        }
}

So that property "usb-role-switch" has reference to the DWC3 node as
its value. That's what we are after here. If you have that property,
the subsystem will find the USB controller for you.

If you need for example the properties for the roles, then the _DSD
would look like this:

Name (_DSD, Package () {
    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
    Package() {
        Package () {"usb-role-switch", \_SB.PCI0.DWC3},
        Package () {"power-role", "dual"},
        Package () {"data-role", "dual"},
    }
})

and so on...


Thanks,

-- 
heikki
