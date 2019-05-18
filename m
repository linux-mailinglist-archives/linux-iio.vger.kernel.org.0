Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B92227D
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfERJH7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 05:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfERJH7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 05:07:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D7D2082C;
        Sat, 18 May 2019 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558170479;
        bh=wXFh7i79M3gDBIl6uydPBZ9mair/rwIE8lvUbTn1Kmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NOf3VfUVgiBk4liAwfnapnqBvCJDl2bE49zuK6ynKIQ45D+hBp31B4Nqc40TlMTA2
         9UhrIkCBexNi//K4t4Vcwp1cc8aWlhuQml3HrMNRfaUMaVgUFuvSluzVpYJMzwTqEl
         +srOqxLXm/+LHwCorYQRTlEIHEzm/NcCMB40SDlc=
Date:   Sat, 18 May 2019 10:07:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Adam Michaelis <adam.michaelis@rockwellcollins.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        charles-antoine.couret@essensium.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com
Subject: Re: [PATCH v3 3/5] dt-bindings: iio: ad7949: Add
 adi,reference-select
Message-ID: <20190518100753.39b438cb@archlinux>
In-Reply-To: <20190514182311.GA31516@bogus>
References: <1557759185-167857-1-git-send-email-adam.michaelis@rockwellcollins.com>
        <1557759185-167857-3-git-send-email-adam.michaelis@rockwellcollins.com>
        <20190514182311.GA31516@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 May 2019 13:23:11 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, 13 May 2019 09:53:03 -0500, Adam Michaelis wrote:
> > Adding optional parameter to AD7949 to specify the source for the
> > reference voltage signal. Default value is maintained with option '3' to
> > match previous version of driver.
> > 
> > Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
> > ---
> > 	V2:
> > 	- Add some defines to reduce use of magic numbers.
> > 	V3:
> > 	- Re-think usage of device tree parameter to focus on the
> > 	actual reference sources instead of the raw hardware
> > 	configuration.
> > ---
> >  .../devicetree/bindings/iio/adc/ad7949.txt          | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Looks fine to me as well. Analog review awaited before applying.
For reference
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

