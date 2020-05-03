Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88901C2E6E
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgECRzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbgECRzL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 13:55:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C1C061A0E;
        Sun,  3 May 2020 10:55:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so18183936wrx.4;
        Sun, 03 May 2020 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eI40m2dbkMq75XJPcjn2SYxgJHs1f4gBLHf7s82v0r8=;
        b=LrRglC6EM5LkA9rqAfw3kv8eIhLT+FL+yOomQF8p4AIiYidrwjYM8WA8VzjHaM1T1s
         rSrokMPm2DSKL79xfw1Z2b144Y8LwXLQKAwoaqXjcFbeMDpJG8N2oa+LT5jF7lyuAgZS
         ZaVCd0m6SisI3Vpmvu9dqcTTFky31fAEcpAYeMtfBnRUdL6c0i16pC0H6STYjY1dV/mC
         OfEpD/aIUOfI2v4uxHx4E3WJGu28YhcxgP88Xgki8TZL4T849LAqRca7mUk4nrwgPI//
         D8Y2yQUq/uQCNYA5dJy6KI7YmJhgOt+cofVNeEOD3ZwLnBOsQ7qYaVTFCtdSwy7xaL6s
         /OdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eI40m2dbkMq75XJPcjn2SYxgJHs1f4gBLHf7s82v0r8=;
        b=mYCwVj2Eu/5ECOec/UHaKCr/bWHj40awjrFDDkowZr93AGi3+zgP+FaXiKbz/yIdlf
         NmaUVbd0h1jWAuusYhgqsvTRoz1Ha76RyNAALuQQfk3t/73YLqBI2B5E0YzrMWTcU4rQ
         LnSIn5J9QHlXMvchOrOwdFCfww6aeB7Em4UawEl9BEXkoVEDy+63XnxR2RatShSd78F+
         fsFK5YaLosevFtlsXwc5sS6OcWzlz9QJLsIL/aFinrlwI1x04EQwy421sjOVqyHmHRbT
         YuSaqhkKlA6IB4849WcrcSAEa4aSdrMlpF26BOg9Tjvi7GajjGlhTT6nkCR4xmiyDDkE
         Q6aA==
X-Gm-Message-State: AGi0PuaZThgYelIdoacbDV6nW1XFGWP82OMCPyfViVHqXTlFbtQp9FDC
        XGlNmYdQTRAVM5Bh+roSyqs=
X-Google-Smtp-Source: APiQypKu6w+sDo2F13RP8Jmf29B7r/5DZk4emtcvrvGIU6aGYcqt7zi7EFmPIH2cPBbiSyNuYmN05A==
X-Received: by 2002:adf:8401:: with SMTP id 1mr15488421wrf.241.1588528509340;
        Sun, 03 May 2020 10:55:09 -0700 (PDT)
Received: from nunojsa-N551JK ([2001:a61:2488:b501:889a:1d04:1d51:f2d0])
        by smtp.googlemail.com with ESMTPSA id j13sm14589830wro.51.2020.05.03.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 10:55:08 -0700 (PDT)
Message-ID: <a7ae81309768ac86413a7350d5735f4a1781be97.camel@gmail.com>
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Sun, 03 May 2020 19:55:07 +0200
In-Reply-To: <20200503181959.369161a4@archlinux>
References: <20200413082445.17324-1-nuno.sa@analog.com>
         <20200413082445.17324-6-nuno.sa@analog.com>
         <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
         <20200502184010.134eb8b5@archlinux>
         <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
         <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
         <20200503094751.633feda1@archlinux>
         <c7c6c4af-826a-d52a-3969-4ccccbff12e9@metafoo.de>
         <231ac29f177774eeb32b0ed907516173af0f97eb.camel@gmail.com>
         <20200503122926.1fcc73fa@archlinux> <20200503181959.369161a4@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2020-05-03 at 18:19 +0100, Jonathan Cameron wrote:
> On Sun, 3 May 2020 12:29:26 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 03 May 2020 13:07:01 +0200
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > 
> > > On Sun, 2020-05-03 at 11:07 +0200, Lars-Peter Clausen wrote:  
> > > > On 5/3/20 10:47 AM, Jonathan Cameron wrote:    
> > > > > On Sat, 02 May 2020 21:52:18 +0200
> > > > > Nuno Sá <noname.nuno@gmail.com> wrote:
> > > > >     
> > > > > > On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen
> > > > > > wrote:    
> > > > > > > On 5/2/20 7:40 PM, Jonathan Cameron wrote:    
> > > > > > > > On Mon, 27 Apr 2020 20:06:07 +0200
> > > > > > > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > > > > > >        
> > > > > > > > > On 4/13/20 10:24 AM, Nuno Sá wrote:    
> > > > > > > > > > [...]
> > > > > > > > > > +static irqreturn_t adis16475_trigger_handler(int
> > > > > > > > > > irq,
> > > > > > > > > > void *p)
> > > > > > > > > > +{
> > > > > > > > > > [...]
> > > > > > > > > > +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> > > > > > > > > > [...]
> > > > > > > > > > +
> > > > > > > > > > +	iio_push_to_buffers_with_timestamp(indio_dev,
> > > > > > > > > > data, pf-    
> > > > > > > > > > > timestamp);    
> > > > > > > > > If the timestamp is enabled the IIO core might insert
> > > > > > > > > padding
> > > > > > > > > between
> > > > > > > > > the data channels and the timestamp. If that happens
> > > > > > > > > this
> > > > > > > > > will
> > > > > > > > > disclose
> > > > > > > > > kernel stack memory to userspace.
> > > > > > > > > 
> > > > > > > > > This needs either a memset(data, 0x00, sizeof(data))
> > > > > > > > > or
> > > > > > > > > maybe put
> > > > > > > > > data
> > > > > > > > > into the state struct and kzalloc it.    
> > > > > > > > Good spot. Could simply do __be16 data[ADI..] = {0};
> > > > > > > > rather
> > > > > > > > than
> > > > > > > > explicit
> > > > > > > > memset, but some form of zeroization is needed.
> > > > > > > > 
> > > > > > > > I've fixed up the applied patch with the above
> > > > > > > > approach.    
> > > > > > > There is actually another issue. The stack data is not
> > > > > > > necessarily
> > > > > > > aligned to 64 bit, which causes issues if we try to put
> > > > > > > the 64-
> > > > > > > bit    
> > > > > > Oh, this is actually more problematic. Yes, since we have
> > > > > > an
> > > > > > array of
> > > > > > u16, that is not guaranteed to be 64bit aligned. Doing a
> > > > > > quick
> > > > > > search
> > > > > > of `iio_push_to_buffers_with_timestamp()` users and I could
> > > > > > quickly
> > > > > > find 4/5 drivers with the same problem. I guess the API
> > > > > > should
> > > > > > clearly
> > > > > > state that `data` needs to be __at least__ 64 bits aligned
> > > > > > (maybe
> > > > > > a
> > > > > > future patch). Or we could even check the address and
> > > > > > guarantee
> > > > > > that it
> > > > > > is properly aligned before continuing (though Im guessing
> > > > > > this
> > > > > > will
> > > > > > break a lot of users...)    
> > > > > > > timestamp in it. I think data should really be in the
> > > > > > > state
> > > > > > > struct.    
> > > > > > Yes, with a proper __aligned(8) attribute... Or couldn't we
> > > > > > just
> > > > > > use
> > > > > > __aligned(8) on the stack variable?    
> > > > > Forcing alignment on the stack isn't terribly reliable, which
> > > > > is
> > > > > why
> > > > > we never do that for dma safe buffers.
> > > > > 
> > > > > Probably better to just move it to the state structure.
> > > > > I'll fix it up to do that. Please sanity check what will
> > > > > shortly
> > > > > be in the testing branch.
> > > > > 
> > > > > The moment Lars mentioned this I groaned. As you've noted a
> > > > > few
> > > > > other
> > > > > drivers have the same problem + the ABI doesn't clearly state
> > > > > or check this.
> > > > > 
> > > > > We should certainly fix all the drivers that suffer this
> > > > > problem
> > > > > first then we can think about adding a runtime check.    
> > > > 
> > > > It looks like it is actually quite a few drivers, maybe we
> > > > should
> > > > switch     
> > > 
> > > Yeps, not surprised...
> > >   
> > > > to put_unaligned(). We probably got lucky in most cases and the
> > > > buffer    
> > > 
> > > This would keep us from having to fix all the users (just need to
> > > fix
> > > the memory leakage you mention on the next email) to use a
> > > properly
> > > aligned buffer. And later on, if we want, we can always add an
> > > `aligned` variant of `iio_push_to_buffers_with_timestamp()` were
> > > we
> > > check for alignment...  
> > 
> > I'd rather scrub the existing set to fix this.  The reason being
> > to make the point they were broken.  Fixing up with an unaligned
> > write in the core is not 'obvious' to people looking at whether
> > to pick up patches for individual drivers.
> > 
> > Unlikely to be too much extra over making sure we don't leak kernel
> > data.   If we move them to the iio_priv structure we will avoid
> > that
> > anyway due to that being kzalloc ed in the first place.  We may
> > leak previous timestamps or read values, but we don't care about
> > that.
> > 
> > It's been there a while, so no 'super hurry' to fix these up but
> > we should do it over next few months.
> 
> It's also worth noticing that there is some care needed.
> Some devices don't need to zero because there is no padding.
> Some devices are using the core demux, so the timestamp is always
> in the same place, hence can be nicely refactored to an explicit
> structure, either on the stack or heap.
> 
> Anyhow, from the first few I looked at I suspect they are all going
> to have slightly different optimal solutions.
> 
> Take a look at the kxsd9 patch I'll send in a minute.  For that one
> I think the cleanest thing is to leave the variable on the stack
> but use an explicit structure to ensure the alignment is correct.

Agreed. In those cases where there is no padding for the timestamp we
can leave the variable on the stack (we can even think about adding an helper macro to declare this kind of construct :D). For the other's we can make use of iio_priv being kzalloc at probe so that we don't leak kernel data...

- Nuno Sá
> 
> 
> Jonathan
> 
> > Jonathan
> > 
> > > - Nuno Sá
> > >   

