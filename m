Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085982D8CF8
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 13:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394236AbgLMMEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 07:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391674AbgLMMEf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 07:04:35 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F011223121;
        Sun, 13 Dec 2020 12:03:53 +0000 (UTC)
Date:   Sun, 13 Dec 2020 12:03:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] devicetree: Add Xilinx System Management Wizard
 binding documentation
Message-ID: <20201213120350.3471676c@archlinux>
In-Reply-To: <20200922134624.13191-1-lars@metafoo.de>
References: <20200922134624.13191-1-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Sep 2020 15:46:23 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Add binding documentation for the Xilinx System Management Wizard. The
> Xilinx System Management Wizard is a AXI frontend for the Xilinx System
> Monitor found in the UltraScale and UltraScale+ FPGAs.
> 
> The System Monitor is the equivalent to the Xilinx XADC found in their
> previous generation of FPGAs and their external and internal interfaces are
> very similar. For this reason the share the same binding documentation. But
> since they are not 100% compatible and software will have to know about the
> differences they use a different compatible string.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
+CC relevant DT bindings people.

As this is fairly trivial I've fixed up the patch title to the usual
dt-bindings format and applied to the togreg branch of iio.git.

I don't want to delay this series even longer to go around again.

Thanks,
> ---
>  .../bindings/iio/adc/xilinx-xadc.txt          | 49 +++++++++++++++----
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> index e0e0755cabd8..f42e18078376 100644
> --- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
> @@ -1,13 +1,22 @@
>  Xilinx XADC device driver
>  
> -This binding document describes the bindings for both of them since the
> -bindings are very similar. The Xilinx XADC is a ADC that can be found in the
> -series 7 FPGAs from Xilinx. The XADC has a DRP interface for communication.
> -Currently two different frontends for the DRP interface exist. One that is only
> -available on the ZYNQ family as a hardmacro in the SoC portion of the ZYNQ. The
> -other one is available on all series 7 platforms and is a softmacro with a AXI
> -interface. This binding document describes the bindings for both of them since
> -the bindings are very similar.
> +This binding document describes the bindings for the Xilinx 7 Series XADC as well
> +as the UltraScale/UltraScale+ System Monitor.
> +
> +The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
> +The XADC has a DRP interface for communication. Currently two different
> +frontends for the DRP interface exist. One that is only available on the ZYNQ
> +family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
> +on all series 7 platforms and is a softmacro with a AXI interface. This binding
> +document describes the bindings for both of them since the bindings are very
> +similar.
> +
> +The Xilinx System Monitor is an ADC that is found in the UltraScale and
> +UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
> +communication. Xilinx provides a standard IP core that can be used to access the
> +System Monitor through an AXI interface in the FPGA fabric. This IP core is
> +called the Xilinx System Management Wizard. This document describes the bindings
> +for this IP.
>  
>  Required properties:
>  	- compatible: Should be one of
> @@ -15,11 +24,14 @@ Required properties:
>  		  configuration interface to interface to the XADC hardmacro.
>  		* "xlnx,axi-xadc-1.00.a": When using the axi-xadc pcore to
>  		  interface to the XADC hardmacro.
> +		* "xlnx,system-management-wiz-1.3": When using the
> +		  Xilinx System Management Wizard fabric IP core to access the
> +		  UltraScale and UltraScale+ System Monitor.
>  	- reg: Address and length of the register set for the device
>  	- interrupts: Interrupt for the XADC control interface.
>  	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
> -	  when using the AXI-XADC pcore this must be the clock that provides the
> -	  clock to the AXI bus interface of the core.
> +	  when using the axi-xadc or the axi-system-management-wizard this must be
> +	  the clock that provides the clock to the AXI bus interface of the core.
>  
>  Optional properties:
>  	- xlnx,external-mux:
> @@ -110,3 +122,20 @@ Examples:
>  			};
>  		};
>  	};
> +
> +	adc@80000000 {
> +		compatible = "xlnx,system-management-wiz-1.3";
> +		reg = <0x80000000 0x1000>;
> +		interrupts = <0 81 4>;
> +		interrupt-parent = <&gic>;
> +		clocks = <&fpga1_clk>;
> +
> +		xlnx,channels {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			channel@0 {
> +				reg = <0>;
> +				xlnx,bipolar;
> +			};
> +		};
> +	};

