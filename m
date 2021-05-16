Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C500381F6D
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 17:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhEPPEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 11:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhEPPEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 11:04:09 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD10C061573;
        Sun, 16 May 2021 08:02:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 197so3463766qkl.12;
        Sun, 16 May 2021 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=8nwtwbwh88ufuVL0iTMD0MkR7lGg6XWeDmvTt2i6B8g=;
        b=iN4eIJhL/vEI0tTa8gfl4eNx56ADtMA7cy8kw/xQugLUui1KmdUmSmUUC+2ObEZE1w
         YF59x4ibuTQnQVAN5ozsVmMbKiI6+4lVt67tiT8wAMCmF/5+ehJWUMxHTVLSOzDdkMKR
         o/LBl0fJcR2LP57un/bEji//887db1sQ/NIPUZW6O3eP3VUoKVoFGxrWf8T9pZ9qBxHM
         qkqg8zeTSwYj5bq0YXiZ6gQ2L1FK2FgYGV4w3ZhSBFZTnsSCeuFJF/WvMonDE4DUJcvy
         mTRHkfdwQf1KVGApGH2f403pauiNXln83vhHPdB87etKeUjnjnhrQKdQ4tYkxMQfJcif
         hCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=8nwtwbwh88ufuVL0iTMD0MkR7lGg6XWeDmvTt2i6B8g=;
        b=lvHwoF3hoLTIGubRDS6ebGoR0CvBpxJWK84VpLm7ojyNsM/YAr799uYn6PfpD5AU0N
         H3qAj4+mIL4++oF5o0bWfzyOAAcBSjIV5m1ahVkv0kypYJiNVSAhzoT5C9l9npt3Vm8Z
         L973ygywletyNZKVAB/J3yyryQFVsCaiV5x+704+YK3E7TZAf/CyoTA7Y7irj4G15+G8
         QVI6gVnorprj4F6PrmVGFCLe5bK02tb/jA+YK3LxyamBLQuQKU23rg37YL7WZZGklFsV
         s8EtQXJEZFMXThySl5JVh+FwN5XVUYChUlzfuJNMM+G5BDAQR01MTDzHWVwzuXngY0H9
         lx7w==
X-Gm-Message-State: AOAM5313uamkQizb8+R0DggwfvJQgLq5RQk+u072U5GE1y44rI+XGf0H
        2KOiOLiNFMWcSqWhF3YgRfs=
X-Google-Smtp-Source: ABdhPJzcdg8wjruwrBDr9MwJXlWPpR8XNIjQ4ap56ccc2yJiR3RtF5joO3HzH3I1p4v9TuyNJs1ZaA==
X-Received: by 2002:a37:5b46:: with SMTP id p67mr25850120qkb.358.1621177374360;
        Sun, 16 May 2021 08:02:54 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q185sm8203163qkd.69.2021.05.16.08.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 08:02:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 16 May 2021 11:02:52 -0400
Message-Id: <CBEREZMZ2Z8U.13BH8G7RKPPL7@shaak>
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     <jdelvare@suse.com>, <linux@roeck-us.net>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        "Peter Rosin" <peda@axentia.se>
Subject: Re: [RFC PATCH v1 0/2] hwmon: (iio_hwmon) optionally force iio
 channel type
From:   "Liam Beguin" <liambeguin@gmail.com>
References: <20210516044315.116290-1-liambeguin@gmail.com>
 <20210516100631.7310a7bb@jic23-huawei>
In-Reply-To: <20210516100631.7310a7bb@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun May 16, 2021 at 5:06 AM EDT, Jonathan Cameron wrote:
> On Sun, 16 May 2021 00:43:13 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > Add a devicetree binding to optionally force a different IIO channel
> > type.
> >=20
> > This is useful in cases where ADC channels are connected to a circuit
> > that represent another unit such as a temperature or a current.
> >=20
> > `channel-types` was chosen instead of `io-channel-types` as this is not
> > part of the iio consumer bindings.
> >=20
> > In the current form, this patch does what it's intended to do:
> > change the unit displayed by `sensors`, but feels like the wrong way to
> > address the problem.
> >=20
> > Would it be possible to force the type of different IIO channels for
> > this kind of use case with a devicetree binding from the IIO subsystem?
> >=20
> > It would be convenient to do it within the IIO subsystem to have the
> > right unit there too.
> >=20
> > Thanks for your time,
> > Liam
>
> Hi Liam,
>
> +CC Peter for AFE part.
>
> It's an interesting approach, but I would suggest we think about this
> a different way.
>
> Whenever a channel is being used to measure something 'different' from
> what it actually measures (e.g. a voltage ADC measuring a current) that
> reflects their being some analog component involved.
> If you look at drivers/iio/afe/iio-rescale.c you can see the approach
> we currently use to handle this.

Many thanks for pointing out the AFE code. That look like what I was
hoping to accomplish, but in a much better way.

>
> Effectively what you add to devicetree is a consumer of the ADC channel
> which in turn provides services to other devices. For this current case
> it would be either a current-sense-amplifier or a current-sense-shunt
> depending on what the analog front end looks like. We have to describe
> the characteristics of that front end which isn't something that can
> be done via a simple channel type.
>

Understood. My original intention was to use sensors.conf to do the
conversions and take into accounts those parameters.

> That afe consumer device can then provide services to another consumer
> (e.g. iio-hwmon) which work for your usecase.
>
> The main limitation of this approach currently is you end up with
> one device per channel. That could be improved upon if you have a
> usecase
> where it matters.
>
> I don't think we currently have an equivalent for temperature sensing
> but it would be easy enough to do something similar.

Wonderful, thanks again for pointing out the AFE!

Liam

>
> Jonathan
>
>
> >=20
> > Liam Beguin (2):
> >   hwmon: (iio_hwmon) optionally force iio channel type
> >   dt-bindings: hwmon: add iio-hwmon bindings
> >=20
> >  .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 +++++++++++++++++++
> >  drivers/hwmon/iio_hwmon.c                     |  2 +
> >  2 files changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.y=
aml
> >=20
> >=20
> > base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717

