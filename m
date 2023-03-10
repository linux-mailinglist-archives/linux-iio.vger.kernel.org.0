Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C842C6B3BCF
	for <lists+linux-iio@lfdr.de>; Fri, 10 Mar 2023 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCJKPU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Mar 2023 05:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCJKPC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2023 05:15:02 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3210DE6B;
        Fri, 10 Mar 2023 02:14:46 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3UEW-1pa1iL1EO2-000brJ; Fri, 10 Mar 2023 11:08:51 +0100
Message-ID: <3c5992f3-269f-8af5-0062-7653c53feffb@i2se.com>
Date:   Fri, 10 Mar 2023 11:08:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/8] dt-bindings: ARM: fsl: Add chargebyte Tarragon
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
 <20230306172249.74003-7-stefan.wahren@i2se.com>
 <a38cb5d4-91d3-0d9a-41d3-44fed9d39512@linaro.org>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <a38cb5d4-91d3-0d9a-41d3-44fed9d39512@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Yab78HLcW38z97dZXDiHJYvgDjmQKxZOV7txq5k0FzHEPtlAm2X
 94lggD0+R3CkrZRs4t5PeeIgmB1+1zKAccV732G8LShJ0PvgxU37GFJeD3PMxWSKLMZybzh
 B2XpKMGuxqWfcjKRYao5A6rLQbNgC/EgraYZg6xBZX6OqYjzCYEA+eH9CtZKOU+V0gWoCRu
 wSB40w2QBfE4MeRYSjRAw==
UI-OutboundReport: notjunk:1;M01:P0:SWcLCySneCw=;W8h4oD+D8eYiskSf5UZ6zqYKNjr
 51kdxFAksai4A3fNbOPEneUE8r8TSjDSURYnV9PjtaDEyxJSMZop0ocIS95HX/NcUZzbjR0ed
 U/ZS8Hkpq46lWKE84Ujv2qh+67erUDnXvgFdDfCWSUQ5KlbUpEviZhPMdFAs/3aZhHrhpiaXB
 1hfWXVbNeDJl9xPKNPv+hZBpdU1SfWkAOX2lVXdFb6t6Q8QuWYLxf2hH//LLYDfsNtIpNj/9x
 ZjlW6uHiiaWgubfd3XzaZc5a8qOoRpeTrSuzXH2sFgSwfoX3DmObJg+7pouw5B2ADkFmCEe2N
 XtnUqvkG/G/LX+tHFaxQYVTndL5xlGThPJdxOd7+8oc+dI1DtVhUUClrko8GRy4+tWEeMi/ZC
 UDQOcpM8DP+iHTlgGGTmYcdpf2+0ZT/R0EZnxC/3ny01ak9D5V9Xctb1kcRYU94AYE9TEZRJC
 BVzXtblJ6pI8OlSmJlOnV9JIZerBtq04C3x3Qt3En+whwcKJ0rDkCP9I9AEAb8WD3ZRnuVIiT
 dZKfFem0A7mVxCQJspjgiIPriJ6KGYpSBVhDMZ7O0tt+B4OqNjdKpFn1M6eioNdoFUgg0aXpb
 W5vJVCZeU4oo60crnA1JDiY4UpQxXfUOrxKVPf1szze2dJ7e8jFMmwS38+y6NUFNIkgTC+rLG
 43QprqC9ZuenI+beCoPmQI18cTlq2Mng2auj3CPpow==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Krzysztof,

Am 07.03.23 um 09:24 schrieb Krzysztof Kozlowski:
> On 06/03/2023 18:22, Stefan Wahren wrote:
>> From: Stefan Wahren <stefan.wahren@chargebyte.com>
>>
>> This adds the compatibles for the chargebyte Tarragon boards.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>   Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index dece3e9ba7fd..2b430e20a7a6 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -781,6 +781,15 @@ properties:
>>             - const: tq,imx6ull-tqma6ull2l      # MCIMX6Y2, LGA SoM variant
>>             - const: fsl,imx6ull
>>   
>> +      - description: chargebyte Tarragon Boards
>> +        items:
>> +          - enum:
>> +              - chargebyte,imx6ull-tarragon-master
>> +              - chargebyte,imx6ull-tarragon-micro
>> +              - chargebyte,imx6ull-tarragon-slave
>> +              - chargebyte,imx6ull-tarragon-slavext
>> +          - const: fsl,imx6ull
> I don't think you put it in correct place. Didn't you just stuff it at
> the end?

Yes, i just put it at the end. But to be honest, i'm not sure about the 
order:

armadeus,imx6ull-opos6uldev
..
dh,imx6ull-dhcom-drc02
..
phytec,imx6ull-pbacd10-emmc
..
toradex,colibri-imx6ull-aster
..
kontron,bl-imx6ull
..
tq,imx6ull-tqma6ull2-mba6ulx

Does the order depend on the compatibles and vendor is relevant?

So your expectation was between armadeus and dh?

>
> Best regards,
> Krzysztof
>
