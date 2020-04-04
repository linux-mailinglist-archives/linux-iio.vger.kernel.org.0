Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4AC19E540
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDDOBt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 10:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDOBs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:01:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CDAB206D4;
        Sat,  4 Apr 2020 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586008908;
        bh=soFRQ2ckp8Un3VVh90dkT5q9BsswR9bx0AlBduBu32I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uNqyz0tu/xn1FiyeOFSTVbOrE7gPf/6zyNm541Dam+IyWitn3LfNftbRd44ITy1Gi
         vV4gbBlWg2JCZoNuY3sfvZn3RMYyIXikVJW8ptpS35ryEt1RZyNRVXuF6ZmqBos1YF
         nY2blL5BqVsmYyaN/fCx9V66Vd3SZ3pzmQa8b16w=
Date:   Sat, 4 Apr 2020 15:01:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, heiko@sntech.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: convert rockchip saradc
 bindings to yaml
Message-ID: <20200404150141.5a3dce00@archlinux>
In-Reply-To: <20200330181052.GA7527@bogus>
References: <20200313132926.10543-1-jbx6244@gmail.com>
        <20200330181052.GA7527@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 12:10:52 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 13 Mar 2020 14:29:24 +0100, Johan Jonker wrote:
> > Current dts files with 'saradc' nodes are manually verified.
> > In order to automate this process rockchip-saradc.txt
> > has to be converted to yaml.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  .../bindings/iio/adc/rockchip-saradc.txt           | 37 ----------
> >  .../bindings/iio/adc/rockchip-saradc.yaml          | 79 ++++++++++++++++++++++
> >  2 files changed, 79 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing to be largely
ignored by the autobuilders.

Thanks,

Jonathan


