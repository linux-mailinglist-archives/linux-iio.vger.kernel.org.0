Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3869128A896
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgJKRy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:54:27 -0400
Received: from first.geanix.com ([116.203.34.67]:57176 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388329AbgJKRy1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:54:27 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2020 13:54:26 EDT
Received: from [192.168.100.11] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id 3D085F410AD;
        Sun, 11 Oct 2020 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1602438441; bh=VCp9dqS6A4lpxeBc/lTDQSqElGB7lvZbvRGUwkTmSj4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QK/0/sU1SRbBC0D1Bzw2fhwLgq7bsSPN4v3koAy9ikCUBWKj+1xjYf6TXgX/lBavI
         VqdX8DjrnT1ARqQgJJFdUUDkIm8o8mDjKrJR00w9OMieLJx1RcwEJp4HenzMJBZcHG
         A47QjBDBeBZ93t7h6uPYSm2HCLkR25M7e60RXZYzylg0xy4ALluYW6ohJIYIh86uuX
         Nj1HVGw/50Pf9cpQpwo9yDhG5Our0oXzqKHoUTWg/isozVJdU32qNbEsL2IGQBu7jm
         ZrDyhVnv2ckc9OqFYc8Jt87Nd3PVe0G2H7bZlBbLSAs+8NNixqL41Il8Ob8G3RHZ/R
         xaFkvkDgpew4Q==
Subject: Re: [PATCH 12/29] dt-bindings:iio:dac:ti,dac5571 yaml conversion.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-13-jic23@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <3812d0a0-7a70-d30c-7fd5-705e2fdef89c@geanix.com>
Date:   Sun, 11 Oct 2020 19:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201011170749.243680-13-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/10/2020 19.07, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> A few tweaks in this conversion.
> * The example didn't have the I2C address of 4C in the node name so
>    fixed that.
> * The reference voltage in the txt file is an optional binding, but
>    the driver is making use of it to provide the scaling of the output
>    channels.  As such I have made it required going forwards.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>
>
Looks good :)

/Sean
