Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325A4B58C4
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiBNRmy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 12:42:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBNRmx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 12:42:53 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937A0652F2
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 09:42:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y5so30474722pfe.4
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 09:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W0jC+BI1XleZWb4xYM6y8STFaTPRsXHACPClwjtx+Ds=;
        b=DAAiKeKy6fnmfv72KiGxiZKt4u2fNPLKP2MFLt/3RJ926upPT/BaGK6gUmWp+BGAwK
         +uaRG1r2hvSEU5yJptA629iQmmZyT2i929+7BWp6g6IdkGYH9hhQx/R4z2MjjcO5N4qh
         KXuFVRrOk8spFMUYk8TJJKW3/gJPd5m9Dr9HbbqSFf7zMoChbpe/6uECjqsYxitj8dQa
         5GbIwEjGH8qFPQQIGm2oiP5N8vC/vCCBRx/vyFh81/L/fpy+fSk9IiV+sVUNxhMCCeXe
         XkJmB85rXQQSzor4ivkwNC/4HQ5jVMX+gVeuIRWSBRBinJ0XGmLundj/BS512UkfEUeJ
         cLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W0jC+BI1XleZWb4xYM6y8STFaTPRsXHACPClwjtx+Ds=;
        b=4zd3ApZFBl68UrCDZ/JX2e16d6oa2iOoxWzkw9+Mgumf15y2s8cmVa+taZ9OEXho6+
         N3YSSC4+ClLm0VyshaF+An4ESUWHsdq4LHOv9pL2c54eo2aQH/zBakIthCX0wjvgpYtE
         exfKTmgOCG7YMQQRbN05oICwl7OMBZB69JGW66hobNTdY0upgMPITmzBhS5H0yQNfCml
         M8AqQeSEdAKhbbAvkNVBCMCbJRssGwllD+roFox+oqsWyaRSVG5MfVHfG+We2zkztGdP
         a3sUtBvXjFj8W2rc5QOLOjK8Te934l2yAKrPXgBjo2J/Xz/tukW7I+2d9jRMz2UmSRV3
         2rYQ==
X-Gm-Message-State: AOAM530OJdJNZe49Go7dpgONLqcxq7oseTbM1UAxJ36vMzkF3Jcx6kib
        DHLgr3kuOHOYCNHU76CUqzgeP9JBovFBNi5MtLaMLg==
X-Google-Smtp-Source: ABdhPJwJiJpYzgpABDBFyLzMhQvo1iBEVDu6iPYEDxL43BvO/78jc0M4fPXPbozpzpwQudr9dC9Z9wsmnPvKbX3AgvQ=
X-Received: by 2002:a05:6a00:804:: with SMTP id m4mr636142pfk.45.1644860564881;
 Mon, 14 Feb 2022 09:42:44 -0800 (PST)
MIME-Version: 1.0
References: <1644395873-3937-1-git-send-email-wangqing@vivo.com>
 <20220213175940.1066f5a8@jic23-huawei> <9e5ed543-cd45-85db-50b5-52c2afd54c55@wanadoo.fr>
 <29e74800-1c3f-e043-97e6-d83f7a53fafb@wanadoo.fr> <20220214110119.00006347@Huawei.com>
In-Reply-To: <20220214110119.00006347@Huawei.com>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Mon, 14 Feb 2022 09:42:33 -0800
Message-ID: <CA+=V6c31+BvssWX-eG=LdeC8o4mE7e1whnT74jbQWRY2w5Zbqg@mail.gmail.com>
Subject: Re: [PATCH] iio: use div64_u64() instead of do_div()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Cameron <jic23@kernel.org>,
        Qing Wang <wangqing@vivo.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

yes, this is wrong. Also, the logic would be broken as the two apis
do_div() and div64_u64 return values are completely different.
Thanks,
Jyoti


On Mon, Feb 14, 2022 at 3:01 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 13 Feb 2022 19:54:01 +0100
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>
> > Le 13/02/2022 =C3=A0 19:50, Christophe JAILLET a =C3=A9crit :
> > > Le 13/02/2022 =C3=A0 18:59, Jonathan Cameron a =C3=A9crit :
> > >> On Wed,  9 Feb 2022 00:37:53 -0800
> > >> Qing Wang <wangqing-DGpbCiVdSXo@public.gmane.org> wrote:
> > >>
> > >>> From: Wang Qing <wangqing-DGpbCiVdSXo@public.gmane.org>
> > >>>
> > >>> do_div() does a 64-by-32 division.
> > >>> When the divisor is u64, do_div() truncates it to 32 bits, this mea=
ns it
> > >>> can test non-zero and be truncated to zero for division.
> > >>>
> > >>> fix do_div.cocci warning:
> > >>> do_div() does a 64-by-32 division, please consider using div64_u64
> > >>> instead.
> > >>>
> > >>> Signed-off-by: Wang Qing <wangqing-DGpbCiVdSXo@public.gmane.org>
> > >> These look correct to me.  Jyoti, please could give these a sanity c=
heck?
> > >>
> > >
> > > This is wrong.
> > >
> > > See [1].
> > >
> > > CJ
> > >
> > > [1]:
> > > https://lore.kernel.org/linux-kernel/20211117112559.jix3hmx7uwqmuryg-=
bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org/
> >
> > Broken link, sorry:
> >
> > [1]
> > https://lore.kernel.org/linux-kernel/20211117112559.jix3hmx7uwqmuryg@pe=
ngutronix.de/
> >
> oops.  Thanks for the heads up. I'd forgotten the slightly odd convention
> around do_div
>
> Jonathan
>
>
> > >
> > >
> > >> Thanks,
> > >>
> > >> Jonathan
> > >>
> > >>> ---
> > >>>   drivers/iio/common/scmi_sensors/scmi_iio.c | 10 +++++-----
> > >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c
> > >>> b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > >>> index d538bf3..d6df5da
> > >>> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> > >>> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > >>> @@ -160,7 +160,7 @@ static int scmi_iio_set_odr_val(struct iio_dev
> > >>> *iio_dev, int val, int val2)
> > >>>       mult =3D scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
> > >>>       sec =3D int_pow(10, mult) * UHZ_PER_HZ;
> > >>> -    do_div(sec, uHz);
> > >>> +    div64_u64(sec, uHz);
> > >>>       if (sec =3D=3D 0) {
> > >>>           dev_err(&iio_dev->dev,
> > >>>               "Trying to set invalid sensor update value for sensor=
 %s",
> > >>> @@ -237,10 +237,10 @@ static void convert_ns_to_freq(u64 interval_n=
s,
> > >>> u64 *hz, u64 *uhz)
> > >>>       u64 rem, freq;
> > >>>       freq =3D NSEC_PER_SEC;
> > >>> -    rem =3D do_div(freq, interval_ns);
> > >>> +    rem =3D div64_u64(freq, interval_ns);
> > >>>       *hz =3D freq;
> > >>>       *uhz =3D rem * 1000000UL;
> > >>> -    do_div(*uhz, interval_ns);
> > >>> +    div64_u64(*uhz, interval_ns);
> > >>>   }
> > >>>   static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val=
,
> > >>> int *val2)
> > >>> @@ -266,7 +266,7 @@ static int scmi_iio_get_odr_val(struct iio_dev
> > >>> *iio_dev, int *val, int *val2)
> > >>>       mult =3D SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
> > >>>       if (mult < 0) {
> > >>>           sensor_interval_mult =3D int_pow(10, abs(mult));
> > >>> -        do_div(sensor_update_interval, sensor_interval_mult);
> > >>> +        div64_u64(sensor_update_interval, sensor_interval_mult);
> > >>>       } else {
> > >>>           sensor_interval_mult =3D int_pow(10, mult);
> > >>>           sensor_update_interval =3D
> > >>> @@ -500,7 +500,7 @@ static u64 scmi_iio_convert_interval_to_ns(u32 =
val)
> > >>>       mult =3D SCMI_SENS_INTVL_GET_EXP(val);
> > >>>       if (mult < 0) {
> > >>>           sensor_interval_mult =3D int_pow(10, abs(mult));
> > >>> -        do_div(sensor_update_interval, sensor_interval_mult);
> > >>> +        div64_u64(sensor_update_interval, sensor_interval_mult);
> > >>>       } else {
> > >>>           sensor_interval_mult =3D int_pow(10, mult);
> > >>>           sensor_update_interval =3D
> > >>
> > >>
> > >
> > >
> >
>
