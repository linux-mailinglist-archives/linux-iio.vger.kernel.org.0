Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680E511F7A9
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 13:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfLOMUV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 07:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfLOMUU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 07:20:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A861F2054F;
        Sun, 15 Dec 2019 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576412420;
        bh=HSM3kjnBrmViAteF1Ui9aJjj67DF4kRB2tovXrQ0mBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BKLPJDnXCefdxeDeWugRF4NcYVsItDmAfNaVKXhiFK/cNXDSAusKqKPPoLPVA/4CG
         Q/U0JnC1Yh1WnWieSWvXGmcqJA9QOSCANtPlmlzSkjOfxUV6sLszVKZsJDTTHzCJfw
         DkZZsrUhKD5meTAP2WPkUCc/5sXCfh9DvwKaNY+I=
Date:   Sun, 15 Dec 2019 12:20:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rodrigo Carvalho <rodrigorsdc@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v6 2/2] dt-bindings: iio: accel: add binding
 documentation for ADIS16240
Message-ID: <20191215122014.1e6ce604@archlinux>
In-Reply-To: <20191213191036.GA28558@bogus>
References: <20191207045339.9186-1-rodrigorsdc@gmail.com>
        <20191207045339.9186-2-rodrigorsdc@gmail.com>
        <20191213191036.GA28558@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Dec 2019 13:10:36 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat,  7 Dec 2019 01:53:39 -0300, Rodrigo Carvalho wrote:
> > This patch add device tree binding documentation for ADIS16240.
> > 
> > Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> > ---
> > V6:
> >   - Update SPDX license identifier
> > 
> >  .../bindings/iio/accel/adi,adis16240.yaml     | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> >   
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Applied to the togreg branch of iio.git, picking up Rob's tag from v5.

Pushed out as testing for the autobuilders to poke at it.

Thanks,

Jonathan

