Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808ED392B6C
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhE0KHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 May 2021 06:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbhE0KHv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 May 2021 06:07:51 -0400
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B2C061574
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 03:06:16 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 3888B600C1
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 10:06:11 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.65.211]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=freedom.nl; s=default;
        t=1622109970; bh=kMkjf/2vriE8zITxyHoL/vTE6fgIyjweNiyep9F/LWk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=OsEselS9VC1iorPLsbTIR0s8Pyb0gn8ZnWuXzrkfSpEY9vlgEcJQyuT2T7jYaR6c0
         Bw0e7aY/2B9S5tlaSlYeNtU19kVixcPmHHCwvEwD8/NbeKT+dfhKI1gSdPZm1a/sz9
         rn5K7jtpjn7eJg+cH23os36ASUu0WGFB2ecxxQ/8=
Subject: Re: active_scan_mask
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
 <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
From:   Henk Medenblik <iio-developer@freedom.nl>
Message-ID: <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
Date:   Thu, 27 May 2021 12:06:08 +0200
MIME-Version: 1.0
In-Reply-To: <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear Alexandru,

> That should be happening in drivers/iio/industrialio-buffer.c in the
> iio_enable_buffers() function.
> The channels get enabled by writing via sysfs in
> /sys/bus/iiio/devices/iio:deviceX/scan_elements  in the _en files.
>
> libiio typically does this manipulation of files for you

I thought so too and I can confirm that when I switch back to less 
channels that the others are disabled. However the scanmask is not updated.

See some logging here trying to debug:

Session 1, read 8 channels:

iio_readdev -b 262144 -s 1024 iio:device0 voltage0 voltage1 voltage2 
voltage3 voltage4 voltage5 voltage6 voltage7 > /mnt/test6.bin
8 active channels
[  513.529510] acq_buffer_preenable
[  513.529521] active scan mask: 0x000000FF
[  513.558286] acq_buffer_postenable
[  513.716868] acq_buffer_predisable

Session 2, read 16 channels:

iio_readdev -b 262144 -s 1024 iio:device0 voltage0 voltage1 voltage2 
voltage3 voltage4 voltage5 voltage6 voltage7 voltage8 voltage9 voltage10 
voltage11 voltage12 voltage13 voltage14 voltage15 > /mnt/test6.bin
16 active channels
[  523.834056] acq_buffer_preenable
[  523.834067] active scan mask: 0x0000FFFF
[  523.880440] acq_buffer_postenable
[  524.041383] acq_buffer_predisable


Session3 ,  read 8 channels again:

iio_readdev -b 262144 -s 1024 iio:device0 voltage0 voltage1 voltage2 
voltage3 voltage4 voltage5 voltage6 voltage7 > /mnt/test6.bin
8 active channels
[  532.002019] acq_buffer_preenable
[  532.002030] active scan mask: 0x0000FFFF
[  532.048375] onr_acq_buffer_postenable
[  532.131081] onr_acq_buffer_predisable


> so, are you using an Analog Devices kernel?
> or is this a vanilla mainline kernel? and which version?
> ADI has some custom patches that deal with this some scanmask manipulation;
> is this being reproduced purely with libiio? and which version of libiio?
> steps to reproduce?
>
> i'm still not sure if the issue is in kernel or in libiio;
>
Yes I am using a adi 4.14 kernel, git tag adi-4.14.0  15e1a16477

For iio_readdev I am currently using the v0.21 zerocopy checkout

Henk


