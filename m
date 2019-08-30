Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF93DA2C06
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2019 03:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfH3BBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 21:01:30 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:56248 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfH3BBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 21:01:30 -0400
Received: (qmail 669 invoked by uid 5089); 30 Aug 2019 01:01:27 -0000
Received: by simscan 1.2.0 ppid: 566, pid: 567, t: 0.1021s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 30 Aug 2019 01:01:26 -0000
Subject: Re: [PATCH 1/2] dt-binding: iio: Add optional label property
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
 <1566876924-63608-2-git-send-email-preid@electromag.com.au>
 <a30b6dca-c598-135a-0559-1018dd5f5fde@xilinx.com>
 <20190829230207.GA22979@bogus>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <b50bce2d-8819-67b1-c55c-8c2b8070a4ac@electromag.com.au>
Date:   Fri, 30 Aug 2019 09:01:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829230207.GA22979@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/08/2019 07:02, Rob Herring wrote:
> On Wed, Aug 28, 2019 at 08:09:19AM +0200, Michal Simek wrote:
>> On 27. 08. 19 5:35, Phil Reid wrote:
>>> This optional property defines a symbolic name for the device.
>>>
>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>> ---
>>>   Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>> index 68d6f8ce063b..ffeae5aad8b5 100644
>>> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>> @@ -18,12 +18,17 @@ Required properties:
>>>   		   with a single IIO output and 1 for nodes with multiple
>>>   		   IIO outputs.
>>>   
>>> +Optional properties:
>>> +label:		   A symbolic name for the device.
>>> +
>>> +
>>>   Example for a simple configuration with no trigger:
>>>   
>>>   	adc: voltage-sensor@35 {
>>>   		compatible = "maxim,max1139";
>>>   		reg = <0x35>;
>>>   		#io-channel-cells = <1>;
>>> +		label = "adc_voltage_sensor";
>>>   	};
>>>   
>>>   Example for a configuration with trigger:
>>>
>>
>> Just for the record. This patch has been created based on initial
>> discussion about label property. And Rob had not problem with using
>> label in connection to ina226. https://lkml.org/lkml/2019/8/27/1213
> 
> I didn't, but based on the name here I'm less convinced. 'label' is
> supposed to be for needing to distinguish between more than 1 of
> something. A name like 'adc_voltage_sensor' doesn't really.
> 
> Rob
> 
> 

That's the problem we're try to solve. Having multiple devices and try to
determine which device is which.
eg: Mutliple adc's.
For example I have the same dac chip on multiple boards that do different
things, it's difficult to id them.

so label examples could be:
label = "current_control_group1";
label = "voltage_control_group1";

Are you totally against this or is it a problem with me not being clear
with the problem and the wording of the commit message or the example?




-- 
Regards
Phil Reid

