Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD22198048
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgC3P6W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 11:58:22 -0400
Received: from www381.your-server.de ([78.46.137.84]:37692 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgC3P6V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 11:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Be9f+e+W+a2dUiEazWBLGMbQ9H+H55+f5ZUHQ4CKwU=; b=POcxx7ZqSXEPTKxuq6ZTv31faF
        o3sMo0wkU0TqNJbcp0CxUVb6w7KBrojg2Zz6DHV4lcBT/pyJDSIXXRCDtgTuPSDZQiB7dw9gf+48x
        8gbIEo322PmkRoBT5FXE8qeUolco92OeishpnLyu75EbmB8RcDxegmtj1HJEJhPHdTWXkSTw2HGus
        RdoYnBvVjEj72/5aY6SKf/VwmxjUuKLC4C6Jia8zWl/4T9lYWSoKXBGVzLuGHxAyRFa72AS3stX4n
        cj7CQXJWafZT0vjrmzqcUbkFJKOtoTF1rAQwR4VuGhf3opANHrtj1x4HJB0GEW4SP/2xAK225DQYr
        IB4GP5xA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jIwnq-0000pq-Ih; Mon, 30 Mar 2020 17:58:18 +0200
Received: from [82.135.79.215] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jIwnq-0004vo-6n; Mon, 30 Mar 2020 17:58:18 +0200
Subject: Re: [RFC PATCH 3/3] iio: buffer: add output buffer support for chrdev
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
        dragos.bogdan@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
References: <20200330145705.29447-1-alexandru.ardelean@analog.com>
 <20200330145705.29447-4-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <53b06603-67f5-fd54-54e6-551ecc789fbc@metafoo.de>
Date:   Mon, 30 Mar 2020 17:58:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330145705.29447-4-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/30/20 4:57 PM, Alexandru Ardelean wrote:
> This is WIP.
> It hasn't been tested yet. Mostly serves as base for some discussion.
>
> There have been some offline discussions about how to go about this.
> Since I wasn't involved in any of those discussions, this kind of tries to
> re-build things from various bits.
>
> 1. First approach is: we keep 1 buffer per device, and we make it either
> in/out, which means that for devices that for devices that have both in/out
> 2 iio_dev instances are required, or an ADC needs to be connected on the in
> path and a DAC on out-path. This is predominantly done in the ADI tree.
>
> 2. One discussion/proposal was to have multiple buffers per-device. But the
> details are vague since they were relayed to me.
> One detail was, to have indexes for devices that have more than 1
> buffer:
>
> Iio_deviceX:
>          buffer
>          scan_elements
>
> Iio_deviceX:
>          BufferY
>          scan_elementsY
>          BufferZ
>          scan_elementsZ
>
> I am not sure how feasible this is for a single chrdev, as when you look at
> the fileops that get assigned to a chrdev, it looks like it can have at
> most two buffers (one for input, out for output).
>
> Multiplexing input buffers can work (from ADCs), but demultiplexing output
> buffers into a DAC, not so well. Especially on a single chrdev.
>
> Question 1: do we want to support more than 2 buffers per chrdev?
>
> This is what ADI currently has in it's tree (and works).
>
> Example, ADC:
>   # ls iio\:device3/buffer/
>   data_available  enable  length  length_align_bytes  watermark
>   #  ls iio\:device3/scan_elements/
>   in_voltage0_en  in_voltage0_index  in_voltage0_type  in_voltage1_en  in_voltage1_index  in_voltage1_type
>
> Example, DAC:
>   #  ls iio\:device4/buffer/
>   data_available  enable  length  length_align_bytes  watermark
>   # ls iio\:device4/scan_elements/
>   out_voltage0_en     out_voltage0_type  out_voltage1_index  out_voltage2_en     out_voltage2_type  out_voltage3_index
>   out_voltage0_index  out_voltage1_en    out_voltage1_type   out_voltage2_index  out_voltage3_en    out_voltage3_type
>
> The direction of each element is encoded into the filename of each channel.
>
> Another question is:
>   Does it make sense to have more than 1 'scan_elements' folder?
>   That is, for devices that would have both in & out channels.
>
> For 'buffer' folders I was thinking that it may make sense to have,
> 'buffer_in' && 'buffer_out'.
>
> So, one idea is:
>
> Iio_deviceX:
>          buffer_in
>          buffer_out
>          scan_elements
>
> Currently, this patch kind of implements 2 buffers per iio_dev/chrdev.
> But the format is:
>
> Iio_deviceX:
>          buffer_in
>          buffer_out
>          scan_elements_in
>          scan_elements_out

I'd make scan_elements as a sub-folder of the buffer folder. And have 
symlink for the legacy case

>
> Obviously it shouldn't work as-is [as it wasn't tested], but at least gives
> some glimpse of where this could go.

I believe the basic idea behind the multiple buffers per device was, 
that if we do it, we should do it in a way that you can have an 
arbitrary number of buffers. E.g. not just one input and output but also 
multiple input buffers.

>
> 3. A side question is about the 'iio_buffer -> pollq' field. I was
> wondering if it would make sense to move that on to 'iio_dev  pollq' if
> adding multiple buffers are added per-device. It almost makes sense to
> unify the 'pollq' on indio_dev.
> But, it looks a bit difficult, and would require some more change [which is
> doable] if it makes sense for whatever reason.
> The only reason to do it, is because the iio_buffer_fileops has a .poll =
> iio_buffer_poll() function attached to it. Adding multiple buffers for an
> IIO device may require some consideration on the iio_buffer_poll() function
> as well.

I think we need one chardev per buffer. Conceptually that is the right 
approach in my option since the two buffers are independent streams. But 
also from a practical point of view we want to have the ability to have 
the buffers opened by different applications. E.g. iio_readdev on the 
input buffer and iio_writedev on the output buffer. And there might be 
some other operations that wont multiplex as nicely as read/write. The 
high speed interface for example would not work as it is right now.

