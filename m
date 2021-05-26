Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402CF391FA6
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhEZSw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 14:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhEZSw1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 14:52:27 -0400
X-Greylist: delayed 281 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 May 2021 11:50:55 PDT
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445ABC061574
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 11:50:55 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 0AB2B6125F
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 18:50:54 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.65.211]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=freedom.nl; s=default;
        t=1622055053; bh=HbH2Wn1zL2qMrsbMfCrF8UR17SEUJ1IxDES7aGYF0/o=;
        h=To:From:Subject:Date:From;
        b=li8uyNdkFfgAOLPYvqM9YcNv8bO89FSnQw8j5EvQcKgA2VqSioqKzyWLo5DR2WRdT
         Hz+MUwyuLd+UJeHKz7FVMZ+oTSEc3a6DVrZfE8D0e+bNMI9uP9TJZk2uM9JO4GFWyK
         m2Vr/gYMYS9F1hW9gfCQor2EqtHujBL1f5heMtCg=
To:     linux-iio@vger.kernel.org
From:   Henk <iio-developer@freedom.nl>
Subject: active_scan_mask
Message-ID: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
Date:   Wed, 26 May 2021 20:50:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear all,

I created a custom IIO device in FPGA which in fact contains a bunch of 
ADC channels which I can acquire and stream to disk. I use analog 
devices' libiio and specifically their iio_readdev application together 
with my custom FPGA design and custom iio kernel driver.

Question: what mechanism is updating the indio_dev->active_scan_mask field.

With the iio_readdev application I can add command arguments where I can 
activate the channels that I want to retrieve (voltage0 voltage1 
...etc). When I use 8 channels as command argument in iio_readdev then 
the active_scan_mask seems to be updated with the enabled channels. When 
adding even more channels the field is extended. However, when trying to 
acquire new data and dropping some of the channel arguments then the 
active_scan_mask field does not seem to revert back to the less enabled 
(or requested) channels.

So.. I am searching which mechanisms updates that field with the aim to 
fix that bug.

Any help is appreciated.

Kind regards

Henk

