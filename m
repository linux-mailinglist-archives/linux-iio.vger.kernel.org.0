Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB0257870
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgHaL3n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 31 Aug 2020 07:29:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaL2x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 07:28:53 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1kChzW-0003De-Gf
        for linux-iio@vger.kernel.org; Mon, 31 Aug 2020 11:28:50 +0000
Received: by mail-wr1-f72.google.com with SMTP id k11so3107612wrw.16
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 04:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+4/Yx6DeQldeglbS376dNJoVgOKnSc5ajKOtdzMws4=;
        b=rn3Lw4q0A72qozyhy+0a4LdX8fWTuWhXkGxSik7Xes0K32OPpjdwKY+/0wppSMGEoG
         HoQ+IUbmvEGr3K69KN3+rufTPErWJtmJMmFvEvWk8U9UWSFXNDtanGdMf2FEbU/NNqc4
         TeAW3KNkgsJszpas6CX9OCoV2EP2VdYb9j9F9Raiieawna6XLRRSl7Nk+r/mnTPTE3OA
         +QyhZ+q90HORASE6VHIOZ9ADJzo3Eb9N15+hDuEjsQELWCsgu8u/2oo8He5Ip1kySwZM
         T8x3UbXqVaTh3CraGcr+cbOyB/6neHBnG6OSxWdy2WrRIhaFQOTVW49f4rlw1rOF50GY
         8s2g==
X-Gm-Message-State: AOAM531eeGRom3wSWq578QE2VKmgh5pgIaHJNJF5RsBR14rUPv5xO3WQ
        zEX3eytqZKUTp/+PLTnQ+jXx950t9j8fQz92+tW1kksssHhM/tyxhb9gXc+mPL8r2EO9IS8qWT/
        d/LY9tCidVCPwywuPJIBSiIXIRf9b254a03lS7F2iytf8b1U7pOp7cg==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr1345546wru.178.1598873328736;
        Mon, 31 Aug 2020 04:28:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNUaRTbjM1YE4AAR11tE2YfJvDxtl/R6uUHfYMBUE4Qb+ZRi35hOwMuCN3NIWR3kfvnlBKWAY3T3S0eBA+ytc=
X-Received: by 2002:a5d:6910:: with SMTP id t16mr1345532wru.178.1598873328545;
 Mon, 31 Aug 2020 04:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw> <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
In-Reply-To: <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 31 Aug 2020 19:28:37 +0800
Message-ID: <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan and Andy,

This patch is mainly for Advantech's UNO-420[1] which is a x86-based platform.
This platform is more like a development platform for customers to
customize their products,
so, specify the channel modes in ACPI table is not generic enough,
that's why William submit this patch.

Are there other ways to specify or pass values to the module without
using module parameters?
It's good if we can leverage sysfs, but I don't know if there is one
for this scenario.

1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c-9df90a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c

Andy Shevchenko <andy.shevchenko@gmail.com> 於 2020年8月31日 週一 上午1:07寫道：
>
> On Mon, Aug 24, 2020 at 8:54 AM William Sung
> <william.sung@advantech.com.tw> wrote:
> >
> > To use ad5593r more flexibly, we use the module parameter to setting the
> > channel modes dynamically whenever the module probe up.
>
> > Users can pass
> > the channel modes to the module parameter for allocating the
> > functionality of channels as desired.
>
> NAK. We have a sysfs interface.
>
> > For example:
> > * Use in the kernel command line:
> > Users can add the module parameter in the kernel command line such as
> >
> >     "ad5593r.ch_mode_cmdline=88001122"
> >
> > "88001122" means the channel mode setting for each channel. The most
> > left side indicates the mode of channel 7, and the most right side
> > indicates the mode of channel 0.
> >
> > * Use when manually probe the module:
> > Similar to the kernel command line usage, users can enter
> >
> >     "modprobe ad5593r ch_mode_probe=88001122"
> >
> > to start the ad5593r module with the desired channel mode setting.
>
> Again NAK, this basically should come from Device Tree or ACPI.
>
> --
> With Best Regards,
> Andy Shevchenko
