Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCF26FAA4
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIRKdT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgIRKdS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 06:33:18 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F91C06174A;
        Fri, 18 Sep 2020 03:33:18 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g7so6225143iov.13;
        Fri, 18 Sep 2020 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LWCjorJLEdlFXmCZ6WEq2/kdEMji/7Y3/q8CSv2UdyE=;
        b=o9nCBOFKuppZJshwDf7CoFem/weD8M0JeXdUunEkZrYPL696sIpTZBx2S0Uz/8VPyh
         v31rwODK+dKXTXPn1VDkqPOkjJLpsDnY+y2w21uyfwlDlWafuI0zWJ1yNkNGyP3LxgSu
         qidVWR32pM9/lKEdDBbNvGxegE1HBiulniuzWgZMApC7qqHe2EccaNeRxXhMhYKA2pDl
         BYExWsmVhEpYr7XeCM9Q2dSIR3nimR7G+9t86O34ZoyqK9I8wZG4iSy5iQK0V6/sF33d
         FV0HizsZbJ0wxRb0F1raDYMckGbyLJk0K3mUuTmSKDRMiOav9oxmxQK4XvUROwH6ggOV
         LF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LWCjorJLEdlFXmCZ6WEq2/kdEMji/7Y3/q8CSv2UdyE=;
        b=WlN2X5pa+Va3OgYEyw4qhLpkYAAsrdNOoAH15uBziSfxVDGk0rVz8mGgsll9wMWN2O
         P0KsT8EJxGczs/VvSNkbwhonCDMe1SKym2VOrofoh2sbh8VicYKWYemMh4salYBdpD6k
         ljo4IA0HyCTj4u5cbdUHpuztIdn4R1spMJ/IKhYhnfXDzoUwo7Qja9ZJPgtoCcCWCIkR
         3Tsz/0P3koDeKP2zNk/HhW+PjI0KqarVxj9rAHaPcsO+PxP8ytegUG/Jxg81n0IX63ed
         ooB8V91a30P1w7rWYtcUr082gNZjsHUYApVie8upHScMPWEHuA3gaSz7Dknfd/UdtybV
         1l4A==
X-Gm-Message-State: AOAM531J/GSuU+nSu4GpcTcaYcRAByjaviltkw/yS/eQNzR/Sm3jJHF3
        9F0A0rmS3ZdrzIkNTq6Nq3QoxWGNoouJR2BICfk=
X-Google-Smtp-Source: ABdhPJz8v4q8ghs2jSHKJgcupHLgmNgQByrMAMy+syEm9A81dkdsm1zZ08m8OXUsOJ1MitePvziBd2LtV9atjhGda4c=
X-Received: by 2002:a5e:8e0a:: with SMTP id a10mr27291002ion.200.1600425197845;
 Fri, 18 Sep 2020 03:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600191369-28040-3-git-send-email-gene.chen.richtek@gmail.com>
 <20200917184256.71328701@archlinux> <CAE+NS35Pw-6UqcHPNOsUtW0GABPVEHfPineF81+qrS6A18HiyA@mail.gmail.com>
 <20200918090321.00007f70@Huawei.com>
In-Reply-To: <20200918090321.00007f70@Huawei.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 18 Sep 2020 18:33:06 +0800
Message-ID: <CAE+NS36T+8Ec4y3NBeoX3DOEOMa4mMu38OBgFvyPYw8su-X4Yg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, Cristian Pop <cristian.pop@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> =E6=96=BC 2020=E5=B9=B49=E6=
=9C=8818=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:05=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Fri, 18 Sep 2020 15:21:44 +0800
> Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> > Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, 16 Sep 2020 01:36:08 +0800
> > > Gene Chen <gene.chen.richtek@gmail.com> wrote:
> > >
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > Add ABI documentation for mt6360 ADC sysfs interfaces.
> > > >
> > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > Would you consider using the proposed label attribute for channels?
> > >
> > > https://lore.kernel.org/linux-iio/20200916132115.81795-1-cristian.pop=
@analog.com/T/#u
> > >
> > > I'm hoping that will remove the need to have ext name used in the maj=
ority of
> > > cases and would like to know if it would work for you?
> > > It may not work for this particular case of course.
> > >
> > > Other comments inline.
> > >
> >
> > because of ADC layout is fixed, I can't switch channel to specific
> > purpose for userspace.
>
> That patch set doesn't allow userspace to change the purpose. It provides
> a *_label attribute for each channel to allow for identification of the c=
hannel.
> That can be provided by ACPI / DT or can be provided by the driver itself=
.
> The advantage is that it removes the nasty freeform parsing that is neede=
d
> to work out the filenames.
>

May I ask how to get this patch for test the labels?
I supposed userspace catch meanings by iio device sysfs node name.
The label defined in DT means it can be modified. But actually shouldn't.

> >
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 83 ++++++++++=
++++++++++++
> > > >  1 file changed, 83 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6=
360
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/D=
ocumentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> > > > new file mode 100644
> > > > index 0000000..4b1c270
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> > > > @@ -0,0 +1,83 @@
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_U=
SBID_input
> > >
> > >
> > > The mixture of case is a bit ugly.  Could we do
> > > in_voltage_usbin_input?
> > >
> >
> > ACK
> >
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 USBID ADC which connected to connect=
or ID pin.
> > > > +             Reading returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_V=
BUSDIV5_input
> > >
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 VBUS ADC with high accuracy
> > > > +             Reading returns voltage in uV
> > >
> > > Why would we ever read the low accuracy version?
> > >

VBUSDIV5 with lower accuracy(+-75mA) higher measure range(1~22V)
VBUSDIV2 with higher accracy (+-30mA) lower measure range(1~9.76V)
I will fix the description

> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_V=
BUSDIV2_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 VBUS ADC with low accuracy
> > > > +             Reading returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_V=
SYS_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 VSYS ADC
> > > > +             Reading returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_V=
BAT_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 VBAT ADC
> > > > +             Reading returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_current_I=
BUS_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 IBUS ADC
> > > > +             Reading returns current in uA
> > > Given voltage and current are already clear from the channel type,
> > > could we avoid the repetition?
> > >
> > > in_current_bus_input perhaps?
> > >
> >
> > ACK
> >
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_current_I=
BAT_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 IBAT ADC
> > > > +             Reading returns current in uA
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_C=
HG_VDDP_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 CHG_VDDP ADC
> > > > +             Reading returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_temp_TEMP=
_JC_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 IC junction temperature
> > > > +             Reading returns temperature in degree
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_V=
REF_TS_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 VREF_TS ADC
> > > > +             Reading returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_T=
S_input
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 TS ADC
> > > > +             Reading returns voltage in uV
> > > > +
> > > > +What:                /sys/bus/iio/devices/iio:deviceX/timestamp
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     gene_chen@richtek.com
> > > > +Description:
> > > > +             Indicated MT6360 timestamp
> > > > +             Reading returns current timestamp in ms
> > >
> > > That's an odd bit of ABI.  Why would we want to read the current time=
stamp from
> > > sysfs?  Timestamps in IIO also tend to be in nano seconds.
> > >
> > >
> > >
> > >
> >
> > ACK, I will remove this.
>
>
