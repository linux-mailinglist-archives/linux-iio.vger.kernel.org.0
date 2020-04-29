Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4B1BDC87
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 14:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2MnZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 08:43:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:38722 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgD2MnY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Apr 2020 08:43:24 -0400
IronPort-SDR: 0lCQU0q54Ng7WLZ4/rMfSd6eQklG4lmgLBjhhDtDZs0ppuItNEvV2JyBrmK+W/u4qKznYIpB4g
 d/G2+a3PI61A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 05:43:24 -0700
IronPort-SDR: uPleOOqDLzBNwLmku8SxH9uVCRLrF2XEg4o0f9aRuNoA0t2wIjCW7zIDeklGfp7P1gvt36YMLR
 rcB1mnE5C6fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="367794354"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 29 Apr 2020 05:43:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 29 Apr 2020 15:43:21 +0300
Date:   Wed, 29 Apr 2020 15:43:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
Subject: Re: ucsi and DRD controller interaction
Message-ID: <20200429124321.GC2738754@kuha.fi.intel.com>
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
 <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
 <20200422110056.GB618654@kuha.fi.intel.com>
 <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
 <20200422142808.GE618654@kuha.fi.intel.com>
 <e85cefec-2731-65e8-f0f5-8cdc5d9e3773@amd.com>
 <20200427120032.GA2351955@kuha.fi.intel.com>
 <b139b18c-0452-d717-856e-14b9dd03910a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b139b18c-0452-d717-856e-14b9dd03910a@amd.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 27, 2020 at 07:45:07PM +0530, Shah, Nehal-bakulchandra wrote:
> Hi Heikki,
> 
> On 4/27/2020 5:30 PM, Heikki Krogerus wrote:
> > On Wed, Apr 22, 2020 at 08:23:54PM +0530, Shah, Nehal-bakulchandra wrote:
> >>> Can you still influence what goes to your ACPI tables, or are we
> >>> talking about products that are already on the market?
> >> Yes still it is in development phase so i can work out with BIOS team for the same. When you say description of connection ,something like this should be part of _DSD method right? (i.e from below dts
> >> to _DSD of ACPI)
> >>
> >>  usb_con: connector {
> >> compatible = "usb-c-connector";
> >>  label = "USB-C";
> >>  data-role = "dual";
> >>  power-role = "dual";
> >>  try-power-role = "sink";
> >>  source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> >>  sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> >>  PDO_VAR(5000, 5000, 1000)>;
> >>  op-sink-microwatt = <10000000>;
> >>  };
> > Here's how the ASL for the _DSD should look like. I don't know how
> > are all these components placed on your platform, so I'm just assuming
> > that your I2C host is under PCI0, as well as your DWC3 controller.
> > It's just an example, but hopefully you get the point from it:
> >
> > /*
> >  * I2C1 is the I2C host, and PDC1 is the USB PD Controller (I2C slave device).
> >  */
> > Scope (\_SB.PCI0.I2C1.PDC1)
> > {
> >         /* Each connector should have its own ACPI device entry (node). */
> >         Device (CON0)
> >         {
> >                 Name (_ADR, 0)
> >
> >                 Name (_DSD, Package () {
> >                     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                     Package() {
> >                         Package () {"usb-role-switch", \_SB.PCI0.DWC3},
> >                     }
> >                 })
> >         }
> > }
> >
> > So that property "usb-role-switch" has reference to the DWC3 node as
> > its value. That's what we are after here. If you have that property,
> > the subsystem will find the USB controller for you.
> >
> > If you need for example the properties for the roles, then the _DSD
> > would look like this:
> >
> > Name (_DSD, Package () {
> >     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >     Package() {
> >         Package () {"usb-role-switch", \_SB.PCI0.DWC3},
> >         Package () {"power-role", "dual"},
> >         Package () {"data-role", "dual"},
> >     }
> > })
> >
> > and so on...
> >
> >
> > Thanks,
> 
> Thanks for the details so this will enable the role switch  for drd controller. Now for UCSI driver to call the role make functions it needs the reference of the same switch reference,
> 
> so for that do i have to use device_get_named_child_node(dev,"CON0"), in UCSI Driver?

No. If you use the ucsi driver, and if your connector child nodes are
in correct order, then ucsi_find_fwnode() takes care of assigning the
node for you.

But you do need to use the USB role class API to get a handle to the
switch (dwc3) in the typec driver.

UCSI is really meant to be a status interface. The specification
states that the USB Type-C connectors should function autonomously
without any OS involvement. So by relying on the driver to configure
the muxes, you are actually corrupting that part of the specification.

I would still strongly recommend that you use TI's own host interface.


Cheers,

-- 
heikki
