Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724273146A7
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 03:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBICy3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 21:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBICy3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 21:54:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC7EC061786
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 18:53:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l18so792196pji.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 18:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=CMKejpqzagM6NPUJk8acfIVETOKzWsy0ygByc8xbfk4=;
        b=iXk8FIk+WuuBGqMKbhHS+Zkc7eyi9geUxgZw0KNq4ymbx9DBWtbfzL/5BbmqhJE/G+
         TDThZIsZH6yxUiyXOl+1dEFeN/JrwnkjbFReukdDlONKmJjnU+67KBoC5+hyJDxt3JSS
         S8uM9EbOf072CkHEi8KhZTrclKugUFPZ5k4OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=CMKejpqzagM6NPUJk8acfIVETOKzWsy0ygByc8xbfk4=;
        b=TDzGe1rgWwv0u/B1yBQhGUpKh3qvpuQC7cGhMmj5O+rqCRj5b1+M3GjjeDdlnSHd02
         5tptjh22P7uR1Qq2fnNnNUeJI6/vS0o4z7FnGsNV2qoO14tNU7HqhxcNKzFSchqFjXjQ
         037KJFP4zxaBdtVR0eD4UzHlr2auwT60aTKbCQlQta9HUKJCQSxnleG+wf/6Rl3XcKyV
         zpZJNlzEvWM5AgodffA0dopVwPBxEtlcEIlir2q9cyMh0rbjILu/aGcq9EHUrMoP++XI
         tlollcEzU8t58RxPSrlMjgRKvpnRVk52zTsnsskcskxoMmiluDivOBhYOq67LoMTqjRk
         ifXQ==
X-Gm-Message-State: AOAM531Q2rEWFdvaO0u57Y0lfc9gC525s6+YwWACNKmb3QIeVN/SGsHC
        eLWV/RdipgNKmM+8xsEGF+Mrvw==
X-Google-Smtp-Source: ABdhPJwYRF0NvyBi1mpJ/Af5Gw5MsRCP+4/wfUlhnJy6mz2B5NSRD+TaEOBWi6HBexHm7q//62F2Cw==
X-Received: by 2002:a17:902:f28d:b029:e2:9654:ed31 with SMTP id k13-20020a170902f28db02900e29654ed31mr18752536plc.2.1612839228258;
        Mon, 08 Feb 2021 18:53:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:751a:ba0b:8918:c305])
        by smtp.gmail.com with ESMTPSA id z186sm5575436pgb.78.2021.02.08.18.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:53:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <161283830033.76967.8675893870348279849@swboyd.mtv.corp.google.com>
References: <20210202064541.2335915-1-gwendal@chromium.org> <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com> <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com> <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com> <CAPUE2uu3eyBbD4KDjE2-AgrAgFm0+NEaPgXX8EBP9HKqyrLsGA@mail.gmail.com> <161283830033.76967.8675893870348279849@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 08 Feb 2021 18:53:45 -0800
Message-ID: <161283922598.76967.9707750025474688009@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Stephen Boyd (2021-02-08 18:38:20)
> Quoting Gwendal Grignou (2021-02-08 18:36:19)
> > On Fri, Feb 5, 2021 at 5:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Gwendal Grignou (2021-02-05 13:49:12)
> > > > On Tue, Feb 2, 2021 at 11:17 AM Stephen Boyd <swboyd@chromium.org> =
wrote:
> > > > >
> > > > > Quoting Gwendal Grignou (2021-02-01 22:45:41)
> > > > > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proxi=
mity/sx9310.c
> > > > > > index 37fd0b65a0140..1a8a441c9774d 100644
> > > > > > --- a/drivers/iio/proximity/sx9310.c
> > > > > > +++ b/drivers/iio/proximity/sx9310.c
> > > > This method of asking first for the number of element and a second
> > > > time for the values is already used at different places in the kern=
el:
> > > > drivers/power/supply/gpio-charger.c : see init_charge_current_limit=
()
> > > > or  madera_get_variable_u32_array insound/soc/codecs/madera.c.
> > >
> > > Sure it's used but that doesn't really mean it's a good pattern to co=
py.
> > > If the number is more than 4 I'd say we should ignore it and move on,
> > > but if it's less than 4 is an error returned?
> > >
> > > >
> > > > However, it could use device_property_count_u32(...), which is more
> > > > readable than device_property_count_u32(..., NULL,0).
> > > >
> > >
> > > How about
> > >
> > >   ret =3D device_property_read_u32_array(dev, "semtech,combined-senso=
rs", combined, ARRAY_SIZE(combined));
> > >   if (ret)
> > >         break; /* Must have overflowed or not existed; ignore */
> > >
> > >   for (i =3D 0; i < ARRAY_SIZE(combined); i++)
> > >
> > > and then it should work as before?
> > It will not work:
> > If the DTD has a valid array of only 3 elements (for instance  [CS0,
> > CS1, CS2] as in
> >          Package (0x02)
> >          {
> >              "semtech,combined-sensors",
> >              Package (0x03)
> >              {
> >                  Zero,
> >                  One,
> >                  0x02
> >              }
> >          },
> > )
> >=20
> > device_property_read_u32_array(...., 4) will return -EOVERFLOW and we
> > will use the default in the driver, which we do not want.
> >=20
>=20
> Isn't that a bug in the ACPI property reading code? 3 doesn't overflow 4
> so I'm lost why it would return an error code to indicate it can't fit
> the whole property into an array that is one size larger.

Or it's a bug in the driver because it's assuming that it can read the
DT property out even when it is only length 1 when the property read
should be variable length. Can you split this into two and fix the
underlying problem with the read of the array not matching the length of
the property? I think it needs to be
of_property_read_variable_u32_array() with 1 and 4 for min and max.
