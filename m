Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF14759D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFPPp4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 11:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfFPPpz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 11:45:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55202063F;
        Sun, 16 Jun 2019 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560699954;
        bh=FfgxTZ0FGxbj3xlmt5bwJEqweYKRnTtg8LNoSPRC0Lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CvMSrzqOXMv2n8ac+ol7mLeNMxoosOicaYWKvMibcPR4JgFwQ362TG/bFkT1oeMrP
         4E7QnDDS6SN4RM3FfYb4CM1m9ysh2LyqHSwO2NxtOX2IjKuGZEP8tnKOiQnv8dA0X6
         y25aIaYbp9Lp9Vy7Y9PSvPBtdrcw2chMEAoWdpKg=
Date:   Sun, 16 Jun 2019 16:45:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Renato Lui Geh <renatogeh@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml
 binding
Message-ID: <20190616164548.01444b50@archlinux>
In-Reply-To: <20190614194302.GA18613@bogus>
References: <cover.1558746978.git.renatogeh@gmail.com>
        <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
        <20190614194302.GA18613@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 13:43:02 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 24 May 2019 22:26:30 -0300, Renato Lui Geh wrote:
> > This patch adds a YAML binding for the Analog Devices AD7780/1 and
> > AD7170/1 analog-to-digital converters.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v2:
> >  - vref-supply to avdd-supply
> >  - remove avdd-supply from required list
> >  - include adc block in an spi block
> > 
> >  .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
> >  .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
> >  2 files changed, 87 insertions(+), 48 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks. As I'd not yet pushed out as togreg (rather than testing)
I've rebased to add your RB.

Thanks,

Jonathan
