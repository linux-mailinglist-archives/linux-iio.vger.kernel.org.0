Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7A571D2
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZTeo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFZTeo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:34:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554D3216FD;
        Wed, 26 Jun 2019 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561577683;
        bh=HrjAB2TnQcww6wt2Btc1X5FvZhuThBNZXuA1Zfytcus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wTzM+/3JcmSHNHlK8g5VjhM/WK+N0bxNbnlFvCiI9DKZpFGefXIdtv/k4k7zJkVLi
         WHWykiddjcahopiKzRLGPdy6OFt1H+O9AUyqK1lWQgaXToz3N89ZAQPbn/A/rWHoT9
         4S+ZTGAo0qhWlHPVDB8OpylM2iGmX0RKMulFD9oE=
Date:   Wed, 26 Jun 2019 20:34:38 +0100
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
Subject: Re: [PATCH V4 5/5] dt-bindings: iio: adc: Add buffered input
 property
Message-ID: <20190626203438.59019143@archlinux>
In-Reply-To: <CAL_Jsq+ryELXJNdzZBxzCfMQnMdeGr_xC+ABJ3wGx2tZum6AwA@mail.gmail.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
        <20190625081128.22190-5-mircea.caprioru@analog.com>
        <CAL_Jsq+ryELXJNdzZBxzCfMQnMdeGr_xC+ABJ3wGx2tZum6AwA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Jun 2019 08:45:01 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Tue, Jun 25, 2019 at 2:12 AM Mircea Caprioru
> <mircea.caprioru@analog.com> wrote:
> >
> > This patch adds the buffered mode device tree property for positive and
> > negative inputs. Each option can be enabled independently.
> >
> > In buffered mode, the input channel feeds into a high impedance input stage
> > of the buffer amplifier. Therefore, the input can tolerate significant
> > source impedances and is tailored for direct connection to external
> > resistive type sensors such as strain gages or RTDs.
> >
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > ---
> >
> > Changelog v3:
> > - added this separate commit for adi,buffered-positive and negative
> >   properties
> >
> > Changelog v4:
> > - nothing changed here
> >
> >  .../devicetree/bindings/iio/adc/adi,ad7124.yaml       | 11 +++++++++++
> >  1 file changed, 11 insertions(+)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing.

thanks,

Jonathan
