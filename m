Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ACD4E51D2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 13:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiCWMGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 08:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiCWMGC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 08:06:02 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2CC6462
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 05:04:31 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 1so838084qke.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Mar 2022 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6FvrDMe4gG4SIpRpME8UY5pB3GrWvgnyaHYuszBYf/A=;
        b=g8LoN7R5ZKaH2yb6ca/pfLQCAxjdp+dW47mrqn0YstCZFD3FdMYhK4D3icxeXW7vp+
         Hb5IB3Btw4qwtzvYqhm+u1fsY7kGP9NJLxxOW4GFha/Q+H7a91m+GDHoBKG1PgZtQ3fa
         oan+/iolblRCp5Hr0RIjeaAxtxs5IuP93wiD0u4pxTzrZU8E48hhaWYDeSKsrQE98YGQ
         kYcjOfIqMJd9w8al6/giNjnKdrP7wslTIhnR4CkSfwb75fESkzFyBZfaNwqxxWIw669S
         CnL41upoi1hnnD08xNLKzQfVRG0MVMF+9EMKzxVYY/0fmDPag2wVN55BEoDkXksG8c5p
         B7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6FvrDMe4gG4SIpRpME8UY5pB3GrWvgnyaHYuszBYf/A=;
        b=jBoWjld9uzAb9MgJnk7jU3EorYt/ZdkVMbs9ybWcw1oZNsg4kfJqQROuz9hBDZj5Si
         shxtdY1f5/wqI+Ao4ZiNdNXQnMlAHMmr7+ZcBJ7szjW5JPgO9//9QYytiFTuZT1h23+i
         HzG1Yz9xZb2Red5cP+6EBypbE4oUvUwcqnNaSvRV0s99abHjWrusIhL4al/E20C59G8M
         9+OFeGNJXXjSz059BgxN/mUaCquGZO22bIL8l/KxNNhe4ez7xc6m0N01jS07gbQzdB8A
         BJ32QyDJA66Np4PHXJ/RSVJbYdIrG8WulKvo1VTkWjzgd8l4nGoRXjLK8KWLDa0SsdAZ
         ffFg==
X-Gm-Message-State: AOAM531LT6yFZRwB3tHl1+BMlIHjeGUSZlc/527ggRoJcof5QNryy5Lm
        n6QZB755kO06/rKwNSsk7zU=
X-Google-Smtp-Source: ABdhPJw7W1ijACaQv2ka9t7dyKclYPok4bBlP3xXOxj73NYjxFSv9VtQuzyoc5YJWYjWu21p9kg/Jw==
X-Received: by 2002:a05:620a:142b:b0:67d:15f0:1dbc with SMTP id k11-20020a05620a142b00b0067d15f01dbcmr17999536qkj.497.1648037070952;
        Wed, 23 Mar 2022 05:04:30 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id t72-20020a37464b000000b0067ec1c9dcaesm1970334qka.44.2022.03.23.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:04:29 -0700 (PDT)
Message-ID: <52553cf76f5d4c7d7224117b528d111ab7ca5ae3.camel@gmail.com>
Subject: Re: [PATCH v2] iio: core: Print error in case sample bits do not
 fit storage bits
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Date:   Wed, 23 Mar 2022 13:05:01 +0100
In-Reply-To: <20220322214248.00007194@Huawei.com>
References: <20220322111619.54808-1-marex@denx.de>
         <20220322214248.00007194@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2022-03-22 at 21:42 +0000, Jonathan Cameron wrote:
> On Tue, 22 Mar 2022 12:16:19 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
> > Add runtime check to verify whether storagebits are at least as big
> > as shifted realbits. This should help spot broken drivers which may
> > set realbits + shift above storagebits.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Hmm. I was thinking we'd fail the probe if this happens,
> though I guess there might be cases where we get away 
> (in kernel anyway) with a driver setting this wrong as
> many drivers don't use realbits internally in an explicit
> fashion, so maybe a message and skipping the channel is
> the right choice...
> 
> Userspace running against such a description is likely
> to generate garbage though unless it's very lucky and
> the spill past storage bits is into padding space and
> the driver doesn't put anything in there (padding might
> contain old data or similar).
> 
> Either way it's a definite improvement so I'm probably fine
> with the message and not failing the probe, (though will
> think a bit more about it before picking this up.)
> 
> 
> Jonathan`
> 

FWIW, if we assume we are ok with potentially some drivers starting to
fail probe, I'm +1 on this should fail probe...

- Nuno Sá
> 
> > ---
> > V2: Use dev_err() instead as WARN_ON() may panic() the kernel on
> > existing machines
> > ---
> >  drivers/iio/industrialio-buffer.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index b078eb2f3c9de..b5670398b06d7 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1629,6 +1629,18 @@ static int
> > __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >                         if (channels[i].scan_index < 0)
> >                                 continue;
> >  
> > +                       /* Verify that sample bits fit into storage
> > */
> > +                       if (channels[i].scan_type.storagebits <
> > +                           channels[i].scan_type.realbits +
> > +                           channels[i].scan_type.shift) {
> > +                               dev_err(&indio_dev->dev,
> > +                                       "Channel %d storagebits
> > (%d) < shifted realbits (%d + %d)\n",
> > +                                       i,
> > channels[i].scan_type.storagebits,
> > +                                       channels[i].scan_type.realb
> > its,
> > +                                       channels[i].scan_type.shift
> > );
> > +                               continue;
> > +                       }
> > +
> >                         ret =
> > iio_buffer_add_channel_sysfs(indio_dev, buffer,
> >                                                         
> > &channels[i]);
> >                         if (ret < 0)
> 

