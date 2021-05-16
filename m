Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678D9381F5C
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhEPO47 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhEPO46 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 10:56:58 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DEDC061573;
        Sun, 16 May 2021 07:55:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 197so3453242qkl.12;
        Sun, 16 May 2021 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=eHswci81bzxhd6oQF655OE4yXzxna+rlMF6/uXVPvIU=;
        b=eq05b9vKUtajtauFWC7moRZEv0qkx0aIaDm20UqPYnC7OwWSFY7E37zIEuVJQ9LW8L
         D9+JHTwWKde7UHj6ZbW0Hkz/u1az8qnXSHz6vxsadPZMfkqOjEqzDzxWytLryd0NZcMC
         whFCIry9iQouwaggHFNN0GEz1OdlY1jxuO5290NcGZ1JVLFkAbeUmDcFbqzU7zkp85pY
         7SkDL/umCmwjkQ6UCc5Z7r2o0y+FHP2NclGxUam6AMZxx/DP8pXBZRLltg+Dgh/WoKOc
         w5dBHPNwBIOO2g5wLS4lhspO15MpHBJzEa1TC2fGzQh6L8E5hCPMMTUFU+wMLykqoSq0
         FEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=eHswci81bzxhd6oQF655OE4yXzxna+rlMF6/uXVPvIU=;
        b=FA5ojN4EdTWYhSAcqoytKGwfEac3wlpypTSRTsOCJYxQMjPJFULM6RIbu3QD4KdMc+
         Lro0iRfVMaReuR2P171pMAAxxWaQqoiRVs17tvs+2HPB9zbw6b99g05NdDlJ34wevWcK
         bVUInMTqqm5pJIA3KrraaFstX2w2iJo34nUodk4Jv5NYYwKTCEt/c3bZ871iDdzht9NM
         lsEZnL6ChSfVOOq4puATrf/YRt5K/RVAIzEIC4H6r0JyGiRYqBD4wXGB89zlsZ4nNrrp
         7J9byFchi1KPbSpFxHdtkBwJnmrEvyLMqJQX5EsR5bsgeJUMdU4W9h+RHYClZSSzcunm
         f36g==
X-Gm-Message-State: AOAM532FeZWdBH7dZ483cNxpYEaqhDFBYUa2IMq9VOpHc4JhV6dxgrZ8
        b/D+iglORroGLf1Oc9nCDYKaktLAR/svgQ==
X-Google-Smtp-Source: ABdhPJyIv77anuRJzOKw9Uz80BRHilgiuRYDoHd7qqfr+vTelJmEVeXTr6xtFSq5t3uVNN+YJKne4A==
X-Received: by 2002:a37:e10b:: with SMTP id c11mr52200367qkm.152.1621176942294;
        Sun, 16 May 2021 07:55:42 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j1sm8325416qkk.78.2021.05.16.07.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 07:55:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 16 May 2021 10:55:40 -0400
Message-Id: <CBER9H2H2I30.25AABLQDA7CD3@shaak>
Cc:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v1 0/2] hwmon: (iio_hwmon) optionally force iio
 channel type
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Guenter Roeck" <linux@roeck-us.net>, <jdelvare@suse.com>,
        <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210516044315.116290-1-liambeguin@gmail.com>
 <29235b1d-78f3-6d8f-567f-78ca6f350340@roeck-us.net>
In-Reply-To: <29235b1d-78f3-6d8f-567f-78ca6f350340@roeck-us.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guenter,

On Sun May 16, 2021 at 4:56 AM EDT, Guenter Roeck wrote:
> On 5/15/21 9:43 PM, Liam Beguin wrote:
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
>
> That doesn't make sense to me. If an ADC is used to report temperatures,
> it would be a thermistor, and the ntc_thermistor driver should be used.
> Not sure what to do with currents, but overriding "voltage" with
> "current"
> seems wrong.

Thanks for pointing out the ntc_thermistor.
It makes sense that the ADC channel would become a thermistor.
I'll have a look and see if it fits my use case.

Liam

>
> Guenter
>
> > It would be convenient to do it within the IIO subsystem to have the
> > right unit there too.
> >=20
> > Thanks for your time,
> > Liam
> >=20
> > Liam Beguin (2):
> >    hwmon: (iio_hwmon) optionally force iio channel type
> >    dt-bindings: hwmon: add iio-hwmon bindings
> >=20
> >   .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 ++++++++++++++++++=
+
> >   drivers/hwmon/iio_hwmon.c                     |  2 +
> >   2 files changed, 43 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.=
yaml
> >=20
> >=20
> > base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> >=20

