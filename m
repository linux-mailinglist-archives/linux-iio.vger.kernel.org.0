Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F814F454
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 10:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfFVIdg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 04:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfFVIdg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 04:33:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F263520665;
        Sat, 22 Jun 2019 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561192415;
        bh=of5tv1lk+Pdmx0ar/vak5HcBEM6lCMPJCV89NlP50P4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w8y+1uPpC2lrIj7R3ZRkGiIQA8Y6k14CMVDTr5DjROuWqLTTUZjy7zq0vkulHnQB6
         6h5tQON+e8ugiuqYDVCRuaGAJoaNL4VtwhUWqx+r8QjXF6va6eca0kVIqYpILH3oMw
         58ZZ9vD6s54DBjysGUomvb3pJhaDVodmZns/E6hE=
Date:   Sat, 22 Jun 2019 09:33:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 4/4] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
Message-ID: <20190622093325.77539301@archlinux>
In-Reply-To: <CAL_JsqLOMKQExp1Vu0Xo32Wx-ETdQk=AWSnex-GQ3QbzdZ7zQA@mail.gmail.com>
References: <20190621121344.24917-1-mircea.caprioru@analog.com>
        <20190621121344.24917-4-mircea.caprioru@analog.com>
        <CAL_JsqLOMKQExp1Vu0Xo32Wx-ETdQk=AWSnex-GQ3QbzdZ7zQA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Jun 2019 08:31:14 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Fri, Jun 21, 2019 at 6:15 AM Mircea Caprioru
> <mircea.caprioru@analog.com> wrote:
> >
> > Convert AD7124 bindings documentation to YAML format.
> >
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > ---
> >
> > Changelog v2:
> > - modified SPDX license to GPL-2.0 OR BSD-2-Clause
> > - added regex for a range from 0 to 15
> > - added minimum and maximum constraints for reg property
> > - set type and range of values for adi,reference-select property
> > - used items for diff-channels property
> > - set bipolar, adi,buffered-positive and negative to type: boolean
> >
> >  .../bindings/iio/adc/adi,ad7124.yaml          | 155 ++++++++++++++++++
> >  1 file changed, 155 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
The result is presumably good but the structure of the patch is not
as straight forward as it should be.  As the changelog makes clear we
aren't just doing a conversion here.  It is a mixture of conversion
and new properties.  Please break the patch in two to reflect that.
First convert the existing binding, then add the new properties.

That will make it easier for people to see what is new.

Thanks,

Jonathan


