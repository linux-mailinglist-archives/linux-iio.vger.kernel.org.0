Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D462413B2
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 01:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgHJXXs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 19:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHJXXs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 19:23:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE4C06174A;
        Mon, 10 Aug 2020 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=f4lfpwYP4UCLYjl7qvZm+DGVFg0hPMCP+jO/TL664x8=; b=k+Zx/ukwz+vOG+SQ4WPT1w5a3y
        +dxqHPiHMx/q+BSh9i36y9NQHtBQqHNllp+PKk59qFDoAxhI6hZagmmR17Th7Z9b/96IcVMCJJ45O
        X/dph0KZXqKEEtPGQXgdQLTsoNkRuNreg/wqulYBVP/Ee+GNMBvUkA+gWMBh0sv2aOJAualoMN/V4
        k/mQXSbK+sbgPob5QzHQYr4NUekMi1O0aS8JfTD4/BGM5S3QzFRnl0PfcevDl+4Pud2q2l+rfd1Lk
        jRnZon/Mmfp+eCtpFDnA38fnLMlqVpyiqGhXrwtpnJahVTrhA/xJatqneTPSfR3rUuHQmbgFnTm5Q
        ZNd8/C3g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5H8m-0003VF-9F; Mon, 10 Aug 2020 23:23:40 +0000
Subject: Re: [PATCH v7 1/4] SFH: Add maintainers and documentation for AMD SFH
 based on HID framework
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de
Cc:     Shyam-sundar.S-k@amd.com
References: <20200810213055.103962-1-Sandeep.Singh@amd.com>
 <20200810213055.103962-2-Sandeep.Singh@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <76874b28-e046-2a23-2ef2-2cbb5431ac00@infradead.org>
Date:   Mon, 10 Aug 2020 16:23:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810213055.103962-2-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/10/20 2:30 PM, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
> document.
> 
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>

Hi,
Did you build the documentation?

Oh, I think you would need to add amd-sfh-hid to
Documentation/hid/index.rst first in order to build the documentation.
That change should be part of your patch set.


So please do that and then run "make htmldocs" and look for warnings or errors.

More below:

> ---
>  Documentation/hid/amd-sfh-hid.rst | 153 ++++++++++++++++++++++++++++++
>  MAINTAINERS                       |   8 ++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/hid/amd-sfh-hid.rst
> 
> diff --git a/Documentation/hid/amd-sfh-hid.rst b/Documentation/hid/amd-sfh-hid.rst
> new file mode 100644
> index 000000000000..0ee9003013f2
> --- /dev/null
> +++ b/Documentation/hid/amd-sfh-hid.rst
> @@ -0,0 +1,153 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +AMD Sensor Fusion Hub:-
> +======================

Underlines (like above) should be at least as long as the heading line,
but heading lines don't need endings on them like ':' or '-', so please
remove those ending characters on all heading lines.


> +AMD Sensor Fusion Hub is part of a SOC starting from Ryzen based platforms.

                                    an SOC

> +The solution is working well on several OEM products. AMD SFH uses HID over PCIe bus.

I would drop that first sentence above.

> +In terms of architecture it resembles ISH .However the major difference is all

                               resembles ISH. However

> +The hid reports are generated as part of kernel driver.

   the HID

> +
> +Block Diagram:-
> +=============
> +	-------------------------------
> +	|  HID User Space Applications  |
> +	-------------------------------
> +---------------------------------------------
> +	 ---------------------------------
> +	|		HID Core          |
> +	 ---------------------------------
> +
> +	 ---------------------------------
> +	|     AMD HID Transport           |
> +	 ---------------------------------
> +
> +	 --------------------------------
> +	|             AMD HID Client     |
> +	|	with HID Report Generator|
> +	 --------------------------------
> +
> +	 --------------------------------
> +	|     AMD MP2 PCIe Driver         |
> +	 --------------------------------
> +---------------------------------------------
> +	  -------------------------------
> +	|     SFH MP2 Processor         |
> +	 --------------------------------
> +
> +
> +AMD HID Transport Layer :-
> +***************************
> +AMD SFH transport is also implemented as a bus. Each client application executing in the AMD MP2
> +is registered as a device on this bus. MP2 which is an ARM® Cortex-M4 core based co-processor to

Incomplete sentence                here:  MP2 ....

> +x86. The driver, which binds each device (AMD SFH HID driver) identifies the device type and
> +registers with the hid core. Transport drivers attach a constant "struct hid_ll_driver" object with

                      HID

> +each device. Once a device is registered with HID core, the callbacks provided via this struct are
> +used by HID core to communicate with the device. AMD HID Transport driver implements the synchronouscalls.

                                                                              implements synchronous calls.

> +
> +AMD HID Client Layer:-
> +**********************
> +This layer is responsible to implement HID request and descriptors. As firmware is OS agnostic,
> +HID client layer fills the HID request structure and descriptors. HID client layer is in complex

                                                                                      is complex

> +in nature as it is interface between MP2 PCIe driver and HID. HID client layer initialized

                                                                                  initializes
I would drop "in nature".

> +the MP2 PCIe driver and holds the instance of MP2 driver.It identified the number of sensors

                                                     driver. It identifies

> +connected using MP2-PCIe driver and based on that allocate the DRAM address for each and every

                                                     allocates

> +sensor and pass it to MP2-PCIe driver.On enumeration of each sensor, client layer fills out the HID

              passes              driver. On

> +Descriptor structure and HID input report structure. HID Feature report structure can be optional.

                                                                           structure is optional.

> +The report descriptor structure varies sensor to sensor. Now on enumeration client layer does
> +two major things

             things:
(at least for punctuation; I don't know if that's sufficient for ReST markup.)

> +1.	Register the HID sensor client to virtual bus (Platform driver) and bind it.
> +2.	Probes the AMD HID transport driver. Which in turns register device to the core.

                                     driver, which in turn registers

> +
> +AMD MP2 PCIe layer:-
> +********************
> +MP2 PCIe Layer is responsible for making all transaction with the firmware over PCIe.

                                                transactions

> +The connection establishment between firmware and PCIe happens here.
> +
> +The communication between X86 and MP2 is spilt into three parts.

                                            split

> +1. Command Transfer => C2P Mailbox Register are used

                                      Registers are used

> +2. Data Transfer => DRAM
> +3. Supported sensor info => P2C Register
> +
> +Commands are sent to MP2 using C2P Mail Box registers. These C2P  registers are common between x86

                                      Mailbox                   C2P registers                     X86

Use Mailbox and X86 as above for consistency.

> +and MP2. Writing into C2P Message register generate interrupt to MP2.  The client layer allocates
> +the physical memory and send the same to MP2 for data transfer. MP2 firmware uses HUBIF interface

What is HUBIF interface?  do we care?

> +to access DRAM memory. For Firmware always write minimum 32 bytes into DRAM.So it is expected that

                              firmware                                    DRAM. So

> +driver shall allocate minimum 32 bytes DRAM space.
> +
> +Enumeration and Probing flow:-
> +*****************************
> +       HID             AMD            AMD                       AMD -PCIe             MP2
> +       Core         Transport      Client layer                   layer                FW
> +	|		|	       |                           |                 |
> +	|		|              |                 on Boot Driver Loaded       |
> +	|		|	       |                           |                 |
> +	|		|	       |                        MP2-PCIe Int         |
> +	|		|              |			   |                 |
> +	|		|	       |---Get Number of sensors-> |                 |
> +	|		|              |                       Read P2C              |
> +	|		|	       |			Register             |
> +	|		|              |                           |                 |
> +	|               |              | Loop(for No of Sensors)   |                 |
> +	|		|	       |----------------------|    |                 |
> +	|		|              | Create HID Descriptor|    |                 |
> +	|		|	       | Create Input  report |    |                 |
> +	|		|              |  Descriptor Map      |    |                 |
> +	|		|	       |  the MP2 FW Index to |    |                 |
> +	|		|              |   HID Index          |    |                 |
> +	|		|	       | Allocate the DRAM    |  Enable              |
> +        |		|	       |	address       |  Sensors             |
> +	|		|              |----------------------|    |                 |
> +	|		| HID transport|                           |    Enable       |
> +	|	        |<--Probe------|                           |---Sensor CMD--> |
> +	|		| Create the   |			   |                 |
> +	|		| HID device   |                           |                 |
> +	|               |    (MFD)     |                           |                 |
> +	|		| by Populating|			   |                 |
> +        |               |  the HID     |                           |                 |
> +	|               |  ll_driver   |                           |                 |
> +	| HID           |	       |			   |                 |
> +	|  add          |              |                           |                 |
> +	|Device         |              |                           |                 |
> +	|<------------- |	       |			   |                 |
> +
> +
> +Data Flow from Application to the AMD SFH Driver:-
> +*************************************************
> +
> +	|	       |              |	  	 	          |		    |
> +Get   	|	       |	      |			          |                 |
> +Input 	|	       |	      |			          |                 |
> +Report	|              |              |                           |                 |
> +--->  	|              |              |                           |                 |
> +	|HID_req       |              |                           |                 |
> +	|get_report    |              |                           |                 |
> +	|------------->|              |                           |                 |
> +	|              | HID_get_input|                           |                 |
> +	|              |  report      |                           |                 |
> +	|              |------------->|------------------------|  |                 |
> +	|              |              |  Read the DRAM data for|  |                 |
> +	|              |              |  requested sensor and  |  |                 |
> +	|              |              |  create the HID input  |  |                 |
> +	|              |              |  report                |  |                 |
> +	|              |              |------------------------|  |                 |
> +	|              |Data received |                           |                 |
> +	|              | in HID report|                           |                 |
> + To	|<-------------|<-------------|                           |                 |
> +Applications           |              |                           |                 |
> +<-------|              |              |                           |                 |
> +
> +
> +Data Flow from AMD SFH Driver to Application:-
> +**********************************************
> +      |		  |               |	            	          |		    |
> +      |           |               |------------------------|      |                 |
> +      |           |               |Periodically Read       |      |                 |
> +      |           |               |the data for all        |      |                 |
> +      |           |               |enumerated sensors      |      |                 |
> +      |           |               |from the dram and create|      |                 |
> +      |           |               | HID Input reports      |      |                 |
> +      |           |               |------------------------|      |                 |
> +      |           |HID Input      |                               |                 |
> +      |           |Input report   |                               |                 |
> +   <----submit to Application-----|                               |                 |
> +      |           |               |                               |                 |


thanks.
-- 
~Randy

