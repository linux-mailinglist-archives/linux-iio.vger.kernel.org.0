Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB617EB55
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 22:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCIVlE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 17:41:04 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41375 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgCIVlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 17:41:04 -0400
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPA id C1733200005;
        Mon,  9 Mar 2020 21:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 22:41:00 +0100
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: input: Add docs for ADC driven
 joystick.
In-Reply-To: <20200309203814.GA29255@bogus>
References: <20200307211412.44148-1-contact@artur-rojek.eu>
 <20200307211412.44148-4-contact@artur-rojek.eu>
 <20200309203814.GA29255@bogus>
Message-ID: <bb188a58f29dfedcf56bb420f07a6813@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

On 2020-03-09 21:38, Rob Herring wrote:
> On Sat,  7 Mar 2020 22:14:11 +0100, Artur Rojek wrote:
>> Add documentation for the adc-joystick driver, used to provide support
>> for joysticks connected over ADC.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> Tested-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>> 
>>  Changes:
>> 
>>  v2: - Add `reg` property to axis subnode in order to enumerate the 
>> axes,
>>      - rename `linux,abs-code` property to `linux,code`,
>>      - drop `linux,` prefix from the remaining properties of axis 
>> subnode
>> 
>>  v3: no change
>> 
>>  v4: - remove "bindings" from the unique identifier string,
>>      - replace `|` with `>` for all description properties,
>>      - specify the number of items for `io-channels`,
>>      - correct the regex pattern of `axis` property,
>>      - specify the value range of `reg` property for each axis,
>>      - put `abs-range` properties under `allOf`
>> 
>>  .../bindings/input/adc-joystick.yaml          | 121 
>> ++++++++++++++++++
>>  1 file changed, 121 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/input/adc-joystick.yaml
>> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
Like with the previous versions of this patch set, the DTS example 
requires that
patch [2/5] is applied first. When that is done, the DT check does 
succeed here.

Regards,
Artur
> 
> Error:
> Documentation/devicetree/bindings/input/adc-joystick.example.dts:22.31-32
> syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:311: recipe for target
> 'Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml'
> failed
> make[1]: ***
> [Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml]
> Error 1
> Makefile:1262: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1250951
> Please check and re-submit.
