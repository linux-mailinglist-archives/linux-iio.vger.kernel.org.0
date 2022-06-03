Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9053CC54
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 17:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbiFCPbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiFCPbM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 11:31:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3171FA4E
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 08:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE24DB8236A
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 15:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D55EC385B8;
        Fri,  3 Jun 2022 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654270268;
        bh=2DAjbWij16d0hGcv03Y+D1sJRrGgziqivonO9TFwQVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MH7gOvgGjxdkuCUDZl0E9EjR0fgADhZyLLsjEwK8X7HwTOJHYLJG9jC7vpzvLrEVP
         YcGRhFq/LeAORtQCZ14QlT93GEsyotinW/2B96Is0+3zI4CQWIqbCLyzky0vdvBohC
         W/N5n9PXhUkzWEszoN5t/9iqzJy2aKhS+2epUp2SMtCiuG1tbPfMgG+NECsser9fjl
         G7gndZugNNe9+pxr9ttbje58kBtcoYpYgWLGrmnZruOpcGgUzGp4p3UiF9KRqMhD9k
         U7+wtEzNp7MwiGQG6azxDBWnAoBGvijUMGzcn70NE7S1WUTAQo2dZb8wqucBMSHIMS
         yHyQD9K9faqtQ==
Date:   Fri, 3 Jun 2022 16:40:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 0/5] dt-bindings: iio: update maintainers
Message-ID: <20220603164009.79eb21c7@jic23-huawei>
In-Reply-To: <CA+U=DspiK92mSSq6M0fPo+19hPk+fA-BrvKmdmFOX_9YrO6jVQ@mail.gmail.com>
References: <20220526134603.75216-1-alexandru.tachici@analog.com>
        <20220528175055.091c4ea0@jic23-huawei>
        <CA+U=DspiK92mSSq6M0fPo+19hPk+fA-BrvKmdmFOX_9YrO6jVQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 May 2022 08:01:56 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, May 28, 2022 at 7:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 26 May 2022 16:45:57 +0300
> > <alexandru.tachici@analog.com> wrote:
> > =20
> > > From: Alexandru Tachici <alexandru.tachici@analog.com>
> > >
> > > Some of the emails in bindings maintainers section are not
> > > working anymore. Update them with current ones. =20
> >
> > Hi Alexandru,
> >
> > Where possible for maintainer changes, cc the original person
> > on their new email addresses.  Alexandru is still active on the
> > list +CC.
> >
> > Now, if they don't reply I don't mind switching these maintainers
> > over but nice to give them a heads up. =20
>=20
> Unfortunately, I have a hard time these days keeping up with open-source =
stuff.
> I may need to create a company that does open-source work to be more
> present again.
> It's ironic, because I read the Linux Foundation reports saying "open
> source jobs are on the rise" and then I look around and it's not quite
> the case.
> It may also mean that non-open-source jobs are even more on the rise.
> =C2=AF\_(=E3=83=84)_/=C2=AF
>=20
> Anyway, for the series:
>=20
> Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Thanks.  Series applied.

Jonathan

>=20
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > >
> > > Alexandru Tachici (5):
> > >   dt-bindings: iio: accel: ADIS16240: update maintainers
> > >   dt-bindings: iio: adc: AD9467: update maintainers
> > >   dt-bindings: iio: adc: axi-adc: update maintainers
> > >   dt-bindings: iio: dac: AD5770R: update maintainers
> > >   dt-bindings: iio: imu: adis16480: update maintainers
> > >
> > >  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
> > >  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml      | 1 -
> > >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml     | 1 -
> > >  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
> > >  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
> > >  5 files changed, 3 insertions(+), 5 deletions(-)
> > > =20
> > =20

