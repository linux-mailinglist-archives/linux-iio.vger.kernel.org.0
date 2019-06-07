Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84753395BF
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2019 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfFGTcn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jun 2019 15:32:43 -0400
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:9215 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfFGTcn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jun 2019 15:32:43 -0400
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id x57JWC27000337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jun 2019 13:32:12 -0600 (CST)
Received: from eng1n65.eng.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id x57JWBOe035937
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 7 Jun 2019 13:32:11 -0600
Subject: Re: [PATCH] iio: adc: xilinx: support all ARM platforms
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
References: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
 <379a99c8405b4cfbaa61ac49f9b40d4c577eb2a8.camel@analog.com>
 <95be35ff-2e3d-bc00-8798-7c9f462a96a6@sedsystems.ca>
 <a96943b7-00f5-288f-fa27-a82f1d6aa8dd@xilinx.com>
 <CA+U=DsrBqfmqfxS_SaPJHHiet0ZuAsCK5Kdha_rH+Cbm4VRP4A@mail.gmail.com>
From:   Robert Hancock <hancock@sedsystems.ca>
Openpgp: preference=signencrypt
Autocrypt: addr=hancock@sedsystems.ca; prefer-encrypt=mutual; keydata=
 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
Organization: SED Systems
Message-ID: <13a8eaf3-b5ee-151b-d959-80fb41e8a7f8@sedsystems.ca>
Date:   Fri, 7 Jun 2019 13:32:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DsrBqfmqfxS_SaPJHHiet0ZuAsCK5Kdha_rH+Cbm4VRP4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019-06-07 1:17 p.m., Alexandru Ardelean wrote:
> On Fri, Jun 7, 2019 at 10:33 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 06. 06. 19 17:21, Robert Hancock wrote:
>>> On 2019-06-06 4:09 a.m., Ardelean, Alexandru wrote:
>>>> On Wed, 2019-06-05 at 15:07 -0600, Robert Hancock wrote:
>>>>> [External]
>>>>>
>>>>>
>>>>> Since the XADC logic can be used with standalone Xilinx FPGAs, this driver
>>>>> can potentially be used with various ARM platforms, not just Zynq.
>>>>> Change the Zynq dependency to ARM in the list of supported platforms
>>>>> in the Kconfig dependencies for this driver.
>>>>
>>>> To my knowledge, there are 3 FPGA platforms with ARM supported in Linux.
>>>> And symbols are ARCH_ZYNQ, ARCH_ZYNQMP & ARCH_SOCFPGA.
>>>> For these ARM + FPGA SoCs, it is usually preferred to list the supported/tested ARM + FPGA platforms in Kconfig.
>>>>
>>>> I am curious: are you using something that isn't in the above list?
>>>
>>> Yes, we are using the XADC on a Kintex-7 FPGA through a PCIe to AXI
>>> bridge using an iMX6D platform - not an integrated ARM+FPGA.
>>>
> 
> In that case, it would be a bit more interesting to do a depends on
> PCIE_XILINX, or whichever is the Kconfig symbol for the PCIe-to-AXI
> bridge.
> 
> And there are some benefits to that, the major being that you can also
> support other ARCHs as well (x86, ppc, mips, etc).

There isn't a kernel driver for that PCIe-AXI bridge - it doesn't really
do much very interesting on its own, it just acts as a regular PCIe
endpoint and has build-time settings to map AXI memory to PCIe BARs and
host memory into AXI memory space. You have to build your own logic to
do things like map interrupts from the AXI side onto MSI interrupts from
the bridge.

It kind of seems like the easiest solution would be to just delete the
platform restriction entirely for this driver, as I really don't see
anything platform specific in there. Would anyone object to that?

> 
> Naturally, if using a different PCIe-to-AXI bridge controller (other
> than Xilinx's), it would be an idea to use that Kconfig symbol.
> 
>>> Using such an approach this driver could potentially be used on just
>>> about any platform, but I didn't want to open it up too much for now in
>>> case of some compile issues.
>>
>> 0day system should answer this for you.
>>
>> M

-- 
Robert Hancock
Senior Software Developer
SED Systems, a division of Calian Ltd.
Email: hancock@sedsystems.ca
