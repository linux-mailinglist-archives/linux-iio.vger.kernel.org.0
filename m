Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32929A6AA
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 09:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394961AbgJ0Ifl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 04:35:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39806 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394400AbgJ0Ifk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 04:35:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so437462otj.6
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2020 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UVweju2YygbjqwhYQbAuXknJwnZnCwO39MieZhFgfEo=;
        b=cEZzybQf8Vu5j1cT+xXOunc87PuNTdChP4u7TbsI7BbsreghqjNO2HIaGEQiawARba
         QM9sbZLy6t7bVAhJP+9/grEO88YLrkbwEI3TresGLrU893OMqfQa60tfFCabO5gnRqr3
         NAPCBdwpIHJFO71ugRCWs0z5sk9HFBNX4Th7sNTB3NXZ6O/d+uGsbT05b02ak5zbrMom
         3GJR/x9f8os3Z+Pf1BndeSzLSNPTGkktxbD58ZEWL9Cxi9e2O12hcNZO+wFz4rGE8NCh
         5pgVctSgRrj8FlSpuORjepwhadHDGrVCzcmBT63GcWjl9xIFDRhompDoCpPyAuFTyKI4
         gcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UVweju2YygbjqwhYQbAuXknJwnZnCwO39MieZhFgfEo=;
        b=tL8B6HwHZQhUROCaU+SKZQWd0eb8Upi3JC8b+KRfRcC5Zp9kD1MvYbaKcWpzYpHY3y
         wbtYc/Hjot6bOdFOtBQGM0U3/CHLVpRG0jjeLaNPzryct1XhQETsXjFagiUWBRhcuDoC
         1ORUW7+E0pbzTBVRAPOOl9BP0NSkfcJMqCQ9VhRRqLVnveckeiTOi6Lpqk6ah3UEWKCt
         RgrXyNpQOhqNueajvh1jnxFwxym7tcdxhF2rQu/9nL+800fzWQjRGBAY5ewBLTZDUFi9
         GzadPAjApVRd9mVDDd0Kb/AOkInuLRxz/u1GpG78skfHpwudzdIV9ULvdN21kWHVqvTy
         BZyw==
X-Gm-Message-State: AOAM533w49ZDCwvhj7Am3QuuAwTnAseFhoW1/I+kmoGU1XnENoRtmyc0
        2RUoCAkwNsbfSPg3u6PBVawxu1S7LxNj2w9ElrD5aF0ETLsDow==
X-Google-Smtp-Source: ABdhPJwtHZC06Kst+viYCTZiAWStaqjGNykZiRq8QOW6SJzx2e0xwGke/nlSWGtZJ7Qre+7F+KQgQ3fJHEbQuIRYrak=
X-Received: by 2002:a05:6830:19c7:: with SMTP id p7mr663718otp.207.1603787739773;
 Tue, 27 Oct 2020 01:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJyU85OXRWuVdFhTB7jdp=ggBDDmGTiQ-CahWbw_6cYrGUF5Ew@mail.gmail.com>
In-Reply-To: <CAJyU85OXRWuVdFhTB7jdp=ggBDDmGTiQ-CahWbw_6cYrGUF5Ew@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Oct 2020 10:35:28 +0200
Message-ID: <CA+U=Dsoaf3WYA3uhBfHzaDrJej-uFqVwt7-m0y7d6P8QJr3MRw@mail.gmail.com>
Subject: Re: Linux Missing IIO
To:     Matt Wyatt <matt@biomason.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 26, 2020 at 9:38 PM Matt Wyatt <matt@biomason.com> wrote:
>
> Hello,
>
> I am using a Raspberry Pi 3 and I am attempting to set up an ADC to
> the GPIO with I2C. I am following this
> tutorial:https://wiki.seeedstudio.com/4-Channel_16-Bit_ADC_for_Raspberry_=
Pi-ADS1115/
> for setup and the iio kernel seems to be missing because I cannot find
> the directory when running cd /sys/bus/iio/devices/iio\:device0/
>
> When running lsmod | grp adc I do not see anything related to iio
> either when the tutorial shows as such.
>

So, using RPi 3 with IIO is sometimes tricky to setup.
Every once in a while, it takes me a few hours just to remember the
debug steps with it.
Reason is: a lot of failures are silent, so there is no clear
indication of what & where it went wrong.

1. What version of the RPi distro are you using?
    Hopefully that's pretty recent.

2. Check i2c is working; either the wires are flaky or they're not
connected correctly.
    No idea.
    To do that, maybe disable the overlays in config.txt first so that
it isn't reserved by the kernel,
    and run i2cdetect -y 0 ( or 1 or 2); I can't remember which one it is.
    This will do a scan over the I2C bus and if the device is there,
it should show up.
    You can search for a few i2cdetect examples online, and also a few
catered for RPi.
    Notice that when i2cdetect shows a UU entry, that means it's
typically reserved by the kernel,
    which doesn't always mean that there is a device physically there.
    A double-dash entry -- means nothing is there, and not reserved by
the kernel.
    A numerical value means that there is a device there and isn't
reserved by the kernel.

3. RPi device-tree overlays are also tricky. When they fail, they're
also pretty silent most of the times.
   Make sure the file is present in /boot/overlays [when mounting the SD-ca=
rd].
   It should be 'ads1115.dto'  or something like that.
   Now, I'll admit I haven't used IIO on the vanilla/official RPi kernel.
   We've typically rebuilt the kernel with IIO as builtin versus kernel-mod=
ule.
   I have a vague recollection that i2c drivers may have had some
issues to probe as kmods.
   This may have been fixed.
   Check the dmesg log with grep to see that the device tried to
initialize but failed.
   [ example:  dmesg | grep ads11  ]


> I am new to this and would really appreciate some help!
>
> Thanks!
>
> --
> Matt Wyatt
> Manufacturing Systems Engineer
> matt@biomason.com
> (703) 474-0933
>
> --
> bio*MASON*=C2=AE
>
>
>
> *This message contains confidential information and is
> intended only for the individual named. If you are not the named addresse=
e
> you should not disseminate, distribute or copy this e-mail. Please notify
> the sender immediately by e-mail if you have received this e-mail by
> mistake and delete this e-mail from your system. E-mail transmission cann=
ot
> be guaranteed to be secure or error-free as information could be
> intercepted, corrupted, lost, destroyed, arrive late or incomplete, or
> contain viruses. The sender therefore does not accept liability for any
> errors or omissions in the contents of this message, which arise as a
> result of e-mail transmission. If verification is required please request=
 a
> hard-copy version. bioMASON Inc., PO Box 110345, Durham, NC 27709,
> www.biomason.com <http://www.biomason.com/>*
