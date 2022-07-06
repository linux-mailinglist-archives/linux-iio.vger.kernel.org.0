Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B555693B4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jul 2022 22:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiGFU6H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiGFU6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 16:58:07 -0400
X-Greylist: delayed 4358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 13:58:05 PDT
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4961E3D3;
        Wed,  6 Jul 2022 13:58:05 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 6A7C2240007;
        Wed,  6 Jul 2022 20:58:01 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 06 Jul 2022 22:58:01 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Rob Herring <robh@kernel.org>
Cc:     Chris Morgan <macroalpha82@gmail.com>, maccraft123mc@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>, paul@crapouillou.net,
        jic23@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: adc-joystick: add poll-interval
In-Reply-To: <20220706143744.GA6709-robh@kernel.org>
References: <20220705190354.69263-1-macromorgan@hotmail.com>
 <20220705190354.69263-2-macromorgan@hotmail.com>
 <20220706143744.GA6709-robh@kernel.org>
Message-ID: <79f571c76adc5e4c17857b6d4785d727@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2022-07-06 16:37, Rob Herring wrote:
> On Tue, 05 Jul 2022 14:03:52 -0500, Chris Morgan wrote:
>> From: Chris Morgan <macroalpha82@gmail.com>
>> 
>> Add poll-interval support for the adc-joystick documentation. This is
>> an optional value and if not provided the adc-joystick works as it
>> does today (with buffers). If this value is provided, the adc-joystick
>> driver is polled at the specified interval. The existing attribute of
>> "poll-interval" was used instead of complying with property-units.yaml
>> after discussion of the issue on the mailing list.
>> 
>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> ---
>>  Documentation/devicetree/bindings/input/adc-joystick.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Artur Rojek <contact@artur-rojek.eu>
