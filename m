Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D631458BF1
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 11:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhKVKDi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 22 Nov 2021 05:03:38 -0500
Received: from aposti.net ([89.234.176.197]:56024 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238875AbhKVKDi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Nov 2021 05:03:38 -0500
Date:   Mon, 22 Nov 2021 10:00:19 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 03/15] iio: buffer-dma: Use round_down() instead of
 rounddown()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Message-Id: <J4XY2R.1WOGAOGR6ITU2@crapouillou.net>
In-Reply-To: <20211121140823.6b2922f6@jic23-huawei>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115141925.60164-4-paul@crapouillou.net>
        <20211121140823.6b2922f6@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le dim., nov. 21 2021 at 14:08:23 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> On Mon, 15 Nov 2021 14:19:13 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  We know that the buffer's alignment will always be a power of two;
>>  therefore, we can use the faster round_down() macro.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> *groan*.  I don't want to know where the naming of these two came 
> from but that
> is spectacular...
> 
> Anyhow, happy to pick up 1-3 now if you like as all are good cleanup 
> of
> existing code.

I think you can pick 2-3 now; I will do some changes to patch [01/15] 
in the V2.

Cheers,
-Paul


