Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC6F1DD5B8
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgEUSLT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgEUSLT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:11:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB60207D3;
        Thu, 21 May 2020 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084679;
        bh=NOalaYPbHEwoE5ZwTM1xPd8ZRFEsjARJSOjT4Et8B6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U0NkA7rt95CF4hYXq7w3C0KfgPKrRQmZ9hvTM3IK+GjltmwQJY1+qpnF5hlVaovXz
         8XPyTmj8Q/SaYkb/8qWLYqW710oKX72UijSwzzw3jJs+Kux/VGlB/whlV9CYUMF3pq
         cdQiFLSeJO+yAQFh1kg6HtwWAOi9HNl/w5BrUmTE=
Date:   Thu, 21 May 2020 19:11:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v14 1/2] dt-bindings: proximity: provide vcnl3020 device
 tree binding document
Message-ID: <20200521191114.6b454ab9@archlinux>
In-Reply-To: <20200518204144.GA11276@bogus>
References: <20200510184537.10335-1-i.mikhaylov@yadro.com>
        <20200510184537.10335-2-i.mikhaylov@yadro.com>
        <20200518204144.GA11276@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 May 2020 14:41:44 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 10 May 2020 21:45:36 +0300, Ivan Mikhaylov wrote:
> > Mostly standard i2c driver with some additional led-current option
> > for vcnl3020.
> > 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > ---
> >  .../iio/proximity/vishay,vcnl3020.yaml        | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


