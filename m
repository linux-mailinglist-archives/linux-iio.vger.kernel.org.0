Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3415E4D9C16
	for <lists+linux-iio@lfdr.de>; Tue, 15 Mar 2022 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiCON1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Mar 2022 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiCON1B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2022 09:27:01 -0400
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 06:25:47 PDT
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510303464B
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 06:25:47 -0700 (PDT)
Received: from smtp.freedom.nl (c04smtp-lb01.int.sover.in [10.10.4.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 4KHvB92MW2z9j
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 13:18:57 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl []) by freedom.nl
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1647350337;
        bh=uXzkka+XEbiU/iBN9AJyKZXP+CR0hqWTyWgSTctGeUo=;
        h=Date:To:From:Subject:From;
        b=YG3m5e6VbknfjwLUdcdOa8kd/RS3zDmIYmdjfkjG7/Jpcr6bcrze4i1MHAhncCGnl
         s2DaRxVPosCCgyMzT35XXEwfppJ/IpXNWKcxlvd0O91Zv4gRkbjdlnQJgP8BN7xWrk
         kRZIgcXg57dR5h0NNECS79lztLc2nJaGm3IdYnkUY1YYoSLHRv59lUBxtqpuGH3Dp2
         IwWoZkGfG8wyE8nHLIukSDpxuEqy+/Jtjtf1T3mlcHOoXlYm6e9W8A9xoFPSqwtEbT
         iUrW1lg12OJSeIA3DAlyDyf315vWHfH/PMWb4jwWIe/EDcacDQZezyjPP2rpmLw2cU
         Wi133EXz2/V/A==
Message-ID: <cfc53292-35cf-28bb-3764-65a681eaedd9@deathstar2.nl>
Date:   Tue, 15 Mar 2022 14:18:55 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     linux-iio <linux-iio@vger.kernel.org>
From:   Henk Medenblik <yoda@deathstar2.nl>
Subject: multiple dma engines/ ring buffers
Organization: DeathStar2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I am struggling with the concept of using two different DMA engines and 
therefore two ring buffer definitions in a single driver.
My purpose is to have two different data paths which I want to select in 
my iio device driver. One of them has the purpose to stream plain ADC 16 
bit data to my backend while the second selection would be a hardware 
FFT core output (complex 32 bit). So which one I stream to the backend 
should be selectable.

Because both paths originate from different parts in my HW design I 
implemented two different DMA engines and therefore I have two different 
dma names. However, how to deal with that in my single driver? Has 
anyone done that?

Regards

Henk

