Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7489E44EC37
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 18:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhKLRxv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 12:53:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235371AbhKLRxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Nov 2021 12:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636739459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5d76gUdGn3UgVlG+TzxPQ8U5rPwd9xOEQ6cc6Tykom0=;
        b=HboXumYX4fz80SLTC9uB5gIp63kyGWMLVV5cQpKbV2LnXqxENEHY3oLEmtCXhwC1rwEJ0P
        tUGrdJcuINyYZg3Qp/4knLx9j1MTX35DxwNC36vRcxhtdqSpktyNqh0m5cahLRuq9GrplR
        aA9oZkNRAmTlQ/jshUTMii6yzWqDfuQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Eu-KxCSINp2dJT80-iSk8g-1; Fri, 12 Nov 2021 12:50:58 -0500
X-MC-Unique: Eu-KxCSINp2dJT80-iSk8g-1
Received: by mail-ed1-f71.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so644949edx.4
        for <linux-iio@vger.kernel.org>; Fri, 12 Nov 2021 09:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5d76gUdGn3UgVlG+TzxPQ8U5rPwd9xOEQ6cc6Tykom0=;
        b=0+1cuZeq00BFqwYnAhrdtQsJpMULboybW2dKhlEn4EBbyoXUCeMZ72qD6EGE0IAjxF
         Ymwb3AqWbp0pugv2gLDKBV+U5VMWKIIW0nI0e98QDpHUR6a7dLZwoH6Baa+5l6R62rvl
         FdEsSXCt18P4mSedyo0n8Qh64K5Fwy2Hx/U5+i8XJHWLeWlE2TeMsh4E01xZST5hyvbe
         eW3vJNPcp4ff76kPiTBvO1M7aH9k/3X4NjyofYZWAZ+gjTbFjZ6T/A1U9zrE0omxvKQ+
         /9ueateMZtV/iXBN7GYyTwF3cPCIXLKmosKLwyO7MpeWp5LZS+nQfRT5iGwnHWkq9a/m
         LZYQ==
X-Gm-Message-State: AOAM531hYZR6f1Nc7Qf5JUCvfDwm77fTRBrnoLYurajrTHVB4AsA9Ybw
        cwUMjY3iKYqdyTcIjf2HpYgV81w1QkzNtO4uS64DWP5dlveYjisWyjbU35c5kPUoWwfSQ6Kvrs8
        QRn4a6PTG/moc8GwGDx3X
X-Received: by 2002:a50:cc07:: with SMTP id m7mr23333703edi.356.1636739456902;
        Fri, 12 Nov 2021 09:50:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm/qstqkH3fHJ+QK9lWlN0FMiXMFk0S7JIQOmqIFQcY7ujdb2Fnnsw4D8yWJIfkxvNtS+oRg==
X-Received: by 2002:a50:cc07:: with SMTP id m7mr23333680edi.356.1636739456766;
        Fri, 12 Nov 2021 09:50:56 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id bo20sm3468495edb.31.2021.11.12.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:50:56 -0800 (PST)
Date:   Fri, 12 Nov 2021 18:50:54 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: dt: iio: st_lsm6dsx: add disable-shub
 property
Message-ID: <YY6pfiWyrneKfPtq@lore-desk>
References: <cover.1636552075.git.lorenzo@kernel.org>
 <c03385c4f862f04406dc4b5f15379c0be921c98a.1636552075.git.lorenzo@kernel.org>
 <20211112162847.782f806a@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rYZ8JO5i7rdGq3vl"
Content-Disposition: inline
In-Reply-To: <20211112162847.782f806a@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--rYZ8JO5i7rdGq3vl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 10 Nov 2021 15:42:33 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> A bit more description here would be good.
>=20
> Also suggestion from patch 1 carries through to maybe spell
> out sensor-hub in the property name?

ack, fine to me. I will fix it.

Regards,
Lorenzo

>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml =
b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > index d9b3213318fb..502438f14e19 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > @@ -61,6 +61,10 @@ properties:
> >      type: boolean
> >      description: enable/disable internal i2c controller pullup resisto=
rs.
> > =20
> > +  st,disable-shub:
> > +    type: boolean
> > +    description: enable/disable internal i2c controller.
> > +
> >    drive-open-drain:
> >      type: boolean
> >      description:
>=20

--rYZ8JO5i7rdGq3vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYY6pfgAKCRA6cBh0uS2t
rMJzAPwL6o30XDFvvdkGK+c42qucOM8aOdPhgTHnJDqDtAOosgEAyE9idPLUHC1o
vk7DYOLCx8JrLGUNChweljck5OJRFAM=
=GhTi
-----END PGP SIGNATURE-----

--rYZ8JO5i7rdGq3vl--

