Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1072427156
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhJHTVM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 15:21:12 -0400
Received: from www381.your-server.de ([78.46.137.84]:50304 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhJHTVM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 15:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=YjtHyAj7iC/zXvwf7dwb8EvZ+U32EBe0Uy2PwZ5sxmw=; b=YNSvfQdgv8lZHpq8AMs/ck+7z6
        RkINaq5qHzA76UTEP0cE/Wyx9VnVRRDo6lEq6Xtz/2BXXs5HbBf7wcixK6TSUtU8NRnqrA4PG+MJX
        dqEeatkflxihdgzcq5V2uwi5M+SbNc5LMGDDx/DjyBgVdZu6cqlfku74AlEN2bKElE0/C7XrUyO9u
        QErsw+UVZN53QPwnrO+GpUm8l7Oymh62RrJ650L9l/RmRbT/0TuQwqA38Z3us5GzCKnBzJb8/cwNJ
        bv48CrN01avtybQskjM4c9sCUX0yAdEU+LbneRhEe4Mo1YYO0bOKIW7i6I0l0oxc07+6vW5Lk5wno
        jH9G+wcA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mYvOi-0002jO-GU; Fri, 08 Oct 2021 21:19:12 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mYvOi-000R4d-AM; Fri, 08 Oct 2021 21:19:12 +0200
Subject: Re: [PATCH v2 0/3] Add settle time support to iio-mux
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, peda@axentia.se,
        jic23@kernel.org, devicetree@vger.kernel.org
Cc:     kernel@axis.com, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <16fab3ba-5dd9-50b3-aeae-acd68b22dfae@metafoo.de>
Date:   Fri, 8 Oct 2021 21:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211007134641.13417-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26316/Fri Oct  8 10:18:46 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/7/21 3:46 PM, Vincent Whitchurch wrote:
> On one of our boards we use gpio-mux with iio-mux to read voltages using an ADC
> from a few different channels, and on this board the input voltage needs some
> time to stabilize after a switch of the mux.
>
> This series add devicetree and driver support for this kind of hardware which
> requries a settle time after muxing.

I have a board with the very same problem. And a similar solution, but 
you beat me with upstreaming. I've switched to your patchset.

Whole series

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>


>
> v1 -> v2:
> - Move property support to iio-mux and delay handling to mux core as suggested
>    by Peter.
>
> v1: https://lore.kernel.org/all/20211004153640.20650-1-vincent.whitchurch@axis.com/
>
> Vincent Whitchurch (3):
>    mux: add support for delay after muxing
>    dt-bindings: iio: io-channel-mux: Add property for settle time
>    iio: multiplexer: iio-mux: Support settle-time-us property
>
>   .../iio/multiplexer/io-channel-mux.yaml       |  5 +++
>   drivers/iio/multiplexer/iio-mux.c             |  7 +++-
>   drivers/mux/core.c                            | 36 ++++++++++++++++---
>   include/linux/mux/consumer.h                  | 23 +++++++++---
>   include/linux/mux/driver.h                    |  4 +++
>   5 files changed, 65 insertions(+), 10 deletions(-)
>

