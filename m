Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789AA1B4750
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgDVO2O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 10:28:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:62923 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgDVO2O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 10:28:14 -0400
IronPort-SDR: AcOCn8zGFjE0SPuvKzm/w0pXWPkq98PvxCKu3JsoO5yWLNfDUlJXjBHkkTUkWrzqz03KXfFOvT
 mdCT7v8/goDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:28:11 -0700
IronPort-SDR: uG8DB1vpE/N32qWEILVLN9UkEaE+Jmg9fbWu3Ouf4CewOJic6C4Osl4Tq3kv8xBRgfswUpjCzL
 IW9Ce7W1ldkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="365692406"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 22 Apr 2020 07:28:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 22 Apr 2020 17:28:08 +0300
Date:   Wed, 22 Apr 2020 17:28:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org,
        Jagadish.Hadimani@amd.com
Subject: Re: ucsi and DRD controller interaction
Message-ID: <20200422142808.GE618654@kuha.fi.intel.com>
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
 <20200421074353.GE3768833@kuha.fi.intel.com>
 <1d4fd9f3-8ea6-c054-0ba4-d50d78226fae@amd.com>
 <20200422110056.GB618654@kuha.fi.intel.com>
 <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <841d88c6-e08b-72d3-6884-0aa51805e3be@amd.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 06:37:10PM +0530, Shah, Nehal-bakulchandra wrote:
> Hi
> 
> On 4/22/2020 4:30 PM, Heikki Krogerus wrote:
> > On Tue, Apr 21, 2020 at 07:23:30PM +0530, Shah, Nehal-bakulchandra wrote:
> >> Hi
> >>
> >> On 4/21/2020 1:13 PM, Heikki Krogerus wrote:
> >>> Adding linux-usb mailing list.
> >>>
> >>> On Mon, Apr 20, 2020 at 07:09:17PM +0530, Shah, Nehal-bakulchandra wrote:
> >>>> Hi Heikki ,
> >>>>
> >>>> I need some pointer from you, so in a system where I have UCSI driver for DRD
> >>>> Controller, then how call stack will be?
> >>>>
> >>>> I am unable to comprehend the flow from UCSI infrastructure to DRD controller
> >>>> code base.
> >>> Do you need to tell the negotiated data role to your USB controller
> >>> driver from the UCSI driver? For that we would need to know which USB
> >>> controller, or more precisely, which USB port is connected to the
> >>> USB Type-C connector in question.
> >>>
> >>> That would require ACPI tables to be able to describe the connection
> >>> between the USB Type-C connector and the USB port (and the connection
> >>> between DisplayPort and the USB Type-C connector etc.). Unfortunately
> >>> there is currently no documented way of doing that, however, there is
> >>> a proposal for a document the defines how the USB Type-C connectors
> >>> should be described in ACPI in general. The proposal does consider
> >>> this problem as well. For this the solution is to use _DSD device
> >>> properties "usb2-port" and "usb3-port" that have references to the
> >>> correct USB port nodes as values.
> >>>
> >>> Which USB controller are you using btw?
> >>>
> >>> thanks,
> >> Thanks for the mail.
> >>
> >> Here is the configuration
> >>
> >> 1. DRD Controller (DWC3 controller)
> >>
> >> 2. TI PD Controller
> >>
> >> 3. TI PD Controller and Host has I2C as transport layer. So ACPI mechanism wont work here.
> >>
> >>
> >> Hence i was wondering, is there any way from UCSI Driver we inform to DWC3 driver stack about Role change. I can understand one point that,
> >>
> >> DWC3 controller can work without UCSI Implementation i.e Only PD firmware. But i want to understand  if there is a role change, PD interrupt will be generated
> >>
> >> and UCSI Driver will come to know about this role change. But from this onwards , i am  unable to comprehend how it can be propagated upto DWC3 stack.
> > If the Type-C drivers need to tell DWC3 driver the data role (USB
> > role) the connector is operating in, then you use the USB Role Switch
> > Class for that (drivers/usb/role/). The USB Type-C driver (so ucsi.c
> > or tps6598x.c in this case) that knows the USB role tells it to the
> > USB role class by calling usb_role_switch_set_role().
> >
> > The USB role switch class then takes care of forwarding the
> > information to the actual switch, which is DWC3 in this case. The DWC3
> > driver already registers the USB role switch for you
> > (drivers/usb/dwc3/drd.c), but the UCSI driver, and also tps6598x.c,
> > does not use the USB role switch API yet. There has never been need
> > for that before this.
> >
> > Adding USB role switch handling to the UCSI and tps6598x drivers can
> > easily be fixed, but it's still not enough. You still need to describe
> > the connection between the USB PD controller and DWC3 somewhere.
> >
> > thanks,
> 
> appreciate your input.  So if understand correctly, something like below  patch has to be done
> 
> http://lkml.iu.edu/hypermail/linux/kernel/2003.1/04687.html
> 
> So this patch is still under review?

The patch is in mainline:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a0a137997448690a642e2325fe73242788b26fe

> right, and this will take for "Registering a role switch in the DRD code". So then from ucsi.c we need to
> 
> call the role class. Also, the above patch is based on device tree binding (i.e for arm platform)but in my case i have x86 so do i have to expose this via ACPI?

That patch does not actually have anything devicetree specific, but
you do need to supply the description of the connection like I said,
and ideally you can do that in your ACPI tables.

Can you still influence what goes to your ACPI tables, or are we
talking about products that are already on the market?


thanks,

-- 
heikki
