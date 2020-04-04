Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78F19E566
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDDONs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 10:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgDDONs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:13:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B64A206D4;
        Sat,  4 Apr 2020 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586009628;
        bh=ZvuleyhiKzg2qJsFUH+wTl9rb8FF4uXXYTWgnvLY7H8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BUJXJ67HM8feh6Ehp8/PVEKDVNXonHBGWgL+5sdET+uAfflyQJuoOahXckHB8wRtu
         ydGRnNQl7EV0JLnWFeVSUY6SVQbW4CLjnejlZjN0s2wIxcxh5I4U3jZ24BPtcq4fl1
         Hc4xAN/itxl5jYnBZUtamOgM4fjgiPQMawaj7NDk=
Date:   Sat, 4 Apr 2020 15:13:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nishant Malpani <nish.malpani25@gmail.com>, robh+dt@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: iio: tsl2563: convert bindings to YAML
Message-ID: <20200404151341.19388a2e@archlinux>
In-Reply-To: <20200330225934.GA19255@bogus>
References: <20200318071940.12220-1-nish.malpani25@gmail.com>
        <20200330225934.GA19255@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 16:59:34 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 18 Mar 2020 12:49:40 +0530, Nishant Malpani wrote:
> > Convert the TSL2563 device tree bindings to the new YAML format.
> > 
> > Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> > ---
> > 
> > Changes in v4:
> >   - Change $id property to reflect corrected relative path.
> > 
> > Changes in v3:
> >   - Include the complete diff (changes from v1).
> > 
> > Changes in v2:
> >   - Rename the dt-bindings to include manufacturer's name.
> >   - Synchronize the bindings with the driver.
> > ---
> >  .../bindings/iio/light/amstaos,tsl2563.yaml   | 49 +++++++++++++++++++
> >  .../devicetree/bindings/iio/light/tsl2563.txt | 19 -------
> >  2 files changed, 49 insertions(+), 19 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2563.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

