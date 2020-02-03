Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1015085B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBCO3N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 09:29:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:4372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgBCO3N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Feb 2020 09:29:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 06:29:11 -0800
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="337385490"
Received: from montimix-mobl.gar.corp.intel.com ([10.251.72.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 06:29:08 -0800
Message-ID: <f669f2682373bcd79995dcd518d3405fd62ec61f.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/4] SFH: Add maintainer list and documentation for
 AMD SFH based on HID framework
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Date:   Mon, 03 Feb 2020 06:29:04 -0800
In-Reply-To: <1580272046-32101-2-git-send-email-Sandeep.Singh@amd.com>
References: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
         <1580272046-32101-2-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-01-29 at 09:57 +0530, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> Add Maintainer list for AMD SFH

SFH (SENSOR FUSION HUB)

This way it will be clear what is SFH.

>  Solution and work flow
> document.
> 
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> ---
>  Documentation/hid/amd-sfh-hid.rst | 159
> ++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                       |   8 ++
>  2 files changed, 167 insertions(+)
>  create mode 100644 Documentation/hid/amd-sfh-hid.rst
> 
> diff --git a/Documentation/hid/amd-sfh-hid.rst
> b/Documentation/hid/amd-sfh-hid.rst
> new file mode 100644
> index 0000000..1183350
> --- /dev/null
> +++ b/Documentation/hid/amd-sfh-hid.rst
> @@ -0,0 +1,159 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +AMD Sensor Fusion Hub:-
> +======================
> +AMD sensor fushion Hub is part of a SOC starting from ryzon based
> platforms.
> +The solution is working well on windows OS in several
> +OEM products. AMD SFH uses HID over PCIe bus. In terms of
> architecture
> +it is much more resmebles like ISH .However the major diffrence is
> all
> +The hid reports are generated as part of kernel driver.
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
> +	|     AMD HID Transport Driver    |
> +	 ---------------------------------
> +
> +	 --------------------------------
> +	|     AMD HID Client Driver      |
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
> +AMD SFH transport is also implemented as a bus. Each client
> application
> +executing in the AMD MP2 is registered as a device on this bus.
> +The driver, which binds each device (AMD SFH  HID driver) identifies
> +the device type and registers with the hid core. Transport drivers
> +attach a constant "struct hid_ll_driver" object with each device.
> +Once a device is registered with HID core, the callbacks provided
> via
> +this struct are used by HID core to communicate with the device.
> +AMD HID Transport driver implements the synchronous calls.
> +
> +AMD HID Client Driver:-
> +**********************
> +This driver is responsible to implement HID request and descriptors.
> +As firmware is OS agnostic, HID client driver fills the HID request
> +structure and descriptors. HID client driver is in complex in nature
> +as it is interface between MP2 PCIe driver and HID. HID client
> driver
> +initialized the MP2 PCIe driver and holds the instance of MP2
> driver.
> +It identified the number of sensors connected using MP2- PCIe driver
> and
> +based on that allocate the DRAM address for each and every sensor
> and
> +pass it to MP2-PCIe driver.
> +On enumeration of each sensor, client driver fills out the HID
> Descriptor
> +structure and HID input report structure. HID Feature report
> structure can
> +be optional.  The report descriptor structure varies sensor to
> sensor.
> +Now on enumeration client driver does two major things
> +1.	Register the HID sensor client to virtual bus (Platform driver)
> and bind it.
> +2.	Probes the AMD HID transport driver. Which in turns register
> device to the core.
> +
> +AMD MP2 PCIe Driver:-
> +********************
> +MP2 PCIe driver is responsible for making all transaction with the
> firmware over
> +PCIe.The connection establishment between firmware and MP2 PCIe
> driver happens here.
> +
> +The communication between X86 and MP2 is spilt into three parts.
> +1. Command Transfer => C2P Mailbox Register are used
> +2. Data Transfer => DRAM
> +
> +Commands are sent to MP2 using C2P Mail Box registers. These
> C2P  registers
> +are mapped in PCIe address space.Writing into C2P Message register
> generate
> +interrupt to MP2.  The client driver allocates the physical memory
> and send
> +the same to MP2 for data transfer. MP2 firmware uses DRAM interface
> registers
> +to indirectly access DRAM memory. For Firmware always write minimum
> 32 bytes
> +into DRAM.So it is expected that driver shall allocate minimum 32
> bytes DRAM space.
> +
> +Enumeration and Probing flow:-
> +*****************************
> +       HID             AMD            AMD                       AMD
> -PCIe             MP2
> +       Core         Transport      Client
> Driver                 Driver               FW
> +	|		|	       |                           |         
>         |
> +	|		|       on Boot Driver Loaded	  	   |         
>         |
> +	|		|	       |                           |         
>         |
> +	|		|	       |----MP2-PCIe Int--------->
> |                 |
> +	|		|              |			   |         
>         |
> +	|		|	       |---Get Number of sensors->
> |                 |
> +	|		|              |                       Read
> P2C              |
> +	|		|	       |			Register     
>         |
> +	|		|              |                           |         
>         |
> +	|               |              | Loop(for No of
> Sensors)   |                 |
> +	|		|	       |--------------------
> --|    |                 |
> +	|		|              | Create HID
> Descriptor|    |                 |
> +	|		|	       | Create Input  report
> |    |                 |
> +	|		|              |  Descriptor
> Map      |    |                 |
> +	|		|	       |  the MP2 FW Index to
> |    |                 |
> +	|		|              |   HID
> Index          |    |                 |
> +	|		|	       | Allocate the
> DRAM    |  Enable              |
> +        |		|	       |	address       |  Sensors     
>         |
> +	|		|              |--------------------
> --|    |                 |
> +	|		| HID
> transport|                           |    Enable       |
> +	|	        |<--Probe------|                           |---Sensor 
> CMD--> |
> +	|		| Create the   |			   |         
>         |
> +	|		| HID
> device   |                           |                 |
> +	|               |    (MFD)     |                           |   
>               |
> +	|		| by Populating|			   |         
>         |
> +        |               |  the
> HID     |                           |                 |
> +	|               |  ll_driver   |                           |   
>               |
> +	| HID           |	       |			   |         
>         |
> +	|  add          |              |                           |   
>               |
> +	|Device         |              |                           |   
>               |
> +	|<------------- |	       |			   |         
>         |
> +
> +
> +Data Flow from Application to the AMD SFH Driver:-
> +*************************************************
> +
> +	|	       |              |	  	 	          |		
>     |
> +Get   	|	       |	      |			          |  
>                |
> +Input 	|	       |	      |			          |  
>                |
> +Report	|              |              |                        
>    |                 |
> +--->  	|              |              |                        
>    |                 |
> +	|HID_req       |              |                           |    
>              |
> +	|get_report    |              |                           |    
>              |
> +	|-------------
> >|              |                           |                 |
> +	|              |
> HID_get_input|                           |                 |
> +	|              |  report      |                           |    
>              |
> +	|              |------------->|----------------------
> --|  |                 |
> +	|              |              |  Read the DRAM data
> for|  |                 |
> +	|              |              |  requsted sensor
> and   |  |                 |
> +	|              |              |  create the HID
> input  |  |                 |
> +	|              |              |  report                |  |    
>              |
> +	|              |              |----------------------
> --|  |                 |
> +	|              |Data received
> |                           |                 |
> +	|              | in HID
> report|                           |                 |
> + To	|<-------------|<-------------
> |                           |                 |
> +Applications           |              |                           | 
>                 |
> +<-------
> |              |              |                           |          
>        |
> +
> +
> +Data Flow from AMD SFH Driver to Application:-
> +**********************************************
> +      |		  |               |	            	     
>      |		    |
> +      |           |               |----------------------
> --|      |                 |
> +      |           |               |Periodically
> Read       |      |                 |
> +      |           |               |the data for
> all        |      |                 |
> +      |           |               |enumerated
> sensors      |      |                 |
> +      |           |               |from the dram and
> create|      |                 |
> +      |           |               | HID Input
> reports      |      |                 |
> +      |           |               |----------------------
> --|      |                 |
> +      |           |HID
> Input      |                               |                 |
> +      |           |Input
> report   |                               |                 |
> +   <----submit to Application-----
> |                               |                 |
> +      |           |               |                               | 
>                 |
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56765f5..7cfeb5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -884,6 +884,14 @@ S:	Supported
>  F:	drivers/net/ethernet/amd/xgbe/
>  F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>  
> +AMD SENSOR FUSION HUB DRIVER
> +M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
> +M:	Sandeep Singh <sandeep.singh@amd.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hid/amd-sfh*
> +F:	drivers/hid/amd-sfh-hid/
> +
>  ANALOG DEVICES INC AD5686 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-pm@vger.kernel.org

