Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2408E4D518D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiCJS7w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 13:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiCJS7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 13:59:51 -0500
X-Greylist: delayed 83 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 10:58:49 PST
Received: from mxd1.seznam.cz (mxd1.seznam.cz [IPv6:2a02:598:a::78:210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EAFE52
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 10:58:48 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc23b.ko.seznam.cz (email-smtpc23b.ko.seznam.cz [10.53.18.31])
        id 2b5e81657050d50c2af74d3b;
        Thu, 10 Mar 2022 19:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1646938727; bh=tLpYhaeFkQ8eZyycAn3jbsGk/bo3h3JaFofWfu13Srg=;
        h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
         Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:X-szn-frgn:X-szn-frgc;
        b=chX1EDANJdfZMTEzyf7QoO+5bUQ/zIPFuM+a444k+dZBor/SRXO2jaS1zP2/zDMnY
         VgAvCXP0odq/09gE6DjAGEEK7FIwpcBnrSkLffVBBl4HGOiw2SQh+50g4+3bmNjgew
         F3oQTgyJPN1vJwbze6p+tqXno0TRHxY7RlBkIgzk=
Received: from [192.168.88.151] (ip-111-27.static.ccinternet.cz [147.161.27.111])
        by email-relay4.ko.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Thu, 10 Mar 2022 19:56:46 +0100 (CET)  
Message-ID: <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
Date:   Thu, 10 Mar 2022 19:56:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220310133938.2495-1-michael.srba@seznam.cz>
 <20220310133938.2495-2-michael.srba@seznam.cz>
 <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
From:   Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-szn-frgn: <135fa290-378a-47e1-90e3-50c66bb08bfa>
X-szn-frgc: <0>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
the thing is, the only reason the different compatible is needed at all
is that the chip presents a different WHOAMI, and the invensense,icm20608
compatible seems to imply the non-D WHOAMI value.
I'm not sure how the driver would react to both compatibles being present,
and looking at the driver code, it seems that icm20608d is not the only
fully icm20608-compatible (to the extent of features supported by
the driver, and excluding the WHOAMI value) invensense IC, yet none
of these other ICs add the invensense,icm20608 compatible, so I guess I
don't see a good reason to do something different.

Regards,
Michael

On 10. 03. 22 17:34, Krzysztof Kozlowski wrote:
> On 10/03/2022 14:39, michael.srba@seznam.cz wrote:
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> ICM-20608-D differs from the other ICM-20608 variants by having
>> a DMP (Digital Motion Processor) core tacked on.
>> Despite having a different WHOAMI register, this variant is
>> completely interchangeable with the other ICM-20608 variants
>> by simply pretending the DMP core doesn't exist.
> I wonder now why not using generic invensense,icm20608 compatible as
> fallback? Why only having one specific compatible?
>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> ---
>>   .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml          | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
>> index d69595a524c1..6784cc140323 100644
>> --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
>> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
>> @@ -17,6 +17,7 @@ properties:
>>       enum:
>>         - invensense,iam20680
>>         - invensense,icm20608
>> +      - invensense,icm20608d
>>         - invensense,icm20609
>>         - invensense,icm20689
>>         - invensense,icm20602
>
> Best regards,
> Krzysztof

