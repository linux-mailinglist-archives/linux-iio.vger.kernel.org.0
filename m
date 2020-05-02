Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A61C2817
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEBTwY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728107AbgEBTwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2020 15:52:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F4FC061A0C;
        Sat,  2 May 2020 12:52:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so5705334wrt.0;
        Sat, 02 May 2020 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3Mnck96kjVP1ccpDH4lQmcsXxZyooBEBeDWkAIMnx9A=;
        b=frvw0Z6lpkh/rUOqacNs9b9JowMotqAtwpoGo1kAKgY5Ft808whoH9Wn7EXwUVYSOv
         D4/SnO/E9yX0egvJnN8LyKuU5fyMwoOJxz5uyPyPzYiriBjBdcnOJGLSCBdX+rrr/OQ/
         ap+Tl35T+o3kxV4/6voxuexV8TTce4vtJAoVa1ttH/jycOJ5iOMFp4JCZjilvoAT7/BT
         WO/Fqv5ncjhSpW8YDS5FDsRnwhKVlKmBMwWpvl0uEH3sO1Ad1rwJeju4CzGA6xzGWcj7
         ykwjuiLY7jHFTP45bu2dd3BkMXOrEeTxkpzb3hTv9nZ8o+Qmtl53hRhkEF+J4BbU/1Pr
         oz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3Mnck96kjVP1ccpDH4lQmcsXxZyooBEBeDWkAIMnx9A=;
        b=pkw6A6sOOh+E2STFjWpqEQxlWY5R7czQNfY3QuXjSVhxH55Tb/UWKFnC9hz4NhuNyC
         Wp+IugUoCaa5Y5mRHXd8F7nPudw6YG1rSs6VlQOc+9xKDtUGPFrczskePsILBd0JTqvC
         1cFhR0mpYb9K9lGvgcVf5O0Wb0qP5eS6qyo+wKLAlPUbR0Wmvfs/EjuIqLPEO8Ksh/co
         JJk3/nim/oJdATrBc3PqsrNBv0vJyac+cRwcFeuRCVpa2eo12dOxx3z4C1CKi62O4tML
         69qyWdyFDt2l+F8YqmCHk+vdQleDMsBQ8gkmeeq8Sx8f7OzVIW0WdCUkf7AOCeyYcnUs
         ro/A==
X-Gm-Message-State: AGi0PuaebdDXMXzXELpgv+BjcfluB81BgCDELL+myu/3Bd3i7kVB7VXU
        1TnjYiik0nkplLJCNHLQrGc=
X-Google-Smtp-Source: APiQypLWE2SHEF2BwLmZgkmhekQa1svIpqZVRQ9MjP1cAAxpFV4D1YSnufiHrLb2NmZ++0cGSNhEcQ==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr10282362wrm.287.1588449140954;
        Sat, 02 May 2020 12:52:20 -0700 (PDT)
Received: from nunojsa-N551JK ([2001:a61:2450:9301:5d5:a6ce:613b:d018])
        by smtp.googlemail.com with ESMTPSA id f7sm10029592wrt.10.2020.05.02.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 12:52:20 -0700 (PDT)
Message-ID: <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Sat, 02 May 2020 21:52:18 +0200
In-Reply-To: <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
References: <20200413082445.17324-1-nuno.sa@analog.com>
         <20200413082445.17324-6-nuno.sa@analog.com>
         <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
         <20200502184010.134eb8b5@archlinux>
         <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen wrote:
> On 5/2/20 7:40 PM, Jonathan Cameron wrote:
> > On Mon, 27 Apr 2020 20:06:07 +0200
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > 
> > > On 4/13/20 10:24 AM, Nuno Sá wrote:
> > > > [...]
> > > > +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> > > > +{
> > > > [...]
> > > > +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> > > > [...]
> > > > +
> > > > +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf-
> > > > >timestamp);
> > > If the timestamp is enabled the IIO core might insert padding
> > > between
> > > the data channels and the timestamp. If that happens this will
> > > disclose
> > > kernel stack memory to userspace.
> > > 
> > > This needs either a memset(data, 0x00, sizeof(data)) or maybe put
> > > data
> > > into the state struct and kzalloc it.
> > Good spot. Could simply do __be16 data[ADI..] = {0}; rather than
> > explicit
> > memset, but some form of zeroization is needed.
> > 
> > I've fixed up the applied patch with the above approach.
> There is actually another issue. The stack data is not necessarily 
> aligned to 64 bit, which causes issues if we try to put the 64-bit 

Oh, this is actually more problematic. Yes, since we have an array of
u16, that is not guaranteed to be 64bit aligned. Doing a quick search
of `iio_push_to_buffers_with_timestamp()` users and I could quickly
find 4/5 drivers with the same problem. I guess the API should clearly
state that `data` needs to be __at least__ 64 bits aligned (maybe a
future patch). Or we could even check the address and guarantee that it
is properly aligned before continuing (though Im guessing this will
break a lot of users...)
> timestamp in it. I think data should really be in the state struct.

Yes, with a proper __aligned(8) attribute... Or couldn't we just use
__aligned(8) on the stack variable?

- Nuno Sá


