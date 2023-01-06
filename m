Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94765FB32
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jan 2023 07:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjAFGJN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Jan 2023 01:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjAFGJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2023 01:09:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616F6C7F7
        for <linux-iio@vger.kernel.org>; Thu,  5 Jan 2023 22:09:11 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A75B418E6
        for <linux-iio@vger.kernel.org>; Fri,  6 Jan 2023 06:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672985349;
        bh=lrXMamYB/Up+VtnJI26INxfpe/sNWwV1ca5PJS3GC9E=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dFugKeIyQu65L8Da4DHSlO6BQJqpnpF2TcwrjTw1jXqfnEOqJarIinLBZyfelm8kl
         utWmc1/m3tseui/rJBKr5new+6vH1G+dBpPBmgGQuK7bAsZtSsnoUxfLb1v7LXaFWN
         FsN8jeg+EMFPw4BDvHOZjochdrHQTa/IUZy6nqnr3wvzHYxx5feX/M/EqIkOY5qRJ9
         XiXMcXhA1fpnXJsKFxaJCOUP4YFZpOaEUwMZtr09wYiV8rt2oDMOFE2QVRjR9NP8Pk
         RhnVQPCeByaBcI/+1fZBbB71bWXsM4q1HdhewB6qFVABnqNJ0ErGg7j+6cnxYxMQR0
         Ktr0CEHOf7cWQ==
Received: by mail-pj1-f69.google.com with SMTP id h12-20020a17090a604c00b00225b2dbe4cfso441920pjm.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Jan 2023 22:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrXMamYB/Up+VtnJI26INxfpe/sNWwV1ca5PJS3GC9E=;
        b=tEgEe2ivWecxrOT/HF6nyr/0KZz8jtgy02a8VKRhbIc+TYfTvf5qNwTBds+s+lvrY4
         /o26PyOxzPbddYZvIrvDHeFXOe+nQ2H1/BC7hibQpTfNb4JvGFa7zbX1Ewozr5kDHJpM
         TAcmAeZiKwL+Gv4EMqlTDLV5OpgVxpsrL9+89SXnPU0+3SpAeiT1IZMJAkIPF29Ec65Z
         1Z+cTJPc2OAH2bLlRvvvnoHhyuoDZoCS8nDFxmfaaxeTaJDqnv7TXLsereDI5FSYqsQu
         y0VIiuC09NMeyPo/+2pz6Hi08czQDv478OBaNe9dCgnVWYFo/CChHEH2W7aWvsTlZ1yj
         VBvg==
X-Gm-Message-State: AFqh2krtX8Vs6Al0gdFxAPQYS84Kzml5SB1M+TQRZczbRbh+uiaJIC8W
        zADSDl7qYEP8q/YKikaTV0wfSqpj8fI/k/hod9NhDidaA7JE9ywYiDKkH6KsdcUNh56GU5dxxiz
        ADZGWPuN4LsTpAbufr5tM3dPhJPSSAnsEsj3WLEVgK4baBuYs3psJjQ==
X-Received: by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id pa13-20020a17090b264d00b002261564643cmr2351564pjb.206.1672985347695;
        Thu, 05 Jan 2023 22:09:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtHTtMdT3B0Gw1hEQi8oBWZ5TctUuAc5ZT6lPybKy21UTiOvkkPAve7NVL6zxV7WvcM4Hgql/vYcQk4PKtoRdw=
X-Received: by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id
 pa13-20020a17090b264d00b002261564643cmr2351559pjb.206.1672985347346; Thu, 05
 Jan 2023 22:09:07 -0800 (PST)
MIME-Version: 1.0
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com>
 <20230103112629.000063e8@Huawei.com> <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com>
In-Reply-To: <XRVRm0eZvITN7LSrbXQuiYw0sb7W0e2rdRLWGQ-9vkmrMqMVB6IMsOyxuP_CyqmUrqzHdQCASMo9_eU7N3EEkLcAvoWr716p0ZvKfdv1OmA=@protonmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 6 Jan 2023 14:08:56 +0800
Message-ID: <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com>
Subject: Re: CM32181 Bug Report (Linux 6.0+)
To:     Wahaj <wahajaved@protonmail.com>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Wahaj,

On Fri, Jan 6, 2023 at 12:26 AM Wahaj <wahajaved@protonmail.com> wrote:
>
> ------- Original Message -------
>
>
> On Tuesday, January 3rd, 2023 at 2:26 PM, Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Wed, 28 Dec 2022 14:05:24 +0000
> > Wahaj wahajaved@protonmail.com wrote:
> >
>
> >> Hi Jonathan
> >>
> >> Hope you're doing well. I have been using a laptop that comes with a
> >> CM32181 Light Sensor and after upgrading to the Linux kernel 6.0+, my
> >> laptop cannot seem to suspend because of the PM subsystem error. I
> >> have narrowed the problem down to this module and I believe that the
> >> commit 68c1b3dd5c48b2323067f8c1f0649ae2f31ab20bis the culprit
> >>
> >> The following lines were provided from the journalctl logs:
> >>
> >>
> >>> cm32181 i2c-CPLM3218:00: PM: dpm_run_callback():
> >>> acpi_subsys_suspend+0x0/0x60 returns -121 cm32181 i2c-CPLM3218:00:
> >>> PM: failed to suspend async: error -121
> >>
> >> I would love the chance to be able to work on this given any guidance
> >> on where to start
> >
> >
> > Hi Wahaj,
> >
> > Certainly seems likely that you have identified the right commit.
> > As a starting point, resend this email to linux-iio@vger.kernel.org
> > and Kai-Heng Feng kai.heng.feng@canonical.com
> >
> >
> > If you could try reverting the commit to be completely sure it is
> > the cause that would help avoid any doubt.
> > Superficially the only thing that I can see causing this problem is
> > a fail of the i2c bus write.
> >
> > Does the device work prior to suspend? Try cat /sys/bus/iio/iio:device0/*
> > and see if you get any errors (may be device1 etc)
> >
> > If the device wasn't working at all the register writes in probe() should
> > have failed so we shouldn't be trying to suspend it.
> > It's possible your machine has some unusual power dependencies or
> > similar that mean the device is getting powered down before we try to
> > suspend it.
> >
> > Anyhow, better to have this discussion on list as there are many other people
> > who may have more insight than me or be able to replicate and help debug.
> >
> > Jonathan
> >
> >> Best Regards,
> >> Wahaj Javed
>
> Hi Jonathan and Kai-Heng Feng,
>
> I am currently using the 5.15 linux kernel for a while now which works perfectly fine.
>
> From what I gather the suspend functionality does work when using an older Linux version without the PM i2c bus writes.

Does your system use S3 or S2idle to perform suspend?

>
> The device does work fine prior to and post attempted suspend with no errors showing in cat /sys/bus/iio/iio:device0/*

Does in_illuminance_input value change after system suspend?

Kai-Heng

> Let me know if there's anything I should start looking into
>
> Best Regards
> Wahaj Javed
