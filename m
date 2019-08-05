Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5581D4C
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfHENcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 09:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHENcP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 09:32:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F7A20644;
        Mon,  5 Aug 2019 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011934;
        bh=Pi1nPOcAzoKzmhilwJpY2NWR69GFPeOfUkKKuRKPdvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e3fijdzZP1l07SRJPZGDKsmIE7Q7W7MGtcbT1oxrQ1NkcOHurMHcxpkFkgFugcgBy
         TfuRG+y41cSoQ4o8FKOjWaVGqiD7ebkqB/XgLG/Ncrvas2kNqhaOYk6b0z58TG2IK+
         SROpwHWuRN2+V9Kvuiw2bdawFhP0rhin5sjBXt38=
Date:   Mon, 5 Aug 2019 14:32:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Martin Kaiser <martin@kaiser.cx>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: potentiometer: add
 max5432.yaml binding
Message-ID: <20190805143209.5307ad93@archlinux>
In-Reply-To: <CAL_JsqK9iuxQEh3s2_AgQhSa19Coq7kSFB497KUMQnjQNU+ELw@mail.gmail.com>
References: <20190721175915.27192-1-martin@kaiser.cx>
        <20190731140706.2765-1-martin@kaiser.cx>
        <20190731140706.2765-2-martin@kaiser.cx>
        <CAL_JsqK9iuxQEh3s2_AgQhSa19Coq7kSFB497KUMQnjQNU+ELw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 31 Jul 2019 10:50:36 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Jul 31, 2019 at 8:07 AM Martin Kaiser <martin@kaiser.cx> wrote:
> >
> > Add a binding for the Maxim Integrated MAX5432-MAX5435 family of digital
> > potentiometers.
> >
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> > changes in v4
> >  - fix the dt bindings
> >    - replace ic20 with i2c
> >    - document the reg property
> >    - add additionalProperties and required
> >
> > changes in v3
> >  - split dt bindings and driver code into separate patches
> >  - use yaml format for dt bindings
> >  - fix formatting of parameter lists
> >
> > changes in v2
> >  - use MAX5432_ prefix for all defines
> >  - fix indentation
> >  - convert void * to unsigned long, not to u32
> >    (warning from kbuild test robot)
> >
> >  .../bindings/iio/potentiometer/max5432.yaml        | 44 ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


