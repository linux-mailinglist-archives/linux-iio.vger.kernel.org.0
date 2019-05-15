Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D911FA68
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2019 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfEOTZM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 May 2019 15:25:12 -0400
Received: from www381.your-server.de ([78.46.137.84]:53502 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOTZL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 May 2019 15:25:11 -0400
X-Greylist: delayed 1662 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 15:25:11 EDT
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1hQz5j-0007jh-V3; Wed, 15 May 2019 20:57:28 +0200
Received: from [93.104.106.165] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1hQz5j-0006DY-KX; Wed, 15 May 2019 20:57:27 +0200
Subject: Re: iio buffer dmaengine
To:     Paul Thomas <pthomas8589@gmail.com>, linux-iio@vger.kernel.org
References: <CAD56B7eKeaobf5xES8PFLSKvMHvpe2t52-w-rnVnRJpBX7bh8Q@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <dfafbc0e-5fdd-16e4-35d1-7b4375394674@metafoo.de>
Date:   Wed, 15 May 2019 20:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD56B7eKeaobf5xES8PFLSKvMHvpe2t52-w-rnVnRJpBX7bh8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25450/Wed May 15 09:59:26 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/15/19 4:15 PM, Paul Thomas wrote:
> Hello,
> 
> Currently I have a driver directly using a dmaengine channel and then
> calling iio_push_to_buffers_with_timestamp() in the callback. I ran
> accross the industrialiio-buffer-dmaengin.c implementation, and it
> looks like this may be a better way to go. However, I had a few
> questions.
> 
> First, am I correct that there are no current users of this interface
> in the mainline kernel? I pulled the analog devices kernel and I see
> users there, but the interface is a little bit different.
> 
> Second, it's not clear to me how or if multiple samples / dma transfer
> and time stamping is supported.

If you are using the DMA based buffer it is not possible to have per
sample software timestamps. The idea behind the DMA support is that all
the data is supplied by the device and the kernel driver never has to
never even look at it. Inserting a timestamp for each sample would
negate all the benefits of DMA and provide not much improvement in terms
of performance over a non DMA setup.

If you have to insert timestamps by software and your update rate is low
enough your current implementation is probably the best approach.
