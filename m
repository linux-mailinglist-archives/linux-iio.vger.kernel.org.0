Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1459A196839
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgC1Rrj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 13:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1Rri (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 13:47:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C5520714;
        Sat, 28 Mar 2020 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585417658;
        bh=mNYkWFhLfxL58A8os+PE0jgGSO/lmQHN1YOVq75Jifk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EBpnVjhWymVWQhNVUW8HujxVUfDxIEn2uFzraKV2IFJSWUFdNK8z36/J/Pg0D8nzA
         40zH7J2f0c95huDR1gfJGCCoEklvN8Xjs2Zir4j+KoLuPIVHjWodgT13pLXm8hGmpe
         bbsrsZ0U43nN9vaywXS9GwvgEut6/0EgPlZa1evw=
Date:   Sat, 28 Mar 2020 17:47:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: Fix adi,ltc2983 uint64-matrix schema
 constraints
Message-ID: <20200328174733.0485a340@archlinux>
In-Reply-To: <BN6PR03MB3347F56F6C3396083F16113199CD0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200327224501.18590-1-robh@kernel.org>
        <BN6PR03MB3347F56F6C3396083F16113199CD0@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> >
> >=20
> > 'minItems' and 'maxItems' apply at the same level as 'items' schemas as
> > the keywords apply to arrays. What's currently defined is a 3
> > dimensional matrix with the outer size being undefined. To fix this,
> > minItems/maxItems needs to be moved up a level.
> >=20
> > With this fixed, the example fails validation. For matrix types, the dts
> > syntax must use brackets (<>) matching the schema definition. In this
> > case, the inner array size is 2 elements, so let's add the correct
> > bracketing.
> >=20
> > Fixes: 3986a14870cb ("dt-bindings: iio: Add ltc2983 documentation")
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: linux-iio@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > I'll take this via the DT tree as I have another change this will
> > conflict.
> >=20
> > Rob
=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

thanks,

Jonathan
>=20
> Thanks,
> - Nuno S=C3=A1
>=20

