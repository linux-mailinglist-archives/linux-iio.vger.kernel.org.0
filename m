Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC99E3962BF
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEaPAw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 11:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbhEaO7U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 10:59:20 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4B9C061236;
        Mon, 31 May 2021 07:03:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d12so2372172qtq.4;
        Mon, 31 May 2021 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=y2MDXnI/OIKxWHEtIFBSOW9PzSGP8Ug1F4tSdphQJdg=;
        b=GvykXANtw8VwODfnhDd6eSNqTgmVMHdl2GChtd7P16iokl17GMuiHXlIXL5Zn5lZ6P
         pnXeemIIAHCuI7bxM8HQeoVQ5e+oikH+1ezUR7DSewH4BnqPDrshCeADClbB/xdtT373
         xQIoOmgNQClnWxioQq2EzG+wp27jqt8NqaJzY4gbGatDlSmScYVs9hcgG66TG0h1phE4
         Lc7cRjnx40NYIFCn6I1sakLsjsJt7N6EF+Wb82T1hTU3Ge6QBp/QJLCl+rDyrt+z3GGf
         yyzgQl4brupNSv306IoKOWVybk54BQ/fLwWsWj7WI/r0ZURxx8B6EaP3OaZ1zYAwLONH
         iCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=y2MDXnI/OIKxWHEtIFBSOW9PzSGP8Ug1F4tSdphQJdg=;
        b=WhFgR3lvokpUH8l9sSIXpqX3axEnZ6h3OeVXLq2clyfz8LZcF9VW0Y8z1LmuMF+gyb
         D6Vt3gcH7haDPj6OiaRP57ol8attJ3ApFU++3FX6xj/KiOcZhelTBJgG1oXPlO3FW8Jf
         Oq+nBEQ6QHvjti5fr/ThaoCZGOJVw6Mlp9mWvIKM+IWisFvEbPdxU1BSeU1lxuMfmPKv
         c1ykvMuOKLVOVOQhvVE+jB3NtDE3U/NVl2o8B4cPgdsQXmknA7CVhvNPZadytttfZoZW
         YUfZzpSVbi8icFGe7e1MfRdcemGUBnuu9lB3JsDVQHniTsD/ctf8I9D6M879MUgGCyn2
         TklQ==
X-Gm-Message-State: AOAM531vMD9k8Dhsx2dxM3KXDeWy4PTBkKAV0kUORXvANfbSgu/nFeRh
        8RYACg3AFrpes643ERv0Z9g=
X-Google-Smtp-Source: ABdhPJyimULmdTkrROg5WHI4lKMoCvfT1Ruqp4XVScUneBYoC1x3sQxiHKGLicO9OVy0EtaMiZTKWA==
X-Received: by 2002:ac8:1483:: with SMTP id l3mr14900526qtj.142.1622469805558;
        Mon, 31 May 2021 07:03:25 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id 7sm9086249qtu.38.2021.05.31.07.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 07:03:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 May 2021 10:03:23 -0400
Message-Id: <CBRHJM8ANOSE.2Q5C1FVQS5QOA@shaak>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 9/9] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
From:   "Liam Beguin" <liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-10-liambeguin@gmail.com>
 <0286de71-1b04-0956-be4e-f38573c6fea2@axentia.se>
In-Reply-To: <0286de71-1b04-0956-be4e-f38573c6fea2@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Mon May 31, 2021 at 3:32 AM EDT, Peter Rosin wrote:
> Hi!
>
> On 2021-05-30 02:59, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > An ADC is often used to measure other quantities indirectly. This
> > binding describe one cases, the measurement of a temperature through a
> > voltage sense amplifier such as the LTC2997.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
>
> What's the significant difference between this and the RTD binding? Does
> not both simply scale/offset a voltage to a temperature?
>

The way I looked at it was one binding per sensor type (resistance
driven, current driven, and voltage driven).

Thinking about it more, these three bindings could be factorized into
one if the user is required to enter parameters "by hand".

These could become something like:
- sense-gain-mult
- sense-gain-div
- sense-offset

I like the idea of having the "datasheet parameters" in the devicetree,
but this would be a lot more versatile.

What do you think?

Cheers,
Liam

> Cheers,
> Peter

