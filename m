Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D15CC9E2
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJEMVp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 08:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEMVp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 08:21:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC882133F;
        Sat,  5 Oct 2019 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570278104;
        bh=0Qv6ievYjsSEhe8QwwCqTOMZU+Qy2Y3YSg8mxXJBhfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OkvNsaLGgGnCSXy8gTPDlJkcCJ2t09sndizauf1BuHdMFg4+33q7ZszFylmft/5AZ
         s0fD0JaE8ZQ74TdRQnHgaBgfPifLu0nD7yi57vE2CZ7Ga1R8ojQtgw2yyTc/qMZMf4
         EYQdJoPjFYEJ7OoA+5KCHK3f/kifFEinEftjNBLc=
Date:   Sat, 5 Oct 2019 13:21:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: bh1750: convert bindings
 to yaml
Message-ID: <20191005132140.6354efd6@archlinux>
In-Reply-To: <CAL_JsqLj6jpgC5e607uDdVJGhKE6b53k=HHgZ3_dq8Qk-X5WDg@mail.gmail.com>
References: <20190916190024.9955-1-tduszyns@gmail.com>
        <20190916190024.9955-2-tduszyns@gmail.com>
        <CAL_JsqLj6jpgC5e607uDdVJGhKE6b53k=HHgZ3_dq8Qk-X5WDg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Sep 2019 09:17:40 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Sep 16, 2019 at 2:01 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
> >
> > Convert existing device tree bindings to yaml.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/light/bh1750.txt  | 18 --------
> >  .../devicetree/bindings/iio/light/bh1750.yaml | 43 +++++++++++++++++++
> >  2 files changed, 43 insertions(+), 18 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
