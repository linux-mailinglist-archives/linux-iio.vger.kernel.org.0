Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933534322E6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhJRPeA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 11:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhJRPeA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 11:34:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5FDC06161C;
        Mon, 18 Oct 2021 08:31:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d3so718975edp.3;
        Mon, 18 Oct 2021 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dILHIBmr21sQ4w3qJYjy8QJvw3XypAA/G1BpXMjCiGk=;
        b=NnTcuzby6V9daRcEeACP+hW3w2rdUBmy8VS4d4KGkU0rHMLzVcygEk6g6uHvI2aDJf
         TSPoh2VmAzxb+IhfQoKUcDPsjgDU9qW/DEF/aNgHvW3Kfg3LQhAI76Wuh4JQrzCGYQr7
         Rr63i5PGNFfVJWNdX59Wb9DqB/TbSxcZ2RAOT1Obu6R4CmmNieWYJXhEVjikxqY5URe/
         rX7s7+vVfNZLEvq0Q/FamiEay7Sz9TOrsNvcUJYc4Z4JVbW2pmCUa9fkbg7bH+H4FroE
         4A8WC/6EVzuWYixsLfnSb8zbDkm+sMHjJsmVCteNaFahbcS8uepyc0TAlDXi30de+RJp
         FaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dILHIBmr21sQ4w3qJYjy8QJvw3XypAA/G1BpXMjCiGk=;
        b=Nfgh5m4y6mcvimwWJybU2+ULgTIMCluL6zA/usI0bSCu3h2ZJvjwzarUre9iWBJX51
         hjz7g0LHa+kseHE4RA8Xf8xil1g0M2PhMQiT3f+44/0h3n0k0Z84iE+QwzErpnXyGpU/
         cnMRZMaEWfRjH8e5Uh6Zrxbzw1Ox5f/lNOrkvm2tKnPW48IqMxlyJgy8dmNuirF8nSxn
         tlbIf1jsUE7aRCDCuLM0eOv6IQv5lY5VRq03AxzjWa8TNz84BTBQqJXXziznYEi1sr/i
         DFMaIGPLtFo2Co+AMD0FCRmNjyuaH6MSQO94Rg8mPPYbnUCxJ1TfE2f2bj6vw54Fflsp
         CLiA==
X-Gm-Message-State: AOAM532baVfuuEc2IiSjAylj/xSw87M7XROOMAB1ympwCN+J+KrEZvGG
        e6lrLLShe6B4P/PziEWFyylb0ZECHMCp+Bv61I3cN9RPHYAluUKOSSM=
X-Google-Smtp-Source: ABdhPJyqpQmrRNKNrn6FiH91HVM3jRb/hLnwin4zzm5Il/zLs8CixRpuU8QIeCzPI3HOG9AhGv2CjmXJ2bRBtwCzQs4=
X-Received: by 2002:a50:e188:: with SMTP id k8mr47022398edl.119.1634571084718;
 Mon, 18 Oct 2021 08:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
In-Reply-To: <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Oct 2021 18:30:32 +0300
Message-ID: <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-realtek-soc@lists.infradead.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, nic_swsd@realtek.com,
        Derek Fang <derek.fang@realtek.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc: Realtek people whom I found in MAINTAINERS or so. Please
waterfall to the people inside Realtek who can answer the question.
(Note, you may access this discussion in full via:
https://lore.kernel.org/linux-iio/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/T/#u)

The problem here is to have an official confirmation of what 10ec:5280
ID is from Realtek's point of view. Context: the current discussion
and a patch state that it's related to gyro sensor. Is it so?

On Mon, Oct 18, 2021 at 6:36 AM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
>
> On Sat, Oct 16, 2021 at 7:19 PM Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> >
> > I recently bought this device, and it has this accelerometer/gyroscope.
> >
> > Unfortunately, the device is advertised in ACPI as 10EC5280, instead of BMI0160
> >
> > I attached a patch that does add this 10EC5280 to the list of ACPI ids of this driver, and the device seems to work fine, showing both acceleration and angular velocity in /sys IIO attributes with reasonable values.
> >
>
> ( resend using plain text - reminds me to never use Gmail's web
> interface, even on weekends .)


-- 
With Best Regards,
Andy Shevchenko
