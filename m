Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D82F698F
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKJPON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:14:13 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35943 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfKJPON (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Nov 2019 10:14:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id j7so9397670oib.3;
        Sun, 10 Nov 2019 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3b1KNrJoF7hiZ9f5QB0CwtZdtDXpaOtcJztE2+Em/I=;
        b=GS5A/gJq9PfTy+ldfS/E8RU4kDfHgdBc6VXLWnBC5R5MW9CS3yRP13Sv9CDsJJoBQw
         0X56lE7y79QDjB9GZp0Whvx4PwMnWdB7VmvowneLpBuCf3SOuyMe5p1RlfH8J8bRwTTK
         m0NB1mlyPC7yPJWHowUvJ2uleq4wqmqTjvT+Fo9ay2ZUScB1YzNNmVVJ0kJmF74n5nsN
         yzLGMNBfQ4vLfS24+u2+5GMpedo+YNbkZyBOZAu5l1eU0D+Vh9bUOQcsCKwSgpFgdGol
         nk1ieRUB7P9MlrOB0xNDtzIXGSfVXPFd0csddnYgkCVzrYb2yB8r18o7ddb9sbhLYvQH
         FZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3b1KNrJoF7hiZ9f5QB0CwtZdtDXpaOtcJztE2+Em/I=;
        b=UK1SYf9bx/3oYvujoPOTZvVU45bI6wf3cLF/mHV9sTt1ofzOvBA06aD9+eTHnwGhUW
         6u8lvRMg9EnkFyDuXSLiIAN3m9Wy1g7uv45wJmXWwqwLSCUh1rfkv5AeRelNtamqeNxG
         vwCIaFFlBGbjaA35EwVkk4UV5H2kQtN16sqZDJDP7zhpIifJRQg325AdPKt+SyWn07MQ
         jvCF6wbM5pBR/krd1F6LKyZoLc61YUITnsMN+FXHF02nQEnJy7mGJt2g6DGCDg5v9irf
         TbPJfXw7bwkVTXt84wyZQBrZvHyUbugohj7hlJQnVAA/oinYPT4ZyssMC5+bLfmBjQLS
         wXDw==
X-Gm-Message-State: APjAAAWuwwB+dSWvXKl4ROZzqKDdldBUxjmHeAHmcnFqL96fIs8TLKtU
        bdqD0jS69hMgQjtGf+QemJ4=
X-Google-Smtp-Source: APXvYqwSsj4htI0kfSz1zjPmqcSnDIZPqvPVxAOvSaMBenRous+uk6xrLI/PcCkj0Y1nPTS/q4SFqA==
X-Received: by 2002:a05:6808:ab4:: with SMTP id r20mr20634682oij.166.1573398852415;
        Sun, 10 Nov 2019 07:14:12 -0800 (PST)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id m4sm3996959otf.0.2019.11.10.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 07:14:11 -0800 (PST)
Date:   Sun, 10 Nov 2019 10:14:08 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] counter: cros_ec: Add synchronization sensor
Message-ID: <20191110151408.GB3984@icarus>
References: <cover.1566563833.git.fabien.lahoudere@collabora.com>
 <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
 <20190826095612.7455cb05@archlinux>
 <8abbe9360938ab851d16c2c1494ba56034775823.camel@collabora.com>
 <6b50bdff184e6af664b7a61e0a8a2cddc5718f0a.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b50bdff184e6af664b7a61e0a8a2cddc5718f0a.camel@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 24, 2019 at 04:20:51PM +0200, Fabien Lahoudere wrote:
> Hi all,
> 
> After some discussions and investigation, the timestamp is very
> important for that sync driver.
> Google team uses that timestamp to compare with gyroscope timestamp.
> 
> So the important data is timestamp and counter value is useless.
> Just the event of counter increment is important to get a timestamp.
> 
> In that case, my idea was to just use an IIO driver with a single
> channel with IIO_TIMESTAMP. We discuss this here and it seems
> controversial.
> 
> So my question to Jonathan is if we have a timestamp coming from the EC
> itself, can we consider this timestamp as a good IIO driver?
> 
> Any other idea is welcome, however Google team would like to manage
> only IIO drivers if possible.
> 
> Thanks

Jonathan,

Should the the timestamp from the EC be introduced as an IIO driver
using IIO_TIMESTAMP?

Since there is no corresponding EC Counter driver in the baseline right
now we don't have a conflict yet. If the EC timestamp is introduced as
an IIO driver then we should make any future EC Counter driver mutually
exclusive with the IIO driver in order to prevent any memory space
conflict. At that point we may deprecate the IIO driver and move the
timestamp functionality to the corresponding Counter driver.

That's assuming someone is interested in the Count component enough to
implement an EC Counter driver; otherwise, the IIO driver will serve
just fine if timestamp is the only data desired from this device.

William Breathitt Gray
