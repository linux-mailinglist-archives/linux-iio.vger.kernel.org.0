Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD8D7841
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 16:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbfJOOTX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 10:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfJOOTX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Oct 2019 10:19:23 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBF0217F9;
        Tue, 15 Oct 2019 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571149162;
        bh=Ps0eVSE3aMchJwYapXACrAHQ9Tmc1Lh7EYWSYguTwBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HIK35ngSo4Li0KqJZlOqvirQyspBko7DXZKdH3ChhzuQXO7/epjncUWQEP1NYWNOE
         AF2IJuNMz2Iydy97zQzBGSOEkMVmTuq8VykpzDqlLcNAbe1xxBPd/g2eSjfZ+T4Lgd
         mi/zGwLqtapm7ByglyKaAeSU60Jto76LHbWKEq2w=
Received: by mail-qk1-f181.google.com with SMTP id y144so19293467qkb.7;
        Tue, 15 Oct 2019 07:19:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUekkVbRrAwFZDfSP90BWgfV/2PxzAdJCRZOoyTWnhT6KqFqisq
        mQiJARPmSNJbSpC6YI9zNLjUGRpDEwJ04js65g==
X-Google-Smtp-Source: APXvYqx4iwG3Lr908rg6R/yv30scCvd74KmrGR5b6l5MNAkXclssKVsoLMwBSzvuitj3CZilrUVQjD7Mz5MUKZ4MkzM=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr4387238qkl.152.1571149161548;
 Tue, 15 Oct 2019 07:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191011084038.45829-1-nuno.sa@analog.com> <20191011084038.45829-2-nuno.sa@analog.com>
 <20191012115745.069119b0@archlinux> <20191014143950.GA6163@bogus>
In-Reply-To: <20191014143950.GA6163@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Oct 2019 09:19:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Hju1KtvfjEJNGsS9maC3LDn0FcQJe6Wp+y-YgiAP=+w@mail.gmail.com>
Message-ID: <CAL_Jsq+Hju1KtvfjEJNGsS9maC3LDn0FcQJe6Wp+y-YgiAP=+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: Add ltc2983 documentation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 14, 2019 at 9:39 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Oct 12, 2019 at 11:57:45AM +0100, Jonathan Cameron wrote:
> > On Fri, 11 Oct 2019 10:40:38 +0200
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >
> > > Document the LTC2983 temperature sensor devicetree bindings.
> > >
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> >
> > I'm happy with this, but will be waiting for Rob to have a chance
> > for a final look before applying.
>
> LGTM, but I need to add the int64-matrix type to the core schema first
> or this will give you errors. I should get to that in the next day or
> so.

Now added, so please update dtschema and check.

Reviewed-by: Rob Herring <robh@kernel.org>
