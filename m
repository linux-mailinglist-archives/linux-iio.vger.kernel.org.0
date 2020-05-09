Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49D1CBF65
	for <lists+linux-iio@lfdr.de>; Sat,  9 May 2020 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgEIIwS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 May 2020 04:52:18 -0400
Received: from www381.your-server.de ([78.46.137.84]:56354 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgEIIwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 May 2020 04:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UX4id79YvnLmpwLxSRzdIBRSmF4fESpagRYbUVxzdds=; b=k4Hx7HSWchDhaD3UM7WhRDZFA4
        /E1yaBZNGr67a2zrz/z27HEbSOBpyBa/eSTjHNPV0WUmk7UkuGwfFzqA+c9MJLldEk4k9Quhr/zsY
        6C4f+pb/41QuLwSh/RYvOXuNhEMm2Wxp+nh0S5cwtXvsY6JgVeufXOkGttz1qci3B+LVU2K4nC5N4
        x2ufxZYtLg1HuH8lUDQCDXKuK6ZBBOn0BiYPWYrTgmEbz3O4XrbR5vW6R8ZZyNBh+GPflWecTaYwh
        FFeJQb0cui89jf9cFFNch8XXmWnMikD4qJ5EAxtATY2xWSm68S8Ir5Zsr+6mYjCAeNnGZzJ9v8NFO
        Zvn9WYOA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jXLDT-0000KF-5C; Sat, 09 May 2020 10:52:15 +0200
Received: from [82.135.71.55] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jXLDS-0000wq-Tj; Sat, 09 May 2020 10:52:15 +0200
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
Date:   Sat, 9 May 2020 10:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25806/Fri May  8 14:16:19 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/8/20 3:53 PM, Alexandru Ardelean wrote:
> [...]
> What I don't like, is that iio:device3 has iio:buffer3:0 (to 3).
> This is because the 'buffer->dev.parent = &indio_dev->dev'.
> But I do feel this is correct.
> So, now I don't know whether to leave it like that or symlink to shorter
> versions like 'iio:buffer3:Y' -> 'iio:device3/bufferY'.
> The reason for naming the IIO buffer devices to 'iio:bufferX:Y' is
> mostly to make the names unique. It would have looked weird to do
> '/dev/buffer1' if I would have named the buffer devices 'bufferX'.
>
> So, now I'm thinking of whether all this is acceptable.
> Or what is acceptable?
> Should I symlink 'iio:device3/iio:buffer3:0' -> 'iio:device3/buffer0'?
> What else should I consider moving forward?
> What means forward?
> Where did I leave my beer?

Looking at how the /dev/ devices are named I think we can provide a name 
that is different from the dev_name() of the device. Have a look at 
device_get_devnode() in drivers/base/core.c. We should be able to 
provide the name for the chardev through the devnode() callback.

While we are at this, do we want to move the new devices into an iio 
subfolder? So iio/buffer0:0 instead of iio:buffer0:0?

