Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31EB256989
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgH2Rxg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgH2Rxf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:53:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB5F204FD;
        Sat, 29 Aug 2020 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723615;
        bh=3R5laqbqSHYvzg6ulvABnCiC0nCd1Jwl6cuiJ6LXRZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uzsymS/RNFHzCSchPZXAnisCtnzCl9thtnhmDeWKViWCKdmPxP9hgBvsWPoj2OgPi
         dzJvqMN2h4PKbop7WGOomjk6bQcapo6V7swrJS86NieM0IOYTI3rCK2/ngiefBhExe
         AeVcskcFehMoVKr2NIKp+l4wx7P3dE3K3is/e3Mo=
Date:   Sat, 29 Aug 2020 18:53:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/13] dt-bindings: iio: adc: ti,adc084s021 yaml
 conversion
Message-ID: <20200829185331.4cb804dc@archlinux>
In-Reply-To: <20200818023000.GA2171469@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-8-jic23@kernel.org>
        <20200818023000.GA2171469@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:30:00 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:47 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Simple conversion.
> >=20
> > Added the #io-channel-cells optional property to allow for consumer
> > bindings if appropriate on a given board.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: M=C3=A5rten Lindahl <martenli@axis.com>
> > ---
> >  .../bindings/iio/adc/ti,adc084s021.yaml       | 58 +++++++++++++++++++
> >  .../bindings/iio/adc/ti-adc084s021.txt        | 19 ------
> >  2 files changed, 58 insertions(+), 19 deletions(-)
> >  =20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied



