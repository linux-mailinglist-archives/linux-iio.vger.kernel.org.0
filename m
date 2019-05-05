Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE913F38
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfEELmS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 07:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfEELmS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 07:42:18 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7234B204EC;
        Sun,  5 May 2019 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557056537;
        bh=OSgrx2DbS9HtGVCVXv4i5t6DYi7dMpy+aWjJzIaZKYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fjUdZYDocP4JlmUQz81Eim7qNTus4jMC2lOhjg8CN+GMngTpt7y8AxQWtsSOQxKN5
         Ea5hAsXcwE9e8ESN3E9eE/4E1PuwDlNP/8VFid/iY+hEQQU+03kl/leIpH27P0qMs2
         f/1uWEEcuM0qRclyzXfc2+i4NVI4d2wIX/gDumuk=
Date:   Sun, 5 May 2019 12:42:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <anson.huang@nxp.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
        Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH] dt-bindings: iio: isl29018: convert bindings to YAML
 format
Message-ID: <20190505124207.650e6a83@archlinux>
In-Reply-To: <CAL_Jsq+Wzc8W11E0XYg5bKfGoYNxFu0U0-Rdk5PqXZf40W21ZA@mail.gmail.com>
References: <20190427182359.27254-1-masneyb@onstation.org>
        <CAL_Jsq+Wzc8W11E0XYg5bKfGoYNxFu0U0-Rdk5PqXZf40W21ZA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Apr 2019 07:44:14 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Sat, Apr 27, 2019 at 1:25 PM Brian Masney <masneyb@onstation.org> wrote:
> >
> > Convert the isl29018 device tree bindings to the new YAML format.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > I'm willing to be listed as the maintainer since this is one of the
> > drivers that I moved out out of staging unless one of the original
> > authors wants to be listed instead.
> >
> > I added the BSD-2-Clause to the new binding document. I wrote the
> > original document and the only commit since then was from Rob in
> > commit 791d3ef2e111 ("dt-bindings: remove 'interrupt-parent' from
> > bindings")
> >
> >  .../bindings/iio/light/isl29018.txt           | 27 ---------
> >  .../bindings/iio/light/isl29018.yaml          | 56 +++++++++++++++++++
> >  2 files changed, 56 insertions(+), 27 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/light/isl29018.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/isl29018.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


