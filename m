Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0434326F6A8
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 09:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIRHV7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 03:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRHV7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 03:21:59 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75036C06174A;
        Fri, 18 Sep 2020 00:21:59 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g128so5759877iof.11;
        Fri, 18 Sep 2020 00:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ju0TrxIs6FJ7xW3Z7H2xcox4RM+XbSHCtVVVywc+J3U=;
        b=D1hAU194FOUNNK3xN6BVA5UEh6cmkI4coh/bY3oUGjv2g5B1UPKStEj7aDce50HTSs
         reqEMLSZP3Si+OWqovmffFtQqGesmdeNnwY+kbtaSQugpsNRZgXOpJEGDiNRpihrjLG4
         hprwG222jyoiThqFbCLYtaqU8yqOnK6mJVQxxoYnw4TY/dh3cIYysMDls68PL+C8pExp
         kxfQlWxpu2r7bWWYpsi/hsIlq01sqEBOaUqG27Hnmdv13oYjw8tE5pDP4ZkygqqZ2C2E
         0imCirahv95O1NQDRZVfDPf+XoZ1A4/Ad4c6idUSuBoKof7KEtv21Uj2tOdBRRaiGCHi
         ILmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ju0TrxIs6FJ7xW3Z7H2xcox4RM+XbSHCtVVVywc+J3U=;
        b=fcq+mHCqAcp0DZZXqPdOc2Cdc+oQBGbhrMf9RbTfxqBxDBVb0TTDstNMSVsq8HlCoZ
         iaZR7XPAqt7QfUBgnrQ13b24Vrp8IYjE1c+gqEq7TVRIBx33fZG5L+Dmq+DpbvuFLMFZ
         lvCAi8AiqAcuiz4sn++nOvZ4i6kyBCDBptadsJFZzKAZ/3KJjvmQ8Scj9nVLPfzm5r1I
         Y/zCs9NGE3kj7QdrTDtOyf2R6lKHuolmkkabgSUL5EXLrNpjty+pKQppc6tn4Wh4+/X+
         SGxz4EeW8RS0QnhpFisHhQxtmFnQDwNq7BG8Tyx3NXg5kSPvcLYEHdQQV1cf3m2DQCwq
         +VlA==
X-Gm-Message-State: AOAM533pV6ysgDNn5va0Zylz5TfgCBuUZbPuIj5T7hSTjoyLgxxWgBTn
        KFfOBAm9Xu7NdVjrtrS1TMh5EtEfcGiCrO1OoXM=
X-Google-Smtp-Source: ABdhPJwqcSkueCL7FLHnuStVDeja8i2Qt8zOn2Xu7ScPuOCLAgvoImXvNC5T9JzSZr2CsBY3QpgPcmFL4IyV+AaVF6s=
X-Received: by 2002:a5e:8e0a:: with SMTP id a10mr26830525ion.200.1600413718688;
 Fri, 18 Sep 2020 00:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600191369-28040-3-git-send-email-gene.chen.richtek@gmail.com> <20200917184256.71328701@archlinux>
In-Reply-To: <20200917184256.71328701@archlinux>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 18 Sep 2020 15:21:44 +0800
Message-ID: <CAE+NS35Pw-6UqcHPNOsUtW0GABPVEHfPineF81+qrS6A18HiyA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, knaack.h@gmx.de,
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

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 16 Sep 2020 01:36:08 +0800
> Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add ABI documentation for mt6360 ADC sysfs interfaces.
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Would you consider using the proposed label attribute for channels?
>
> https://lore.kernel.org/linux-iio/20200916132115.81795-1-cristian.pop@ana=
log.com/T/#u
>
> I'm hoping that will remove the need to have ext name used in the majorit=
y of
> cases and would like to know if it would work for you?
> It may not work for this particular case of course.
>
> Other comments inline.
>

because of ADC layout is fixed, I can't switch channel to specific
purpose for userspace.

> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 | 83 ++++++++++++++=
++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 b/Docum=
entation/ABI/testing/sysfs-bus-iio-adc-mt6360
> > new file mode 100644
> > index 0000000..4b1c270
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
> > @@ -0,0 +1,83 @@
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_USBID=
_input
>
>
> The mixture of case is a bit ugly.  Could we do
> in_voltage_usbin_input?
>

ACK

> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 USBID ADC which connected to connector I=
D pin.
> > +             Reading returns voltage in uV
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSD=
IV5_input
>
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 VBUS ADC with high accuracy
> > +             Reading returns voltage in uV
>
> Why would we ever read the low accuracy version?
>
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VBUSD=
IV2_input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 VBUS ADC with low accuracy
> > +             Reading returns voltage in uV
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VSYS_=
input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 VSYS ADC
> > +             Reading returns voltage in uV
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VBAT_=
input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 VBAT ADC
> > +             Reading returns voltage in uV
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_current_IBUS_=
input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 IBUS ADC
> > +             Reading returns current in uA
> Given voltage and current are already clear from the channel type,
> could we avoid the repetition?
>
> in_current_bus_input perhaps?
>

ACK

> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_current_IBAT_=
input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 IBAT ADC
> > +             Reading returns current in uA
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_CHG_V=
DDP_input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 CHG_VDDP ADC
> > +             Reading returns voltage in uV
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_temp_TEMP_JC_=
input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 IC junction temperature
> > +             Reading returns temperature in degree
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_VREF_=
TS_input
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 VREF_TS ADC
> > +             Reading returns voltage in uV
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage_TS_in=
put
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 TS ADC
> > +             Reading returns voltage in uV
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/timestamp
> > +KernelVersion:       5.8.0
> > +Contact:     gene_chen@richtek.com
> > +Description:
> > +             Indicated MT6360 timestamp
> > +             Reading returns current timestamp in ms
>
> That's an odd bit of ABI.  Why would we want to read the current timestam=
p from
> sysfs?  Timestamps in IIO also tend to be in nano seconds.
>
>
>
>

ACK, I will remove this.
